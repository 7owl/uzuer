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

import com.google.gson.Gson;
import com.lingtong.dao.UnlockDao;
import com.lingtong.interfaces.message.CommonErrorEnum;
import com.lingtong.model.Community;
import com.lingtong.model.KeyList;
import com.lingtong.model.Pagination;
import com.lingtong.model.Role;
import com.lingtong.model.Room;
import com.lingtong.model.Tenants;
import com.lingtong.model.Unlock;
import com.lingtong.util.LTBeanUtils;
import com.lingtong.util.PageUtil;
import com.lingtong.util.PushtoSingleUtil;
import com.lingtong.util.SpringManage;
import com.lingtong.util.SystemConfiguration;
import com.lingtong.vo.ContractVo;
import com.lingtong.vo.TenantAndUnlock;
import com.lingtong.vo.UnlockVo;
import com.ssqian.common.util.MD5Utils;
import com.uzuser.thirdparty.sciener.Authorize;
import com.uzuser.thirdparty.sciener.FreezeKeyUtil;
import com.uzuser.thirdparty.sciener.GetKeyListUtil;
import com.uzuser.thirdparty.sciener.SendKey;

/**
 * @author xqq
 * @date 2015-9-22 下午10:18:39
 * 
 */
@Component("unlockDaoImpl")
public class UnlockDaoImpl implements UnlockDao {
	@Resource(name="jdbcTemplate")
	private JdbcTemplate jdbcTemplate;

