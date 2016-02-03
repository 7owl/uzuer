package com.lingtong.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.lingtong.bo.KeyBo;
import com.lingtong.bo.TenantsBo;
import com.lingtong.model.Community;
import com.lingtong.model.KeyList;
import com.lingtong.model.Pagination;
import com.lingtong.model.Tenants;
import com.lingtong.util.GetParams;
import com.lingtong.util.SpringManage;
import com.uzuser.thirdparty.sciener.GetKeyListUtil;

/**
 * @author xqq
 * @date 2015-9-27 上午3:43:56
 * 
 */
@Controller
public class KeyController {
	@Resource(name="keyBoImpl")
	private KeyBo keyBoImpl;
	
	@Resource(name="tenantsBoImpl")
	private TenantsBo tenantsBo;
	/**
	 * 跳转到钥匙页面
	 * */
	@RequestMapping("/viewKey")
	public ModelAndView viewKey( HttpServletResponse resp, HttpServletRequest req ){
		ModelAndView view = new ModelAndView("key");
		return view;
	}
	
	@RequestMapping(value="/queryKey")
	public @ResponseBody Map<String, Object> queryKey( HttpServletResponse resp, HttpServletRequest req) throws UnsupportedEncodingException{
		req.setCharacterEncoding("utf8");
		Pagination page = new Pagination();
		GetParams.getInstance().getParam(req, page);
		System.out.println(page.getQueryType() + ":" +page.getQueryWord());
		Map<String, Object> results = new HashMap<String, Object>();
		
		
		keyBoImpl.query( page, results );
		return results;
	}
	
	/***
	 * 删除钥匙
	 * 
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/deleteKey")
	public @ResponseBody
	Map<String, Object> deleteKey(HttpServletResponse resp,
			HttpServletRequest req) {
		String room_id = req.getParameter("room_id");
		String key_id = req.getParameter("key_id");
		String openid = req.getParameter("openid");
		
		Map<String, Object> map = keyBoImpl.delete(room_id, key_id, openid);
		return map;
	}
	
	@RequestMapping("/sendKey")
	public @ResponseBody Map<String, Object> sendKey( HttpServletResponse resp, HttpServletRequest req ){
		String roomids = req.getParameter("roomids");
		String locks = req.getParameter("locks");
		String tenantid = req.getParameter("tenantid");
		String start_date = req.getParameter("start_date");
		String end_date = req.getParameter("end_date");
		String openid = req.getParameter("openid");
		
		Tenants tenant = tenantsBo.findTenantById(StringUtils.isBlank(tenantid) ? "-1" : tenantid);
		tenant.setSciener_openid( openid );
		if( tenant == null ){
			Map<String, Object> result = new HashMap<String, Object>();
			result.put("code", "-1");
			result.put("msg", "此用户不存在...");
			return result;
		}
		return keyBoImpl.sendKey(roomids, tenant, start_date, end_date, locks);
	}
	
	@RequestMapping("/freezeKey")
	public @ResponseBody Map<String, Object> freezeKey( HttpServletResponse resp, HttpServletRequest req ){
		String isFreeze = req.getParameter("isFreeze");
		String room_id = req.getParameter("room_id");
		String key_id = req.getParameter("key_id");
		String openid = req.getParameter("openid");
		
		String tenantid = req.getParameter("tenantid");
		
		Tenants tenant = tenantsBo.findTenantById(tenantid);
		if( tenant == null ){
			Map<String, Object> result = new HashMap<String, Object>();
			result.put("code", "-1");
			result.put("msg", "此用户不存在...");
			return result;
		}
		//return unlockBo.freezeKey(isFreeze, tenant);
		return keyBoImpl.freezeKey(isFreeze, room_id, key_id, openid);
	}
}
