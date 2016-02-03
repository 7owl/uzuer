package com.lingtong.dao;

import java.util.List;
import java.util.Map;

import javax.ws.rs.core.Response;

import com.lingtong.model.Contract;
import com.lingtong.model.Order;
import com.lingtong.model.Pagination;
import com.lingtong.vo.RoomVo;

public interface OrderDao {
	/***
	 * 分页查询
	 * @param page
	 * @param results
	 * @return
	 */
	public List<Order> query( Pagination page, Map<String, Object> results );

	public boolean createOrderByContract(Contract contract,RoomVo roomVo);

	public List<Order> getLastedOrders(Contract contract);

	public Map<String, Object> updateState(String roomid, String orderid);

	public int deleteOrderByContractId(int cid);

	public Map<String, Object> getOrdersByContractNo(String contractid);

	public boolean updatePayState(String out_trade_no);

	public String getFristOrderNo(Integer id);
	public	Order getFristOrder(Integer id);
}
