package com.lingtong.bo.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lingtong.bo.TenantsBo;
import com.lingtong.dao.TenantsDao;
import com.lingtong.model.Pagination;
import com.lingtong.model.Tenants;
import com.lingtong.vo.TenantVo;

/**
 * @author xqq
 * @date 2015-8-2 上午11:50:35
 * 
 */
@Component("tenantsBoImpl")
public class TenantsBoImpl implements TenantsBo {
	@Resource(name="tenantsDaoImpl")
	private TenantsDao tenantsDao;

	public Map<String, Object> save( Tenants tenant ) {
		return tenantsDao.save(tenant);
	}

	public boolean isExist(Tenants tenant) {
		return tenantsDao.isExist(tenant);
	}
	
	public List<Tenants> query( Pagination page, Map<String, Object> results ) {
		return tenantsDao.query( page, results );
	}
	
	public Map<String, Object> delete(String delIds) {
		return tenantsDao.delete(delIds);
	}

	public Tenants findTenantById(String id) {
		return tenantsDao.findTenantById(id);
	}

	public Map<String, Object> updateAuthState(String tenantid) {
		return tenantsDao.updateAuthState(tenantid);
	}

}
