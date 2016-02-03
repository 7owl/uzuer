package com.lingtong.interfaces;

import javax.ws.rs.FormParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

/**
 * @author xqq
 * @date 2015-8-16 下午4:28:41
 * 
 */
public interface ComplainService {
	/***
	 * 用户抱怨
	 * @param auth,验证字段
	 * @param tenant_id,房客编号
	 * @param room_id,房源编号
	 * @return
	 */
	@Path("/save/")
	@POST
	@Produces({MediaType.APPLICATION_FORM_URLENCODED})
	Response save(@FormParam("auth") String auth, @FormParam("complain") String complain);
}
