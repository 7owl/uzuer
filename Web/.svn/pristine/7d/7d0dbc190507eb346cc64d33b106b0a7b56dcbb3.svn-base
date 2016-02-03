package com.lingtong.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.NumberUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lingtong.bo.RegionBo;
import com.lingtong.model.Region;

@Controller
public class RegionController {
	@Resource(name="regionBoImpl")
	private RegionBo regionBoImpl;
	
	/**
	 * 跳转到角色页面
	 * */
	@RequestMapping("/regions/{pId}")
	public @ResponseBody List<Region> regions( HttpServletResponse resp, HttpServletRequest req, @PathVariable("pId") String pId ){
		Integer id = Integer.MIN_VALUE;
		List<Region> regions = new ArrayList<Region>();
		if( NumberUtils.isNumber( pId ) ){
			id = Integer.parseInt( pId );
			regions = regionBoImpl.getRegionByPId( id );
		}
		return regions;
	}
	

	
}
