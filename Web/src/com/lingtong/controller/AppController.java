package com.lingtong.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.FormParam;
import javax.ws.rs.core.Response;

import org.apache.commons.lang.NumberUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alipay.util.AlipayCore;
import com.alipay.util.AlipayNotify;
import com.google.gson.Gson;
import com.lingtong.bo.ContractBo;
import com.lingtong.bo.RoomBo;
import com.lingtong.dao.ContractDao;
import com.lingtong.dao.ImageDao;
import com.lingtong.dao.OrderDao;
import com.lingtong.dao.RoomDao;
import com.lingtong.dao.impl.ContractDaoImpl;
import com.lingtong.dao.impl.ImageDaoImpl;
import com.lingtong.dao.impl.OrderDaoImpl;
import com.lingtong.dao.impl.RoomDaoImpl;
import com.lingtong.interfaces.interceptor.Auth;
import com.lingtong.interfaces.interceptor.ReturnJSON;
import com.lingtong.interfaces.message.CommonErrorEnum;
import com.lingtong.interfaces.message.FaultTolerant;
import com.lingtong.model.Image;
import com.lingtong.model.Order;
import com.lingtong.model.Tenants;
import com.lingtong.vo.RoomVo;
import com.sun.org.apache.bcel.internal.generic.NEW;
import com.sun.org.apache.regexp.internal.REDebugCompiler;


@Controller
@RequestMapping("/app/")
public class AppController {
	@Resource(name="roomBoImpl")
	private RoomBo roomBo;
	
	@Resource(name="contractBoImpl")
	private ContractBo contractBoImpl; 
	
	@Resource(name="roomDaoImpl")
	private RoomDao roomDao = new RoomDaoImpl();
	
	@Resource(name="imageDaoImpl")
	private ImageDao imageDao = new ImageDaoImpl();
	
	@Resource(name="orderDaoImpl")
	private OrderDao orderDao = new OrderDaoImpl();
	
	@Resource(name="contractDaoImpl")
	private ContractDao contractDao = new ContractDaoImpl();
	 
	
	@RequestMapping("getSharingRoomDetail/{roomSeq}")
	public @ResponseBody RoomVo getRoomDetailByRoomSeq(HttpServletRequest req, HttpServletResponse resp, @PathVariable("roomSeq") String roomSeq){
		RoomVo roomVo =  roomBo.getRoomDetailByRoomSeq(roomSeq);
//		String defaultpic="http://7xl031.com1.z0.glb.clouddn.com/11.jpg";
//		List<String> roompics = new ArrayList<String>();
//		List<Image> images = new ArrayList<Image>();
//		if (!StringUtils.isEmpty(roomVo.getPicture())) {
//			
//			String[] room = roomVo.getPicture().split(",");
//			System.out.println(room.length);
//			for (int i = 0; i < room.length; i++) {
//				Image image = new Image();
//				if (!StringUtils.isEmpty(room[i])&&room[i].contains("thumb")) {
////					roompics.add(room[i]);
//					image.setUrl(room[i]);
//					images.add(image);
//				}
//			}
//			if (room.length==0) {
//				Image image = new Image();
//				image.setUrl(defaultpic);
//				images.add(image);
////				roompics.add(defaultpic);
//			}
//		}
////	System.out.println(roompics.toString());
//		req.setAttribute("appimages", images);
		req.getSession().getAttribute("appimages");
//		roomVo.setPicture(StringUtils.join(roompics, ","));
		return roomVo;
	}
	
	@RequestMapping("getRoomDetailByRoomSeq")
	public  ModelAndView skipRoomDetailByRoomSeq(HttpServletRequest req, HttpServletResponse resp){
		Map<String, Object> map = new HashMap<String, Object>();
		ModelAndView model = new ModelAndView("sharingRoomDetail", map);
		System.out.println(req.getParameter("roomSeq"));
		map.put("roomSeq", req.getParameter("roomSeq"));
		
		List<Image> images = imageDao.getPicByRoomNo(req.getParameter("roomSeq"));
		req.getSession().setAttribute("appimages", images);
		return model;
	}
	
