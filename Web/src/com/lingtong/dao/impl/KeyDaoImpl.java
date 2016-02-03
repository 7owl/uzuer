package com.lingtong.dao.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.NumberUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import cn.com.ultrapower.eoms.util.StringUtil;

import com.lingtong.dao.KeyDao;
import com.lingtong.model.Community;
import com.lingtong.model.HomeMaker;
import com.lingtong.model.KeyList;
import com.lingtong.model.Pagination;
import com.lingtong.model.Tenants;
import com.lingtong.model.Unlock;
import com.lingtong.util.LTBeanUtils;
import com.lingtong.util.PageUtil;
import com.lingtong.util.PushtoSingleUtil;
import com.lingtong.util.SystemConfiguration;
import com.lingtong.vo.CommunityVo;
import com.lingtong.vo.KeyListVo;
import com.lingtong.vo.RoomVo;
import com.lingtong.vo.TenantAndUnlock;
import com.ssqian.common.util.MD5Utils;
import com.uzuser.thirdparty.sciener.Authorize;
import com.uzuser.thirdparty.sciener.DeleteKeyUtil;
import com.uzuser.thirdparty.sciener.FreezeKeyUtil;
import com.uzuser.thirdparty.sciener.GetKeyListUtil;
import com.uzuser.thirdparty.sciener.SendKey;

/**
 * @author xqq
 * @date 2015-9-27 下午12:19:00
 * 
 */
@Component("keyDaoImpl")
public class KeyDaoImpl implements KeyDao {
	
	@Resource(name="jdbcTemplate")
	private JdbcTemplate jdbcTemplate;
	
	public boolean save(List<KeyList> keys) {
		StringBuilder sql = new StringBuilder("insert into " + KeyList.TABLENAME + " (`date`, end_date, key_id, key_status, room_id, start_date) values");
		if( keys == null || keys.size() == 0 ){
			return false;
		}
		Object[] values = new Object[6*keys.size()];
		String[] fields = new String[keys.size()];
		int i = 0;
		for( KeyList key : keys ){
			values[i] = key.getDate();
			values[i+1] = key.getEnd_date();
			values[i+2] = key.getKey_id();
			values[i+3] = key.getKey_status();
			values[i+4] = key.getRoom_id();
			values[i+5] = key.getKey_status();
			i+=5;
		}
		for( int j = 0 ; j < keys.size(); j++ ){
			fields[j] = "(?,?,?,?,?,?)";
		}
		sql.append( StringUtils.join(fields, ",")  )
			.append(" on duplicate key update `date`=values(`date`), end_date=values(end_date), key_status=values(key_status), room_id=values(room_id), start_date=values(start_date)");
		System.out.println(sql.toString());
		return jdbcTemplate.update(sql.toString(), values) > 0 ? true : false;
	}

	public void query(Pagination page, Map<String, Object> results) {
		// List
		List<KeyListVo> keyListVos = new ArrayList<KeyListVo>();
		// 过滤条件
		StringBuilder filterCondition = new StringBuilder(
				" where keylist.room_id = locklist.roomid and locklist.uz_room_seq = roomview.roomSeq and tu.openid = ten.sciener_openid and tu.lockid = locklist.roomid and keylist.openid = tu.openid");
		// 字段
		String[] fields = new String[] { "keylist.*", "roomSeq", "comm_address", "comm_name", "room_name", "keylist.openid", "concat(first_name, last_name) as fullname"};
		
		String sql = "select " + StringUtils.join(fields, ",") + " from "
				+ KeyList.TABLENAME + " keylist, " + Unlock.TABLENAME
				+ " locklist, " + RoomVo.VIEWNAME + " roomview, " + TenantAndUnlock.TABLENAME + " tu, " + Tenants.TABLENAME + " ten " + filterCondition.toString();
		
		String pageCondition = PageUtil.getInstance().getQueryCondition(page, KeyListVo.class, true);
		String nopageCondition = PageUtil.getInstance().getQueryCondition(page, KeyListVo.class, false);
		sql += " " + pageCondition;
		System.out.println("sql:" + sql);

		List list = jdbcTemplate.queryForList(sql);// 分页数据

		int total = jdbcTemplate.queryForInt("select count(keylist.key_id) from "
				+ KeyList.TABLENAME + " keylist, " + Unlock.TABLENAME
				+ " locklist, " + RoomVo.VIEWNAME + " roomview, " + TenantAndUnlock.TABLENAME + " tu, " + Tenants.TABLENAME + " ten " + filterCondition.toString() 
				+ " " + nopageCondition);
		for (int i = 0; list != null && i < list.size(); i++) {
			Map<String, Object> map = (Map<String, Object>) list.get(i);
			KeyListVo keyListVo = new KeyListVo();
			LTBeanUtils.getInstance().Map2Bean(map, keyListVo);
			keyListVos.add(keyListVo);
		}
		results.put("rows", keyListVos);
		results.put("total", total);
	}

