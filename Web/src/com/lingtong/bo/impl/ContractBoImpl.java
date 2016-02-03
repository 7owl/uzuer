package com.lingtong.bo.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.lingtong.bo.ContractBo;
import com.lingtong.dao.ContractDao;
import com.lingtong.model.Contract;
import com.lingtong.model.Pagination;

/**
 * @author xqq
 * @date 2015-9-20 下午3:04:18
 * 
 */
@Component("contractBoImpl")
public class ContractBoImpl implements ContractBo {
	@Resource(name="contractDaoImpl")
	private ContractDao contractDao;
	
	public boolean updateContractStatus(String signId) {
		return contractDao.updateContractStatus(signId);
	}

	public List<Map<String, Object>> query(Pagination page,
			Map<String, Object> results) {
		return contractDao.query( page, results );
	}

	public Contract queryById(Integer id) {
		return contractDao.queryById( id );
	}

}
