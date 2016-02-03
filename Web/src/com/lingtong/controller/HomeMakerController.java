package com.lingtong.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.NumberUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.lingtong.bo.HomeMakerBo;
import com.lingtong.model.HomeMaker;
import com.lingtong.model.Pagination;
import com.lingtong.util.GetParams;

@Controller
public class HomeMakerController {

	@Resource(name="homeMakerBoImpl")
	private HomeMakerBo homeMakerBo;
	
	/**
	 * 跳转到管家页面
	 * */
	@RequestMapping("/viewHomeMaker")
	public ModelAndView viewHomeMaker( HttpServletResponse resp, HttpServletRequest req ){
		ModelAndView view = new ModelAndView("homemaker");
		return view;
	}
	/***
	 * 增加管家
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping(value="/saveHomeMaker")
	public @ResponseBody Map<String, Object> saveHomeMaker( HttpServletResponse resp, HttpServletRequest req) throws UnsupportedEncodingException{
		req.setCharacterEncoding("utf-8");
		String string = req.getParameter("homemaker");
		HomeMaker homeMaker = null;
		if( StringUtils.isNotBlank(string) ){
			homeMaker = new Gson().fromJson(string, HomeMaker.class);
		}
		Map<String, Object> map = homeMakerBo.save(homeMaker);
		return map;
	}
	
	@RequestMapping(value="/queryHomeMaker")
	public @ResponseBody Map<String, Object> queryHomeMaker( HttpServletResponse resp, HttpServletRequest req) throws UnsupportedEncodingException{
		req.setCharacterEncoding("utf8");
		Pagination page = new Pagination();
		GetParams.getInstance().getParam(req, page);
		Map<String, Object> results = new HashMap<String, Object>();
		List<HomeMaker> homeMakers = new ArrayList<HomeMaker>();
		results.put("rows", homeMakers);
		results.put("total", 0);
		homeMakerBo.query( page, results );
		return results;
	}
	
	@RequestMapping(value="/hms")
	public @ResponseBody List<HomeMaker> hms( HttpServletResponse resp, HttpServletRequest req) throws UnsupportedEncodingException{
		
		Pagination page = new Pagination();
		page.setPage(1);
		page.setRows(Integer.MAX_VALUE);
		
		Map<String, Object> results = new HashMap<String, Object>();
		List<HomeMaker> hms = new ArrayList<HomeMaker>();
		hms = homeMakerBo.query( page, results );
		return hms;
	}
	
	/***
	 * 增加管家
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping(value="/deleteHomeMaker")
	public @ResponseBody Map<String, Object> deleteHomeMaker( HttpServletResponse resp, HttpServletRequest req, @RequestParam("delIds") String delIds){
		
		Map<String, Object> map = homeMakerBo.delete( delIds );
		return map;
	}
	
	@RequestMapping(value="/hms/{id}")
	public @ResponseBody HomeMaker hms( HttpServletResponse resp, HttpServletRequest req, @PathVariable("id") String id) throws UnsupportedEncodingException{
		HomeMaker hm = new HomeMaker();
		if( NumberUtils.isNumber( id )){
			hm = homeMakerBo.getHomeMakerById( Integer.parseInt( id ) );
		}
		return hm;
	}
	
}
