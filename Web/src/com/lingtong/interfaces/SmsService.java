package com.lingtong.interfaces;

import javax.ws.rs.FormParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;


public interface SmsService {
	
	/***
	 * 获取验证码
	 * @param tel_number
	 * @return
	 */
	@Path("/requestSmsCode/")
	@POST
	@Produces({MediaType.APPLICATION_FORM_URLENCODED})
	Response requestSmsCode( @FormParam("tel_number")String tel_number );
}
