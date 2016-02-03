package com.lingtong.dao;

import java.util.List;
import java.util.Map;

import com.lingtong.model.Contract;
import com.lingtong.model.Pagination;
import com.lingtong.vo.ContractVo;
import com.lingtong.vo.RoomVo;

public interface ContractDao {
	public Map<String, Object> save (Contract contract,RoomVo roomVo);

	/**
	 * 根据合同编号,获取合同
	 * @param contractNo
	 * @return
	 */
	public ContractVo getContractByNo(String contractno);

	/**
	 * @param contracno
	 * @param docid
	 * @param signid
	 * @param ssq_email
	 * @return
	 */
	public boolean editContract(String contractno, String docid, String signid, String ssq_email);
	
	/**
	 * 更新合同状态
	 * @param signId
	 * @return
	 */
	public boolean updateContractStatus(String signId);

	public Map<String, Object> getContractByTenantId(String tenantid);

	public boolean updateContractAfterPay(String out_trade_no);

	/**
	 * @param page
	 * @param results
	 * @return
	 */
	public List<Map<String, Object>> query(Pagination page,
			Map<String, Object> results);

	/**
	 * @param id
	 * @return
	 */
	public Contract queryById(Integer id);
}
