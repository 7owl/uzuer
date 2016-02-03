package com.lingtong.interfaces;

import javax.ws.rs.FormParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

/**
 * @author xqq
 * @date 2015-8-15 下午1:26:33
 * 
 */
public interface RoomService {
	/***
	 * 获得推荐房源列表
	 * @param tel_number
	 * @return
	 */
	@Path("/getFeaturedList/")
	@POST
	@Produces({MediaType.APPLICATION_FORM_URLENCODED})
	Response getFeaturedList(@FormParam("auth") String auth, @FormParam("cityid") String cityid);
	
	/***
	 * 根据小区名,获得未出租的房子
	 * @param tel_number
	 * @return
	 */
	@Path("/getRoomList/")
	@POST
	@Produces({MediaType.APPLICATION_FORM_URLENCODED})
	Response getRoomList(@FormParam("page") String page, @FormParam("lonAndLat") String lonAndLat, @FormParam("auth") String auth, @FormParam("comm_name") String comm_name, @FormParam("cityid") String cityid);

	/***
	 * 获得推荐房源列表
	 * @param tel_number
	 * @return
	 */
	@Path("/getRoomDetail/")
	@POST
	@Produces({MediaType.APPLICATION_FORM_URLENCODED})
	Response getRoomDetail(@FormParam("auth") String auth,@FormParam("roomid") String roomid);
	
	
}
