package com.lingtong.interfaces;

import java.util.HashMap;
import java.util.Map;

import javax.ws.rs.FormParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.google.gson.Gson;
import com.lingtong.dao.OrderDao;
import com.lingtong.dao.RoomDao;
import com.lingtong.dao.impl.OrderDaoImpl;
import com.lingtong.dao.impl.RoomDaoImpl;
import com.lingtong.interfaces.interceptor.Auth;
import com.lingtong.interfaces.interceptor.ReturnJSON;
import com.lingtong.interfaces.message.CommonErrorEnum;
import com.lingtong.interfaces.message.FaultTolerant;

public class OrderServiceImpl  implements OrderService{

	private OrderDao orderDao = new OrderDaoImpl();
	
	public Response updateState(String auth, String roomid, String orderid) {

		Map<String, Object> result = new HashMap<String, Object>();
		FaultTolerant fault = new Gson().fromJson(auth, FaultTolerant.class);
		// 进行验证
		if (Auth.auth(fault) == false) {
			result.put("code", CommonErrorEnum.FAULT_FOLERANT.getCode());
			result.put("msg", CommonErrorEnum.FAULT_FOLERANT.getMessage());
			return ReturnJSON.getInstance().ret(result);
		}
		
		result =  orderDao.updateState(roomid, orderid);
		
		return ReturnJSON.getInstance().ret(result);
	}

	public Response getOrdersByContractNo(String auth, String contractid) {
		Map<String, Object> result = new HashMap<String, Object>();
		FaultTolerant fault = new Gson().fromJson(auth, FaultTolerant.class);
		// 进行验证
		if (Auth.auth(fault) == false) {
			result.put("code", CommonErrorEnum.FAULT_FOLERANT.getCode());
			result.put("msg", CommonErrorEnum.FAULT_FOLERANT.getMessage());
			return ReturnJSON.getInstance().ret(result);
		}
		result = orderDao.getOrdersByContractNo(contractid);
		return ReturnJSON.getInstance().ret(result);
	}

//	 
//	public Response notify(String notify_id) {
//		
//		System.out.println(" test 接口调用");
//		
//		return Response.ok().entity("success").header(HttpHeaders.CONTENT_TYPE,
//                MediaType.APPLICATION_JSON + ";charset=UTF-8").build();
//	}
//	
}
