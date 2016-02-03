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

import com.lingtong.dao.ImageDao;
import com.lingtong.dao.RoomDao;
import com.lingtong.interfaces.message.AppRoomPage;
import com.lingtong.interfaces.message.AppRoomPageUtil;
import com.lingtong.model.Community;
import com.lingtong.model.Company;
import com.lingtong.model.Hosts;
import com.lingtong.model.Image;
import com.lingtong.model.Pagination;
import com.lingtong.model.Room;
import com.lingtong.model.Unlock;
import com.lingtong.util.CalendarUtil;
import com.lingtong.util.FileUtils;
import com.lingtong.util.LTBeanUtils;
import com.lingtong.util.PageUtil;
import com.lingtong.util.SpringManage;
import com.lingtong.vo.RoomVo;

/**
 * 
 * @author MTT
 * @date 2015-8-4
 */
@Component("roomDaoImpl")
public final class RoomDaoImpl implements RoomDao {

	@Resource(name = "jdbcTemplate")
	private JdbcTemplate jdbcTemplate;

	@Resource(name = "imageDaoImpl")
	private ImageDao imageDaoImpl;

	public Map<String, Object> save(Room room) {
		//保存或修改房源
		Map<String, Object> result = new HashMap<String, Object>();
		if (room == null) {
			result.put("error", "房源信息为空...");
		}
		if (!isExist(room)) {// 如果不存在 房源名称是否重复
			if (room.getId() != null && room.getId() > 0)// 修改的情况
			{
				/*
				 * 新增的字段 bed; wardrobe; air_conditioning;tv; kitchen; bashroom
				 */
				String[] updateFields = new String[] { "room_name = ?",
						"address = ?", "price = ?", "rental_start_time = ?",
						"rental_end_time = ?", "status = ?", "`desc` = ?",
						"size = ?", "kind = ?", "floor = ?", "orient = ?",
						"occupancy = ?", "metro=?", "comm_id = ?", "bed=?",
						"wardrobe=?", "air_conditioning=?", "tv=?",
						"gasstove=?", "washing=?", "heater = ?",
						"refrigerator = ?", " microwaveOven= ?",
						"room_host= ?", "recommend=?", "recommendTarget=?",
						"cityid=?,decoration = ?,rent_type = ?,company_id=?,smartlock=?", "isRecommend=?" };
				Object[] fieldsValue = new Object[] {
						room.getRoom_name(),
						room.getAddress(),
						room.getPrice(),
						room.getRental_start_time(),
						room.getRental_end_time(),
						room.getStatus(),
						room.getDesc(),
						room.getSize(),
						room.getKind(),
						room.getFloor(),
						room.getOrient(),
						room.getOccupancy(),
						room.getMetro(),
						room.getComm_id(),
						room.getBed(),// 床
						room.getWardrobe(),// 衣柜
						room.getAir_conditioning(),// 空调
						room.getTv(),// 电视
						room.getGasstove(),// 燃气灶
						room.getWashing(),// 洗衣机
						room.getHeater(),// 热水器
						room.getRefrigerator(),// 冰箱
						room.getMicrowaveOven(),// 微波炉
						room.getRoom_host(), room.getRecommend(),
						room.getRecommendTarget(), room.getCityid(),
						room.getDecoration(), room.getRent_type(),
						room.getCompany_id(),
						room.getSmartlock(),
						room.getIsRecommend()};
				/*
				 * for( int i = 0; i < updateFields.length; i++ ){
				 * System.out.println(updateFields[i] + ":" + String.valueOf(
				 * fieldsValue[i] )); }
				 */

				String sql = "update " + Room.TABLENAME + " set "
						+ StringUtils.join(updateFields, ",") + " where id ="
						+ room.getId().toString();
				// System.out.println(sql );
				int affected = jdbcTemplate.update(sql, fieldsValue);
				if (affected > 0) {
					result.put("success", "修改成功");
				} else {
					result.put("success", "修改失败");
				}
			} else {// 新增

				String sql = "insert into "
						+ Room.TABLENAME
						+ " (room_name,"
						+ "address,price,"
						+ "rental_start_time,"
						+ "rental_end_time,"
						+ "status,size,"
						+ "kind,floor,"
						+ "orient,occupancy,"
						+ "metro,`desc`,"
						+ "comm_id,"
						+ " bed,wardrobe,"
						+ "air_conditioning,"
						+ "tv,gasstove,"
						+ "washing,heater,refrigerator,microwaveOven,room_host,"
						+ "recommend,"
						+ "recommendTarget,cityid,createtime,decoration,rent_type,company_id, smartlock, isRecommend) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				System.out.println(sql);

				int affected = jdbcTemplate.update(
						sql,
						new Object[] {
								room.getRoom_name(),
								room.getAddress(),
								room.getPrice(),
								room.getRental_start_time(),
								room.getRental_end_time(),
								room.getStatus(),
								room.getSize(),
								room.getKind(),
								room.getFloor(),
								room.getOrient(),
								room.getOccupancy(),
								room.getMetro(),
								room.getDesc(),
								room.getComm_id(),
								room.getBed(),
								room.getWardrobe(),
								room.getAir_conditioning(),
								room.getTv(),
								room.getGasstove(),// 燃气灶
								room.getWashing(),// 洗衣机
								room.getHeater(),// 热水器
								room.getRefrigerator(),// 冰箱
								room.getMicrowaveOven(),// 微波炉
								room.getRoom_host(), room.getRecommend(),
								room.getRecommendTarget(), room.getCityid(),
								CalendarUtil.getInstance().getCurrentTime(),
								room.getDecoration(), room.getRent_type(),
								room.getCompany_id(),
								room.getSmartlock(),
								room.getIsRecommend()
						});
				//获得id,再更新房源编号
				
				if (affected > 0) {
					String query = "select last_insert_id() as id from "
							+ Image.TABLENAME + " limit 1";
					System.out.println("图片id查询语句:" + query);
					int id = jdbcTemplate.queryForInt(query);
					String roomSeq = room.getRoomSeq()+ StringUtils.leftPad(id+"", 5, "0");
					affected = jdbcTemplate.update("update " + Room.TABLENAME + " set roomSeq = ? where id = ?", new Object[]{roomSeq, id});
					if( affected > 0){
						System.out.println("房源保存成功,且房源编号更新成功...");
					}
					result.put("success", "保存成功");
				} else {
					result.put("success", "保存失败");
				}
			}
		} else {
			result.put("error", "房源名称已存在");
		}

		return result;
	}

