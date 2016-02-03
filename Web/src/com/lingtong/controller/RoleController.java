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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.lingtong.bo.RoleBo;
import com.lingtong.model.Pagination;
import com.lingtong.model.Role;
import com.lingtong.util.GetParams;

@Controller
public class RoleController {

	@Resource(name="roleBoImpl")
	private RoleBo roleBo;
	
	/**
	 * 跳转到角色页面
	 * */
	@RequestMapping("/viewRole")
	public ModelAndView viewRole( HttpServletResponse resp, HttpServletRequest req ){
		ModelAndView view = new ModelAndView("role");
		return view;
	}
	/***
	 * 增加角色
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping(value="/saveRole")
	public @ResponseBody Map<String, Object> saveRole( HttpServletResponse resp, HttpServletRequest req) throws UnsupportedEncodingException{
		req.setCharacterEncoding("utf-8");
		String string = req.getParameter("role");
		Role role = null;
		if( StringUtils.isNotBlank(string) ){
			role = new Gson().fromJson(string, Role.class);
		}
		Map<String, Object> map = roleBo.save(role);
		return map;
	}
	
	@RequestMapping(value="/queryRole")
	public @ResponseBody Map<String, Object> queryRole( HttpServletResponse resp, HttpServletRequest req) throws UnsupportedEncodingException{
		req.setCharacterEncoding("utf8");
		Pagination page = new Pagination();
		GetParams.getInstance().getParam(req, page);
		Map<String, Object> results = new HashMap<String, Object>();
		List<Role> roles = new ArrayList<Role>();
		results.put("rows", roles);
		results.put("total", 0);
		roleBo.query( page, results );
		return results;
	}
	
	/***
	 * 增加房客
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping(value="/deleteRole")
	public @ResponseBody Map<String, Object> deleteRole( HttpServletResponse resp, HttpServletRequest req, @RequestParam("delIds") String delIds){
		
		Map<String, Object> map = roleBo.delete( delIds );
		return map;
	}

	
}
