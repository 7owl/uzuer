package com.lingtong.dao;

import java.util.List;
import java.util.Map;

import com.lingtong.model.Pagination;
import com.lingtong.model.Hosts;

/**
 * @author xqq
 * @date 2015-8-2 下午12:03:02
 * 
 */
public interface HostsDao {
	/**
	 * 房东增加或修改
	 * @return
	 */
	public Map<String, Object> save( Hosts host );
	
	/**
	 * 检查是否存在
	 * */
	public boolean isExist( Hosts host );
	
	/***
	 * 分页查询
	 * @param page
	 * @param results
	 * @return
	 */
	public List<Hosts> query( Pagination page, Map<String, Object> results );
	
	/**
	 * 删除
	 * @param delIds
	 * @return
	 */
	public Map<String, Object> delete(String delIds);
	
	
	/**********************************app 专用接口*****************************************/
	
}
