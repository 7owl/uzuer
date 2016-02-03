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
import com.lingtong.bo.HostsBo;
import com.lingtong.model.Pagination;
import com.lingtong.model.Hosts;
import com.lingtong.util.GetParams;
import com.lingtong.vo.CommunityVo;


@Controller
public class HostController {
	@Resource(name="hostsBoImpl")
	private HostsBo hostsBo;
	/**
	 * 跳转到房东页面
	 * */
	@RequestMapping("/viewHost")
	public ModelAndView viewTenat( HttpServletResponse resp, HttpServletRequest req ){
		ModelAndView view = new ModelAndView("host");
		return view;
	}
	
	/***
	 * 增加房东
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping(value="/saveHost")
	public @ResponseBody Map<String, Object> saveHost( HttpServletResponse resp, HttpServletRequest req) throws UnsupportedEncodingException{
		req.setCharacterEncoding("utf-8");
		String string = req.getParameter("host");
		Hosts host = null;
		if( StringUtils.isNotBlank(string) ){
			host = new Gson().fromJson(string, Hosts.class);
		}
		Map<String, Object> map = hostsBo.save(host);
		return map;
	}
	
	@RequestMapping(value="/queryHost")
	public @ResponseBody Map<String, Object> queryHost( HttpServletResponse resp, HttpServletRequest req) throws UnsupportedEncodingException{
		req.setCharacterEncoding("utf8");
		Pagination page = new Pagination();
		GetParams.getInstance().getParam(req, page);
		Map<String, Object> results = new HashMap<String, Object>();
		List<Hosts> hosts = new ArrayList<Hosts>();
		results.put("rows", hosts);
		results.put("total", 0);
		hostsBo.query( page, results );
		return results;
	}
	
	/***
	 * 增加房客
	 */
	@RequestMapping(value="/deleteHost")
	public @ResponseBody Map<String, Object> deleteHost( HttpServletResponse resp, HttpServletRequest req, @RequestParam("delIds") String delIds){
		
		Map<String, Object> map = hostsBo.delete( delIds );
		return map;
	}
	
	@RequestMapping(value="/hosts")
	public @ResponseBody List<Hosts> hosts( HttpServletResponse resp, HttpServletRequest req) throws UnsupportedEncodingException{
		Pagination page = new Pagination();
		page.setPage(1);
		page.setRows(Integer.MAX_VALUE);
		Map<String, Object> results = new HashMap<String, Object>();
		List<Hosts> hosts = new ArrayList<Hosts>();
		hosts = hostsBo.query( page, results );
		
		for(Hosts h :hosts)
		{
			h.setFirst_name((h.getFirst_name() +" " +h.getLast_name()));
		}
		
		return hosts;
	} 
	
	
}
