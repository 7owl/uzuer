package com.lingtong.dao.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.NumberUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.lingtong.dao.CommunityDao;
import com.lingtong.dao.RoomDao;
import com.lingtong.model.HomeMaker;
import com.lingtong.model.Pagination;
import com.lingtong.model.Community;
import com.lingtong.model.Room;
import com.lingtong.model.Tenants;
import com.lingtong.util.CalDistance;
import com.lingtong.util.GetPinYin;
import com.lingtong.util.LTBeanUtils;
import com.lingtong.util.LatitudeUtils;
import com.lingtong.util.PageUtil;
import com.lingtong.util.SpringManage;
import com.lingtong.vo.CommunityVo;
import com.lingtong.vo.RoomVo;

/**
 * 
 * @author MTT
 * @date 2015-8-5
 */
@Component("communityDaoImpl")
public class CommunityDaoImpl implements CommunityDao {

	@Resource(name = "jdbcTemplate")
	private JdbcTemplate jdbcTemplate;
	
	@Resource(name="roomDaoImpl")
	private RoomDao roomDao;

	public Map<String, Object> save(Community community) {
		Map<String, Object> map = new HashMap<String, Object>();
		if (community == null) {
			map.put("error", "小区为空...");
		}
		if (!isExist(community)) {// 不存在 小区
			if (community.getId() != null && community.getId() > 0) {
				String[] updateFields = new String[] { "comm_name= ?",
						"comm_address = ?", "comm_address_code = ?",
						"comm_desc = ?", "hm_id = ?", "longitude = ?", "pinyin = ?, busiCircle = ?, latitude = ? " };
				Double longitude = null;//经度
				Double latitude = null;//纬度
				/*if( StringUtils.isNotBlank( community.getLonAndLat() ) && community.getLonAndLat().indexOf(",") != -1 ){
					String tmp = community.getLonAndLat();
					String[] strs = tmp.split(",");
					if( strs.length == 2 && NumberUtils.isNumber(strs[0]) && NumberUtils.isNumber(strs[1]) ){
						longitude = Double.valueOf( strs[0] );
						latitude = Double.valueOf( strs[1] );
					}
				}*/
				Map<String, String> json = LatitudeUtils.getGeocoderLatitude(community.getComm_address()+community.getComm_name());
				if( NumberUtils.isNumber(json.get("lng")) && NumberUtils.isNumber(json.get("lat")) ){
					longitude = Double.valueOf( json.get("lng") );
					latitude = Double.valueOf( json.get("lat") );
					System.out.println("经度:" + longitude + ",纬度:" + latitude + ";小区地址:" + community.getComm_address() + community.getComm_name());
				} else {
					System.err.println("没有定位到小区的地址:" + community.getComm_address() + community.getComm_name());
				}
				
				Object[] fieldsValue = new Object[] { community.getComm_name(),
						community.getComm_address(),
						community.getComm_address_code(),
						community.getComm_desc(), community.getHm_id(),
						longitude, GetPinYin.getPinYin( community.getComm_name() ),
						community.getBusiCircle(), latitude};
				String sql = "update " + Community.TABLENAME + " set "
						+ StringUtils.join(updateFields, ",") + "where id ="
						+ community.getId().toString();
				int affected = jdbcTemplate.update(sql, fieldsValue);
				//更新小区内房源的地址
				roomDao.updateRoomCityId(community.getComm_address(), community.getComm_name(), community.getId());
				if (affected > 0) {
					map.put("success", "修改成功...");
				} else {
					map.put("success", "修改失败...");
				}
			} else {
				Double longitude = null;//经度
				Double latitude = null;//纬度
				/*if( StringUtils.isNotBlank( community.getLonAndLat() ) && community.getLonAndLat().indexOf(",") != -1 ){
					String tmp = community.getLonAndLat();
					String[] strs = tmp.split(",");
					if( strs.length == 2 && NumberUtils.isNumber(strs[0]) && NumberUtils.isNumber(strs[1]) ){
						longitude = Double.valueOf( strs[0] );
						latitude = Double.valueOf( strs[1] );
					}
				}*/
				Map<String, String> json = LatitudeUtils.getGeocoderLatitude(community.getComm_address()+community.getComm_name());
				if( NumberUtils.isNumber(json.get("lng")) && NumberUtils.isNumber(json.get("lat")) ){
					longitude = Double.valueOf( json.get("lng") );
					latitude = Double.valueOf( json.get("lat") );
					System.out.println("经度:" + longitude + ",纬度:" + latitude + ";小区地址:" + community.getComm_address() + community.getComm_name());
				} else {
					System.err.println("没有定位到小区的地址:" + community.getComm_address() + community.getComm_name());
				}
				
				String sql = "insert into "
						+ Community.TABLENAME
						+ "(comm_name, comm_address, comm_address_code,comm_desc, hm_id, longitude, pinyin, busiCircle, latitude) "
						+ "value (? ,?, ?, ?, ?, ?, ?, ?, ?)";
				int affected = jdbcTemplate.update(
						sql,
						new Object[] { community.getComm_name(),
								community.getComm_address(),
								community.getComm_address_code(),
								community.getComm_desc(), community.getHm_id(),
								longitude, GetPinYin.getPinYin( community.getComm_name() ),
								community.getBusiCircle(), latitude
								});
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

	public boolean isExist(Community community) {
		if (StringUtils.isBlank(community.getComm_name())) {
			return true;
		}
		String sql = "select count(*) from " + Community.TABLENAME
				+ " where comm_name = ? and comm_address_code = ?";
		if (community.getId() != null && community.getId() > 0) {
			sql += " and id!=" + community.getId();
		}
		int count = jdbcTemplate.queryForInt(sql,
				new Object[] { community.getComm_name(), community.getComm_address_code() });
		System.out.println(" Community Count ： " + count + "-- "
				+ community.getComm_name());
		return (count > 0 ? true : false);
	}

	public List<CommunityVo> query(Pagination page, Map<String, Object> result) {
		// List
		List<CommunityVo> communityVos = new ArrayList<CommunityVo>();
		// 过滤条件
		StringBuilder filterCondition = new StringBuilder(
				" where comm.hm_id = hm.id ");
		// 字段
		String[] fields = new String[] { "comm.*", "hm_number", "hm_name" };
		
		String sql = "select " + StringUtils.join(fields, ",") + " from "
				+ Community.TABLENAME + " comm, " + HomeMaker.TABLENAME
				+ " hm " + filterCondition.toString();
		
		String pageCondition = PageUtil.getInstance().getQueryCondition(page, CommunityVo.class, true);
		String nopageCondition = PageUtil.getInstance().getQueryCondition(page, CommunityVo.class, false);
		sql += " " + pageCondition;
		System.out.println("sql:" + sql);

		List list = jdbcTemplate.queryForList(sql);// 分页数据

		int total = jdbcTemplate.queryForInt("select count(comm.id) from "
				+ Community.TABLENAME + " comm, " + HomeMaker.TABLENAME
				+ " hm " + filterCondition.toString() + " " + nopageCondition);
		for (int i = 0; list != null && i < list.size(); i++) {
			Map<String, Object> map = (Map<String, Object>) list.get(i);
			CommunityVo communityVo = new CommunityVo();
			LTBeanUtils.getInstance().Map2Bean(map, communityVo);
			communityVos.add(communityVo);
		}
		result.put("rows", communityVos);
		result.put("total", total);

		return communityVos;
	}

	public Map<String, Object> delete(String delids) {
		// 删除角色
		Map<String, Object> map = new HashMap<String, Object>();
		if (StringUtils.isBlank(delids)) {
			map.put("error", "请选中要删除的数据");
			return map;
		}
		String[] ids = delids.split(",");
		StringBuilder sb = new StringBuilder("delete  from "
				+ Community.TABLENAME);
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
		System.out.println("CommunityDaoImpl.delete() Sql : " + sql);
		int affected = jdbcTemplate.update(sql);
		map.put("success", "已经成功删除" + affected + "条记录...");
		return map;
	}

	/*
	 * public List<Community> query(Pagination page, Map<String, Object> result)
	 * { // List List<Community> communitys = new ArrayList<Community>(); // 分页
	 * StringBuilder paginationCondition = new StringBuilder(); // 排序
	 * StringBuilder sortCondition = new StringBuilder(" order by "); // 过滤条件
	 * StringBuilder filterCondition = new StringBuilder();
	 * 
	 * if (page != null) { if (page.getPage() > 0 && page.getRows() > 0) {
	 * paginationCondition.append(" limit ") .append((page.getPage() - 1) *
	 * page.getRows()) .append(" , ").append(page.getRows());
	 * 
	 * } if (StringUtils.isNotBlank(page.getSort())) {
	 * sortCondition.append(page.getSort() + " "); } else {
	 * sortCondition.append(" id "); } if
	 * (StringUtils.isNotBlank(page.getOrder())) {
	 * sortCondition.append(page.getOrder()); } else {
	 * sortCondition.append("desc"); } if
	 * (StringUtils.isNotBlank(page.getQueryType())) { if
	 * (StringUtils.isNotBlank(page.getQueryWord())) {
	 * filterCondition.append(" where " + page.getQueryType() + " like '%" +
	 * page.getQueryWord() + "%'"); } } } String sql = "select * from " +
	 * Community.TABLENAME + filterCondition.toString(); if
	 * (StringUtils.isNotBlank(sortCondition.toString())) { sql +=
	 * sortCondition.toString(); } if
	 * (StringUtils.isNotBlank(paginationCondition.toString())) { sql +=
	 * paginationCondition.toString(); } System.out.println("sql:" + sql);
	 * 
	 * List list = jdbcTemplate.queryForList(sql);// 分页数据
	 * 
	 * int total = jdbcTemplate.queryForInt("select count(id) from " +
	 * Community.TABLENAME + filterCondition.toString()); for (int i = 0; list
	 * != null && i < list.size(); i++) { Map<String, Object> map = (Map<String,
	 * Object>) list.get(i); Community community = new Community();
	 * LTBeanUtils.getInstance().Map2Bean(map, community);
	 * communitys.add(community); } result.put("rows", communitys);
	 * result.put("total", total);
	 * 
	 * return communitys; }
	 */

 
	public List<Community> getCommAddressById(int comm_id) {
		
		String address = "" ;
		List<Community> comms = new ArrayList<Community>();
		String sql = "select * from " +Community.TABLENAME +
				" where id = " + comm_id;
		List list = jdbcTemplate.queryForList(sql);
		
		for (int i = 0; list != null && i < list.size(); i++) {
			Map<String, Object> map = (Map<String, Object>) list.get(i);

			Community comm = new Community();
			LTBeanUtils.getInstance().Map2Bean(map, comm);
			comms.add(comm);
		}
		
		return comms;
	}

	/**********************************app 专用接口*****************************************/
	public List<CommunityVo> getCommunityByName( String comm_name, String cityid ) {
		if( jdbcTemplate == null ){
			jdbcTemplate = (JdbcTemplate) SpringManage.getInstance().getObject("jdbcTemplate");
		}
		List<CommunityVo> comms = new ArrayList<CommunityVo>();
		StringBuilder sql = new StringBuilder();
		sql.append( " select comm_name, longitude, latitude, count(room.id) as room_num from " + Community.TABLENAME + " comm," + Room.TABLENAME + " room where concat(comm_name, pinyin) like '%" + comm_name + "%' and comm_address like '%" + cityid + "%' and room.comm_id = comm.id and room.status = '0' group by comm.id" );
		System.out.println( "接口根据小区名进行查找:" + sql.toString() );
		List list = jdbcTemplate.queryForList(sql.toString());
		
		for (int i = 0; list != null && i < list.size(); i++) {
			Map<String, Object> map = (Map<String, Object>) list.get(i);

			CommunityVo comm = new CommunityVo();
			LTBeanUtils.getInstance().Map2Bean(map, comm);
			if( comm.getRoom_num() != 0){
				comms.add(comm);
			}
		}
		return comms;
	}

	public boolean isDeleteCommnuity() {
		return false;
	}

	public List<CommunityVo> getCommunityByDistance(String lonAndLat, Double r) {
		if( jdbcTemplate == null ){
			jdbcTemplate = (JdbcTemplate) SpringManage.getInstance().getObject("jdbcTemplate");
		}
		List<CommunityVo> comms = new ArrayList<CommunityVo>();
		
		if( StringUtils.isBlank( lonAndLat ) ){
			return comms;
		}
		if( !lonAndLat.contains( "," ) ){
			return comms;
		}
		if( lonAndLat.split(",").length != 2){
			return comms;
		}
		String[] poses = lonAndLat.split(",");
		if( !NumberUtils.isNumber( poses[0] ) || !NumberUtils.isNumber( poses[1] ) ){
			return comms;
		}
		
		Double longitude = Double.valueOf( poses[0] );
		Double latitude = Double.valueOf( poses[1] );
		
		StringBuilder sql = new StringBuilder();
		String tmp = CalDistance.getDistanceBylonAndLat(longitude, latitude);
		System.out.println( "tmp:" + tmp );
		sql.append( " select comm_name, count(room.id) as room_num ,longitude ,latitude  from " + Community.TABLENAME + " comm," + Room.TABLENAME + " room where room.comm_id = comm.id and room.status = '0' and " + tmp + " <= " + (r * 1000) + " group by comm.id" );
		System.out.println( "接口根据范围进行查找:" + sql.toString() );
		List list = jdbcTemplate.queryForList(sql.toString());
		
		for (int i = 0; list != null && i < list.size(); i++) {
			Map<String, Object> map = (Map<String, Object>) list.get(i);

			CommunityVo comm = new CommunityVo();
			LTBeanUtils.getInstance().Map2Bean(map, comm);
			if( comm.getRoom_num() != 0){
				comms.add(comm);
			}
		}
		return comms;
	}
	
	public static void main(String[] args) {
		new CommunityDaoImpl().getCommunityByDistance("120.23200927515691,30.192054810701006", 3.0);
	}

}
