package com.lingtong.vo;

/**
 * @author xqq
 * @date 2015-9-22 下午9:55:13
 * 锁表
 */
public class UnlockVo {
	public static final String TABLENAME = "scienerlock";
	//锁信息
	private Integer kid;
	private Integer roomid;//跟房源无关
	private String uz_room_seq;//跟房源的编号关联(非主键关联)
	private Integer tenantid;//跟房客的主键关联
	//房源信息
	private String cityid;//省市区/县
	private String room_name;
	private String roomSeq;
	//小区信息
	private String comm_address;//小区地址
	private String comm_name;//小区名称
	
	public Integer getKid() {
		return kid;
	}
	public void setKid(Integer kid) {
		this.kid = kid;
	}
	public Integer getRoomid() {
		return roomid;
	}
	public void setRoomid(Integer roomid) {
		this.roomid = roomid;
	}
	public String getUz_room_seq() {
		return uz_room_seq;
	}
	public void setUz_room_seq(String uz_room_seq) {
		this.uz_room_seq = uz_room_seq;
	}
	public Integer getTenantid() {
		return tenantid;
	}
	public void setTenantid(Integer tenantid) {
		this.tenantid = tenantid;
	}
	public String getCityid() {
		return cityid;
	}
	public void setCityid(String cityid) {
		this.cityid = cityid;
	}
	public String getRoom_name() {
		return room_name;
	}
	public void setRoom_name(String room_name) {
		this.room_name = room_name;
	}
	public String getRoomSeq() {
		return roomSeq;
	}
	public void setRoomSeq(String roomSeq) {
		this.roomSeq = roomSeq;
	}
	public String getComm_address() {
		return comm_address;
	}
	public void setComm_address(String comm_address) {
		this.comm_address = comm_address;
	}
	public String getComm_name() {
		return comm_name;
	}
	public void setComm_name(String comm_name) {
		this.comm_name = comm_name;
	}
}
