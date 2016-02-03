package com.lingtong.model;

import org.apache.commons.lang.StringUtils;

/**
 * 
 * @author Administrator 租房订单类
 * 
 */
public class Order {

	public static final String TABLENAME = "payorder";

	private Integer id;
	private String orderno;
	private String createtime;
	private Integer contract_id;
	private String amount;// 订单金额
	private Integer paystate; // 支付状态 0：未支付。1：表示已支付。 -1 表示订单失效 
	private String paytime; // 付款成功时间
	// 租房的时间段
	private String order_rental_starttime; // 关联合同的租房时间段 开始时间
	private String order_rental_endtime;// 关联合同的租房时间段 结束时间

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getOrderno() {
		if (StringUtils.isBlank(orderno)) {
			this.orderno = new StringBuilder()
					.append("order")
					.append(StringUtils.leftPad(contract_id + "", 4, "0"))
					.toString();
		}
		return orderno;
	}

	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}

	public String getCreatetime() {
		return createtime;
	}

	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}

	public Integer getContract_id() {
		return contract_id;
	}

	public void setContract_id(Integer contract_id) {
		this.contract_id = contract_id;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public Integer getPaystate() {
		return paystate;
	}

	public void setPaystate(Integer paystate) {
		this.paystate = paystate;
	}

	public String getPaytime() {
		return paytime;
	}

	public void setPaytime(String paytime) {
		this.paytime = paytime;
	}

	public String getOrder_rental_starttime() {
		return order_rental_starttime;
	}

	public void setOrder_rental_starttime(String order_rental_starttime) {
		this.order_rental_starttime = order_rental_starttime;
	}

	public String getOrder_rental_endtime() {
		return order_rental_endtime;
	}

	public void setOrder_rental_endtime(String order_rental_endtime) {
		this.order_rental_endtime = order_rental_endtime;
	}

}
