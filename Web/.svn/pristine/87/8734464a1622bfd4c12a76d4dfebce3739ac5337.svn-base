package com.lingtong.dao;

import java.util.List;
import java.util.Map;

import com.lingtong.model.Company;
import com.lingtong.model.Pagination;
import com.lingtong.vo.CompanyVo;
/**
 * 
 * @author MTT
 * @date 2015-8-7
 */
public interface CompanyDao {
	public Map<String, Object> save (Company company);

	public boolean isExist(Company company);

	public List<CompanyVo> query ( Pagination page, Map<String, Object> results );
 
	public Map<String, Object> delete(String delIds);
}