	public boolean isExist(Room room) {
		// TODO 是否存在相同的房源信息
		if (StringUtils.isBlank(room.getRoom_name())) {
			return true;
		}
		String sql = "select count(*) from " + Room.TABLENAME
				+ " where room_name = ?";
		if (room.getId() != null && room.getId() > 0) {
			sql += " and id != " + room.getId();
		}
		System.out.println("SQL :" + sql);
		int count = jdbcTemplate.queryForInt(sql,
				new Object[] { room.getRoom_name() });
		System.out.println("room_name:" + room.getRoom_name() + "count :"
				+ count);
		return (count > 0 ? true : false);
	}

	public List<RoomVo> query(Pagination page, Map<String, Object> results) {
		// 分页查询
		List<RoomVo> rooms = new ArrayList<RoomVo>();
		// 过滤条件
		StringBuilder filterCondition = new StringBuilder(
				" where room.comm_id = community.id and room.room_host = hosts.id and room.company_id = company.id");

		// 字段
		String[] fileds = new String[] { "room.*", "community.comm_name",
				"community.comm_address",
				"CONCAT(hosts.first_name,hosts.last_name) as fullname",
				"company.company_name as companyname" };

		String sql = "select " + StringUtils.join(fileds, ",") + " from "
				+ Room.TABLENAME + " room, " + Community.TABLENAME
				+ " community ," + Hosts.TABLENAME + " hosts, "
				+ Company.TABLENAME + " company " + filterCondition.toString();

		String pageCondition = PageUtil.getInstance().getQueryCondition(page,
				RoomVo.class, true);
		String nopageCondition = PageUtil.getInstance().getQueryCondition(page,
				RoomVo.class, false);
		sql += " " + pageCondition;
		System.out.println("sql:" + sql);

		List list = jdbcTemplate.queryForList(sql);// 分页数据

		int total = jdbcTemplate.queryForInt("select count(room.id) from "
				+ Room.TABLENAME + " room ," + Community.TABLENAME
				+ " community ," + Hosts.TABLENAME + " hosts ,"
				+ Company.TABLENAME + " company " + filterCondition.toString() + " " + nopageCondition);
		for (int i = 0; list != null && i < list.size(); i++) {
			Map<String, Object> map = (Map<String, Object>) list.get(i);
			RoomVo roomvo = new RoomVo();
			LTBeanUtils.getInstance().Map2Bean(map, roomvo);

			rooms.add(roomvo);
		}

		results.put("rows", rooms);
		results.put("total", total);

		return rooms;
	}
	
