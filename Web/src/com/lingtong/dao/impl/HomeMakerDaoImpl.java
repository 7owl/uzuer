package com.lingtong.dao.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.NumberUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.lingtong.dao.HomeMakerDao;
import com.lingtong.model.HomeMaker;
import com.lingtong.model.Pagination;
import com.lingtong.model.Role;
import com.lingtong.util.LTBeanUtils;
import com.lingtong.util.PageUtil;
import com.lingtong.vo.RoomVo;

/**
 * @author xqq
 * @date 2015-8-5 下午9:21:00
 * 
 */
@Component("homeMakerDaoImpl")
public class HomeMakerDaoImpl implements HomeMakerDao {

	@Resource(name = "jdbcTemplate")
	private JdbcTemplate jdbcTemplate;

	public Map<String, Object> save(HomeMaker homeMaker) {
		Map<String, Object> map = new HashMap<String, Object>();
		if (homeMaker == null) {
			map.put("error", "管家为空...");
		}
		if (!isExist(homeMaker)) {// 不存在管家
			if (homeMaker.getId() != null && homeMaker.getId() > 0) {
				String sql = "update " + HomeMaker.TABLENAME + " set hm_name= ?,"
						+ " hm_number = ? where id ="
						+ homeMaker.getId().toString();
				int affected = jdbcTemplate.update(sql, new Object[] {
						homeMaker.getHm_name(), homeMaker.getHm_number() });
				if (affected > 0) {
					map.put("success", "修改成功...");
				} else {
					map.put("success", "修改失败...");
				}
			} else {
				String sql = "insert into " + HomeMaker.TABLENAME
						+ "(hm_name, hm_number) " + "value (? ,?)";
				int affected = jdbcTemplate.update(sql, new Object[] {
						homeMaker.getHm_name(), homeMaker.getHm_number() });
				if (affected > 0) {
					map.put("success", "保存成功...");
				} else {
					map.put("success", "保存失败...");
				}
			}
		} else {
			map.put("error", "管家名重复");
		}
		return map;
	}

	public boolean isExist(HomeMaker homeMaker) {
		if (StringUtils.isBlank(homeMaker.getHm_name())) {
			return true;
		}
		String sql = "select count(*) from " + HomeMaker.TABLENAME
				+ " where hm_name = ?";
		if (homeMaker.getId() != null && homeMaker.getId() > 0) {
			sql += " and id!=" + homeMaker.getId();
		}
		int count = jdbcTemplate.queryForInt(sql,
				new Object[] { homeMaker.getHm_name() });
		System.out.println(" HomeMaker Count ： " + count + "-- "
				+ homeMaker.getHm_name());
		return (count > 0 ? true : false);
	}

	public List<HomeMaker> query(Pagination page, Map<String, Object> results) {
		// List
		List<HomeMaker> hms = new ArrayList<HomeMaker>();
		
		//过滤条件
		StringBuilder filterCondition = new StringBuilder(" where 1 = 1 ");
		String sql = "select * from " + HomeMaker.TABLENAME + filterCondition.toString();
		
		String pageCondition = PageUtil.getInstance().getQueryCondition(page, HomeMaker.class, true);
		String nopageCondition = PageUtil.getInstance().getQueryCondition(page, HomeMaker.class, false);
		
		sql += pageCondition;
		System.out.println("sql:" + sql);

		List list = jdbcTemplate.queryForList(sql);// 分页数据

		int total = jdbcTemplate.queryForInt("select count(id) from "
				+ HomeMaker.TABLENAME + " " + nopageCondition);
		for (int i = 0; list != null && i < list.size(); i++) {
			Map<String, Object> map = (Map<String, Object>) list.get(i);
			HomeMaker hm = new HomeMaker();
			LTBeanUtils.getInstance().Map2Bean(map, hm);
			hms.add(hm);
		}
		results.put("rows", hms);
		results.put("total", total);

		return hms;
	}

	public Map<String, Object> delete(String delIds) {
		// 删除角色
		Map<String, Object> map = new HashMap<String, Object>();
		if (StringUtils.isBlank(delIds)) {
			map.put("error", "请选中要删除的数据");
			return map;
		}
		String[] ids = delIds.split(",");
		StringBuilder sb = new StringBuilder("delete  from " + HomeMaker.TABLENAME);
		StringBuilder condition = new StringBuilder();

		for (String id : ids) {
			if (NumberUtils.isNumber(id)) {
				condition.append(" id = " + id + " or ");
			}
		}
		if (StringUtils.isNotBlank(condition.toString())) {
			sb.append(" where ").append(condition.toString());
		}
		int pos = sb.toString().lastIndexOf("or");
		String sql = "";
		if (pos != -1) {
			sql = sb.toString().substring(0, pos);
		} else {
			sql = sb.toString();
		}
		System.out.println("HomeMakerDaoImpl.delete() Sql : " + sql);
		int affected = jdbcTemplate.update(sql);
		map.put("success", "已经成功删除" + affected + "条记录...");
		return map;
	}
	
	public HomeMaker getHomeMakerById( Integer id ){
		List list = jdbcTemplate.queryForList("select * from " + HomeMaker.TABLENAME + " where id = " + id);
		HomeMaker hm = new HomeMaker();
		if( list != null && list.size() > 0 ){
			Map<String, Object> map = (Map<String, Object>) list.get(0);
			LTBeanUtils.getInstance().Map2Bean(map, hm);
		}
		return hm;
	}
}
