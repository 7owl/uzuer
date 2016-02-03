package com.lingtong.timer;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.net.io.FromNetASCIIInputStream;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.lingtong.model.Contract;
import com.lingtong.model.Order;
import com.lingtong.model.Room;
import com.lingtong.util.FileUtils;
import com.lingtong.util.LTBeanUtils;
import com.lingtong.util.SpringManage;
import com.lingtong.vo.RoomVo;

/**
 * 定时更新合同状态 付款逻辑已完成 所有的Order count数 = paystate和 并且时间 > 结束时间
 * @author Administrator
 *
 */
@Component("updateContractState")
public class UpdateContractState {
	private JdbcTemplate jdbcTemplate = (JdbcTemplate) SpringManage.getInstance().getObject("jdbcTemplate");
	
	@Scheduled(cron = "59 59 23 * * ?")
	public void deleteImage() {//一分钟执行一次
		System.out.println("................ 更新合同状态，更新合同中房源主体 定时器开始工作...............");
		
		StringBuilder sql = new StringBuilder();
		//到点了没有 更新状态滴 合同
		String sql1 = "select * from " + Contract.TABLENAME + " where  DATEDIFF (end_time ,new()) < 0 and completedState != '2'";
		
//		sql.append( "select group_concat(url separator ',') `keys`, room_id from picture where status = 0 group by room_id" );
//		System.out.println("keys sql:" + sql.toString());
		System.out.println( jdbcTemplate == null );
		List list = jdbcTemplate.queryForList(sql.toString());
		//没更新状态的 合同集合
		List<Contract> contracts = new ArrayList<Contract>();
		
		System.out.println(list.size());
		for (int i = 0; list != null && i < list.size(); i++) {
			Contract contract = new Contract();
			Map<String, Object> map = (Map<String, Object>) list.get(i);
			LTBeanUtils.getInstance().Map2Bean(map, contract);
			String s = "select count(*) from " + Order.TABLENAME + " where contract_id = ? and paystate= 0 ";
			int count = jdbcTemplate.queryForInt(s,new Object[]{contract.getId()});
			String updateContract ="update  " + Contract.TABLENAME+" set completedState='2' where id=?";
			//设置成未出租
			String updateRoom = "update " + Room.TABLENAME +" set status=0 where id= ？" ;
			if (count==0) {
				int affected = jdbcTemplate.update(updateContract ,new Object[]{contract.getId()});
				if (affected>0) {
					System.out.println("updateContract completedState success ");
				}
				affected = jdbcTemplate.update(updateRoom,new Object[]{contract.getRoom_id()});
				if (affected>0) {
					System.out.println("updateContract roomstatus success ");
				}
			}
			else {
				System.out.println("Not have data to update");
			}
		}
		System.out.println(".................更新合同状态，更新合同中房源主体 定时器结束工作...............");
	}
	
	public static void main(String[] args) {
		new DeleteJob().deleteImage();
	}
	
}
