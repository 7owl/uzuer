package com.lingtong.bo;

import java.util.List;
import java.util.Map;

import com.lingtong.model.Pagination;
import com.lingtong.model.Room;
import com.lingtong.vo.RoomVo;

/**
 * 
 * @author MTT
 * @date 2015-8-4
 */
public interface RoomBo {
	/**
	 * 房源保存修改
	 * @param room
	 * @return
	 */
	public Map<String, Object> save (Room room);
	/**
	 * 房源是否存在
	 * @param room
	 * @return
	 */
	public boolean isExist(Room room);
	/**
	 * 分页查询
	 * @param page
	 * @param results
	 * @return
	 */
	public List<RoomVo> query ( Pagination page, Map<String, Object> results );
//	public List<Room> query ( Pagination page, Map<String, Object> results );
 
	/**
	 * 删除 房源
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
	
	/**
	 * @param roomSeq
	 */
	public RoomVo getRoomDetailByRoomSeq(String roomSeq);
	/**
	 * @param page
	 * @param results
	 */
	public List<RoomVo> queryLock(Pagination page, Map<String, Object> results);
	
}
