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

import com.lingtong.dao.HostsDao;
import com.lingtong.model.Pagination;
import com.lingtong.model.Hosts;
import com.lingtong.util.LTBeanUtils;
import com.lingtong.util.PageUtil;

/**
 * @author xqq
 * @date 2015-8-2 下午12:04:00
 * 
 */
@Component("hostsDaoImpl")
public class HostsDaoImpl implements HostsDao {
	@Resource(name = "jdbcTemplate")
	private JdbcTemplate jdbcTemplate;

	public Map<String, Object> save(Hosts host) {
		Map<String, Object> result = new HashMap<String, Object>();
		if (host == null) {
			result.put("error", "房东信息为空...");
			return result;
		}

		if ( !isExist(host)) {//如果不存在
			if ( host.getId() != null && host.getId() > 0 ) {//而且有id的话,就修改
				String sql = "update "
						+ host.TABLENAME
						+ "  set username = ?, pwd = ?, first_name = ?, last_name = ?, tel_number = ?, email = ?, id_card = ?, native_place = ?, work_unit = ?, work_place = ?, work_place_number = ?, bank_card = ? where id = " + host.getId();
				int affected = jdbcTemplate.update(sql,
						new Object[] { host.getUsername(), host.getPwd(),
								host.getFirst_name(), host.getLast_name(),
								host.getTel_number(), host.getEmail(),
								host.getId_card(), host.getNative_place(),
								host.getWork_unit(), host.getWork_place(),
								host.getWork_place_number(), host.getBank_card() });
				if (affected > 0) {
					result.put("success", "修改成功...");
				} else {
					result.put("success", "修改失败...");
				}
			} else {// 不存在id值,就保存
				String sql = "insert into "
						+ host.TABLENAME
						+ " (username, pwd, first_name, last_name, tel_number, email, id_card, native_place, work_unit, work_place, work_place_number, bank_card) values(?, ?, ? , ?, ?, ?, ?, ?, ? , ?, ?, ?)";
				System.out.println(host.getNative_place());
				int affected = jdbcTemplate.update(sql,
						new Object[] { host.getUsername(), host.getPwd(),
								host.getFirst_name(), host.getLast_name(),
								host.getTel_number(), host.getEmail(),
								host.getId_card(), host.getNative_place(),
								host.getWork_unit(), host.getWork_place(),
								host.getWork_place_number(), host.getBank_card() });
				if (affected > 0) {
					result.put("success", "保存成功...");
				} else {
					result.put("success", "保存失败...");
				}
			}
		} else {//如果存在,说明重名了
			result.put("error", "房东用户名已存在...");
		}
		return result;
	}

	public boolean isExist(Hosts host) {
		if (StringUtils.isBlank(host.getUsername())) {
			return true;
		}
		String sql = "select count(*) from " + host.TABLENAME
				+ " where username = ?";
		if ( host.getId() != null && host.getId() > 0) {// 允许修改后,自己跟自己重名,或没有重名
			sql += " and id != " + host.getId();

			int count = jdbcTemplate.queryForInt(sql,
					new Object[] { host.getUsername() });
			System.out
					.println("username:" + host.getUsername() + ":" + count);
			return (count > 0 ? true : false);
		}
		int count = jdbcTemplate.queryForInt(sql,
				new Object[] { host.getUsername() });
		System.out.println("username:" + host.getUsername() + ":" + count);
		return (count > 0 ? true : false);
	}

	public List<Hosts> query(Pagination page, Map<String, Object> results) {
		List<Hosts> hosts = new ArrayList<Hosts>();
		// 过滤条件
		StringBuilder filterCondition = new StringBuilder(" where 1 = 1");
		
		if (page != null) {
			if( StringUtils.isNotBlank( page.getQueryType() ) ){
				if( "full_name".equals( page.getQueryType() ) ){
					if( StringUtils.isNotBlank( page.getQueryWord() ) ){
						filterCondition.append( " and concat(first_name, last_name) like '%" + page.getQueryWord()  + "%' ");
						page.setQueryWord( "" );
					}
				}
			}
		}

		String sql = "select * from " + Hosts.TABLENAME + filterCondition.toString();
		String pageCondition = PageUtil.getInstance().getQueryCondition(page, Hosts.class, true);
		String nopageCondition = PageUtil.getInstance().getQueryCondition(page, Hosts.class, false);
		sql += pageCondition;
		System.out.println("sql:" + sql);
		
		System.out.println(sql);
		List list = jdbcTemplate.queryForList(sql);// 分页数据
		
		int total = jdbcTemplate.queryForInt("select count(id) from "
				+ Hosts.TABLENAME + filterCondition.toString() + " " + nopageCondition);
		for (int i = 0; list != null && i < list.size(); i++) {
			Map<String, Object> map = (Map<String, Object>) list.get(i);

			Hosts ten = new Hosts();
			LTBeanUtils.getInstance().Map2Bean(map, ten);
			hosts.add(ten);
		}
		results.put("rows", hosts);
		results.put("total", total);
		return hosts;
	}
	
	public Map<String, Object> delete(String delIds){
		Map<String, Object> map = new HashMap<String, Object>();
		if( StringUtils.isBlank(delIds) ){
			map.put("error", "请选中要删除的记录...");
			return map;
		}
		
		String[] ids = delIds.split(",");
		StringBuilder sb = new StringBuilder( "delete from " + Hosts.TABLENAME );
		StringBuilder condition = new StringBuilder();
		for( String id : ids){
			if( NumberUtils.isNumber( id )){
				condition.append( "id = " + id + " or " );
			}
		}
		if( StringUtils.isNotBlank( condition.toString() ) ){
			sb.append( " where ")
			  .append( condition.toString() );
		}
		int pos = sb.toString().lastIndexOf("or");
		String sql = "";
		if( pos != -1){
			sql = sb.toString().substring(0, pos);
		} else {
			sql = sb.toString();
		}
		
		System.out.println("delete hosts sql:" + sql);
		
		int affected = jdbcTemplate.update( sql );
		map.put("success", "已成功删除" + affected + "条记录...");
		
		return map;
	}

	
	/**********************************app 专用接口*****************************************/
	
}
