package com.lingtong.model;

/**
 * @author xqq
 * @date 2015-9-26 下午10:43:39
 * 
 */
public class KeyList {
	public static final String TABLENAME = "keylist";
	
	private Long date;
	private Long end_date;
	private Long key_id;
	private String key_status;
	private Long room_id;
	private Long start_date;
	private Integer sciener_is_freeze;
	private Integer openid;
	
	public Long getDate() {
		return date;
	}
	public void setDate(Long date) {
		this.date = date;
	}
	public Long getEnd_date() {
		return end_date;
	}
	public void setEnd_date(Long end_date) {
		this.end_date = end_date;
	}
	public Long getKey_id() {
		return key_id;
	}
	public void setKey_id(Long key_id) {
		this.key_id = key_id;
	}
	public String getKey_status() {
		return key_status;
	}
	public void setKey_status(String key_status) {
		this.key_status = key_status;
	}
	public Long getRoom_id() {
		return room_id;
	}
	public void setRoom_id(Long room_id) {
		this.room_id = room_id;
	}
	public Long getStart_date() {
		return start_date;
	}
	public void setStart_date(Long start_date) {
		this.start_date = start_date;
	}
	public Integer getSciener_is_freeze() {
		return sciener_is_freeze;
	}
	public void setSciener_is_freeze(Integer sciener_is_freeze) {
		this.sciener_is_freeze = sciener_is_freeze;
	}
	
	public Integer getOpenid() {
		return openid;
	}
	public void setOpenid(Integer openid) {
		this.openid = openid;
	}
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((key_id == null) ? 0 : key_id.hashCode());
		result = prime * result + ((room_id == null) ? 0 : room_id.hashCode());
		return result;
	}
	
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		KeyList other = (KeyList) obj;
		if (key_id == null) {
			if (other.key_id != null)
				return false;
		} else if (!key_id.equals(other.key_id))
			return false;
		if (room_id == null) {
			if (other.room_id != null)
				return false;
		} else if (!room_id.equals(other.room_id))
			return false;
		return true;
	}
}
