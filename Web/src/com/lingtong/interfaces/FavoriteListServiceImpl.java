package com.lingtong.interfaces;

import java.util.HashMap;
import java.util.Map;

import javax.ws.rs.core.Response;

import org.apache.commons.lang.NumberUtils;

import com.google.gson.Gson;
import com.lingtong.dao.FavoriteListDao;
import com.lingtong.dao.impl.FavoriteListDaoImpl;
import com.lingtong.interfaces.interceptor.Auth;
import com.lingtong.interfaces.interceptor.ReturnJSON;
import com.lingtong.interfaces.message.CommonErrorEnum;
import com.lingtong.interfaces.message.FaultTolerant;

/**
 * @author xqq
 * @date 2015-8-16 下午4:31:43
 * 
 */
public class FavoriteListServiceImpl implements FavoriteListService {
	private FavoriteListDao ftDao = new FavoriteListDaoImpl();
	
	public Response save(String auth, String tenant_id, String room_id) {
		Map<String, Object> result = new HashMap<String, Object>();
		FaultTolerant fault = new Gson().fromJson(auth, FaultTolerant.class);
		//进行验证
		if( Auth.auth( fault ) == false ){
			result.put("code", CommonErrorEnum.FAULT_FOLERANT.getCode());
			result.put("msg", CommonErrorEnum.FAULT_FOLERANT.getMessage());
			return ReturnJSON.getInstance().ret(result);
		}
		
		result = ftDao.save(tenant_id, room_id);
		return ReturnJSON.getInstance().ret( result );
	}

	public Response query(String auth, String tenant_id) {
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
		result = ftDao.query(tenant_id);
		return ReturnJSON.getInstance().ret( result );
	}
	
	public Response delFeaturedList(String auth, String uid, String delIds) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		FaultTolerant fault = new Gson().fromJson(auth, FaultTolerant.class);
		//进行验证
		if( Auth.auth( fault ) == false ){
			result.put("code", CommonErrorEnum.FAULT_FOLERANT.getCode());
			result.put("msg", CommonErrorEnum.FAULT_FOLERANT.getMessage());
			return ReturnJSON.getInstance().ret(result);
		}
		
		if( !NumberUtils.isNumber( uid ) ){
			result.put("code", CommonErrorEnum.TENANT_IS_NOT_EXIST.getCode());
			result.put("msg", CommonErrorEnum.TENANT_IS_NOT_EXIST.getMessage());
			return ReturnJSON.getInstance().ret(result);
		}
		result = ftDao.delFeaturedList(Integer.valueOf( uid ), delIds);
		
		return ReturnJSON.getInstance().ret(result);
	}
}
