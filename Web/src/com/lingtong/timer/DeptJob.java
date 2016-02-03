package com.lingtong.timer;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.NumberUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.lingtong.interfaces.interceptor.BmobSmsUtil;
import com.lingtong.model.Contract;
import com.lingtong.model.Room;
import com.lingtong.model.Tenants;
import com.lingtong.util.FileUtils;
import com.lingtong.util.PushtoSingleUtil;
import com.lingtong.util.SpringManage;

/**
 * @author xqq
 * @date 2015-8-29 上午9:51:14 催款的定时器
 */
@Component("deptJob")
public class DeptJob {
	private Integer[] remainDays = new Integer[]{5, 0};
	private JdbcTemplate jdbcTemplate = (JdbcTemplate) SpringManage.getInstance().getObject("jdbcTemplate");
	
	@Scheduled(cron = "00 00 10 * * ?")
	public void dept() {
		System.out.println(".................催款的定时器开始工作...............");
		
		StringBuilder sql = new StringBuilder();
		String[] tables = new String[]{Contract.TABLENAME + " con", Room.TABLENAME + " room", Tenants.TABLENAME + " ten"};
		sql.append("select ten.tel_number, ten.clientid, ten.devicetoken, ,  TIMESTAMPDIFF(DAY,DATE_FORMAT( sign_time, '%Y-%m-%d'), DATE_FORMAT( date_add(now(), interval -(TIMESTAMPDIFF(MONTH,DATE_FORMAT( sign_time, '%Y-%m-%d'), DATE_FORMAT( now(), '%Y-%m-%d'))) month), '%Y-%m-%d')) as diffdays from " + StringUtils.join(tables, ",") + " where con.room_id = room.id and con.tenant_id = ten.id ")
		   //.append( " and room.status = '1'" )//已出租状态
		   .append( " and Datediff(DATE_FORMAT( sign_time, '%Y-%m-%d'), now()) < 0 and Datediff(DATE_FORMAT( end_time, '%Y-%m-%d'), now()) > 0" )//当前时间大于开始时间,小于到期时间
		   .append( " and TIMESTAMPDIFF(MONTH,DATE_FORMAT( sign_time, '%Y-%m-%d'), DATE_FORMAT( now(), '%Y-%m-%d')) != 0 " )//不能是同月
		   .append( " and TIMESTAMPDIFF(MONTH,DATE_FORMAT( sign_time, '%Y-%m-%d'), DATE_FORMAT( now(), '%Y-%m-%d'))%3 = 0 " )//相差3,6,9,12个月
		   .append( getSql(remainDays) );//相差的日期是20天或12天
		System.out.println("keys sql:" + sql.toString());
		List list = jdbcTemplate.queryForList(sql.toString());
		System.out.println(list.size());
		for (int i = 0; list != null && i < list.size(); i++) {
			Map<String, Object> map = (Map<String, Object>) list.get( i );
			if( map.get("CLIENTID") != null && map.get("DEVICETOKEN") != null ){
				String cid = map.get("CLIENTID").toString();
				String devicetoken = map.get("DEVICETOKEN").toString();
				String diffdays = map.get("DIFFDAYS").toString();
				try {
					PushtoSingleUtil.pushToCilent(cid, "尊敬的优租客户,您距离下一次付款的时间还有"+diffdays+"天,请及时付款", "2", devicetoken,"","20");
					PushtoSingleUtil.pushToCilent(cid, "尊敬的优租客户,您距离下一次付款的时间还有"+diffdays+"天,请及时付款", "1", devicetoken,"","20");
					if( map.get("TEL_NUMBER") != null ){//短信推送
						BmobSmsUtil.getInstance().sendSMS("尊敬的优租客户,您距离下一次付款的时间还有"+diffdays+"天,请及时付款", map.get("TEL_NUMBER").toString());
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				
			}
			
		}
		
		System.out.println(".................催款的定时器结束工作...............");
	}
	
	private String getSql(Integer[] remainDays){
		StringBuilder sb = new StringBuilder();
		if( remainDays != null && remainDays.length > 0 ){
			List<String> conditions = new ArrayList<String>();
			for( Integer day : remainDays  ){
				conditions.add( " TIMESTAMPDIFF(DAY,DATE_FORMAT( sign_time, '%Y-%m-%d'), DATE_FORMAT( date_add(now(), interval -(TIMESTAMPDIFF(MONTH,DATE_FORMAT( sign_time, '%Y-%m-%d'), DATE_FORMAT( now(), '%Y-%m-%d'))) month), '%Y-%m-%d')) = " + day + " " );
			}
			sb.append( " " + StringUtils.join(conditions.toArray(new String[]{}), "or") + " " );
		}
		if( !sb.toString().equals("") ){
			return " and (" + sb.toString() + ") ";
		}
		return "";
	}
	
	public static void main(String[] args) {
		new DeptJob().dept();
	}
}
