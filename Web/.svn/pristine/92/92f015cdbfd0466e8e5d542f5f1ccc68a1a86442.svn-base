package com.lingtong.dao;

import java.util.List;
import java.util.Map;

import com.lingtong.model.Pagination;
import com.lingtong.model.Community;
import com.lingtong.vo.CommunityVo;
import com.lingtong.vo.RoomVo;

/**
 * @author xqq
 * @date 2015-8-6 下午10:31:46
 * 
 */
public interface CommunityDao {
	
	public Map<String, Object> save (Community community);
	
	public boolean isExist (Community community);
	
	//public List<Community> query (Pagination page , Map<String, Object> result);
	
	public List<CommunityVo> query (Pagination page , Map<String, Object> result);
	
	public Map<String , Object> delete(String delids);
	
	public List<Community> getCommAddressById(int comm_id);
	/***
	 * 小区是否可删,查多的一方,级联
	 * @return
	 */
	public boolean isDeleteCommnuity();
	/**********************************app 专用接口*****************************************/
	/**
	 * 根据小区名获得小区
	 * @return
	 */
	public List<CommunityVo> getCommunityByName( String comm_name, String cityid );

	/**
	 * 根据经纬度获得指定距离小区
	 * @return
	 */
	public List<CommunityVo> getCommunityByDistance( String lonAndLat, Double r );
}