	public List<RoomVo> queryLock(Pagination page, Map<String, Object> results) {
		// 分页查询
		List<RoomVo> rooms = new ArrayList<RoomVo>();
		// 过滤条件
		StringBuilder filterCondition = new StringBuilder(
				" where room.comm_id = community.id and room.room_host = hosts.id and room.company_id = company.id and unlocktable.uz_room_seq = room.roomSeq ");

		// 字段
		String[] fileds = new String[] { "room.*", "community.comm_name",
				"community.comm_address",
				"CONCAT(hosts.first_name,hosts.last_name) as fullname",
				"company.company_name as companyname, unlocktable.roomid" };

		String sql = "select " + StringUtils.join(fileds, ",") + " from "
				+ Room.TABLENAME + " room, " + Community.TABLENAME
				+ " community ," + Hosts.TABLENAME + " hosts, "
				+ Company.TABLENAME + " company, " + Unlock.TABLENAME + " unlocktable " + filterCondition.toString();

		String pageCondition = PageUtil.getInstance().getQueryCondition(page,
				RoomVo.class, true);
		String nopageCondition = PageUtil.getInstance().getQueryCondition(page,
				RoomVo.class, false);
		sql += " " + pageCondition;
		System.out.println("sql:" + sql);

		List list = jdbcTemplate.queryForList(sql);// 分页数据

		int total = jdbcTemplate.queryForInt("select count(room.id) from "
				+ Room.TABLENAME + " room ," + Community.TABLENAME
				+ " community ," + Hosts.TABLENAME + " hosts ,"
				+ Company.TABLENAME + " company, " + Unlock.TABLENAME + " unlocktable " + filterCondition.toString() + " " + nopageCondition);
		for (int i = 0; list != null && i < list.size(); i++) {
			Map<String, Object> map = (Map<String, Object>) list.get(i);
			RoomVo roomvo = new RoomVo();
			LTBeanUtils.getInstance().Map2Bean(map, roomvo);

			rooms.add(roomvo);
		}

		results.put("rows", rooms);
		results.put("total", total);

		return rooms;
	}
	
	public Map<String, Object> delete(String delIds) {
		// TODO 删除房源
		Map<String, Object> map = new HashMap<String, Object>();
		if (StringUtils.isBlank(delIds)) {
			map.put("error", "请选中要删除的数据");
			return map;
		}
		String[] ids = delIds.split(",");
		StringBuilder sb = new StringBuilder("delete  from " + Room.TABLENAME);
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
		System.out.println("RoomDaoImpl.delete() Sql : " + sql);
		int affected = jdbcTemplate.update(sql);
		// 同时把图标标志位改为0
		imageDaoImpl.delete(delIds);

		map.put("success", "已经成功删除" + affected + "条记录...");
		return map;

	}

