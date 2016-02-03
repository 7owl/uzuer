package com.lingtong.dao;

import java.util.List;
import java.util.Map;

import com.lingtong.model.Pagination;
import com.lingtong.model.Role;
/**
 * 
 * @author MTT
 * @date 2015-8-5
 */
public interface RoleDao {

	public Map<String, Object> save (Role role);
	
	public boolean isExist (Role role);
	
	public List<Role> query (Pagination page , Map<String, Object> result);
	
	public Map<String , Object> delete(String delids);
	
}
