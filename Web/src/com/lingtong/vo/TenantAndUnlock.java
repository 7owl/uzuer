package com.lingtong.vo;

/**
 * @author xqq
 * @date 2015-9-26 下午10:39:50
 * 冗余表	
 */
public class TenantAndUnlock {
	public static final String TABLENAME = "tenant_unlock";
	
	private Integer id;//主键
	private Integer openid;//sciener注册的用户id
	private Integer lockid;//锁id
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getOpenid() {
		return openid;
	}
	public void setOpenid(Integer openid) {
		this.openid = openid;
	}
	public Integer getLockid() {
		return lockid;
	}
	public void setLockid(Integer lockid) {
		this.lockid = lockid;
	}
}
