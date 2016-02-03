package com.lingtong.interfaces;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.commons.lang.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;

import com.google.gson.Gson;
import com.lingtong.dao.TenantsDao;
import com.lingtong.dao.UnlockDao;
import com.lingtong.dao.impl.TenantsDaoImpl;
import com.lingtong.dao.impl.UnlockDaoImpl;
import com.lingtong.interfaces.interceptor.Auth;
import com.lingtong.interfaces.interceptor.ReturnJSON;
import com.lingtong.interfaces.message.CommonErrorEnum;
import com.lingtong.interfaces.message.FaultTolerant;
import com.lingtong.model.KeyList;
import com.lingtong.model.Tenants;
import com.lingtong.model.Unlock;
import com.lingtong.util.SpringManage;
import com.lingtong.vo.RoomVo;
import com.lingtong.vo.TenantAndUnlock;
import com.ssqian.common.util.MD5Utils;
import com.uzuser.thirdparty.sciener.Authorize;

/**
 * @author xqq
 * @date 2015-9-22 下午10:15:55
 * 
 */
public class UnlockServiceImpl implements UnlockService {
	private UnlockDao unlockDao = new UnlockDaoImpl();
	private TenantsDao tenantDao = new TenantsDaoImpl();
	private JdbcTemplate jdbcTemplate = (JdbcTemplate) SpringManage.getInstance().getObject("jdbcTemplate");
	/*public Response create(String unlock) {
		Unlock lock = new Gson().fromJson(unlock, Unlock.class);
		Map<String, Object> map = unlockDao.create(lock);
		System.out.println("map:"+new Gson().toJson(map));
		return ReturnJSON.getInstance().ret( unlockDao.create(lock) );
		return Response.ok()
				   .entity("hello")
				   .header(HttpHeaders.CONTENT_TYPE,
	                 MediaType.TEXT_HTML + ";charset=UTF-8").build();
	}*/
	public Response sendKey(String roomSeq) {
		Map<String, Object> result = new HashMap<String, Object>();
		//unlockDao.sendKey(roomSeq, null);
		return ReturnJSON.getInstance().ret(result);
	}

	public Response create(Integer kid, String adminKeyboardPs,
			String adminKeyboardPsTmp, String aseKey, Double date,
			Integer day10mPsIndex, Integer day1PsIndex, Integer day2PsIndex,
			Integer day3PsIndex, Integer day4PsIndex, Integer day5PsIndex,
			Integer day6PsIndex, Integer day7PsIndex, String deletePs,
			String deletePsTmp, String desc1, String doorName, Double endDate,
			String version, String username, Integer unlockFlag,
			Double startDate, Integer roomid, String password, String mac,
			String lockName, String lockmac, Integer isShared, Integer isAdmin,
			Integer hasbackup, String uz_room_seq, String key) {
		Unlock lock = new Unlock();
		System.out.println("aseKey:"+aseKey);
		System.out.println("deletePs:"+deletePs);
		lock.setKid(kid);
		lock.setAdminKeyboardPs(adminKeyboardPs);
		lock.setAdminKeyboardPsTmp(adminKeyboardPsTmp);
		lock.setAseKey(aseKey);
		lock.setDate(date);
		lock.setDay10mPsIndex(day10mPsIndex);
		lock.setDay1PsIndex(day1PsIndex);
		lock.setDay2PsIndex(day2PsIndex);
		lock.setDay3PsIndex(day3PsIndex);
		lock.setDay4PsIndex(day4PsIndex);
		lock.setDay5PsIndex(day5PsIndex);
		lock.setDay6PsIndex(day6PsIndex);
		lock.setDay7PsIndex(day7PsIndex);
		lock.setDeletePs(deletePs);
		lock.setDeletePsTmp(deletePsTmp);
		lock.setDesc1(desc1);
		lock.setDoorName(doorName);
		lock.setEndDate(endDate);
		lock.setVersion(version);
		lock.setHasbackup(hasbackup);
		lock.setIsAdmin(isAdmin);
		lock.setIsShared(isShared);
		lock.setKey(key);
		lock.setLockmac(lockmac);
		lock.setLockName(lockName);
		lock.setMac(mac);
		lock.setPassword(password);
		lock.setRoomid(roomid);
		lock.setStartDate(startDate);
		lock.setUnlockFlag(unlockFlag);
		lock.setUsername(username);
		lock.setUz_room_seq(uz_room_seq);
		System.out.println("aseKey:"+lock.getAseKey());
		System.out.println("deletePs:"+lock.getDeletePs());
		Map<String, Object> map = unlockDao.create(lock);
		System.out.println("map:"+new Gson().toJson(map));
		return ReturnJSON.getInstance().ret( map );
	}

	public Response getLockAndKey(String tenantid) {
		Tenants tenant = tenantDao.findTenantById(tenantid);
		Map<String, Object> result = new HashMap<String, Object>();
		if( tenant != null){
			String password = tenant.getSciener_password();
			if( StringUtils.isBlank( password ) ){
				password = tenant.getTel_number().substring( tenant.getTel_number().length() - 6 );
			}
			Map map = Authorize.getInstance().authorizeDirect(tenant.getSciener_username(), password);
			if( map == null ){
				result.put("code", CommonErrorEnum.UNLOCK_AUTH_FAIL.getCode() + "");
				result.put("msg", CommonErrorEnum.UNLOCK_AUTH_FAIL.getMessage());
			} else {
				Map<String, Object> data = new HashMap<String, Object>();
				//List<Map<String, Object>> list = jdbcTemplate.queryForList("select `date`, end_date, key_status, start_date, openid, room_id, key_id from " + TenantAndUnlock.TABLENAME + " tu, " + KeyList.TABLENAME + " keylist," + Unlock.TABLENAME + " sciencelock where keylist.room_id = tu.roomid and sciencelock.roomid = tu.roomid");
				//List<Map<String, Object>> list = jdbcTemplate.queryForList("select * from " + TenantAndUnlock.TABLENAME + " tu, " + KeyList.TABLENAME + " keylist," + Unlock.TABLENAME + " sciencelock where keylist.room_id = tu.lockid and sciencelock.roomid = tu.lockid");
				List<Map<String, Object>> list = jdbcTemplate.queryForList("select * from " +  KeyList.TABLENAME + " keylist, " + Unlock.TABLENAME
						+ " locklist, " + TenantAndUnlock.TABLENAME + " tu where keylist.room_id = locklist.roomid  and tu.lockid = locklist.roomid and keylist.openid = tu.openid and tu.openid = ?", new Object[]{tenant.getSciener_openid()});
				System.out.println( "select * from " +  KeyList.TABLENAME + " keylist, " + Unlock.TABLENAME
						+ " locklist, " + TenantAndUnlock.TABLENAME + " tu, " + " where keylist.room_id = locklist.roomid  and tu.lockid = locklist.roomid and keylist.openid = tu.openid and tu.openid = ?" );
				if( list == null ){
					list = new ArrayList<Map<String,Object>>();
				}
				result.put("data", new Gson().toJson(list));
				result.put("code", "0");
				result.put("msg", "获取成功...");
			}
		} else {
			result.put("code", CommonErrorEnum.TENANT_IS_NOT_EXIST.getCode() + "");
			result.put("msg", CommonErrorEnum.TENANT_IS_NOT_EXIST.getMessage());
		}
		
		return ReturnJSON.getInstance().ret(result);
	}
}
