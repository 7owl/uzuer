package com.lingtong.interfaces.message;

/**
 * @author xqq
 * @date 2015-8-13 下午8:06:45
 * 接口的容错信息
 */
public class FaultTolerant {
	private String uid = "";//id信息,主要是房客
	private String platform = "";//系统平台
	private String version = "";//app版本
	private String token = "";//令牌
	private String packageName = "";//包名
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getPlatform() {
		return platform;
	}
	public void setPlatform(String platform) {
		this.platform = platform;
	}
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getToken() {
		return token;
	}
	public void setToken(String token) {
		this.token = token;
	}
	public String getPackageName() {
		return packageName;
	}
	public void setPackageName(String packageName) {
		this.packageName = packageName;
	}
}
