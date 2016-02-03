package com.lingtong.dao.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.lingtong.dao.ComplainDao;
import com.lingtong.interfaces.message.CommonErrorEnum;
import com.lingtong.model.Complain;
import com.lingtong.util.CalendarUtil;
import com.lingtong.util.SpringManage;

/**
 * @author xqq
 * @date 2015-8-16 下午9:53:51
 * 
 */
@Component("complainDaoImpl")
public class ComplainDaoImpl implements ComplainDao {
	@Resource(name="jdbcTemplate")
	private JdbcTemplate jdbcTemplate;
	
	/**********************************app 专用接口*****************************************/
	public Map<String, Object> save(Complain complain) {
		if( jdbcTemplate == null ){
			jdbcTemplate = (JdbcTemplate) SpringManage.getInstance().getObject("jdbcTemplate");
		}
		Map<String, Object> result = new HashMap<String, Object>();
		StringBuilder sql = new StringBuilder();
		sql.append( "insert into " + Complain.TABLENAME + "(id, content, createtime) values(?, ?, ?)" );
		//System.out.println("抱怨插入sql:" + sql.toString());
		
		if( complain == null ){
			result.put("code", CommonErrorEnum.COMPLAINT_IS_NULL.getCode());
			result.put("msg", CommonErrorEnum.COMPLAINT_IS_NULL.getMessage());
			return result;
		}
		String createtime = StringUtils.isBlank( complain.getCreatetime() ) ? CalendarUtil.getInstance().getCurrentTime() : complain.getCreatetime();
		int affected = jdbcTemplate.update(sql.toString(), new Object[]{complain.getId(), complain.getContent(), createtime});
		if( affected > 0 ){
			result.put("code", "0");
			result.put("msg", "抱怨生成成功");
		} else {
			result.put("code", CommonErrorEnum.COMPLAINT_INSERT_FAIL.getCode());
			result.put("msg", CommonErrorEnum.COMPLAINT_INSERT_FAIL.getMessage());
		}
		return result;
	}

}
