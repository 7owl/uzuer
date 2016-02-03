package com.lingtong.interfaces;

import javax.ws.rs.FormParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

/**
 * @author xqq
 * @date 2015-8-15 下午1:26:33
 * 
 */
public interface CommunityService {
	/***
	 * 根据小区名,获得小区列表
	 * @param tel_number
	 * @return 
	 */
	@Path("/getCommunityByName/")
	@POST
	Response getCommunityByName( @FormParam("auth") String auth, @FormParam("comm_name") String comm_name, @FormParam("cityid") String cityid );
	
	/***
	 * 根据返回搜索小区
	 * @param tel_number
	 * @return 
	 */
	@Path("/getCommunityByDistance/")
	@POST
	Response getCommunityByDistance( @FormParam("auth") String auth, @FormParam("lonAndLat") String lonAndLat, @FormParam("r") String r );
}
