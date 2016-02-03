package com.lingtong.dao;

import java.util.List;
import java.util.Map;

import com.lingtong.model.BankInfo;
import com.lingtong.model.Pagination;

public interface BankInfoDao {

	Map<String, Object> save(BankInfo bankInfo);
	boolean isExist(BankInfo bankInfo);
	List<BankInfo> query(Pagination page, Map<String, Object> results);
	Map<String, Object> delete(String delIds);

}