	public void updateRoomCityId(String comm_address, String comm_name,
			Integer comm_id) {
		StringBuilder sql = new StringBuilder();
		sql.append("update " + Room.TABLENAME
				+ " set cityid = concat(?, ?, room_name) where comm_id = ? ");
		jdbcTemplate.update(sql.toString(), new Object[] { comm_address,
				comm_name, comm_id });
	}

	public RoomVo getRoomDetailByRoomSeq(String roomSeq) {
		Map<String, Object> result = new HashMap<String, Object>();
		RoomVo roomVo = new RoomVo();
		StringBuilder sql = new StringBuilder();

		sql.append("select * from ").append(RoomVo.VIEWNAME)
				.append(" where roomSeq = '" + roomSeq + "'");
		List list = jdbcTemplate.queryForList(sql.toString());

		if (list != null && list.size() > 0) {
			Map<String, Object> map = (Map<String, Object>) list.get(0);
			LTBeanUtils.getInstance().Map2Bean(map, roomVo);
			if (StringUtils.isNotBlank(roomVo.getPicture())) {
				String[] filenames = roomVo.getPicture().split(",");

				List<String> urls = new ArrayList<String>();

				for (int k = 0; k < filenames.length; k++) {
					String url = FileUtils.downloadUrl2(filenames[k]);
					System.out.println(" url :" + url);
					urls.add(url);
				}
				roomVo.setPicture(StringUtils.join(
						urls.toArray(new String[] {}), ","));
			}
		}
		return roomVo;
	}
	/********************************** app 专用接口 *****************************************/
	public Map<String, Object> getFeaturedList(String cityid) {
		Map<String, Object> result = new HashMap<String, Object>();
		List<RoomVo> roomVos = new ArrayList<RoomVo>();
		if (jdbcTemplate == null) {
			jdbcTemplate = (JdbcTemplate) SpringManage.getInstance().getObject(
					"jdbcTemplate");
		}

		StringBuilder sql = new StringBuilder();

		String[] fields = new String[] { "id", "price", "comm_name", "kind",
				"address", "picture", "recommend", "recommendTarget", "size",
				"rent_type", "hm_number", "busiCircle", "longitude", "latitude", "roomSeq", "smartlock", "isRecommend" };
		String condition = " where cityid like '%" + cityid
				+ "%' " + " AND ( isRecommend = 1 )";//是否是推荐房源的字段";//getRoomListFilter() ;//and status = '0'
		sql.append("select " + StringUtils.join(fields, ",") + " from "
				+ RoomVo.VIEWNAME + condition);
		List list = jdbcTemplate.queryForList(sql.toString());

		for (int i = 0; list != null && i < list.size(); i++) {
			Map<String, Object> map = (Map<String, Object>) list.get(i);
			RoomVo roomVo = new RoomVo();
			LTBeanUtils.getInstance().Map2Bean(map, roomVo);
			if (StringUtils.isNotBlank(roomVo.getPicture())) {
				String[] filenames = roomVo.getPicture().split(",");

				List<String> urls = new ArrayList<String>();

				for (int k = 0; k < filenames.length; k++) {
					String url = FileUtils.downloadUrl2(filenames[k]);
					System.out.println(" url :" + url);
					urls.add(url);
				}
				roomVo.setPicture(StringUtils.join(
						urls.toArray(new String[] {}), ","));
			}
			/*
			 * if( map.get("URL") != null ){ String url = (String)
			 * map.get("URL"); if( StringUtils.isNotBlank( url.trim() ) ){ url =
			 * FileUtils.downloadUrl(url); roomVo.setPicture(url); } } if(
			 * roomVos.contains( roomVo ) ){//已经包含了 int pos = roomVos.indexOf(
			 * roomVo ); String picture = roomVos.get( pos ).getPicture(); if(
			 * picture == null ){ picture = roomVo.getPicture(); } else {
			 * picture += "," + roomVo.getPicture(); } roomVos.get( pos
			 * ).setPicture(picture); } else { roomVos.add( roomVo ); }
			 */
			roomVos.add(roomVo);
		}
		result.put("data", roomVos);
		result.put("code", "0");
		result.put("msg", "查询成功");
		return result;
	}

