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
import com.lingtong.bo.CommunityBo;
import com.lingtong.model.Community;
import com.lingtong.model.Pagination;
import com.lingtong.util.GetParams;
import com.lingtong.vo.CommunityVo;

@Controller
public class CommunityController {
	@Resource(name="communityBoImpl")
	private CommunityBo communityBoImpl;
	
	/**
	 * 跳转到小区页面
	 * */
	@RequestMapping("/viewCommunity")
	public ModelAndView viewHomeMaker( HttpServletResponse resp, HttpServletRequest req ){
		ModelAndView view = new ModelAndView("community");
		return view;
	}
	
	/***
	 * 增加小区
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping(value="/saveCommunity")
	public @ResponseBody Map<String, Object> saveCommunity( HttpServletResponse resp, HttpServletRequest req) throws UnsupportedEncodingException{
		req.setCharacterEncoding("utf-8");
		String string = req.getParameter("community");
		Community community = null;
		if( StringUtils.isNotBlank(string) ){
			community = new Gson().fromJson(string, Community.class);
		}
		Map<String, Object> map = communityBoImpl.save( community );
		return map;
	}
	
	@RequestMapping(value="/queryCommunity")
	public @ResponseBody Map<String, Object> queryCommunity( HttpServletResponse resp, HttpServletRequest req) throws UnsupportedEncodingException{
		req.setCharacterEncoding("utf8");
		Pagination page = new Pagination();
		GetParams.getInstance().getParam(req, page);
		Map<String, Object> results = new HashMap<String, Object>();
		List<Community> communitys = new ArrayList<Community>();
		results.put("rows", communitys);
		results.put("total", 0);
		communityBoImpl.query( page, results );
		return results;
	}
	
	/***
	 * 删除小区
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping(value="/deleteCommunity")
	public @ResponseBody Map<String, Object> deleteCommunity( HttpServletResponse resp, HttpServletRequest req, @RequestParam("delIds") String delIds){
		
		Map<String, Object> map = communityBoImpl.delete( delIds );
		return map;
	}
	
	@RequestMapping(value="/comms")
	public @ResponseBody List<CommunityVo> hms( HttpServletResponse resp, HttpServletRequest req) throws UnsupportedEncodingException{
		
		Pagination page = new Pagination();
		page.setPage(1);
		page.setRows(Integer.MAX_VALUE);
		
		Map<String, Object> results = new HashMap<String, Object>();
		List<CommunityVo> comms = new ArrayList<CommunityVo>();
		comms = communityBoImpl.query( page, results );
		return comms;
	} 
	
}
