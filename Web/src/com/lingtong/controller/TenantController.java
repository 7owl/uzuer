package com.lingtong.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.lingtong.bo.TenantsBo;
import com.lingtong.model.Pagination;
import com.lingtong.model.Tenants;
import com.lingtong.util.GetParams;


@Controller
public class TenantController {
	@Resource(name="tenantsBoImpl")
	private TenantsBo tenantsBo;
	/**
	 * 跳转到房客页面
	 * */
	@RequestMapping("/viewTenant")
	public ModelAndView viewTenat( HttpServletResponse resp, HttpServletRequest req ){
		ModelAndView view = new ModelAndView("tenant");
		return view;
	}
	
	/***
	 * 增加房客
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping(value="/saveTenant")
	public @ResponseBody Map<String, Object> saveTenant( HttpServletResponse resp, HttpServletRequest req) throws UnsupportedEncodingException{
		req.setCharacterEncoding("utf-8");
		String string = req.getParameter("tenant");
		Tenants tenant = null;
		if( StringUtils.isNotBlank(string) ){
			tenant = new Gson().fromJson(string, Tenants.class);
		}
		Map<String, Object> map = tenantsBo.save(tenant);
		return map;
	}
	
	@RequestMapping(value="/queryTenant")
	public @ResponseBody Map<String, Object> queryTenant( HttpServletResponse resp, HttpServletRequest req) throws UnsupportedEncodingException{
		req.setCharacterEncoding("utf8");
		Pagination page = new Pagination();
		GetParams.getInstance().getParam(req, page);
		Map<String, Object> results = new HashMap<String, Object>();
		List<Tenants> tenants = new ArrayList<Tenants>();
		results.put("rows", tenants);
		results.put("total", 0);
		tenantsBo.query( page, results );
		return results;
	}
	
	/***
	 * 删除房客
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping(value="/deleteTenant")
	public @ResponseBody Map<String, Object> deleteTenant( HttpServletResponse resp, HttpServletRequest req, @RequestParam("delIds") String delIds){
		
		Map<String, Object> map = tenantsBo.delete( delIds );
		return map;
	}
	
	@RequestMapping("/updateAuthState")
	public @ResponseBody Map<String, Object> updateAuthState( HttpServletResponse resp, HttpServletRequest req, @RequestParam("tenantid") String tenantid){
		
		Map<String, Object> map = tenantsBo.updateAuthState(tenantid);
		return map;
	}	
}
