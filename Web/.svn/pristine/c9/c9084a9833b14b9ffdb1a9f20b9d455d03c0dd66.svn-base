package com.lingtong.dao.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.NumberUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;

import com.google.gson.Gson;
import com.lingtong.dao.FavoriteListDao;
import com.lingtong.interfaces.message.CommonErrorEnum;
import com.lingtong.model.Community;
import com.lingtong.model.FavoriteList;
import com.lingtong.model.Image;
import com.lingtong.model.Room;
import com.lingtong.model.Tenants;
import com.lingtong.util.CalendarUtil;
import com.lingtong.util.FileUtils;
import com.lingtong.util.LTBeanUtils;
import com.lingtong.util.SpringManage;
import com.lingtong.vo.RoomVo;
import com.lingtong.vo.TenantVo;

/**
 * @author xqq
 * @date 2015-8-16 下午4:34:04
 * 
 */
public class FavoriteListDaoImpl implements FavoriteListDao {
	@Resource(name="jdbcTemplate")
	private JdbcTemplate jdbcTemplate;
	
	/**********************************app 专用接口*****************************************/
	public Map<String, Object> save(String tenant_id, String room_id) {
		if( jdbcTemplate == null ){
			jdbcTemplate = (JdbcTemplate) SpringManage.getInstance().getObject("jdbcTemplate");
		}
		Map<String, Object> map = new HashMap<String, Object>();
		
		int num = jdbcTemplate.queryForInt(" select count(*) from " + Tenants.TABLENAME + " where id = ?", new Object[]{ tenant_id });
		if( num < 1){//不存在改房客
			map.put("code", CommonErrorEnum.TENANT_IS_NOT_EXIST.getCode());
			map.put("msg", CommonErrorEnum.TENANT_IS_NOT_EXIST.getMessage());
			return map;
		}
		
		num = jdbcTemplate.queryForInt(" select count(*) from " + Room.TABLENAME + " where id = ?", new Object[]{ room_id });
		if( num < 1){//不存在改房客
			map.put("code", CommonErrorEnum.ROOM_IS_NOT_EXIST.getCode());
			map.put("msg", CommonErrorEnum.ROOM_IS_NOT_EXIST.getMessage());
			return map;
		}
		
		StringBuilder sql = new StringBuilder();
		sql.append( "update " + FavoriteList.TABLENAME + " set updatetime = ? where tenant_id = ? and room_id = ? " );
		String updatetime = CalendarUtil.getInstance().getCurrentTime();
		System.out.println( updatetime);
		int affected = jdbcTemplate.update(sql.toString(), new Object[]{ updatetime, tenant_id, room_id});
		
		if( affected > 0 ){
			map.put("code", 0);
			map.put("msg", "已被添加到中意列表");
		} else {
			StringBuilder insertSql = new StringBuilder();
			insertSql.append( "insert into " + FavoriteList.TABLENAME + "(tenant_id, room_id, updatetime) values(?, ?, ?)" );
			affected = jdbcTemplate.update(insertSql.toString(), new Object[]{tenant_id, room_id, updatetime});
			map.put("code", 0);
			map.put("msg", "添加成功");
		}
		return map;
	}


	public Map<String, Object> query(String tenant_id) {
		if( jdbcTemplate == null ){
			jdbcTemplate = (JdbcTemplate) SpringManage.getInstance().getObject("jdbcTemplate");
		}
		Map<String, Object> result = new HashMap<String, Object>();
		List<TenantVo> tenants = new ArrayList<TenantVo>();
		
		StringBuilder sql = new StringBuilder();
		String[] fields = new String[]{"roomview.id as id", "price", "comm_name", "kind", "address", "kind", "address", "picture", "recommend", "recommendTarget", "roomSeq", "smartlock", "longitude", "latitude"};
		//sql.append(" select " + StringUtils.join(fields, ",") + " from " + Tenants.TABLENAME + " tenant," + Room.TABLENAME + " room, " + FavoriteList.TABLENAME + " ft," + Community.TABLENAME + " comm," + Image.TABLENAME + " img where ft.tenant_id = ? and room.id = ft.room_id and tenant.id = ft.tenant_id and img.room_id = room.id and comm.id = room.comm_id" );
		sql.append(" select " + StringUtils.join(fields, ",") + " from " + Tenants.TABLENAME + " tenant," + FavoriteList.TABLENAME + " ft," + RoomVo.VIEWNAME + " roomview where ft.tenant_id = ? and roomview.id = ft.room_id and tenant.id = ft.tenant_id" );
		System.out.println( sql );
		List list = jdbcTemplate.queryForList(sql.toString(), new Object[]{tenant_id});
		for( int i = 0; list != null && i < list.size(); i++ ){
			Map<String, Object> map = (Map<String, Object>) list.get(i);
			TenantVo tVo = new TenantVo();
			LTBeanUtils.getInstance().Map2Bean(map, tVo);
			/*if( map.get("URL") != null ){
				String url = (String) map.get("URL");
				if( StringUtils.isNotBlank( url.trim() ) ){
					url = FileUtils.downloadUrl2(url);
					tVo.setPicture(url);
				}
			}
			if( tenants.contains( tVo ) ){//已经包含了
				int pos = tenants.indexOf( tVo );
				String picture = tenants.get( pos ).getPicture();
				if( picture == null ){
					picture = tVo.getPicture();
				} else {
					picture += "," + tVo.getPicture();
				}
				tenants.get( pos ).setPicture(picture);
			} else {
				tenants.add( tVo );
			}*/
			if (StringUtils.isNotBlank(tVo.getPicture())) {
				String[] filenames = tVo.getPicture().split(",");

				List<String> urls = new ArrayList<String>();

				for (int k = 0; k < filenames.length; k++) {
					String url = FileUtils.downloadUrl2(filenames[k]);
					System.out.println(" url :" + url);
					urls.add(url);
				}
				tVo.setPicture(StringUtils.join(
				urls.toArray(new String[] {}), ","));
			}
			tenants.add(tVo);
		}
		result.put("data", tenants);
		result.put("code", "0");
		result.put("msg", "查询成功");
		return result;
	}
	
	public Map<String, Object> delFeaturedList(Integer uid, String delIds){
		if( jdbcTemplate == null ){
			jdbcTemplate = (JdbcTemplate) SpringManage.getInstance().getObject("jdbcTemplate");
		}
		Map<String, Object> result = new HashMap<String, Object>();
		
		StringBuilder condition = new StringBuilder( "delete from " + FavoriteList.TABLENAME + " where tenant_id = " + uid );
	
		if ( !StringUtils.isBlank(delIds)) {
			List<String> idConds = new ArrayList<String>();
			
			String[] ids = delIds.split(",");
			for (String id : ids){
				if (NumberUtils.isNumber(id)) {
					idConds.add( " room_id = " + id );
				}
			}
			
			if( idConds.size() > 0 ){
				String tmp = StringUtils.join( idConds.toArray( new String[]{} ), " or " );
				condition.append( " and (" + tmp )
				 .append( ")" );
			}
		}
		System.out.println( "删除中意房源sql:" + condition.toString() );
		
		int affected = jdbcTemplate.update( condition.toString() );
		result.put("code", "0");
		result.put("msg", affected + "条中意房源被删除");
		return result;
	}
	
	public static void main(String[] args) {
		Map<String, Object> map = new FavoriteListDaoImpl().query("48");
		System.out.println( new Gson().toJson(map) );
	}
}