	public Map<String, Object> getRoomList(AppRoomPage page, String lonAndLat,
			String comm_name, String cityid) {
		if (jdbcTemplate == null) {
			jdbcTemplate = (JdbcTemplate) SpringManage.getInstance().getObject(
					"jdbcTemplate");
		}
		Map<String, Object> result = new HashMap<String, Object>();
		List<RoomVo> roomVos = new ArrayList<RoomVo>();
		StringBuilder sql = new StringBuilder();
		StringBuilder count = new StringBuilder();

		String[] fields = new String[] { "id", "price", "comm_name", "kind",
				"address", "picture", "recommend", "recommendTarget", "size",
				"rent_type", "hm_number", "busiCircle", "longitude", "latitude", "roomSeq", "smartlock", "isRecommend" };
		String condition = " where concat(comm_name, comm_pinyin) like '%"
				+ comm_name + "%' and cityid like '%" + cityid
				+ "%' " + getRoomListFilter();//and status = '0'

		Integer total = jdbcTemplate.queryForInt("select count(id) from "
				+ RoomVo.VIEWNAME + condition);
		sql.append(
				"select " + StringUtils.join(fields, ",") + " from "
						+ RoomVo.VIEWNAME + condition)
				.append(AppRoomPageUtil.getInstance().getPageSql(page,
						lonAndLat, true));
		// .append(" limit " + curPage * 5 + ", 5");
		System.out.println("总数:"
				+ "select count(id) from "
				+ RoomVo.VIEWNAME
				+ condition
				+ AppRoomPageUtil.getInstance().getPageSql(page, lonAndLat,
						false));
		System.out.println("接口根据小区名进行查找房源:" + sql.toString());
		List list = jdbcTemplate.queryForList(sql.toString());

		for (int i = 0; list != null && i < list.size(); i++) {
			Map<String, Object> map = (Map<String, Object>) list.get(i);

			RoomVo roomVo = new RoomVo();
			LTBeanUtils.getInstance().Map2Bean(map, roomVo);

			if (StringUtils.isNotBlank(roomVo.getPicture())) {
				String[] filenames = roomVo.getPicture().split(",");

				List<String> urls = new ArrayList<String>();

				for (int k = 0; k < filenames.length; k++) {
					String url = FileUtils.downloadUrl2(filenames[k]);
					System.out.println(" url :" + url);
					urls.add(url);
				}
				roomVo.setPicture(StringUtils.join(
						urls.toArray(new String[] {}), ","));
			}

			roomVos.add(roomVo);
		}

		if ((page.getCurPage() + 1) * page.getRows() <= total) {
			result.put("curPage", page.getCurPage() + 1);
		} else {
			result.put("curPage", page.getCurPage());
		}
		result.put("data", roomVos);
		result.put("code", "0");
		result.put("msg", "查询成功");
		result.put("total", total);
		return result;
	}

