package com.lingtong.model;


/**
 * 角色 角色
 */
public class Role {
	/**
	 * 
	 */
	public static final String TABLENAME = "role" ;
	
	private Integer id; // 编号
	private String role_name; // 角色名
	private String power; // 权限

	public Role() {
	}

	/**
	 * 获取编号
	 * 
	 * @return
	 */
	public Integer getId() {
		return id;
	}

	/**
	 * 设置编号
	 * 
	 * @param value
	 */
	public void setId(Integer value) {
		this.id = value;
	}

	/**
	 * 获取 角色名称
	 * 
	 * @return
	 */
	public String getRole_name() {
		return role_name;
	}

	/**
	 * 角色名称
	 * 
	 * @param value
	 */
	public void setRole_name(String value) {
		this.role_name = value;
	}

	/**
	 * 获取权限
	 * 
	 * @return
	 */
	public String getPower() {
		return power;
	}

	/**
	 * 设置权限
	 * 
	 * @param value
	 */
	public void setPower(String value) {
		this.power = value;
	}

	public boolean equals(Object obj) {
		// TODO Auto-generated method stub
		if (obj == null)
			return false;
		else if (obj instanceof Role) {
			Role room = (Role) obj;
			if (room.id == this.id)
				return true;
		}
		return false;
	}

}
