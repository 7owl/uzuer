package com.lingtong.model;

import com.sun.org.apache.bcel.internal.generic.NEW;

/***
 * 小区
 * @author MTT
 * 
 */
public class Community {
	public static final String TABLENAME = "community";
	private Integer id; // 小区ID
	private Integer hm_id;// 管家ID
	private String comm_name;// 小区名称
	private String comm_address;// 小区地址
	private String comm_address_code;//小区地址代码
	private String comm_desc;// 小区描述
	private Double longitude;// 小区的经度
	private Double latitude;// 小区的纬度
	
	private String lonAndLat;//临时变量,如"经度,纬度"
	
	//新增字段
	private String pinyin;
	private String busiCircle;//商圈
	
	//级联删除,逻辑字段
	private Integer isDel;

	public Integer getId() {
		return id;
	}

	public void setId(Integer value) {
		this.id = value;
	}

	public Integer getHm_id() {
		return hm_id;
	}

	public void setHm_id(Integer value) {
		this.hm_id = value;
	}

	public String getComm_name() {
		return comm_name;
	}

	public void setComm_name(String value) {
		this.comm_name = value;
	}

	public String getComm_address() {
		return comm_address;
	}

	public void setComm_address(String value) {
		this.comm_address = value;
	}

	public String getComm_desc() {
		return comm_desc;
	}

	public void setComm_desc(String value) {
		this.comm_desc = value;
	}
	
	public Double getLongitude() {
		return longitude;
	}

	public void setLongitude(Double longitude) {
		this.longitude = longitude;
	}

	public String getComm_address_code() {
		return comm_address_code;
	}

	public void setComm_address_code(String comm_address_code) {
		this.comm_address_code = comm_address_code;
	}

	public String getPinyin() {
		return pinyin;
	}

	public void setPinyin(String pinyin) {
		this.pinyin = pinyin;
	}

	public Integer getIsDel() {
		return isDel;
	}

	public void setIsDel(Integer isDel) {
		this.isDel = isDel;
	}

	public String getBusiCircle() {
		return busiCircle;
	}

	public void setBusiCircle(String busiCircle) {
		this.busiCircle = busiCircle;
	}

	public Double getLatitude() {
		return latitude;
	}

	public void setLatitude(Double latitude) {
		this.latitude = latitude;
	}

	public String getLonAndLat() {
		return lonAndLat;
	}

	public void setLonAndLat(String lonAndLat) {
		this.lonAndLat = lonAndLat;
	}
}
