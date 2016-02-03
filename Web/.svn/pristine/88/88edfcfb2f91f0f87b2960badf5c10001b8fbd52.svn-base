package com.lingtong.interfaces.interceptor;

import org.apache.commons.lang.NumberUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;

import com.lingtong.interfaces.message.FaultTolerant;
import com.lingtong.model.Tenants;
import com.lingtong.util.SpringManage;

/**
 * @author xqq
 * @date 2015-8-15 上午8:15:12
 * 接口调用,token认证
 */
public class Auth {
	private static JdbcTemplate jdbcTemplate = (JdbcTemplate) SpringManage.getInstance().getObject("jdbcTemplate");
	
	public static boolean auth( FaultTolerant ft ){
		if( ft != null && StringUtils.isNotBlank( ft.getToken() ) && NumberUtils.isNumber( ft.getUid() )){
			StringBuilder sql = new StringBuilder();
			sql.append( "select count(*) from " + Tenants.TABLENAME + " where token = ? and id = ?" );
			int num = jdbcTemplate.queryForInt(sql.toString(), new Object[]{ft.getToken(), Integer.parseInt( ft.getUid() )});
			
			if( num  > 0 ){
				return true;
			}
		}
		return false;
	}
}
