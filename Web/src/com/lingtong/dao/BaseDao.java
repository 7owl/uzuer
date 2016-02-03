package com.lingtong.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;
/**
 * @author xqq
 * @date 2015-8-9 下午3:08:23
 * 
 */
public interface BaseDao<T extends Object> {
	/**
	 * 
	 * @param t
	 * @param tableName
	 * @param className
	 * @param idField
	 * @return
	 */
	public Map<String, Object> save( T t, String tableName, String idField, String className );
	
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
	public List<T> select( String[] tables, String idField, String[] projects, String where, String className, Map<String, Object> results );
	
	/***
	 * 统计总数
	 * @param tables
	 * @param idField
	 * @param where
	 * @param results
	 * @param className,T对应的类型
	 * @return
	 */
	public Integer count( String[] tables, String idField, String where );
	
	public boolean isExist(T t);
	
	public boolean isHasIdValue( T t);
}
