package com.lingtong.dao;

import java.util.Map;

/**
 * @author xqq
 * @date 2015-8-16 下午4:32:30
 * 
 */
public interface FavoriteListDao {
	
	
	/**********************************app 专用接口*****************************************/
	/**
	 * 添加或修改中意列表
	 * @param tenant_id,房客编号
	 * @param room_id,房源编号
	 * @return
	 */
	public Map<String, Object> save(String tenant_id, String room_id);
	
	/**
	 * 根据房客编号,查找中意的房源
	 * @param tenant_id,房客编号
	 * @param cityid,城市过滤
	 * @return
	 */
	public Map<String, Object> query(String tenant_id);
	
	/***
	 * 根据房客id和中意房源的id,删除中意列表
	 * @param uid
	 * @param delIds
	 * @return
	 */
	public Map<String, Object> delFeaturedList(Integer uid, String delIds);
}
