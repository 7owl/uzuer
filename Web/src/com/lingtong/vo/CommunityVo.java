package com.lingtong.vo;

/**
 * @author xqq
 * @date 2015-8-7 下午9:48:12
 * 
 */
public class CommunityVo {
	private String hm_name;// 管家姓名
	private String hm_number;// 管家联系方式
	
	private Integer id; // 小区ID
	private Integer hm_id;// 管家ID
	private String comm_name;// 小区名称
	private String comm_address;// 小区地址
	private String comm_address_code;//小区地址代码
	private String comm_desc;// 小区描述
	private Double longitude;// 小区的经度
	private Double latitude;// 小区的纬度
	
	private Integer room_num;//小区所在的未出租的房子总数
	
	//新增字段
	private String busiCircle;//商圈
	
	public String getHm_name() {
		return hm_name;
	}
	public void setHm_name(String hm_name) {
		this.hm_name = hm_name;
	}
	public String getHm_number() {
		return hm_number;
	}
	public void setHm_number(String hm_number) {
		this.hm_number = hm_number;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getHm_id() {
		return hm_id;
	}
	public void setHm_id(Integer hm_id) {
		this.hm_id = hm_id;
	}
	public String getComm_name() {
		return comm_name;
	}
	public void setComm_name(String comm_name) {
		this.comm_name = comm_name;
	}
	public String getComm_address() {
		return comm_address;
	}
	public void setComm_address(String comm_address) {
		this.comm_address = comm_address;
	}
	public String getComm_address_code() {
		return comm_address_code;
	}
	public void setComm_address_code(String comm_address_code) {
		this.comm_address_code = comm_address_code;
	}
	public String getComm_desc() {
		return comm_desc;
	}
	public void setComm_desc(String comm_desc) {
		this.comm_desc = comm_desc;
	}
	public Double getLongitude() {
		return longitude;
	}
	public void setLongitude(Double longitude) {
		this.longitude = longitude;
	}
	public Double getLatitude() {
		return latitude;
	}
	public void setLatitude(Double latitude) {
		this.latitude = latitude;
	}
	public String getBusiCircle() {
		return busiCircle;
	}
	public void setBusiCircle(String busiCircle) {
		this.busiCircle = busiCircle;
	}
	public Integer getRoom_num() {
		return room_num;
	}
	public void setRoom_num(Integer room_num) {
		this.room_num = room_num;
	}
	
}