	@RequestMapping("getFeaturedList")
	public  @ResponseBody List<RoomVo> getFeaturedList(HttpServletRequest req, HttpServletResponse resp, @FormParam("cityid") String cityid) {
		Map<String, Object> result = new HashMap<String, Object>();
		result = roomDao.getFeaturedList(cityid);
		List<RoomVo> roomVos = (List<RoomVo>)result.get("data");
		return roomVos;
	}
	
	@RequestMapping("signResult")
	public ModelAndView signResult(HttpServletRequest req, HttpServletResponse resp){
		Map<String, Object> map = new HashMap<String, Object>();
		ModelAndView model = new ModelAndView("signResult", map);
		String signId = req.getParameter("signID");
		String code = req.getParameter("code");
		if( NumberUtils.isNumber(code) ){
			if( Integer.parseInt(code) == 100000 ){
				contractBoImpl.updateContractStatus(signId);
			}
		}
		return model;
	}
	
	@RequestMapping("notify")
	public void notify(HttpServletRequest req, HttpServletResponse resp){

		try {
			
		//获取支付宝POST过来反馈信息
		Map<String,String> params = new HashMap<String,String>();
		Map requestParams = req.getParameterMap();
		for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
			String name = (String) iter.next();
			String[] values = (String[]) requestParams.get(name);
			String valueStr = "";
			for (int i = 0; i < values.length; i++) {
				valueStr = (i == values.length - 1) ? valueStr + values[i]
						: valueStr + values[i] + ",";
			}
			//乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
			//valueStr = new String(valueStr.getBytes("ISO-8859-1"), "gbk");
			params.put(name, valueStr);
		}
		String out_trade_no = new String(req.getParameter("out_trade_no").getBytes("ISO-8859-1"),"UTF-8");
		//支付宝交易号
		String trade_no = new String(req.getParameter("trade_no").getBytes("ISO-8859-1"),"UTF-8");
		//交易状态
		String trade_status = new String(req.getParameter("trade_status").getBytes("ISO-8859-1"),"UTF-8");
		
		if(AlipayNotify.verify(params)){//验证成功
			//////////////////////////////////////////////////////////////////////////////////////////
			//请在这里加上商户的业务逻辑程序代码

			//——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
			
			if(trade_status.equals("TRADE_FINISHED")){
				//判断该笔订单是否在商户网站中已经做过处理
					//如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
					//如果有做过处理，不执行商户的业务程序
					
				//sql = "update " + Room.TABLENAME  +" set status = 1 where id = ?";
				//sql1 = "update " +  +;
				//注意：
				//该种交易状态只在两种情况下出现
				//1、开通了普通即时到账，买家付款成功后。
				//2、开通了高级即时到账，从该笔交易成功时间算起，过了签约时的可退款时限（如：三个月以内可退款、一年以内可退款等）后。
			} else if (trade_status.equals("TRADE_SUCCESS")){
				//判断该笔订单是否在商户网站中已经做过处理
					//如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
					//如果有做过处理，不执行商户的业务程序
				boolean isSuccess1 = orderDao.updatePayState(out_trade_no);
				if (!isSuccess1) {
					AlipayCore.logResult("更新Order状态： "+ isSuccess1);
					resp.getWriter().write("fail");
				}
				boolean  isSuccess2= contractDao.updateContractAfterPay(out_trade_no);
				if (!isSuccess2) {
					AlipayCore.logResult("更新合同状态： "+ isSuccess2);
					resp.getWriter().write("fail");
				}
				//注意：
				//该种交易状态只在一种情况下出现——开通了高级即时到账，买家付款成功后。
			}
			//——请根据您的业务逻辑来编写程序（以上代码仅作参考）——
			resp.getWriter().write("success");	//请不要修改或删除
			//////////////////////////////////////////////////////////////////////////////////////////
		}else{//验证失败
			resp.getWriter().write("fail");
//			out.println("fail");
		}
//		resp.getWriter().write("success");
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
}
