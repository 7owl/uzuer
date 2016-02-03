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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.lingtong.bo.CommunityBo;
import com.lingtong.bo.RoomBo;
import com.lingtong.bo.TenantsBo;
import com.lingtong.model.Community;
import com.lingtong.model.Pagination;
import com.lingtong.model.Room;
import com.lingtong.model.Tenants;
import com.lingtong.util.GetParams;
import com.lingtong.vo.RoomVo;


@Controller
public class RoomController {
	@Resource(name="roomBoImpl")
	private RoomBo roomBo;
	@Resource(name="communityBoImpl")
	private CommunityBo communityBo;
	/**
	 * 跳转到房客页面
	 * */
	@RequestMapping("/viewRoom")
	public ModelAndView viewRoom( HttpServletResponse resp, HttpServletRequest req ){
		ModelAndView view = new ModelAndView("room");
		return view;
	}
	/***
	 * 增加房客
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping(value="/saveRoom")
	public @ResponseBody Map<String, Object> saveRoom( HttpServletResponse resp, HttpServletRequest req) throws UnsupportedEncodingException{
		req.setCharacterEncoding("utf-8");
		String string = req.getParameter("room");
		String cityid = "" ; 
		Room room = null;
		if( StringUtils.isNotBlank(string) ){
			room = new Gson().fromJson(string, Room.class);
			int comm_id = room.getComm_id();
			List<Community> comms = communityBo.getCommAddressById(comm_id);
			
			for (int i = 0; i < comms.size(); i++) {
				cityid += (comms.get(i).getComm_address()+comms.get(i).getComm_name());
			}
			cityid += room.getRoom_name();
		}
		room.setCityid(cityid);
		Map<String, Object> map = roomBo.save(room);
		return map;
	}
	
	@RequestMapping(value="/queryRoom")
	public @ResponseBody Map<String, Object> queryRoom( HttpServletResponse resp, HttpServletRequest req) throws UnsupportedEncodingException{
		req.setCharacterEncoding("utf8");
		Pagination page = new Pagination();
		GetParams.getInstance().getParam(req, page);
		Map<String, Object> results = new HashMap<String, Object>();
		List<Room> rooms = new ArrayList<Room>();
		results.put("rows", rooms);
		results.put("total", 0);
		roomBo.query( page, results );
		return results;
	}
	
	@RequestMapping(value="/queryLockRoom")
	public @ResponseBody Map<String, Object> queryLockRoom( HttpServletResponse resp, HttpServletRequest req) throws UnsupportedEncodingException{
		req.setCharacterEncoding("utf8");
		Pagination page = new Pagination();
		GetParams.getInstance().getParam(req, page);
		Map<String, Object> results = new HashMap<String, Object>();
		List<Room> rooms = new ArrayList<Room>();
		results.put("rows", rooms);
		results.put("total", 0);
		roomBo.queryLock( page, results );
		return results;
	}
	
	/***
	 * 增加房客
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping(value="/deleteRoom")
	public @ResponseBody Map<String, Object> deleteRoom( HttpServletResponse resp, HttpServletRequest req, @RequestParam("delIds") String delIds){
		
		Map<String, Object> map = roomBo.delete( delIds );
		return map;
	}

	
}
