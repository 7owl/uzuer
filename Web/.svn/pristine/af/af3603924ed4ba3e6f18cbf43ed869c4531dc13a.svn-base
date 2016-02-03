package com.lingtong.interfaces;

import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.cxf.jaxrs.ext.multipart.Multipart;
public interface TenantService {
	/***
	 * 用手机号码进行注册和登录
	 * @param tel_number
	 * @return
	 */
	@Path("/save/")
	@POST
	@Produces({MediaType.APPLICATION_FORM_URLENCODED})
	Response save(@FormParam("tel_number")String tel_number, @FormParam("smsCode") String smsCode);
	
	/***
	 * 房客,即用户更改资料
	 * @param info
	 * @return
	 */
	@Path("/edit/")
	@POST
	@Produces({MediaType.APPLICATION_FORM_URLENCODED})
	Response edit(@FormParam("tenant") String tenant, @FormParam("auth") String auth);
	
	/***
	 * 
	 * @param info
	 * @return
	 */
	@Path("/getTenantDetail/")
	@POST
	@Produces({MediaType.APPLICATION_FORM_URLENCODED})
	Response getDetail(@FormParam("tenantid") String tenantid, @FormParam("uuid") String uuid ,
			@FormParam("clientid") String clientid,@FormParam("auth") String auth, @FormParam("devicetoken") String devicetoken);
	
	/***
	 * activeEmail
	 */
	@Path("/activeEmail/")
	@GET
	@Produces("application/json")
	Response activeEmail(@QueryParam("tenant") String tenantid, @QueryParam("token") String token ,@QueryParam("platform") String platform);
	
	/**
	 * 上传用户证件照
	 * @param tenantid
	 * @param image
	 * @return
	 */
	@POST
	@Path("/authentication")
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	Response uploadFile(@Multipart("tenant")String tenant, @Multipart("imageFile1")byte[] image1,  @Multipart("imageFile2")byte[] image2,  @Multipart("imageFile3")byte[] image3, @Multipart("auth") String auth);	
}
