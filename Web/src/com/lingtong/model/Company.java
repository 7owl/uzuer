package com.lingtong.model;

import java.io.Serializable;


public class Company  {
	public static final String TABLENAME = "company"; 
	private Integer id;// 公司ID
	private Integer role_id;// 角色ID
	private String company_name;// 公司名
	private String company_address;// 公司地址
	private String company_ceo;// 公司负责人
	private String company_number;// 公司客服电话
	private String company_desc;// 公司介绍
	
	//新增字段
	private Integer room_number;//公司挂钩的房屋数量

	public Company() {
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer value) {
		this.id = value;
	}

	public Integer getRole_id() {
		return role_id;
	}

	public void setRole_id(Integer value) {
		this.role_id = value;
	}

	public String getCompany_name() {
		return company_name;
	}

	public void setCompany_name(String value) {
		this.company_name = value;
	}

	public String getCompany_address() {
		return company_address;
	}

	public void setCompany_address(String value) {
		this.company_address = value;
	}

	public String getCompany_ceo() {
		return company_ceo;
	}

	public void setCompany_ceo(String value) {
		this.company_ceo = value;
	}

	public String getCompany_number() {
		return company_number;
	}

	public void setCompany_number(String value) {
		this.company_number = value;
	}

	public String getCompany_desc() {
		return company_desc;
	}

	public void setCompany_desc(String value) {
		this.company_desc = value;
	}

	public Integer getRoom_number() {
		return room_number;
	}

	public void setRoom_number(Integer room_number) {
		this.room_number = room_number;
	}

	public boolean equals(Object obj) {
		if (obj == null)
			return false;
		else if (obj instanceof Company) {
			Company company = (Company) obj;
			if (company.id == this.id)
				return true;
		}
		return false;
	}

}
