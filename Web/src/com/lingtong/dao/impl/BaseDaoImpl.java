package com.lingtong.dao.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.lingtong.util.LTBeanUtils;
import com.lingtong.util.SpringManage;
/**
 * @author xqq
 * @date 2015-8-9 下午3:08:23
 * 
 */
@Component("baseDaoImpl")
public class BaseDaoImpl<T extends Object> {
	@Resource(name="jdbcTemplate")
	protected JdbcTemplate jdbcTemplate;
	
	/**
	 * 
	 * @param t
	 * @param tableName
	 * @param className
	 * @param idField
	 * @return
	 */
	public Map<String, Object> save( T t, String tableName, String idField, String className ){
		Map<String, Object> result = new HashMap<String, Object>();
		
		if ( t == null) {
			result.put("error",  className + "为空...");
			return result;
		}
		
		List<String> fields = new ArrayList<String>();
		List<Object> values = new ArrayList<Object>(); 
		LTBeanUtils.getInstance().getFieldInfo(t, fields, values);
		
		if( !isExist(t) ){
			StringBuilder sb = new StringBuilder();
			if( isHasIdValue(t) ){//进行修改
				
				List<String> sets = new ArrayList<String>();
				Object idValue = null;
				for( int i = 0; fields != null && i < fields.size(); i++ ){
					String field = fields.get(i);
					if( !field.equals( idField )){
						sets.add( field );
					} else {
						idValue = values.get(i);
						values.remove(i);
						
					}
				}
				values.add( idValue );
				sb.append( "update " + tableName + " set ")
				  .append( StringUtils.join(sets.toArray(new String[]{}), ",") )
				  .append( " where " + idField + " = ?" );
				System.out.println( "修改sql:" + sb.toString() );
				int affected = jdbcTemplate.update( sb.toString(), StringUtils.join(values.toArray(new String[]{}), ",") );
				if (affected > 0) {
					result.put("success", "修改成功...");
				} else {
					result.put("success", "修改失败...");
				}
			} else {//进行插入
				
				sb.append( "insert into" + tableName + "(" )
				  .append( StringUtils.join( fields.toArray(new String[]{}), "," ) )  
				  .append( ") values(" )
				  .append( StringUtils.join( values.toArray(new String[]{}), "," ) )
				  .append( ")" );
				System.out.println( "插入sql:" + sb.toString() );
				int affected = jdbcTemplate.update( sb.toString() );
				if (affected > 0) {
					result.put("success", "插入成功...");
				} else {
					result.put("success", "插入失败...");
				}
			}
		} else {
			result.put("error", className + "已存在...");
		}
		return null;
	}
	
	/***
	 * 分页
	 * @param tables
	 * @param idField
	 * @param projects
	 * @param where
	 * @param results
	 * @param className,T对应的类型
	 * @return
	 */
	public List<T> select( String[] tables, String idField, String[] projects, String where, String className, Map<String, Object> results ){
		List<T> ts = new ArrayList<T>();
		
		StringBuilder sb = new StringBuilder( "select" );
		if( projects == null ){//如果没有要查询的字段
			return null;
		}
		sb.append( " " + StringUtils.join(projects, ",") );
		
		if( tables == null ){//如果没有表
			return null;
		}
		sb.append( " from " + StringUtils.join(tables, ",") + " ");
		
		if( StringUtils.isNotBlank( where ) ){//如果有查询条件
			sb.append( " where " )
			  .append( where );
		}
		System.out.println( "查询sql:" + sb.toString() );
		
		if( jdbcTemplate == null){
			jdbcTemplate = (JdbcTemplate) SpringManage.getInstance().getObject( "jdbcTemplate" );
		}
		
		List list = jdbcTemplate.queryForList( sb.toString() );
		for( int i = 0 ; list != null && list.size() > i; i++ ){
			Map<String, Object> map = (Map<String, Object>) list.get( i );
			try {
				Class cls = Class.forName(className);
				T t = (T) cls.newInstance();
				LTBeanUtils.getInstance().Map2Bean(map, t);
				ts.add( t );
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
				return ts;
			} catch (InstantiationException e) {
				e.printStackTrace();
				return ts;
			} catch (IllegalAccessException e) {
				e.printStackTrace();
				return ts;
			}
		}
		
		int total = count( tables, idField, where );
		results.put("rows", ts);
		results.put("total", total);
		return ts;
	}
	
	/***
	 * 统计总数
	 * @param tables
	 * @param idField
	 * @param where
	 * @param results
	 * @param className,T对应的类型
	 * @return
	 */
	public Integer count( String[] tables, String idField, String where ){
		List<T> ts = new ArrayList<T>();
		
		StringBuilder sb = new StringBuilder( "select count(" );
		
		if( StringUtils.isNotBlank( idField ) ){
			sb.append( idField + ") " );
		} else {
			sb.append( "*) " );
		}
		
		if( tables == null ){//如果没有表
			return null;
		}
		sb.append( " from " + StringUtils.join(tables, ",") + " ");
		
		if( StringUtils.isNotBlank( where ) ){//如果有查询条件
			sb.append( " where " )
			  .append( where );
		}
		System.out.println( "统计sql:" + sb.toString() );
		
		if( jdbcTemplate == null){
			jdbcTemplate = (JdbcTemplate) SpringManage.getInstance().getObject( "jdbcTemplate" );
		}
		
		return jdbcTemplate.queryForInt( sb.toString() );
	}
	
	public boolean isExist(T t) {
		return false;
	}
	
	public boolean isHasIdValue( T t){
		return false;
	}
}
