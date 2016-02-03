package com.lingtong.bo;

import java.util.List;
import java.util.Map;

import com.lingtong.model.Pagination;
import com.lingtong.model.Tenants;
import com.lingtong.vo.TenantVo;

/**
 * @author xqq
 * @date 2015-8-2 上午11:49:07
 * 
 */
public interface TenantsBo {
	/**
	 * 房客增加或修改
	 * @return
	 */
	public Map<String, Object> save( Tenants tenant );
	
	/**
	 * 检查是否存在
	 * */
	public boolean isExist( Tenants tenant );
	
	/***
	 * 分页查询
	 * @param page
	 * @param results
	 * @return
	 */
	public List<Tenants> query( Pagination page, Map<String, Object> results );

	/**
	 * 删除
	 * @param delIds
	 * @return
	 */
	public Map<String, Object> delete(String delIds);

	public Tenants findTenantById(String id);

	public Map<String, Object> updateAuthState(String tenantid);
}
