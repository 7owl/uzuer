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
import com.lingtong.bo.CompanyBo;
import com.lingtong.model.Company;
import com.lingtong.model.Hosts;
import com.lingtong.model.Pagination;
import com.lingtong.util.GetParams;
import com.lingtong.vo.CompanyVo;
/**
 * 
 * @author MTT
 * @date 2015-8-7
 */
@Controller
public class CompanyController {
	@Resource(name="companyBoImpl")
	private CompanyBo companyBo;
	/**
	 * 跳转到小区页面
	 * */
	@RequestMapping("/viewCompany")
	public ModelAndView viewCompany( HttpServletResponse resp, HttpServletRequest req ){
		ModelAndView view = new ModelAndView("company");
		return view;
	}
	/***
	 * 增加小区信息
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping(value="/saveCompany")
	public @ResponseBody Map<String, Object> saveCompany( HttpServletResponse resp, HttpServletRequest req) throws UnsupportedEncodingException{
		req.setCharacterEncoding("utf-8");
		String string = req.getParameter("company");
		Company company = null;
		if( StringUtils.isNotBlank(string) ){
			company = new Gson().fromJson(string, Company.class);
		}
		Map<String, Object> map = companyBo.save(company);
		return map;
	}
	
	@RequestMapping(value="/queryCompany")
	public @ResponseBody Map<String, Object> queryCompany( HttpServletResponse resp, HttpServletRequest req) throws UnsupportedEncodingException{
		req.setCharacterEncoding("utf8");
		Pagination page = new Pagination();
		GetParams.getInstance().getParam(req, page);
		Map<String, Object> results = new HashMap<String, Object>();
		List<Company> Companys = new ArrayList<Company>();
		results.put("rows", Companys);
		results.put("total", 0);
		companyBo.query( page, results );
		return results;
	}
	
	/***
	 * 增加Company
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping(value="/deleteCompany")
	public @ResponseBody Map<String, Object> deleteCompany( HttpServletResponse resp, HttpServletRequest req, @RequestParam("delIds") String delIds){
		
		Map<String, Object> map = companyBo.delete( delIds );
		return map;
	}
	
	
	@RequestMapping(value="/companys")
	public @ResponseBody List<CompanyVo> hosts( HttpServletResponse resp, HttpServletRequest req) throws UnsupportedEncodingException{
		Pagination page = new Pagination();
		page.setPage(1);
		page.setRows(Integer.MAX_VALUE);
		Map<String, Object> results = new HashMap<String, Object>();
		List<CompanyVo> companies = new ArrayList<CompanyVo>();
		companies = companyBo.query( page, results );
		
//		for(Hosts h :companies)
//		{
//			h.setFirst_name((h.getFirst_name() +" " +h.getLast_name()));
//		}
		return companies;
	} 
	
	
}
