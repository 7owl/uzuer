package com.lingtong.interfaces;

import javax.ws.rs.FormParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

/**
 * @author xqq
 * @date 2015-9-18 下午9:04:04
 * 
 */
public interface ContractService {
	@Path("/viewConstract/")
	@POST
	@Produces({MediaType.APPLICATION_FORM_URLENCODED})
	Response viewConstract(@FormParam("auth") String auth, @FormParam("roomid") String roomid , @FormParam("constractType") String constractType);

	
	@Path("/uploadConstract/")
	@POST
	@Produces({MediaType.APPLICATION_FORM_URLENCODED})
	Response uploadConstract(@FormParam("auth") String auth, @FormParam("roomid") String roomid , @FormParam("constractType") String constractType);

	
	/**
	 * 数据库里生产对应合同记录 ，拆分订单
	 * 按照信息内容生成合同 file 
	 * 调用上上签接口上传合同，并获取预览合同url 
	 * @param auth
	 * @param roomid
	 * @param constractType
	 * @param tenantid
	 * @return
	 */
	@Path("/signConstract/")
	@POST
	@Produces({MediaType.APPLICATION_FORM_URLENCODED})
	Response signConstract(@FormParam("auth") String auth,
							@FormParam("roomid") String roomid ,
							@FormParam("constractType") String constractType ,
							@FormParam("tenantid") String tenantid);
	
	@Path("/getContractByTenantId/")
	@POST
	@Produces({MediaType.APPLICATION_FORM_URLENCODED})
	Response getContractByTenantId(@FormParam("auth") String auth,@FormParam("tenantid") String tenantid);
	
	/*********************************************上上签,合同签署开始***************************************************/
	/***
	 * 合同上传并发送
	 * @param auth,验证字段
	 * @param tenant_id,房客编号
	 * @param room_id,房源编号
	 * @return
	 */
	@Path("/uploadAndSend/")
	@POST
	@Produces({MediaType.APPLICATION_FORM_URLENCODED})
	Response save(@FormParam("auth") String auth, @FormParam("contractno") String contractno);
	
	@Path("/sign/")
	@POST
	@Produces({MediaType.APPLICATION_FORM_URLENCODED})
	Response sign(@FormParam("auth") String auth, @FormParam("contractno") String contractno);
	
	@Path("/view/")
	@POST
	@Produces({MediaType.APPLICATION_FORM_URLENCODED})
	Response view(@FormParam("auth") String auth, @FormParam("contractno") String contractno);
	/*********************************************上上签,合同签署结束***************************************************/
}
