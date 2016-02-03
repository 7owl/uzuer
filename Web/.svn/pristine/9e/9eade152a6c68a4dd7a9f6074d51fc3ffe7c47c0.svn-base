package com.lingtong.dao;

import java.util.List;
import java.util.Map;

import com.lingtong.model.HomeMaker;
import com.lingtong.model.Pagination;
import com.lingtong.model.Role;
/**
 * 
 * @author MTT
 * @date 2015-8-5
 */
public interface HomeMakerDao {

	public Map<String, Object> save (HomeMaker homeMaker);

	public boolean isExist(HomeMaker homeMaker);

	public List<HomeMaker> query ( Pagination page, Map<String, Object> results );
 
	public Map<String, Object> delete(String delIds);
	
	public HomeMaker getHomeMakerById( Integer id );
}
