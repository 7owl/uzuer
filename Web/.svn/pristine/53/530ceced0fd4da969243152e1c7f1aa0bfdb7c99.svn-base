package com.lingtong.bo;

import java.util.List;
import java.util.Map;

import com.lingtong.model.Company;
import com.lingtong.model.Pagination;
import com.lingtong.vo.CompanyVo;

public interface CompanyBo {

	public abstract Map<String, Object> save(Company company);

	public abstract boolean isExist(Company company);

	public abstract List<CompanyVo> query(Pagination page,
			Map<String, Object> results);

	public abstract Map<String, Object> delete(String delIds);

}