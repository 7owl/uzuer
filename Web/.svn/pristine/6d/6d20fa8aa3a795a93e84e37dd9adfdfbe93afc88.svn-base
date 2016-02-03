package com.lingtong.interfaces;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.commons.lang.NumberUtils;
import org.apache.commons.lang.StringUtils;

import com.google.gson.Gson;
import com.lingtong.dao.CommunityDao;
import com.lingtong.dao.impl.CommunityDaoImpl;
import com.lingtong.interfaces.interceptor.Auth;
import com.lingtong.interfaces.interceptor.ReturnJSON;
import com.lingtong.interfaces.message.CommonErrorEnum;
import com.lingtong.interfaces.message.FaultTolerant;
import com.lingtong.model.Community;
import com.lingtong.vo.CommunityVo;

/**
 * @author xqq
 * @date 2015-8-15 下午1:26:33
 * 
 */
public class CommunityServiceImpl implements CommunityService{
	private CommunityDao commDao = new CommunityDaoImpl();
	
	public Response getCommunityByName(String auth, String comm_name, String cityid ){
		List<CommunityVo> comms = commDao.getCommunityByName( comm_name, cityid );
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
		result.put("code", 0);
		result.put("msg", "查询成功");
		result.put("data", comms);
		
		return ReturnJSON.getInstance().ret(result);
	}

	public Response getCommunityByDistance(String auth, String lonAndLat,
			String r) {
		Double distance = 0.0;
		if( StringUtils.isBlank(r) || !NumberUtils.isNumber( r ) ){
			distance = 3.0;//默认是3千米
		} else {
			distance = Double.valueOf( r );
		}
		
		List<CommunityVo> comms = commDao.getCommunityByDistance(lonAndLat, distance);
		
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
		result.put("code", 0);
		result.put("msg", "查询成功");
		result.put("data", comms);
		
		return ReturnJSON.getInstance().ret(result);
	}

}
