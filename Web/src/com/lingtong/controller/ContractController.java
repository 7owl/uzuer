package com.lingtong.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.NumberUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.lingtong.bo.ContractBo;
import com.lingtong.model.Contract;
import com.lingtong.model.Pagination;
import com.lingtong.util.GetParams;
import com.ssqian.signature.open.action.sign.ViewContract;

@Controller
public class ContractController {
	@Resource(name="contractBoImpl")
	private ContractBo contractBoImpl;
	
	@RequestMapping("/viewContractInfo")
	public ModelAndView skip(HttpServletRequest req, HttpServletResponse resp){
		ModelAndView model = new ModelAndView("contractinfo");
		
		return model;
	} 
	
	@RequestMapping("/queryContract")
	public @ResponseBody Map<String, Object> query(HttpServletRequest req, HttpServletResponse resp) throws UnsupportedEncodingException{
		Map<String, Object> results = new HashMap<String, Object>();
		
		req.setCharacterEncoding("utf8");
		Pagination page = new Pagination();
		GetParams.getInstance().getParam(req, page);
		contractBoImpl.query(page, results);
		return results;
	} 
	
	@RequestMapping("/previewContract")
	public void preview(HttpServletRequest req, HttpServletResponse resp) throws UnsupportedEncodingException{
		String id = req.getParameter("id");
		String url = "";
		String msg = "";
		Contract con = null;
		if( NumberUtils.isNumber( id ) ){
			con = contractBoImpl.queryById( Integer.parseInt( id ) );
			if( con != null ){
				if( StringUtils.isNotBlank( con.getSignid() ) && StringUtils.isNotBlank( con.getDocid() ) ){
					try {
						url = ViewContract.excute(con.getSignid(), con.getDocid());
					} catch (IOException e) {
						e.printStackTrace();
					}
				} else {
					msg = "此合同信息不全,无法预览......";
				}
			} else {
				msg = "合同不存在......";
			}
		} else {
			msg = "合同不存在......";
		}
		
		if( StringUtils.isNotBlank( url ) ){
			try {
				resp.sendRedirect(url);
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {
			try {
				resp.setHeader("Content-type", "text/html;charset=UTF-8");
				resp.setCharacterEncoding("utf-8");
				resp.getWriter().write( msg );
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				try {
					if( resp.getWriter() != null ){
						resp.getWriter().close();
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		
	}
}
