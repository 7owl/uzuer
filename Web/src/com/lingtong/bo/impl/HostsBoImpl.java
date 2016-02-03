package com.lingtong.bo.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.lingtong.bo.HostsBo;
import com.lingtong.dao.HostsDao;
import com.lingtong.model.Pagination;
import com.lingtong.model.Hosts;

/**
 * @author xqq
 * @date 2015-8-2 上午11:50:35
 * 
 */
@Component("hostsBoImpl")
public class HostsBoImpl implements HostsBo {
	@Resource(name="hostsDaoImpl")
	private HostsDao hostsDao;

	public Map<String, Object> save( Hosts host ) {
		return hostsDao.save(host);
	}

	public boolean isExist(Hosts host) {
		return hostsDao.isExist(host);
	}
	
	public List<Hosts> query( Pagination page, Map<String, Object> results ) {
		return hostsDao.query( page, results );
	}
	
	public Map<String, Object> delete(String delIds) {
		return hostsDao.delete(delIds);
	}

}
