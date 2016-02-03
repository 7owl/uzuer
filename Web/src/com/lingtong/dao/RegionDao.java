package com.lingtong.dao;

import java.util.List;
import java.util.Map;

import com.lingtong.model.Pagination;
import com.lingtong.model.Region;
import com.lingtong.model.Role;
/**
 * 
 * @author MTT
 * @date 2015-8-5
 */
public interface RegionDao {
	/***
	 * @param maxLevel,从哪一层开始取
	 * @param regions
	 * @return
	 * 太耗时了,作废
	 */
	public void getRegions( Integer maxLevel, List<Region> regions );
	
	/***
	 * 根据父id,获得下级地市
	 * @param pid
	 * @return
	 */
	public List<Region> getRegionByPId(Integer pid);
}
