package com.lingtong.bo;

import java.util.List;
import java.util.Map;

import com.lingtong.model.Pagination;
import com.lingtong.model.Role;

/**
 * 
 * @author MTT
 * @date 2015-8-5
 */
public interface RoleBo {
	/**
	 * 房源保存修改
	 * @param Role
	 * @return
	 */
	public Map<String, Object> save (Role role);
	/**
	 * 角色是否存在
	 * @param Role
	 * @return
	 */
	public boolean isExist(Role role);
	/**
	 * 分页查询
	 * @param page
	 * @param results
	 * @return
	 */
	public List<Role> query ( Pagination page, Map<String, Object> results );
 
	/**
	 * 删除 房源
	 * @param delIds
	 * @return
	 */
	public Map<String, Object> delete(String delIds);
	
	
}
