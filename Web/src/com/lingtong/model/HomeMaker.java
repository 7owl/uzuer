package com.lingtong.model;

import java.io.Serializable;

/**
 * homemaker(管家)
 */
public class HomeMaker {
	public static String TABLENAME = "homemaker" ;
	public Integer id; // 管家ID
	public Integer role_id;// 管家角色ID
	public String hm_name;// 管家姓名
	public String hm_number;// 管家联系方式

	public Integer getId() {
		return id;
	}

	public void setId(Integer value) {
		this.id = value;
	}

	/**
	 * 获取 角色编号
	 * 
	 * @return
	 */
	public Integer getRole_id() {
		return role_id;
	}

	public void setRole_id(Integer value) {
		this.role_id = value;
	}

	public String getHm_name() {
		return hm_name;
	}

	public void setHm_name(String value) {
		this.hm_name = value;
	}

	public String getHm_number() {
		return hm_number;
	}

	public void setHm_number(String value) {
		this.hm_number = value;
	}
}