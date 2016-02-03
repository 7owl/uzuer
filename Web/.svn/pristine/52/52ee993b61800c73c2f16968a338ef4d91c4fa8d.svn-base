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

import com.lingtong.dao.BankInfoDao;
import com.lingtong.model.BankInfo;
import com.lingtong.model.BankInfo;
import com.lingtong.model.Pagination;
import com.lingtong.util.LTBeanUtils;
import com.lingtong.util.PageUtil;

@Component("bankInfoDaoImpl")
public class BankInfoDaoImpl implements BankInfoDao {
	@Resource(name = "jdbcTemplate")
	private JdbcTemplate jdbcTemplate;
	
	
	
	public Map<String, Object> save(BankInfo bankInfo) {
		Map<String, Object> map = new HashMap<String, Object>();
		if (bankInfo == null) {
			map.put("error", "银行信息为空...");
		}
		if (!isExist(bankInfo)) {// 不存在管家
			if (bankInfo.getId() != null && bankInfo.getId() > 0) {
				String sql = "update " + BankInfo.TABLENAME + " set bankName= ?,"
						+ " bankNum = ? ,bankPerson= ? where id ="
						+ bankInfo.getId().toString();
				int affected = jdbcTemplate.update(sql, new Object[] {
						bankInfo.getBankName(), bankInfo.getBankNum(),bankInfo.getBankPerson()});
				if (affected > 0) {
					map.put("success", "修改成功...");
				} else {
					map.put("success", "修改失败...");
				}
			} else {
				String sql = "insert into " + BankInfo.TABLENAME
						+ "(bankName, bankNum,bankPerson) " + "value (?,?,?)";
				int affected = jdbcTemplate.update(sql, new Object[] {
						bankInfo.getBankName(), bankInfo.getBankNum(),bankInfo.getBankPerson()});
				if (affected > 0) {
					map.put("success", "保存成功...");
				} else {
					map.put("success", "保存失败...");
				}
			}
		} else {
			map.put("error", "银行账号重复");
		}
		return map;
	}

	public boolean isExist(BankInfo bankInfo) {
		if (StringUtils.isBlank(bankInfo.getBankNum())) {
			return true;
		}
		String sql = "select count(*) from " + BankInfo.TABLENAME
				+ " where bankNum = ?";
		if (bankInfo.getId() != null && bankInfo.getId() > 0) {
			sql += " and id!=" + bankInfo.getId();
		}
		int count = jdbcTemplate.queryForInt(sql,
				new Object[] { bankInfo.getBankNum() });
		System.out.println(" bankInfo Count ： " + count + "-- "
				+ bankInfo.getBankNum());
		return (count > 0 ? true : false);
	}

	public  List<BankInfo> query(Pagination page, Map<String, Object> results) {
		List<BankInfo> bankInfos = new ArrayList<BankInfo>();
		
		//过滤条件
		StringBuilder filterCondition = new StringBuilder(" where 1 = 1 ");
		String sql = "select * from " + BankInfo.TABLENAME + filterCondition.toString();
		
		String pageCondition = PageUtil.getInstance().getQueryCondition(page, BankInfo.class, true);
		String nopageCondition = PageUtil.getInstance().getQueryCondition(page, BankInfo.class, false);
		
		sql += pageCondition;
		System.out.println("sql:" + sql);

		List list = jdbcTemplate.queryForList(sql);// 分页数据

		int total = jdbcTemplate.queryForInt("select count(id) from "
				+ BankInfo.TABLENAME + " "+filterCondition.toString() + nopageCondition);
		for (int i = 0; list != null && i < list.size(); i++) {
			Map<String, Object> map = (Map<String, Object>) list.get(i);
			BankInfo bankInfo = new BankInfo();
			LTBeanUtils.getInstance().Map2Bean(map, bankInfo);
			bankInfos.add(bankInfo);
		}
		results.put("rows", bankInfos);
		results.put("total", total);
		return bankInfos;
	}

	public Map<String, Object> delete(String delIds) {
		// 删除角色
				Map<String, Object> map = new HashMap<String, Object>();
				if (StringUtils.isBlank(delIds)) {
					map.put("error", "请选中要删除的数据");
					return map;
				}
				String[] ids = delIds.split(",");
				StringBuilder sb = new StringBuilder("delete  from " + BankInfo.TABLENAME);
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
				System.out.println("BankInfoDaoImpl.delete() Sql : " + sql);
				int affected = jdbcTemplate.update(sql);
				map.put("success", "已经成功删除" + affected + "条记录...");
				return map;
	}

}