	public Map<String, Object> delete(String room_id, String key_id, String openid) {
		Map<String, Object> result = new HashMap<String, Object>();
		Map authInfo = Authorize.getInstance().authorizeDirect(SystemConfiguration.getString("sciener.admin.username"), MD5Utils.md5(SystemConfiguration.getString("sciener.admin.password")));
		Integer roomid = Integer.parseInt(room_id);
		Integer keyid  = Integer.parseInt(key_id);
		if(DeleteKeyUtil.getInstance().deleteKey(authInfo, roomid, keyid, openid)){
			int affected = jdbcTemplate.update("delete from " + KeyList.TABLENAME + " where key_id = ?", new Object[]{key_id});
			jdbcTemplate.update("delete from " + TenantAndUnlock.TABLENAME + " where openid = ? and lockid = ?", new Object[]{openid, room_id});
			if( affected > 0 ){
				result.put("msg", "删除成功");
			} else {
				result.put("msg", "删除失败");
			}
		} else {
			result.put("msg", "删除失败");
		}
		
		return result;
	}
	
	public Map<String, Object> sendKey(String roomSeq, Tenants tenant, String start_date, String end_date, String locks) {
		Map<String, Object> result = new HashMap<String, Object>();
		if( StringUtils.isNotBlank(roomSeq) ){
			String[] rooms = roomSeq.split(",");
			String[] lockids = locks.split(",");
			int success = 0;
			for( int j = 0; j < rooms.length; j++ ){
				String room = rooms[j];
				if( NumberUtils.isNumber( room ) ){
					Map map = Authorize.getInstance().authorizeDirect(SystemConfiguration.getString("sciener.admin.username"), MD5Utils.md5(SystemConfiguration.getString("sciener.admin.password")));;
					int count = jdbcTemplate.queryForInt("select count(*) from " + TenantAndUnlock.TABLENAME + " where openid = ? and lockid=?", new Object[]{tenant.getSciener_openid(), Integer.parseInt(lockids[j])});
					if( count < 1){//如果不存在
						if( map != null && map.get("openid") != null && StringUtils.isNotBlank( map.get("openid").toString() ) ){
							//先往冗余表插记录
							int affected = jdbcTemplate.update("insert into " + TenantAndUnlock.TABLENAME + " (openid, lockid) values(?,?)", new Object[]{tenant.getSciener_openid(), Integer.parseInt(lockids[j])});
							if( affected > 0 ){
								int id = jdbcTemplate.queryForInt("SELECT LAST_INSERT_ID()");
								if( SendKey.getInstance().sendKey(Integer.parseInt(lockids[j]), tenant, start_date, end_date) ){//成功的话,获取钥匙列表
									success++;
									Map authMap = Authorize.getInstance().authorizeDirect(tenant.getSciener_username(), tenant.getSciener_password());
									System.out.println(authMap);
									JSONObject json = GetKeyListUtil.getInstance().getKeyList(authMap);
									System.out.println(json);
									if( json != null ) {
										JSONArray list = json.getJSONArray("list");
										/*List<KeyList> keyList = new ArrayList<KeyList>();
										for(int i = 0; i < list.size(); i++){//往钥匙表,加数据
											JSONObject key = (JSONObject) list.get(i);
											KeyList k = new KeyList();
											k.setKey_id(key.getLong("key_id"));
											k.setRoom_id(key.getLong("room_id"));
											if( !keyList.contains(k) ){//
												keyList.add(k);
												int num = jdbcTemplate.queryForInt("select count(*) from " + KeyList.TABLENAME + " where key_id = ?", new Object[]{key.get("key_id")} );
												if( num < 1){
													jdbcTemplate.update("insert into " + KeyList.TABLENAME + " (`date`, end_date, key_id, key_status, room_id, start_date, openid) values(?,?,?,?,?,?,?)", new Object[]{key.get("date"), key.get("end_date"), key.get("key_id"), key.get("key_status"), key.get("room_id"), key.get("start_date"), tenant.getSciener_openid()});
												} else {
													result.put("code", "-1");
													result.put("msg", "电子锁以已存在...");
												}
											}
										}
										keyList = null;*/
										List<KeyList> keyList = new ArrayList<KeyList>();
										if( list.size() > 0 ){
											JSONObject key = (JSONObject) list.get(0);
											for(int i = 1; i < list.size(); i++){//往钥匙表,加数据
												JSONObject keyJson = (JSONObject) list.get(i);
												KeyList k = new KeyList();
												k.setKey_id(keyJson.getLong("key_id"));
												k.setRoom_id(keyJson.getLong("room_id"));
												k.setRoom_id(keyJson.getLong("room_id"));
												if( keyJson.getLong("date") > key.getLong("date") ){
													key = keyJson;
												}
											}//将最新的钥匙信息更新到数据库中
											int num = jdbcTemplate.queryForInt("select count(*) from " + KeyList.TABLENAME + " where key_id = ?", new Object[]{key.get("key_id")} );
											if( num < 1){
												jdbcTemplate.update("insert into " + KeyList.TABLENAME + " (`date`, end_date, key_id, key_status, room_id, start_date, openid) values(?,?,?,?,?,?,?)", new Object[]{key.get("date"), key.get("end_date"), key.get("key_id"), key.get("key_status"), key.get("room_id"), key.get("start_date"), tenant.getSciener_openid()});
											} else {
												result.put("code", "-2");
												result.put("msg", "电子锁以已存在...");
											}
										} else {
											result.put("code", "-3");
											result.put("msg", "电子锁发送失败...");
										}
									}
								} else {//上传失败,删除冗余记录
									jdbcTemplate.update("delete from " + TenantAndUnlock.TABLENAME + " where id = ?", new Object[]{id});
								}
							}
						}
					}
				}
			}
			if( result.get("code") == null ){
				result.put("code", "0");
				result.put("msg", success + "条电子锁上传成功...");
			}
			try {
				PushtoSingleUtil.pushToCilent(tenant.getClientid(), "尊敬的优租用户,您有" + success + "条电子锁上传成功...", "1", tenant.getDevicetoken(),"","13");
				PushtoSingleUtil.pushToCilent(tenant.getClientid(), "尊敬的优租用户,您有" + success + "条电子锁上传成功...", "2", tenant.getDevicetoken(),"","13");
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			result.put("code", "-4");
			result.put("msg", "0条电子锁上传成功");
		}
		return result;
	}
	
	public Map<String, Object> freezeKey(String isFreeze, String room_id,
			String key_id, String openid) {
		Map map = Authorize.getInstance().authorizeDirect(SystemConfiguration.getString("sciener.admin.username"), MD5Utils.md5(SystemConfiguration.getString("sciener.admin.password")));
		Map<String, Object> result = new HashMap<String, Object>();
		boolean flag = false;
		if( JSONObject.fromObject(map) != null && StringUtils.isNotBlank("room_id") && StringUtils.isNotBlank("key_id") ){
			Integer roomid = Integer.parseInt( room_id );
			Integer keyid = Integer.parseInt( key_id );
			if( "1".equals(isFreeze) ){//1表示冻结
				FreezeKeyUtil.getInstance().freeze(JSONObject.fromObject(map), roomid, keyid, openid);
			} else if( "0".equals(isFreeze) ){//0表示解冻
				FreezeKeyUtil.getInstance().unfreeze(JSONObject.fromObject(map), roomid, keyid, openid);
			}
		}
		if( "1".equals(isFreeze) ){
			jdbcTemplate.update("update " + KeyList.TABLENAME + " set sciener_is_freeze = 1 where room_id = ? and key_id = ? ", new Object[]{room_id, key_id} );
			result.put("msg", "冻结成功");
		} else {
			jdbcTemplate.update("update " + KeyList.TABLENAME + " set sciener_is_freeze = 0 where room_id = ? and key_id = ? ", new Object[]{room_id, key_id} );
			result.put("msg", "解冻成功");
		} 
		return result;
	}
	
}
