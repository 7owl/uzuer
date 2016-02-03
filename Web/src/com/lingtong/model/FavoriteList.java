package com.lingtong.model;

/**
 * @author xqq
 * @date 2015-8-16 下午4:26:09
 * 中意清单
 */
public class FavoriteList {
	public static final String TABLENAME = "favoriteList";
	private Integer tenant_id;//房客编号
	private Integer room_id;//房源编号
	private String updatetime;//时间
	
	public Integer getTenant_id() {
		return tenant_id;
	}
	public void setTenant_id(Integer tenant_id) {
		this.tenant_id = tenant_id;
	}
	public Integer getRoom_id() {
		return room_id;
	}
	public void setRoom_id(Integer room_id) {
		this.room_id = room_id;
	}
	public String getUpdatetime() {
		return updatetime;
	}
	public void setUpdatetime(String updatetime) {
		this.updatetime = updatetime;
	}
}
