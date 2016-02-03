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
import com.lingtong.bo.BankInfoBo;
import com.lingtong.bo.BankInfoBo;
import com.lingtong.model.BankInfo;
import com.lingtong.model.BankInfo;
import com.lingtong.model.Pagination;
import com.lingtong.util.GetParams;


@Controller
public class BankInfoController {
	
	@Resource(name="bankInfoBoImpl")
	private BankInfoBo bankInfoBo;
	
	
	/**
	 *  
	 * */
	@RequestMapping("/viewBankInfo")
	public ModelAndView viewBankInfo( HttpServletResponse resp, HttpServletRequest req ){
		ModelAndView view = new ModelAndView("bankinfo");
		return view;
	}
	/***
	 *  
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping(value="/saveBankInfo")
	public @ResponseBody Map<String, Object> saveBankInfo( HttpServletResponse resp, HttpServletRequest req) throws UnsupportedEncodingException{
		req.setCharacterEncoding("utf-8");
		String string = req.getParameter("bankInfo");
		BankInfo bankInfo = null;
		if( StringUtils.isNotBlank(string) ){
			bankInfo = new Gson().fromJson(string, BankInfo.class);
		}
		Map<String, Object> map = bankInfoBo.save(bankInfo);
		return map;
	}
	
	@RequestMapping(value="/queryBankInfo")
	public @ResponseBody Map<String, Object> queryBankInfo( HttpServletResponse resp, HttpServletRequest req) throws UnsupportedEncodingException{
		req.setCharacterEncoding("utf8");
		Pagination page = new Pagination();
		GetParams.getInstance().getParam(req, page);
		Map<String, Object> results = new HashMap<String, Object>();
		List<BankInfo> BankInfos = new ArrayList<BankInfo>();
		results.put("rows", BankInfos);
		results.put("total", 0);
		bankInfoBo.query( page, results );
		return results;
	}
	
	
	/***
	 * 
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping(value="/deleteBankInfo")
	public @ResponseBody Map<String, Object> deleteBankInfo( HttpServletResponse resp, HttpServletRequest req, @RequestParam("delIds") String delIds){
		Map<String, Object> map = bankInfoBo.delete( delIds );
		return map;
	}
}
