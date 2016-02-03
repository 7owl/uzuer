package com.lingtong.model;

import org.apache.commons.lang.StringUtils;

public class Contract {
	public static final String TABLENAME = "contract";

	private Integer id;// 合同ID
	private String contractno;//合同编号
	private Integer host_id;//关联房东ID
	private Integer tenant_id;//关联租客ID
	private Integer contract_type_id;//关联合同类型ID
	private Integer company_id;//关联公司ID
	private Integer room_id;//关联房源ID
	private String house_commander;//关联方司令
	private String sign_time;//合同签订时间。 生效时间
	private String end_time;//合同到期日
	private String signid;//上上签的合同编号
	private String docid;//合同上传之后的id
	private Integer status;//合同状态
	private String ssq_email;//合同上传之后,ssq系统生成的新的邮箱
	
	private String completedState;
	// 新增的 数据库合同状态，
	//0：合同在预览阶段，无法律效力;
	//1：合同履行中，订单状态存在未付款部分或者合同时间未结束 ；
	//2：合同履行结束 对应订单全部结束，并且合同到达结束日期 ；
	

	public String getContractno() {
		if (StringUtils.isBlank(contractno)) {
			this.contractno = new StringBuilder().append("contract")
					.append(StringUtils.leftPad(room_id + "", 4, "0"))
					.toString();
		}
		return contractno;
	}

	public String getCompletedState() {
		return completedState;
	}

	public void setCompletedState(String completedState) {
		this.completedState = completedState;
	}

	public void setContractno(String contractno) {
		this.contractno = contractno;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer value) {
		this.id = value;
	}

	public Integer getHost_id() {
		return host_id;
	}

	public void setHost_id(Integer value) {
		this.host_id = value;
	}

	public Integer getTenant_id() {
		return tenant_id;
	}

	public void setTenant_id(Integer value) {
		this.tenant_id = value;
	}

	public Integer getContract_type_id() {
		return contract_type_id;
	}

	public void setContract_type_id(Integer value) {
		this.contract_type_id = value;
	}


	public Integer getCompany_id() {
		return company_id;
	}

	public void setCompany_id(Integer value) {
		this.company_id = value;
	}

	public Integer getRoom_id() {
		return room_id;
	}

	public void setRoom_id(Integer value) {
		this.room_id = value;
	}

	public String getHouse_commander() {
		return house_commander;
	}

	public void setHouse_commander(String value) {
		this.house_commander = value;
	}

	public String getSign_time() {
		return sign_time;
	}

	public void setSign_time(String value) {
		this.sign_time = value;
	}

	public String getEnd_time() {
		return end_time;
	}

	public void setEnd_time(String value) {
		this.end_time = value;
	}

	public String getSignid() {
		return signid;
	}

	public void setSignid(String signid) {
		this.signid = signid;
	}

	public String getDocid() {
		return docid;
	}

	public void setDocid(String docid) {
		this.docid = docid;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getSsq_email() {
		return ssq_email;
	}

	public void setSsq_email(String ssq_email) {
		this.ssq_email = ssq_email;
	}

	public boolean equals(Object obj) {
		if (obj == null)
			return false;
		else if (obj instanceof Contract) {
			Contract contract = (Contract) obj;
			if (contract.id == this.id)
				return true;
		}
		return false;
	}

}
