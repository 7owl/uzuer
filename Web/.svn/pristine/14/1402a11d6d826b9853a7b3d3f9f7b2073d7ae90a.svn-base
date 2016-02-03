package com.lingtong.interfaces;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.commons.lang.NumberUtils;
import org.apache.commons.lang.StringUtils;

import com.google.gson.Gson;
import com.lingtong.dao.RoomDao;
import com.lingtong.dao.impl.RoomDaoImpl;
import com.lingtong.interfaces.interceptor.Auth;
import com.lingtong.interfaces.interceptor.ReturnJSON;
import com.lingtong.interfaces.message.AppRoomPage;
import com.lingtong.interfaces.message.CommonErrorEnum;
import com.lingtong.interfaces.message.FaultTolerant;
import com.lingtong.vo.RoomVo;

/**
 * @author xqq
 * @date 2015-8-15 下午1:30:05
 * 
 */
public class RoomServiceImpl implements RoomService{
	private RoomDao roomDao = new RoomDaoImpl();
	
	public Response getFeaturedList(String auth, String cityid) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		FaultTolerant fault = new Gson().fromJson(auth, FaultTolerant.class);
		//进行验证
		if( !"0".equals( fault.getUid() ) ){
			if( Auth.auth( fault ) == false ){
				result.put("code", CommonErrorEnum.FAULT_FOLERANT.getCode());
				result.put("msg", CommonErrorEnum.FAULT_FOLERANT.getMessage());
				return ReturnJSON.getInstance().ret(result);
			}
		}
		
		result = roomDao.getFeaturedList(cityid);
		
		return ReturnJSON.getInstance().ret(result);
	}

	public Response getRoomList(String pageStr, String lonAndLat, String auth, String comm_name, String cityid) {
		Map<String, Object> result = new HashMap<String, Object>();
		AppRoomPage page = new Gson().fromJson(pageStr, AppRoomPage.class);
		
		FaultTolerant fault = new Gson().fromJson(auth, FaultTolerant.class);
		//进行验证
		if( !"0".equals( fault.getUid() ) ){
			if( Auth.auth( fault ) == false ){
				result.put("code", CommonErrorEnum.FAULT_FOLERANT.getCode());
				result.put("msg", CommonErrorEnum.FAULT_FOLERANT.getMessage());
				return ReturnJSON.getInstance().ret(result);
			}
		}
		
		/*int page = 0;//当前页默认是0
		if( NumberUtils.isNumber( curPage ) ){//如果当前页
			page = Integer.parseInt( curPage );
		}*/
		
		result = roomDao.getRoomList( page, lonAndLat, comm_name, cityid );
		return ReturnJSON.getInstance().ret(result);
	}

	
	public Response getRoomDetail(String auth, String roomid) {
		Map<String, Object> result = new HashMap<String, Object>();

		FaultTolerant fault = new Gson().fromJson(auth, FaultTolerant.class);
		// 进行验证
		if (!"0".equals(fault.getUid())) {
			if (Auth.auth(fault) == false) {
				result.put("code", CommonErrorEnum.FAULT_FOLERANT.getCode());
				result.put("msg", CommonErrorEnum.FAULT_FOLERANT.getMessage());
				return ReturnJSON.getInstance().ret(result);
			}
		}
		if( StringUtils.isBlank( roomid ) ){
			result.put("code", CommonErrorEnum.ROOM_IS_NOT_EXIST.getCode());
			result.put("msg", CommonErrorEnum.ROOM_IS_NOT_EXIST.getMessage());
			return ReturnJSON.getInstance().ret(result);
		}
		
		result = roomDao.getRoomDetailById(roomid);
		return ReturnJSON.getInstance().ret(result);
	}

	
	
}