	public Map<String, Object> getRoomDetailById(String roomid) {
		if (jdbcTemplate == null) {
			jdbcTemplate = (JdbcTemplate) SpringManage.getInstance().getObject(
					"jdbcTemplate");
		}
		Map<String, Object> result = new HashMap<String, Object>();
		List<RoomVo> roomVos = new ArrayList<RoomVo>();
		StringBuilder sql = new StringBuilder();
		StringBuilder count = new StringBuilder();

		// String[] fields = new String[]{"id", "price", "comm_name", "kind",
		// "address", "picture", "recommend", "recommendTarget"};
		// String condition = " where concat(comm_name, comm_pinyin) like '%" +
		// comm_name + "%' and cityid like '%" + cityid + "%' and status = '0'";
		// Integer total = jdbcTemplate.queryForInt( "select count(id) from " +
		// RoomVo.VIEWNAME + condition );
		// sql.append( "select " + StringUtils.join(fields, ",") + " from " +
		// RoomVo.VIEWNAME + condition)
		// .append(" limit " + curPage * 5 + ", 5");

		// String[] fields = new String[]{"id", "price", "comm_name", "kind",
		// "address", "picture", "recommend", "recommendTarget"};
		System.out.println("根据房源ID 获取房源明细 :" + sql.toString());
		sql.append("select * from ").append(RoomVo.VIEWNAME)
		.append(" where id =" + roomid + " and picture like '%.thumb.%'");
//		sql.append("select * from ").append(RoomVo.VIEWNAME)
//		.append(" where id =" + roomid);
		List list = jdbcTemplate.queryForList(sql.toString());

		if (list != null && list.size() > 0) {
			Map<String, Object> map = (Map<String, Object>) list.get(0);
			RoomVo roomVo = new RoomVo();
			LTBeanUtils.getInstance().Map2Bean(map, roomVo);
			if (StringUtils.isNotBlank(roomVo.getPicture())) {
				String[] filenames = roomVo.getPicture().split(",");

				List<String> urls = new ArrayList<String>();

				for (int k = 0; k < filenames.length; k++) {
					if (filenames[k].contains(".thumb.")) {
						String url = FileUtils.downloadUrl2(filenames[k]);
						System.out.println(" url :" + url);
						urls.add(url);
					}
				}
				roomVo.setPicture(StringUtils.join(
						urls.toArray(new String[] {}), ","));
			}
			roomVos.add(roomVo);
		}

		result.put("data", roomVos);
		result.put("code", "0");
		result.put("msg", "查询成功");
		return result;
	}

	public Map<String, Object> getRoomVoById(String roomid) {
		if (jdbcTemplate == null) {
			jdbcTemplate = (JdbcTemplate) SpringManage.getInstance().getObject(
					"jdbcTemplate");
		}
		Map<String, Object> result = new HashMap<String, Object>();
		List<RoomVo> roomVos = new ArrayList<RoomVo>();
		StringBuilder sql = new StringBuilder();
		StringBuilder count = new StringBuilder();
		sql.append("select * from ").append(RoomVo.VIEWNAME)
				.append(" where id =" + roomid);
		System.out.println("根据房源ID 获取房源明细 :" + sql.toString());
		List list = jdbcTemplate.queryForList(sql.toString());
		if (list != null && list.size() > 0) {
			Map<String, Object> map = (Map<String, Object>) list.get(0);
			RoomVo roomVo = new RoomVo();
			LTBeanUtils.getInstance().Map2Bean(map, roomVo);
			if (StringUtils.isNotBlank(roomVo.getPicture())) {
				String[] filenames = roomVo.getPicture().split(",");

				List<String> urls = new ArrayList<String>();

				for (int k = 0; k < filenames.length; k++) {
					String url = FileUtils.downloadUrl2(filenames[k]);
					System.out.println(" url :" + url);
					urls.add(url);
				}
				roomVo.setPicture(StringUtils.join(
						urls.toArray(new String[] {}), ","));
			}
			roomVos.add(roomVo);
		}

		result.put("data", roomVos);
		result.put("code", "0");
		result.put("msg", "查询成功");
		return result;
	}

	private  String getRoomListFilter()
	{
		String cond = " AND (`status` = '0'  OR  (`status`='1' AND DATEDIFF(date_add(NOW(), interval 2 month),rental_end_time)>0 AND DATEDIFF(NOW(),rental_end_time)<0 ))";
		return  cond;
	}

}
