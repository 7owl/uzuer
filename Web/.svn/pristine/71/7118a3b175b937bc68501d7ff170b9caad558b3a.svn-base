package com.lingtong.dao.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.lingtong.dao.RegionDao;
import com.lingtong.model.Region;
import com.lingtong.util.LTBeanUtils;
import com.lingtong.util.SpringManage;

/**
 * @author xqq
 * @date 2015-8-6 下午8:07:43
 * 
 */
@Component("regionDaoImpl")
public class RegionDaoImpl implements RegionDao {
	@Resource(name = "jdbcTemplate")
	private JdbcTemplate jdbcTemplate;

	public void getRegions(Integer maxLevel, List<Region> regions) {
		if (maxLevel > 0 && maxLevel < 4) {
			String sql = "select region_id, region_name, region_code from region where region_level = "
					+ maxLevel;
			System.out.println("获得" + maxLevel + "层:" + sql);
			List list = jdbcTemplate.queryForList(sql);
			for (int i = 0; list != null && i < list.size(); i++) {
				Map<String, Object> map = (Map<String, Object>) list.get(i);
				Region region = new Region();
				List<Region> children = new ArrayList<Region>();
				region.setChildren(children);

				LTBeanUtils.getInstance().Map2Bean(map, region);
				regions.add(region);
				// 获得下级
				if (maxLevel < 3) {
					sql = "select region_id, region_name, region_code from region where region_level = "
							+ (maxLevel + 1)
							+ " and parent_id = "
							+ region.getRegion_id().intValue();
					System.out.println("获得" + (maxLevel + 1) + "层:" + sql);
					List list1 = jdbcTemplate.queryForList(sql);
					for (int j = 0; list1 != null && j < list1.size(); j++) {
						Map<String, Object> map1 = (Map<String, Object>) list1.get(j);
						Region region1 = new Region();
						List<Region> children1 = new ArrayList<Region>();
						region1.setChildren(children1);

						LTBeanUtils.getInstance().Map2Bean(map, region);

						getRegions(maxLevel + 1, children1);
					}
				}
			}
		}
	}

	public List<Region> getRegionByPId(Integer pId){
		List<Region> regions = new ArrayList<Region>();
		
		String sql = "select region_id, region_name, region_code from region where parent_id = " + pId;
		List list = jdbcTemplate.queryForList(sql);
		for (int i = 0; list != null && i < list.size(); i++) {
			Map<String, Object> map = (Map<String, Object>) list.get(i);
			Region region = new Region();
			List<Region> children = new ArrayList<Region>();
			region.setChildren(children);

			LTBeanUtils.getInstance().Map2Bean(map, region);
			regions.add(region);
		}
		
		return regions;
	}
	
	public void init(){
		jdbcTemplate = (JdbcTemplate) SpringManage.getInstance().getObject("jdbcTemplate");
	}
	
	public static void main(String[] args) {
		RegionDaoImpl r = new RegionDaoImpl();
		r.init();
		
		List<Region> regions = new ArrayList<Region>();
		//r.getRegions( 1, regions);
		regions = r.getRegionByPId(1);
		System.out.println( regions.size() );
	}
}