	public Map<String, Object> create(Unlock unlock) {
		Map<String, Object> result = new HashMap<String, Object>();
		if (jdbcTemplate == null) {
			jdbcTemplate = (JdbcTemplate) SpringManage.getInstance().getObject(
					"jdbcTemplate");
		}
		String[] fields = new String[] { "adminKeyboardPs",
				"adminKeyboardPsTmp", "aseKey", "date", "day10mPsIndex",
				"day1PsIndex", "day2PsIndex", "day3PsIndex", "day4PsIndex",
				"day5PsIndex", "day6PsIndex", "day7PsIndex", "deletePs",
				"deletePsTmp", "desc1", "doorName", "endDate", "hasbackup",
				"isAdmin", "isShared", "`key`", "kid", "lockName", "lockmac",
				"mac", "password", "roomid", "startDate", "unlockFlag",
				"username", "version", "uz_room_seq"};
		String[] tmps = new String[fields.length];
		
		String[] updateFields = new String[fields.length];
		for( int i = 0; i < fields.length; i++){
			tmps[i] = "?";
			updateFields[i] = fields[i] + " = ?";
		}
		Object[] values = new Object[]{
				unlock.getAdminKeyboardPs(),
			unlock.getAdminKeyboardPsTmp(), unlock.getAseKey(), unlock.getDate(), unlock.getDay10mPsIndex(),
			unlock.getDay1PsIndex(), unlock.getDay2PsIndex(), unlock.getDay3PsIndex(), unlock.getDay4PsIndex(),
			unlock.getDay5PsIndex(), unlock.getDay6PsIndex(), unlock.getDay7PsIndex(), unlock.getDeletePs(),
			unlock.getDeletePsTmp(), unlock.getDesc1(), unlock.getDoorName(), unlock.getEndDate(), unlock.getHasbackup(),
			unlock.getIsAdmin(), unlock.getIsShared(), unlock.getKey(), unlock.getKid(), unlock.getLockName(), unlock.getLockmac(),
			unlock.getMac(), unlock.getPassword(), unlock.getRoomid(), unlock.getStartDate(), unlock.getUnlockFlag(),
			unlock.getUsername(), unlock.getVersion(), unlock.getUz_room_seq()
		};
		int isExist = jdbcTemplate.queryForInt("select count(roomid) from " + Unlock.TABLENAME + " where roomid = ?", new Object[]{unlock.getRoomid()});
		System.out.println("锁查询:" + "select count(roomid) from " + Unlock.TABLENAME + " where roomid = " + unlock.getRoomid() );
		int affect ;
		if( isExist < 1 ){//锁不存在,进行创建
			affect = jdbcTemplate.update("insert into " + Unlock.TABLENAME + " (" + StringUtils.join(fields, ",") + ") values (" + StringUtils.join(tmps, ",") + ")", values);
		} else {//锁已存在,进行更新
			affect = jdbcTemplate.update("update " + Unlock.TABLENAME + " set " + StringUtils.join(updateFields, ",") + " where roomid = " + unlock.getRoomid(), values);
		}
		if( affect > 0){
			result.put("code", "0");
			result.put("msg", "锁创建成功...");
		} else {
			result.put("code", CommonErrorEnum.UNLOCK_CREATE_FAIL.getCode() + "");
			result.put("msg", CommonErrorEnum.UNLOCK_CREATE_FAIL.getMessage());
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
	

	public void query(Pagination page, Map<String, Object> results) {
		if( results == null ){
			results = new HashMap<String, Object>();
		}
		// List
		List<UnlockVo> unlocks = new ArrayList<UnlockVo>();
		// 分页
		StringBuilder paginationCondition = new StringBuilder();
		// 排序
		StringBuilder sortCondition = new StringBuilder(" order by ");
		// 过滤条件
		StringBuilder filterCondition = new StringBuilder();
		filterCondition.append( " where sl.uz_room_seq = room.roomSeq and room.comm_id = comm.id " );
		
		String pageCondition = PageUtil.getInstance().getQueryCondition(page,
				UnlockVo.class, true);
		String nopageCondition = PageUtil.getInstance().getQueryCondition(page,
				UnlockVo.class, false);
		
		String[] fields = new String[]{"kid", "roomid", "roomSeq", "room_name", "comm_address", "comm_name"};
		String sql = "select " + StringUtils.join(fields, ",") + " from " + UnlockVo.TABLENAME + " sl, " + Room.TABLENAME + " room," + Community.TABLENAME + " comm " + 
					 filterCondition.toString() + " " + pageCondition;
		
		System.out.println("sql:" + sql);

		List list = jdbcTemplate.queryForList(sql);// 分页数据

		int total = jdbcTemplate.queryForInt("select count(roomid) from "
				 + UnlockVo.TABLENAME + " sl, " + Room.TABLENAME + " room," + Community.TABLENAME + " comm " 
				 + filterCondition.toString() + " " + nopageCondition);
		for (int i = 0; list != null && i < list.size(); i++) {
			Map<String, Object> map = (Map<String, Object>) list.get(i);
			UnlockVo unlock = new UnlockVo();
			LTBeanUtils.getInstance().Map2Bean(map, unlock);
			unlocks.add(unlock);
		}
		results.put("rows", unlocks);
		results.put("total", total);
	}


	public Map<String, Object> delete(String delIds) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		if( StringUtils.isNotBlank( delIds) ){
			String[] roomids = delIds.split(",");
			String[] delUnlock = new String[roomids.length];//删除锁表中的数据
			String[] delTU = new String[roomids.length];//删除房客与锁表中关联的数据
			String[] delKey = new String[roomids.length];//删除钥匙表中关联的锁数据
			
			for( int i = 0; i < roomids.length; i++ ){
				String roomid = roomids[i];
				delUnlock[i] = "roomid=?";
				delTU[i] = "lockid=?";
				delKey[i] = "room_id=?";
			}
			int affect = jdbcTemplate.update("delete from " + Unlock.TABLENAME + " where " + StringUtils.join(delUnlock, " or "), roomids);
			jdbcTemplate.update("delete from " + TenantAndUnlock.TABLENAME + " where " + StringUtils.join(delTU, " or "), roomids);
			jdbcTemplate.update("delete from " + KeyList.TABLENAME + " where " + StringUtils.join(delKey, " or "), roomids);
			
			result.put("success", affect + "把锁已被删除...");
			result.put("code", "1");
		} else {
			result.put("error", "请选择要删除的锁");
			result.put("code", "-1");
		}
		
		return result;
	}
	
	public static void main(String[] args) {
		Unlock unlock = new Unlock();
		unlock.setAdminKeyboardPs("AdminKeyboardPs");
		unlock.setAdminKeyboardPsTmp("AdminKeyboardPsTmp");
		unlock.setAseKey("asekey");
		unlock.setDate(100d);
		unlock.setDay10mPsIndex(10);
		unlock.setDay1PsIndex(1);
		unlock.setDay2PsIndex(2);
		unlock.setDay3PsIndex(3);
		unlock.setDay4PsIndex(4);
		unlock.setDay5PsIndex(5);
		unlock.setDay6PsIndex(6);
		unlock.setDay7PsIndex(7);
		unlock.setDeletePs("deleteps");
		unlock.setDeletePsTmp("deletePsTmp");
		unlock.setDesc1("desc1");
		unlock.setDoorName("doorName");
		unlock.setEndDate(12d);
		unlock.setVersion("version");
		unlock.setUsername("username");
		unlock.setUnlockFlag(0);
		unlock.setStartDate(2d);
		unlock.setRoomid(1234);
		unlock.setPassword("password");
		unlock.setMac("12");
		unlock.setLockName("lockName");
		unlock.setLockmac("lockmac");
		unlock.setKid(123456);
		unlock.setIsShared(0);
		unlock.setIsAdmin(1);
		unlock.setHasbackup(1);
		System.out.println(new Gson().toJson(unlock));
		//new UnlockDaoImpl().create(unlock);
	}

}
