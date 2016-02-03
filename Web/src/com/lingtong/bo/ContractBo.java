package com.lingtong.bo;

import java.util.List;
import java.util.Map;

import com.lingtong.model.Contract;
import com.lingtong.model.Pagination;

/**
 * @author xqq
 * @date 2015-9-20 下午3:03:44
 * 
 */
public interface ContractBo {
	/**
	 * 更新合同状态
	 * @param signId
	 * @return
	 */
	public boolean updateContractStatus(String signId);
	
	public List<Map<String, Object>> query( Pagination page, Map<String, Object> results );

	/**
	 * @param id
	 * @return
	 */
	public Contract queryById(Integer id);
}
