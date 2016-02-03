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
public interface FavoriteListService {
	/***
	 * 获得推荐房源列表
	 * @param auth,验证字段
	 * @param tenant_id,房客编号
	 * @param room_id,房源编号
	 * @return
	 */
	@Path("/save/")
	@POST
	@Produces({MediaType.APPLICATION_FORM_URLENCODED})
	Response save(@FormParam("auth") String auth, @FormParam("tenant_id") String tenant_id, @FormParam("room_id") String room_id);
	
	/***
	 * 获得推荐房源列表
	 * @param auth,验证字段
	 * @param tenant_id,房客编号
	 * @param room_id,房源编号
	 * @return
	 */
	@Path("/query/")
	@POST
	@Produces({MediaType.APPLICATION_FORM_URLENCODED})
	Response query(@FormParam("auth") String auth, @FormParam("tenant_id") String tenant_id);
	
	/**
	 * 根据房客id和中意房源的id,删除中意列表
	 * @param auth
	 * @param uid
	 * @param delIds
	 * @return
	 */
	@Path("/delete/")
	@POST
	@Produces({MediaType.APPLICATION_FORM_URLENCODED})
	Response delFeaturedList(@FormParam("auth") String auth,@FormParam("uid") String uid, @FormParam("delIds") String delIds);
}
