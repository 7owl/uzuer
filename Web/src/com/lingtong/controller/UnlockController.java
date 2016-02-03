package com.lingtong.controller;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.NumberUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.lingtong.bo.TenantsBo;
import com.lingtong.bo.UnlockBo;
import com.lingtong.model.Pagination;
import com.lingtong.model.Tenants;
import com.lingtong.util.GetParams;


@Controller
public class UnlockController {
	@Resource(name="unlockBoImpl")
	private UnlockBo unlockBo;
	
	/**
	 * 跳转到钥匙页面
	 * */
	@RequestMapping("/viewUnlock")
	public ModelAndView viewKey( HttpServletResponse resp, HttpServletRequest req ){
		ModelAndView view = new ModelAndView("unlock");
		return view;
	}
	
	
	@RequestMapping(value="/queryUnlock")
	public @ResponseBody Map<String, Object> queryKey( HttpServletResponse resp, HttpServletRequest req) throws UnsupportedEncodingException{
		req.setCharacterEncoding("utf8");
		Pagination page = new Pagination();
		GetParams.getInstance().getParam(req, page);
		System.out.println(page.getQueryType() + ":" +page.getQueryWord());
		Map<String, Object> results = new HashMap<String, Object>();
		
		
		unlockBo.query( page, results );
		return results;
	}
	
	/***
	 * 删除钥匙
	 * 
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/deleteUnlock")
	public @ResponseBody
	Map<String, Object> deleteKey(HttpServletResponse resp,
			HttpServletRequest req, @RequestParam("delIds") String delIds) {		
		Map<String, Object> map = unlockBo.delete(delIds);
		return map;
	}
	
	
}
