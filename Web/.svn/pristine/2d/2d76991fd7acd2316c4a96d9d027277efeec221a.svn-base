package com.lingtong.interfaces;

import java.util.HashMap;
import java.util.Map;

import javax.ws.rs.core.Response;

import com.google.gson.Gson;
import com.lingtong.dao.ComplainDao;
import com.lingtong.dao.impl.ComplainDaoImpl;
import com.lingtong.interfaces.interceptor.Auth;
import com.lingtong.interfaces.interceptor.ReturnJSON;
import com.lingtong.interfaces.message.CommonErrorEnum;
import com.lingtong.interfaces.message.FaultTolerant;
import com.lingtong.model.Complain;

/**
 * @author xqq
 * @date 2015-8-16 下午9:51:18
 * 
 */
public class ComplainServiceImpl implements ComplainService {
	private ComplainDao complainDao = new ComplainDaoImpl();
	
	public Response save(String auth, String complain) {
		Map<String, Object> result = new HashMap<String, Object>();
		FaultTolerant fault = new Gson().fromJson(auth, FaultTolerant.class);
		Complain comp = new Gson().fromJson(complain, Complain.class);
		//进行验证
		if( !"0".equals( fault.getUid() ) ){
			if( Auth.auth( fault ) == false ){
				result.put("code", CommonErrorEnum.FAULT_FOLERANT.getCode());
				result.put("msg", CommonErrorEnum.FAULT_FOLERANT.getMessage());
				return ReturnJSON.getInstance().ret(result);
			}
		}
		
		result = complainDao.save(comp);
		return ReturnJSON.getInstance().ret(result);
	}

}
