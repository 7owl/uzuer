package com.lingtong.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lingtong.bo.OrderBo;

@Controller
public class OrderController {
	@Resource(name="orderBoImpl")
	private OrderBo orderBoImpl;
	
	@RequestMapping("queryOrderByContractno")
	public @ResponseBody Map<String, Object> queryOrderByContractno(HttpServletRequest req, HttpServletResponse resp){
		String contractno = req.getParameter("contractno");
		Map<String, Object> result = new HashMap<String, Object>();
		
		if( StringUtils.isNotBlank( contractno ) ){
			result = orderBoImpl.getOrdersByContractNo( contractno );
		} else {
			result.put("total", 0);
			result.put("rows", new Object[]{});
		}
		return result;
	}
}