package com.lingtong.bo.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.lingtong.bo.CompanyBo;
import com.lingtong.dao.CompanyDao;
import com.lingtong.model.Company;
import com.lingtong.model.Pagination;
import com.lingtong.vo.CompanyVo;
/**
 * 
 * @author MTT
 * @date 2015-8-7
 */
@Component("companyBoImpl")
public class CompanyBoImpl implements CompanyBo {

	@Resource(name="companyDaoImpl")
	private CompanyDao compdao;
	
	/* (non-Javadoc)
	 * @see com.lingtong.bo.impl.CompanyBo#save(com.lingtong.model.Company)
	 */
	public Map<String, Object> save(Company company) {
		return compdao.save(company);
	}

	/* (non-Javadoc)
	 * @see com.lingtong.bo.impl.CompanyBo#isExist(com.lingtong.model.Company)
	 */
	public boolean isExist(Company company) {
		return compdao.isExist(company);
	}

	/* (non-Javadoc)
	 * @see com.lingtong.bo.impl.CompanyBo#query(com.lingtong.model.Pagination, java.util.Map)
	 */
	public List<CompanyVo> query(Pagination page, Map<String, Object> results) {
		return compdao.query(page, results);
	}

	/* (non-Javadoc)
	 * @see com.lingtong.bo.impl.CompanyBo#delete(java.lang.String)
	 */
	public Map<String, Object> delete(String delIds) {
		return compdao.delete(delIds);
	}

	
}
