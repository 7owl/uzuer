package com.lingtong.bo.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.lingtong.bo.HomeMakerBo;
import com.lingtong.dao.HomeMakerDao;
import com.lingtong.model.HomeMaker;
import com.lingtong.model.Pagination;

/**
 * @author xqq
 * @date 2015-8-5 下午9:18:22
 * 
 */
@Component("homeMakerBoImpl")
public class HomeMakerBoImpl implements HomeMakerBo {
	@Resource(name="homeMakerDaoImpl")
	private HomeMakerDao hmDao;
	
	public Map<String, Object> save(HomeMaker homeMaker) {
		return hmDao.save(homeMaker);
	}

	public boolean isExist(HomeMaker homeMaker) {
		return hmDao.isExist(homeMaker);
	}

	public List<HomeMaker> query(Pagination page, Map<String, Object> results) {
		return hmDao.query(page, results);
	}

	public Map<String, Object> delete(String delIds) {
		return hmDao.delete(delIds);
	}

	public HomeMaker getHomeMakerById(Integer id) {
		return hmDao.getHomeMakerById(id);
	}

}
