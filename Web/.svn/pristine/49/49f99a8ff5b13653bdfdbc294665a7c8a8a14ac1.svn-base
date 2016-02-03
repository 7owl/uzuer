package com.lingtong.model;

import java.io.Serializable;

import org.apache.commons.lang.StringUtils;

import com.lingtong.util.CalendarUtil;

/**
 * @author xqq
 * @date 2015-8-11 下午9:08:38
 * 
 */
public class IdImage implements Serializable {
	public static final String TABLENAME = "idPicture";
	
	private Integer id;//图片id
	private Integer room_id;//房源id
	private String url;//新图片名字
	private String picname;//原图片名字
	private String pictime;//上传时间
	private Integer tenant_id ; //房客名称
	
	public Integer getTenant_id() {
		return tenant_id;
	}
	public void setTenant_id(Integer tenant_id) {
		this.tenant_id = tenant_id;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getRoom_id() {
		return room_id;
	}
	public void setRoom_id(Integer room_id) {
		this.room_id = room_id;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getPicname() {
		return picname;
	}
	public void setPicname(String picname) {
		this.picname = picname;
	}
	public String getPictime() {
		if( StringUtils.isBlank( pictime ) ){//默认值
			return CalendarUtil.getInstance().getCurrentTime();
		}
		return pictime;
	}
	public void setPictime(String pictime) {
		this.pictime = pictime;
	}
}
