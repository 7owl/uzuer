package com.lingtong.vo;

import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;
import java.util.Locale;

import org.apache.commons.lang.StringUtils;

/**
 * 合同
 * 
 * @author MTT
 * 
 */
public class ContractVo {
	public static final String TABLENAME = "contract";
	public static final String VIEWNAME = "contractView";
	public static final String DETAILVIEWNAME = "contractDetailView";
	//原始合同信息
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
	private String completedState;//合同状态 0 是未完成 ，1 是完成的合同 ，-1 是付款超市状态
	//房源信息
	private Integer price;//租金
	private String cityid;//省市区/县
	private Integer size;// 面积
	private String room_name;
	private String roomSeq;
	//房客信息
	private String first_name;//姓氏
	private String last_name;//名字
	private String tel_number;//手机号码
	private String id_card;//身份证
	private String email;// 邮箱
	private String kind;//厅室信息
	private String full_name;//在数据库里是没这个字段,只用来查询用的
	//小区信息
	private String comm_address;//小区地址
	private String comm_name;//小区名称
	//公司信息
	private String company_name;//公司名称
	
	public String getComm_name() {
		return comm_name;
	}

	public void setComm_name(String comm_name) {
		this.comm_name = comm_name;
	}

	public String getKind() {
		return kind;
	}

	public void setKind(String kind) {
		this.kind = kind;
	}

	public String getContractno() {
		return contractno;
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

	public String getSsq_email() {
		return ssq_email;
	}

	public void setSsq_email(String ssq_email) {
		this.ssq_email = ssq_email;
	}

	public Integer getPrice() {
		return price;
	}

	public void setPrice(Integer price) {
		this.price = price;
	}

	public String getCityid() {
		return cityid;
	}

	public void setCityid(String cityid) {
		this.cityid = cityid;
	}

	public Integer getSize() {
		return size;
	}

	public void setSize(Integer size) {
		this.size = size;
	}

	public String getFirst_name() {
		return first_name;
	}

	public void setFirst_name(String first_name) {
		this.first_name = first_name;
	}

	public String getLast_name() {
		return last_name;
	}

	public void setLast_name(String last_name) {
		this.last_name = last_name;
	}

	public String getTel_number() {
		return tel_number;
	}

	public void setTel_number(String tel_number) {
		this.tel_number = tel_number;
	}

	public String getId_card() {
		return id_card;
	}

	public void setId_card(String id_card) {
		this.id_card = id_card;
	}
	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
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

	public String getCompletedState() {
		return completedState;
	}

	public void setCompletedState(String completedState) {
		this.completedState = completedState;
	}
	
	public String getRoom_name() {
		return room_name;
	}

	public void setRoom_name(String room_name) {
		this.room_name = room_name;
	}

	public String getComm_address() {
		return comm_address;
	}

	public void setComm_address(String comm_address) {
		this.comm_address = comm_address;
	}

	public String getRoomSeq() {
		return roomSeq;
	}

	public void setRoomSeq(String roomSeq) {
		this.roomSeq = roomSeq;
	}

	public String getCompany_name() {
		return company_name;
	}

	public void setCompany_name(String company_name) {
		this.company_name = company_name;
	}

	public String getFull_name() {
		return full_name;
	}

	public void setFull_name(String full_name) {
		this.full_name = full_name;
	}

	public boolean equals(Object obj) {
		if (obj == null)
			return false;
		else if (obj instanceof ContractVo) {
			ContractVo contract = (ContractVo) obj;
			if (contract.id == this.id)
				return true;
		}
		return false;
	}

}
