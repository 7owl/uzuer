package com.lingtong.interfaces;

import java.util.Date;

import javax.ws.rs.FormParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

public interface OrderService {

	@Path("/updateState/")
	@POST
	@Produces({MediaType.APPLICATION_FORM_URLENCODED})
	Response updateState(@FormParam("auth") String auth, @FormParam("roomid") String roomid , @FormParam("orderid") String orderid);
	
	@Path("/getOrderList/")
	@POST
	@Produces({MediaType.APPLICATION_FORM_URLENCODED})
	Response getOrdersByContractNo(@FormParam("auth") String auth, @FormParam("contractid") String contractid);
	
//	@Path("/notify/")
//	@POST
//	@Produces({MediaType.APPLICATION_XML})
//	Response notify(@FormParam("") a);
	
	
}
