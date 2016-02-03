package com.lingtong.bo.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.lingtong.bo.BankInfoBo;
import com.lingtong.dao.BankInfoDao;
import com.lingtong.dao.HomeMakerDao;
import com.lingtong.model.BankInfo;
import com.lingtong.model.Pagination;
 

@Component("bankInfoBoImpl")
public class BankInfoBoImpl implements BankInfoBo {

	@Resource(name="bankInfoDaoImpl")
	private BankInfoDao bankInfoDao;
	
	
	public Map<String, Object> save(BankInfo bankInfo) {
		return bankInfoDao.save(bankInfo);
	}

	public boolean isExist(BankInfo bankInfo) {
		return bankInfoDao.isExist(bankInfo);
	}

	public List<BankInfo> query(Pagination page, Map<String, Object> results) {
		return  bankInfoDao.query(page, results);
	}

	public Map<String, Object> delete(String delIds) {
		 
		return bankInfoDao.delete(delIds);
	}

}
