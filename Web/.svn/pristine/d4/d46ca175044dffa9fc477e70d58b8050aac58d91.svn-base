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

import com.lingtong.dao.RoleDao;
import com.lingtong.model.Pagination;
import com.lingtong.model.Role;
import com.lingtong.util.LTBeanUtils;

/**
 * 
 * @author MTT
 * @date 2015-8-5
 */
@Component("roleDaoImpl")
public class RoleDaoImpl implements RoleDao {

	@Resource(name = "jdbcTemplate")
	private JdbcTemplate jdbcTemplate;

	public Map<String, Object> save(Role role) {
		Map<String, Object> map = new HashMap<String, Object>();
		if (role == null) {
			map.put("error", "角色为空...");
		}
		if (!isExist(role)) {// 不存在 角色
			if (role.getId() != null && role.getId() > 0) {
				String sql = "update " + Role.TABLENAME + " set role_name= ?,"
						+ "power = ? where id =" + role.getId().toString();
				int affected = jdbcTemplate.update(sql,
						new Object[] { role.getRole_name(), role.getPower() });
				if (affected > 0) {
					map.put("success", "修改成功...");
				} else {
					map.put("success", "修改失败...");
				}
			} else {
				String sql = "insert into " + Role.TABLENAME
						+ "(role_name, power) " + "value (? ,?)";
				int affected = jdbcTemplate.update(sql,
						new Object[] { role.getRole_name(), role.getPower() });
				if (affected > 0) {
					map.put("success", "保存成功...");
				} else {
					map.put("success", "保存失败...");
				}
			}
		} else {
			map.put("error", "角色名重复");
		}
		return map;
	}

	public boolean isExist(Role role) {
		if (StringUtils.isBlank(role.getRole_name())) {
			return true;
		}
		String sql = "select count(*) from " + Role.TABLENAME
				+ " where role_name = ?";
		if (role.getId() != null && role.getId() > 0) {
			sql += " and id!=" + role.getId();
		}
		int count = jdbcTemplate.queryForInt(sql,
				new Object[] { role.getRole_name() });
		System.out.println(" Role Count ： " + count + "-- "
				+ role.getRole_name());
		return (count > 0 ? true : false);
	}

	public List<Role> query(Pagination page, Map<String, Object> result) {
		// List
		List<Role> roles = new ArrayList<Role>();
		// 分页
		StringBuilder paginationCondition = new StringBuilder();
		// 排序
		StringBuilder sortCondition = new StringBuilder(" order by ");
		// 过滤条件
		StringBuilder filterCondition = new StringBuilder();

		if (page != null) {
			if (page.getPage() > 0 && page.getRows() > 0) {
				paginationCondition.append(" limit ")
						.append((page.getPage() - 1) * page.getRows())
						.append(" , ").append(page.getRows());

			}
			if (StringUtils.isNotBlank(page.getSort())) {
				sortCondition.append(page.getSort() + " ");
			} else {
				sortCondition.append(" id ");
			}
			if (StringUtils.isNotBlank(page.getOrder())) {
				sortCondition.append(page.getOrder());
			} else {
				sortCondition.append("desc");
			}
			if (StringUtils.isNotBlank(page.getQueryType())) {
				if (StringUtils.isNotBlank(page.getQueryWord())) {
					filterCondition.append(" where " + page.getQueryType()
							+ " like '%" + page.getQueryWord() + "%'");
				}
			}
		}
		String sql = "select * from " + Role.TABLENAME
				+ filterCondition.toString();
		if (StringUtils.isNotBlank(sortCondition.toString())) {
			sql += sortCondition.toString();
		}
		if (StringUtils.isNotBlank(paginationCondition.toString())) {
			sql += paginationCondition.toString();
		}
		System.out.println("sql:" + sql);

		List list = jdbcTemplate.queryForList(sql);// 分页数据

		int total = jdbcTemplate.queryForInt("select count(id) from "
				+ Role.TABLENAME + filterCondition.toString());
		for (int i = 0; list != null && i < list.size(); i++) {
			Map<String, Object> map = (Map<String, Object>) list.get(i);
			Role role = new Role();
			LTBeanUtils.getInstance().Map2Bean(map, role);
			roles.add(role);
		}
		result.put("rows", roles);
		result.put("total", total);

		return roles;
	}

	public Map<String, Object> delete(String delids) {
		// 删除角色
		Map<String, Object> map = new HashMap<String, Object>();
		if (StringUtils.isBlank(delids)) {
			map.put("error", "请选中要删除的数据");
			return map;
		}
		String[] ids = delids.split(",");
		StringBuilder sb = new StringBuilder("delete  from " + Role.TABLENAME);
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
		System.out.println("RoleDaoImpl.delete() Sql : " + sql);
		int affected = jdbcTemplate.update(sql);
		map.put("success", "已经成功删除" + affected + "条记录...");
		return map;
	}

}
