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

import com.lingtong.dao.CompanyDao;
import com.lingtong.model.Company;
import com.lingtong.model.Company;
import com.lingtong.model.Pagination;
import com.lingtong.model.Room;
import com.lingtong.util.LTBeanUtils;
import com.lingtong.vo.CompanyVo;

@Component("companyDaoImpl")
public class CompanyDaoImpl implements CompanyDao {

	@Resource(name = "jdbcTemplate")
	private JdbcTemplate jdbcTemplate;

	public Map<String, Object> save(Company company) {
		Map<String, Object> map = new HashMap<String, Object>();
		if (company == null) {
			map.put("error", "管家为空...");
		}
		if (!isExist(company)) {// 不存在管家
			if (company.getId() != null && company.getId() > 0) {
				String sql = "update " + Company.TABLENAME
						+ " set company_name= ?," + "company_address=?,"
						+ "company_ceo=?," + "company_number=?,"
						+ "company_desc= ?" + " where id ="
						+ company.getId().toString();
				int affected = jdbcTemplate.update(
						sql,
						new Object[] { company.getCompany_name(),
								company.getCompany_address(),
								company.getCompany_ceo(),
								company.getCompany_number(),
								company.getCompany_desc() });
				if (affected > 0) {
					map.put("success", "修改成功...");
				} else {
					map.put("success", "修改失败...");
				}
			} else {
				String sql = "insert into " + Company.TABLENAME
						+ "(company_name,company_address,"
						+ "company_ceo,company_number," + "company_desc) "
						+ "value (?,?,?,?,?)";
				int affected = jdbcTemplate.update(
						sql,
						new Object[] { company.getCompany_name(),
								company.getCompany_address(),
								company.getCompany_ceo(),
								company.getCompany_number(),
								company.getCompany_desc() });
				if (affected > 0) {
					map.put("success", "保存成功...");
				} else {
					map.put("success", "保存失败...");
				}
			}
		} else {
			map.put("error", "公司名重复");
		}
		return map;
	}

	public boolean isExist(Company company) {
		if (StringUtils.isBlank(company.getCompany_name())) {
			return true;
		}
		String sql = "select count(*) from " + Company.TABLENAME
				+ " where company_name = ?";
		if (company.getId() != null && company.getId() > 0) {
			sql += " and id!=" + company.getId();
		}
		int count = jdbcTemplate.queryForInt(sql,
				new Object[] { company.getCompany_name() });
		System.out.println(" Company Count ： " + count + "-- "
				+ company.getCompany_name());
		return (count > 0 ? true : false);
	}

	public List<CompanyVo> query(Pagination page, Map<String, Object> results) {
		// List
		List<CompanyVo> comps = new ArrayList<CompanyVo>();
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
				sortCondition.append(" company.id ");
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
		String sql = "select * from " + CompanyVo.VIEWNAME + " company "
				+ filterCondition.toString();
		if (StringUtils.isNotBlank(sortCondition.toString())) {
			sql += sortCondition.toString();
		}
		if (StringUtils.isNotBlank(paginationCondition.toString())) {
			sql += paginationCondition.toString();
		}
		System.out.println("sql:" + sql);

		List list = jdbcTemplate.queryForList(sql);// 分页数据

		int total = jdbcTemplate
				.queryForInt("select count(*) from " + CompanyVo.VIEWNAME
						+ filterCondition.toString());
		for (int i = 0; list != null && i < list.size(); i++) {
			Map<String, Object> map = (Map<String, Object>) list.get(i);
			CompanyVo company = new CompanyVo();
			LTBeanUtils.getInstance().Map2Bean(map, company);
			comps.add(company);
		}
		results.put("rows", comps);
		results.put("total", total);

		return comps;
	}

	public Map<String, Object> delete(String delIds) {
		// 删除角色
		Map<String, Object> map = new HashMap<String, Object>();
		if (StringUtils.isBlank(delIds)) {
			map.put("error", "请选中要删除的数据");
			return map;
		}
		String[] ids = delIds.split(",");
		StringBuilder sb = new StringBuilder("delete  from "
				+ Company.TABLENAME);
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
		System.out.println("CompanyDaoImpl.delete() Sql : " + sql);
		int affected = jdbcTemplate.update(sql);
		map.put("success", "已经成功删除" + affected + "条记录...");
		return map;
	}

}
