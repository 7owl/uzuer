package com.lingtong.interfaces.interceptor;

import java.util.Map;

import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.google.gson.Gson;

/**
 * @author xqq
 * @date 2015-8-16 上午10:56:03
 * 
 */
public class ReturnJSON {
	private static ReturnJSON ret;
	
	private ReturnJSON() {}
	
	public static ReturnJSON getInstance(){
		if( ret == null ){
			ret = new ReturnJSON();
		}
		return ret;
	}
	
	public Response ret(Map<String, Object> result){
		String str = new Gson().toJson( result );
		return Response.ok()
				   .entity(str)
				   .header(HttpHeaders.CONTENT_TYPE,
	                 MediaType.APPLICATION_JSON + ";charset=UTF-8").build();
	}
}
