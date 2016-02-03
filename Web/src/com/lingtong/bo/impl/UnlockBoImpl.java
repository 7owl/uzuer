package com.lingtong.bo.impl;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.lingtong.bo.UnlockBo;
import com.lingtong.dao.UnlockDao;
import com.lingtong.model.Pagination;
import com.lingtong.model.Tenants;

/**
 * @author xqq
 * @date 2015-9-26 下午4:57:32
 * 
 */
@Component("unlockBoImpl")
public class UnlockBoImpl implements UnlockBo {
	@Resource(name="unlockDaoImpl")
	private UnlockDao unlockDao;

	public Map<String, Object> delete(String delIds) {
		return unlockDao.delete(delIds);
	}

	public void query(Pagination page, Map<String, Object> results) {
		unlockDao.query(page, results);
	}
	
	

}
