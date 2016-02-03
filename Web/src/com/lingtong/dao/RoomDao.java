package com.lingtong.dao;

import java.util.List;
import java.util.Map;

import com.lingtong.interfaces.message.AppRoomPage;
import com.lingtong.model.Pagination;
import com.lingtong.model.Room;
import com.lingtong.vo.RoomVo;
 

/**
 * 
 * @author MTT
 * @date 2015-8-4
 */
public interface RoomDao {
	/**
	 * 房源 增加或修改
	 * @return
	 */
	public Map<String, Object> save( Room room );
	
	/**
	 * 检查是否存在
	 * */
	public boolean isExist( Room room );
	
	/***
	 * 分页查询
	 * @param page
	 * @param results
	 * @return
	 */
//	public List<Room> query( Pagination page, Map<String, Object> results );
	public List<RoomVo> query( Pagination page, Map<String, Object> results );
	
	/**
	 * 删除
	 * @param delIds
	 * @return
	 */
	public Map<String, Object> delete(String delIds);
	
	/***
	 * 当小区地址修改之后,修改房源地址
	 * @param comm_address
	 * @param comm_name
	 * @param comm_id
	 */
	public void updateRoomCityId(String comm_address, String comm_name, Integer comm_id);
	
	/**********************************app 专用接口*****************************************/
	/**
	 * 获得推荐房源
	 * @return
	 */
	public Map<String, Object> getFeaturedList(String cityid);
	
	/***
	 * 根据小区名获得未出租的房源
	 * @return
	 */
	public Map<String, Object> getRoomList( AppRoomPage page, String lonAndLat, String comm_name, String cityid );

	public Map<String, Object> getRoomDetailById(String roomid);

	/**
	 * @param roomSeq
	 * @return
	 */
	public RoomVo getRoomDetailByRoomSeq(String roomSeq);
	
	/**
	 * 合同用
	 * @param roomid
	 * @return
	 */
	public Map<String, Object> getRoomVoById(String roomid);

	/**
	 * @param page
	 * @param results
	 * @return
	 */
	public List<RoomVo> queryLock(Pagination page, Map<String, Object> results);
	
}
