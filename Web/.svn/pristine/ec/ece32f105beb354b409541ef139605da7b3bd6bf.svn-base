package com.lingtong.dao.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.lingtong.dao.OrderDao;
import com.lingtong.dao.RoomDao;
import com.lingtong.model.Contract;
import com.lingtong.model.Order;
import com.lingtong.model.Pagination;
import com.lingtong.model.Room;
import com.lingtong.util.LTBeanUtils;
import com.lingtong.util.SpringManage;
import com.lingtong.vo.RoomVo;
import com.sun.org.apache.bcel.internal.generic.NEW;

@Component("orderDaoImpl")
public class OrderDaoImpl implements OrderDao {

	@Resource(name = "jdbcTemplate")
	private JdbcTemplate jdbcTemplate;

	@Resource(name = "roomDaoImpl")
	private RoomDao roomDao = new RoomDaoImpl();

	public List<Order> query(Pagination page, Map<String, Object> results) {
		return null;
	}

	public boolean createOrderByContract(Contract contract, RoomVo roomVo) {

		if (jdbcTemplate == null) {
			jdbcTemplate = (JdbcTemplate) SpringManage.getInstance().getObject(
					"jdbcTemplate");
		}
		String starttime = contract.getSign_time();
		String endtime = contract.getEnd_time();
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar calendar1 = Calendar.getInstance();
		Calendar calendar2 = Calendar.getInstance();
		String roomid = contract.getRoom_id().toString();
		// 房源的数据
		// 获取房源的 数据 ，月租金之类的
		Integer price = 0;
		price = roomVo.getPrice();

		try {
			Date start = fmt.parse(starttime);
			Date end = fmt.parse(endtime);
			calendar1.setTime(start);
			calendar2.setTime(end);
			Order order;

			switch (contract.getContract_type_id()) {
			case 1:
				// 押一付三
				for (int i = 0; i <= 4; i++) {
					order = new Order();
					order.setContract_id(contract.getId());
					order.setCreatetime(fmt.format(new Date()));
					order.setPaystate(0);
					// 生成五张订单 1是押金
					// 首次支付的订单
					if (i == 0) {
						// 押一付三 包含 押金
						order.setOrder_rental_starttime(fmt.format(calendar1
								.getTime()));
						calendar1.add(Calendar.YEAR, 1);
						order.setOrder_rental_endtime(fmt.format(calendar1
								.getTime()));
						calendar1.add(Calendar.YEAR, -1);
						order.setAmount(price + "");
					} else {
						order.setOrder_rental_starttime(fmt.format(calendar1
								.getTime()));
						calendar1.add(Calendar.MONTH, 3);
						order.setOrder_rental_endtime(fmt.format(calendar1
								.getTime()));
						order.setAmount((price * 3) + "");
					}
					createNewOrder(order);
				}
				break;
			case 2:
				// 分期
				order = new Order();
				order.setContract_id(contract.getId());
				order.setCreatetime(fmt.format(new Date() ));
				order.setPaystate(0);
				// 开始时间结束时间相同标示的是 支付了押金 （一个月房租）
				order.setOrder_rental_starttime(fmt.format(calendar1.getTime()));
				order.setOrder_rental_endtime(fmt.format(calendar1.getTime()));
				order.setAmount(price + "");
				createNewOrder(order);
				break;

			default:
				break;
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return true;
	}

	private boolean createNewOrder(Order order) {
		if (jdbcTemplate == null) {
			jdbcTemplate = (JdbcTemplate) SpringManage.getInstance().getObject(
					"jdbcTemplate");
		}

		String sql = "INSERT INTO  "
				+ Order.TABLENAME
				+ "  (createtime, contract_id,amount ,paystate ,order_rental_starttime ,order_rental_endtime ) VALUES (?,?,?,?,?,?)";
		int affected = jdbcTemplate.update(
				sql,
				new Object[] { order.getCreatetime(), order.getContract_id(),
						order.getAmount(), order.getPaystate(),
						order.getOrder_rental_starttime(),
						order.getOrder_rental_endtime() });
		if (affected > 0) {
			String query = "select last_insert_id() as id from "
					+ Order.TABLENAME + " limit 1";
			System.out.println("last_insert_id: " + query);
			int id = jdbcTemplate.queryForInt(query);
			String orderno = order.getOrderno()
					+ StringUtils.leftPad(id + "", 5, "0");
			String updatesql = "update " + Order.TABLENAME
					+ " set orderno= ? where id= ?";
			int affected1 = jdbcTemplate.update(updatesql, new Object[] {
					orderno, id });
			if (affected1 > 0) {
				System.out
						.println("order save success, order nunber update success...");
			}
			return true;
		} else {
			return false;
		}
	}

	public List<Order> getLastedOrders(Contract contract) {
		if (jdbcTemplate == null) {
			jdbcTemplate = (JdbcTemplate) SpringManage.getInstance().getObject(
					"jdbcTemplate");
		}
		String sql = "select * from " + Order.TABLENAME
				+ " where contract_id=? order by id asc ";
		List list = jdbcTemplate.queryForList(sql,
				new Object[] { contract.getId() });
		List<Order> orders = new ArrayList<Order>();
		for (int i = 0; list != null && i < list.size(); i++) {
			Order order = new Order();
			Map<String, Object> map = (Map<String, Object>) list.get(i);
			LTBeanUtils.getInstance().Map2Bean(map, order);
			orders.add(order);
		}
		return orders;
	}

	public Map<String, Object> updateState(String roomid, String orderid) {

		if (jdbcTemplate == null) {
			jdbcTemplate = (JdbcTemplate) SpringManage.getInstance().getObject(
					"jdbcTemplate");
		}
		Map<String, Object> result = new HashMap<String, Object>();
		String updateRoomstate = "update " + Room.TABLENAME
				+ " set status=1 where id= ?";
		int affected1 = jdbcTemplate.update(updateRoomstate,
				new Object[] { roomid });

		String updateOrderstate = "update " + Order.TABLENAME
				+ " set paystate=1 where id= ?";
		int affected2 = jdbcTemplate.update(updateRoomstate,
				new Object[] { roomid });

		if (affected1 > 0 && affected2 > 0) {
			result.put("code", 0);
			result.put("msg", "本地数据状态更新成功");
		} else {
			result.put("code", "12007");
			result.put("msg", "本地数据状态更新失败");
		}

		return null;
	}
	
	public int deleteOrderByContractId(int cid) {
		if (jdbcTemplate == null) {
			jdbcTemplate = (JdbcTemplate) SpringManage.getInstance().getObject(
					"jdbcTemplate");
		}
		String sql = "delete from " + Order.TABLENAME +" where contract_id = ?";
		return jdbcTemplate.update(sql, new Object[]{cid});
	}

	public Map<String, Object> getOrdersByContractNo(String contractid) {
		Map<String, Object> result = new HashMap<String, Object>();
		if (jdbcTemplate == null) {
			jdbcTemplate = (JdbcTemplate) SpringManage.getInstance().getObject(
					"jdbcTemplate");
		}
		String sql = "select * from "+ Order.TABLENAME +" where contract_id=?";
		
		List list = jdbcTemplate.queryForList(sql,new Object[]{contractid});
		List<Order> orders = new ArrayList<Order>(); 
		for (int i = 0; list != null && i < list.size(); i++) {
			Map<String, Object> map = (Map<String, Object>) list.get(i);
			Order order = new Order() ;
			LTBeanUtils.getInstance().Map2Bean(map, order);
			orders.add(order);
		}
		result.put("data", orders);
		result.put("code", 0);
		result.put("msg", "订单获取成功");
		return result; 
	 
	}

	public boolean updatePayState(String out_trade_no) {
		if (jdbcTemplate == null) {
			jdbcTemplate = (JdbcTemplate) SpringManage.getInstance().getObject(
					"jdbcTemplate");
		}
		String sql1 = "update " + Order.TABLENAME +" set paystate=1,paytime=? where orderno = ?";
		SimpleDateFormat format =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String paytime = format.format(new Date()) ;
		int affected = jdbcTemplate.update(sql1, new Object[]{paytime,out_trade_no});
		if(affected<=0)
		{
			return false;
		}
		return true;
	}

	public String getFristOrderNo(Integer id) {
		if (jdbcTemplate == null) {
			jdbcTemplate = (JdbcTemplate) SpringManage.getInstance().getObject(
					"jdbcTemplate");
		}
		String sql ="select orderno from " + Order.TABLENAME + " where contract_id=? order by id asc limit 1";
		String firstOrder = jdbcTemplate.queryForObject(sql, new Object[]{id} ,String.class);
		return firstOrder;
	}
	
	
	public Order getFristOrder(Integer id) {
		if (jdbcTemplate == null) {
			jdbcTemplate = (JdbcTemplate) SpringManage.getInstance().getObject(
					"jdbcTemplate");
		}
		//没有支付的 第一张订单 + 
		String sql ="select * from " + Order.TABLENAME + " where contract_id=? order by id asc limit 1";
		 List<Map<String, Object>>  firstList = jdbcTemplate.queryForList(sql, new Object[]{id});
		Order order = new Order() ;
		if (firstList!= null && firstList.size() > 0) {
			Map<String, Object> map = (Map<String, Object>) firstList.get(0);
			LTBeanUtils.getInstance().Map2Bean(map, order);
		}
		return order;
	}

	public static void main(String[] args) {
		System.out.println( new OrderDaoImpl().getFristOrderNo(139));
	}
}
