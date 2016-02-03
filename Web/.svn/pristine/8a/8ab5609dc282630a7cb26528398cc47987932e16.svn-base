package com.lingtong.bo.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.lingtong.bo.RoleBo;
import com.lingtong.dao.RoleDao;
import com.lingtong.model.Pagination;
import com.lingtong.model.Role;
/**
 * 
 * @author MTT
 * @date 2015-8-5
 */
@Component("roleBoImpl")
public class RoleBoImpl implements RoleBo{

	@Resource(name="roleDaoImpl")
	private RoleDao roleDao ;
	
	public Map<String, Object> save(Role role) {
		// TODO Auto-generated method stub
		return roleDao.save(role);
	}

	public boolean isExist(Role role) {
		// TODO Auto-generated method stub
		return roleDao.isExist(role);
	}

	public List<Role> query(Pagination page, Map<String, Object> results) {
		// TODO Auto-generated method stub
		return roleDao.query(page, results);
	}

	public Map<String, Object> delete(String delIds) {
		// TODO Auto-generated method stub
		return roleDao.delete(delIds);
	}

}
