package com.lingtong.bo.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.lingtong.bo.KeyBo;
import com.lingtong.dao.KeyDao;
import com.lingtong.model.KeyList;
import com.lingtong.model.Pagination;
import com.lingtong.model.Tenants;

/**
 * @author xqq
 * @date 2015-9-27 上午11:29:20
 * 
 */
@Component("keyBoImpl")
public class KeyBoImpl implements KeyBo {
	@Resource(name="keyDaoImpl")
	private KeyDao keyDaoImpl;
	
	public boolean save(List<KeyList> keys) {
		return keyDaoImpl.save(keys);
	}

	public void query(Pagination page, Map<String, Object> results) {
		keyDaoImpl.query(page, results);
	}

	public Map<String, Object> delete(String room_id, String key_id, String openid) {
		return keyDaoImpl.delete(room_id, key_id, openid);
	}
	
	public Map<String, Object> sendKey(String roomSeq, Tenants tenant, String start_date, String end_date, String locks) {
		return keyDaoImpl.sendKey(roomSeq, tenant, start_date, end_date, locks);
	}

	public Map<String, Object> freezeKey(String isFreeze, String room_id,
			String key_id, String openid) {
		return keyDaoImpl.freezeKey(isFreeze, room_id, key_id, openid);
	}
}
