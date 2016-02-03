package com.lingtong.bo.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.lingtong.bo.RoomBo;
import com.lingtong.dao.RoomDao;
import com.lingtong.model.Pagination;
import com.lingtong.model.Room;
import com.lingtong.vo.RoomVo;
/**
 * 
 * @author MTT
 * @date 2015-8-4
 */
@Component("roomBoImpl")
public class RoomBoImpl implements RoomBo {

	@Resource(name ="roomDaoImpl")
	private RoomDao roomDao;
	
	public Map<String, Object> save(Room room) {
		return roomDao.save(room);
	}

	public boolean isExist(Room room) {
		return roomDao.isExist(room);
	}

	public List<RoomVo> query(Pagination page, Map<String, Object> results) {
		return roomDao.query(page, results);
	}

	public Map<String, Object> delete(String delIds) {
		return roomDao.delete(delIds);
	}

	public void updateRoomCityId(String comm_address, String comm_name,
			Integer comm_id) {
		roomDao.updateRoomCityId(comm_address, comm_name, comm_id);
	}

	public RoomVo getRoomDetailByRoomSeq(String roomSeq) {
		return roomDao.getRoomDetailByRoomSeq(roomSeq);
	}

	public List<RoomVo> queryLock(Pagination page, Map<String, Object> results) {
		return roomDao.queryLock(page, results);
	}

}
