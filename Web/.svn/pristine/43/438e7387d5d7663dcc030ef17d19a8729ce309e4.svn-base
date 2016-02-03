package com.lingtong.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.NumberUtils;
import org.apache.cxf.binding.corba.wsdl.Array;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.lingtong.bo.ImageBo;
import com.lingtong.bo.TenantsBo;
import com.lingtong.model.IdImage;
import com.lingtong.model.Image;
import com.lingtong.model.Tenants;

@Controller
public class ImageController {
	@Resource(name="imageBoImpl")
	private ImageBo imageBo;
	
		
	@Resource(name="tenantsBoImpl")
	private TenantsBo tenantsBo;
	
	@RequestMapping("/fileUpView")
	public ModelAndView fileUpView(@RequestParam("id") String  id,HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		//String id = request.getParameter("id");
		//int room_id = Integer.parseInt(id); 
		request.getSession().setAttribute("imageList", imageBo.getImageListById(id));
		request.getSession().setAttribute("room_id", id);
		ModelAndView model = new ModelAndView("uploadpic");
		return model ;
	}
	
	@RequestMapping("/idPictureView")
	public ModelAndView idPictureView(@RequestParam("id") String  id,HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		Map<String, Object> map = new HashMap<String, Object>();
		
		map = imageBo.getIdAuthPic(id);
		List<IdImage> imgs = (ArrayList<IdImage>)map.get("success") ;
		List<String> urls = new ArrayList<String>();
		for (IdImage image : imgs) {
			urls.add(image.getUrl());
		}
		map.put("idPictures", urls);
		ModelAndView model = new ModelAndView("idPicture", map);
		return model ;
	}
 
	@RequestMapping(value="/uploadImage", method= RequestMethod.POST)
	public ModelAndView upload( HttpServletResponse resp, HttpServletRequest req, @RequestParam MultipartFile[] image){
		String id =  (String)req.getSession().getAttribute("room_id");
		ModelAndView view = new ModelAndView("redirect:/fileUpView?id="+ id);
		Map<String, Object> map = new HashMap<String, Object>();
		
		String room_id = (String) req.getSession().getAttribute("room_id");
		if( NumberUtils.isNumber(room_id) ){
			String dir = req.getSession().getServletContext().getRealPath("/upload");
			map = imageBo.upload(image, dir, Integer.parseInt(room_id));
			//req.getSession().setAttribute("imageList", map.get("success"));
			return view;
		} else {
//			map.put("error", "房源为空...");
			return  new ModelAndView("error");
		}
 
	}
	
	@RequestMapping("/updateImageSort")
	public @ResponseBody Map<String, Object> updateImageSort(HttpServletRequest req, HttpServletResponse resp, @RequestParam("images") String images){
		JSONObject jsonObject = JSONObject.fromObject(images);
		JSONArray jsonArray = jsonObject.getJSONArray("datas");  
        List<Image> list = (List) JSONArray.toCollection(jsonArray,  
                Image.class);  
       
        return imageBo.updateImageSort(list);
	} 
	
	@RequestMapping(value="/delImage")
	public @ResponseBody Map<String, Object> delete( HttpServletResponse resp, HttpServletRequest req, @RequestParam("delIds") String delIds){
		ModelAndView view = new ModelAndView("result");
		Map<String, Object> map = new HashMap<String, Object>();
        return imageBo.delete(delIds);   
	}
	
	@RequestMapping(value="/queryByRoomId")
	public @ResponseBody Map<String, Object> queryByRoomId( HttpServletResponse resp, HttpServletRequest req, @RequestParam("room_id") String room_id){
		ModelAndView view = new ModelAndView("result");
		Map<String, Object> map = new HashMap<String, Object>();
        return imageBo.queryByRoomId(room_id);   
	}

}
