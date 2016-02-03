package com.lingtong.bo.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.lingtong.bo.RegionBo;
import com.lingtong.dao.RegionDao;
import com.lingtong.model.Region;

/**
 * @author xqq
 * @date 2015-8-6 下午8:07:43
 * 
 */
@Component("regionBoImpl")
public class RegionBoImpl implements RegionBo {
	@Resource(name = "regionDaoImpl")
	private RegionDao regionDaoImpl;

	public void getRegions(Integer maxLevel, List<Region> regions) {
		
	}

	public List<Region> getRegionByPId(Integer pId){
		return regionDaoImpl.getRegionByPId(pId);
	}
}
