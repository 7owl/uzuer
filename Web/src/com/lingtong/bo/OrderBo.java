package com.lingtong.bo;

import java.util.Map;

/**
 * @author xqq
 * @date 2015-10-18 上午8:40:21
 * 
 */
public interface OrderBo {

	/**
	 * @param contractno
	 */
	public Map<String, Object> getOrdersByContractNo(String contractno);

}
