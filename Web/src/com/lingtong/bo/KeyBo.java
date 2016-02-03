package com.lingtong.bo;

import java.util.List;
import java.util.Map;
import org.springframework.web.multipart.MultipartFile;

import com.lingtong.model.Hosts;
import com.lingtong.model.Image;
import com.lingtong.model.KeyList;
import com.lingtong.model.Pagination;
import com.lingtong.model.Tenants;
/**
 * @author xqq
 * @date 2015-8-2 上午11:49:07
 * 
 */
public interface KeyBo {
	public boolean save(List<KeyList> keys);

	/**
	 * @param page
	 * @param results
	 */
	public void query(Pagination page, Map<String, Object> results);

	/**
	 * @param delIds
	 * @param openid 
	 * @param key_id 
	 * @return
	 */
	public Map<String, Object> delete(String room_id, String key_id, String openid);
	
	/**
	 * @param roomSeq
	 * @param tenant
	 * @return
	 */
	public Map<String, Object> sendKey(String roomSeq, Tenants tenant, String start_date, String end_date, String locks);

	/**
	 * @param isFreeze
	 * @param room_id
	 * @param key_id
	 * @param openid 
	 * @return
	 */
	public Map<String, Object> freezeKey(String isFreeze, String room_id,
			String key_id, String openid);
}
