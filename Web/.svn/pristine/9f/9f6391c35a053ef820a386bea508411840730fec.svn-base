package com.lingtong.bo.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.lingtong.bo.OrderBo;
import com.lingtong.dao.OrderDao;
import com.lingtong.model.Order;

/**
 * @author xqq
 * @date 2015-10-18 上午8:41:07
 * 
 */
@Component("orderBoImpl")
public class OrderBoImpl implements OrderBo {
	@Resource(name="orderDaoImpl")
	private OrderDao orderDaoImpl;

	public Map<String, Object> getOrdersByContractNo(String contractno) {
		Map<String, Object> map = orderDaoImpl.getOrdersByContractNo( contractno );
		if( map != null && map.get("data") != null ){
			List<Order> orders = (List<Order>) map.get("data");
			if( orders != null ){
				map.put("rows", orders);
				map.put("total", orders.size());
			} else {
				map.put("rows", new Object[]{});
				map.put("total", 0);
			}
			map.remove("data");
		}
		return map;
	}
	
	
}
