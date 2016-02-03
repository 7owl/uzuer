package com.lingtong.timer;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.NumberUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.lingtong.util.FileUtils;
import com.lingtong.util.SpringManage;

/**
 * @author xqq
 * @date 2015-8-29 上午9:51:14 删除的定时器
 */
@Component("deleteJob")
public class DeleteJob {
	private JdbcTemplate jdbcTemplate = (JdbcTemplate) SpringManage.getInstance().getObject("jdbcTemplate");
	
	@Scheduled(cron = "59 59 23 * * ?")
	public void deleteImage() {//一分钟执行一次
		System.out.println(".................删除图片定时器开始工作...............");
		
		StringBuilder sql = new StringBuilder();
		sql.append( "select group_concat(url separator ',') `keys`, room_id from picture where status = 0 group by room_id" );
		System.out.println("keys sql:" + sql.toString());
		System.out.println( jdbcTemplate == null );
		List list = jdbcTemplate.queryForList(sql.toString());
		System.out.println(list.size());
		for (int i = 0; list != null && i < list.size(); i++) {
			Map<String, Object> map = (Map<String, Object>) list.get( i );
			if( map.get("KEYS") != null ){
				String keys = map.get("KEYS").toString();
				String room_id = map.get("ROOM_ID").toString();
				System.out.println( room_id );
				if( StringUtils.isNotBlank( keys ) ){
					boolean flag = FileUtils.deleteFile(keys);
					if( flag == true ){
						List<String> urls = new ArrayList<String>();
						String[] ids = keys.split(",");
						for (String id : ids) {
							urls.add("'" + id + "'");
						}
						if( urls.size() > 0 ){
							System.out.println( "delete from picture where status = 0 and room_id = " + Integer.valueOf( room_id ) + " and url in (" + StringUtils.join(urls.toArray(new String[]{}), ",") + ")" );
							jdbcTemplate.update( "delete from picture where status = 0 and room_id = " + Integer.valueOf( room_id ) + " and url in (" + StringUtils.join(urls.toArray(new String[]{}), ",") + ")" );
						}
					}
				}
			}
			
		}
		
		System.out.println(".................删除图片定时器结束工作...............");
	}
	
	public static void main(String[] args) {
		new DeleteJob().deleteImage();
	}
}
