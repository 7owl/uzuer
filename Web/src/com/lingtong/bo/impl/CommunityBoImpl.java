package com.lingtong.bo.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.lingtong.bo.CommunityBo;
import com.lingtong.dao.CommunityDao;
import com.lingtong.model.Community;
import com.lingtong.model.Pagination;
import com.lingtong.vo.CommunityVo;
/**
 * 
 * @author MTT
 * @date 2015-8-5
 */
@Component("communityBoImpl")
public class CommunityBoImpl implements CommunityBo{

	@Resource(name="communityDaoImpl")
	private CommunityDao communityDao ;
	
	public Map<String, Object> save(Community community) {
		return communityDao.save(community);
	}

	public boolean isExist(Community community) {
		return communityDao.isExist(community);
	}

	public List<CommunityVo> query(Pagination page, Map<String, Object> results) {
		return communityDao.query(page, results);
	}

	public Map<String, Object> delete(String delIds) {
		return communityDao.delete(delIds);
	}

	public List<Community> getCommAddressById(int comm_id) {
		// TODO Auto-generated method stub
		return communityDao.getCommAddressById(comm_id);
	}

}
