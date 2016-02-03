package com.lingtong.model;

import javax.xml.bind.annotation.XmlRootElement;
/**
 * tenants(租客)
 */
//一定要使用XmlRootElement注解进行标注
@XmlRootElement(name = "tenant")
public class Tenants {
	public static final String TABLENAME = "tenants";
	private Integer id; // 租客ID
	private Integer room_id;// 房间 ID
	private Integer role_id;// 角色ID
	private String username;// 用户名
	private String pwd;// 密码
	private String first_name;// 姓氏
	private String last_name;// 名字
	private String tel_number;// 手机号码
	private String email;// 邮箱
	private String id_card;// 身份证
	private String native_place;// 籍贯
	private String work_unit;// 工作单位
	private String work_place;// 工作地址
	private String work_place_number;// 工作单位号码
	private String fullname;//非数据库字段
	//新增字段
	private String token;//令牌
	private Integer email_validate;//邮箱是否被验证,1表示验证通过,0表示未验证通过
	
	private String email_valid_token;//邮箱验证口令
	private String email_valid_tokenEndTime;//邮箱 激活链接 失效时间

	private String uuid ;//
	private String clientid;

	private String devicetoken;
	
	private Integer identity_valid;//身份验证
	private String id_card_valid;//身份证验证
	private String full_name_valid;//姓名验证
	
	private String headpic ;// 头像字段
	
	private String sciener_openid;////sciener,注册的用户id
	private String sciener_username;//sciener,注册的用户名
	private String sciener_password;//sciener,注册的密码
	
	public String getHeadpic() {
		return headpic;
	}

	public void setHeadpic(String headpic) {
		this.headpic = headpic;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getClientid() {
		return clientid;
	}

	public void setClientid(String clientid) {
		this.clientid = clientid;
	}

	public String getDevicetoken() {
		return devicetoken;
	}

	public void setDevicetoken(String devicetoken) {
		this.devicetoken = devicetoken;
	}

	public String getEmail_valid_token() {
		return email_valid_token;
	}

	public void setEmail_valid_token(String email_valid_token) {
		this.email_valid_token = email_valid_token;
	}

	public String getEmail_valid_tokenEndTime() {
		return email_valid_tokenEndTime;
	}

	public void setEmail_valid_tokenEndTime(String email_valid_tokenEndTime) {
		this.email_valid_tokenEndTime = email_valid_tokenEndTime;
	}

	public Integer getId() {
		return id;
	}
	
	public void setId(Integer value) {
		this.id = value;
	}

	public Integer getRoom_id() {
		return room_id;
	}
	
	public void setRoom_id(Integer value) {
		this.room_id = value;
	}

	public Integer getRole_id() {
		return role_id;
	}
	
	public void setRole_id(Integer value) {
		this.role_id = value;
	}
 
	public String getUsername() {
		return username;
	}

	public void setUsername(String value) {
		this.username = value;
	}

	
	public String getPwd() {
		return pwd;
	}
	
	public void setPwd(String value) {
		this.pwd = value;
	}

	public String getFirst_name() {
		return first_name;
	}
	
	public void setFirst_name(String value) {
		this.first_name = value;
	}

	public String getLast_name() {
		return last_name;
	}
	
	public void setLast_name(String value) {
		this.last_name = value;
	}

	public String getTel_number() {
		return tel_number;
	}
	
	public void setTel_number(String value) {
		this.tel_number = value;
	}

	public String getEmail() {
		return email;
	}
	
	public void setEmail(String value) {
		this.email = value;
	}

	public String getId_card() {
		return id_card;
	}
	
	public void setId_card(String value) {
		this.id_card = value;
	}

	public String getNative_place() {
		return native_place;
	}
	
	public void setNative_place(String value) {
		this.native_place = value;
	}

	public String getWork_unit() {
		return work_unit;
	}

	public void setWork_unit(String value) {
		this.work_unit = value;
	}

	public String getWork_place() {
		return work_place;
	}

	public void setWork_place(String value) {
		this.work_place = value;
	}

	public String getWork_place_number() {
		return work_place_number;
	}
	
	public void setWork_place_number(String value) {
		this.work_place_number = value;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public Integer getEmail_validate() {
		return email_validate;
	}

	public void setEmail_validate(Integer email_validate) {
		this.email_validate = email_validate;
	}

	public Integer getIdentity_valid() {
		return identity_valid;
	}

	public void setIdentity_valid(Integer identity_valid) {
		this.identity_valid = identity_valid;
	}

	public String getId_card_valid() {
		return id_card_valid;
	}

	public void setId_card_valid(String id_card_valid) {
		this.id_card_valid = id_card_valid;
	}

	public String getFull_name_valid() {
		return full_name_valid;
	}

	public void setFull_name_valid(String full_name_valid) {
		this.full_name_valid = full_name_valid;
	}

	public String getSciener_openid() {
		return sciener_openid;
	}

	public void setSciener_openid(String sciener_openid) {
		this.sciener_openid = sciener_openid;
	}

	public String getSciener_username() {
		return sciener_username;
	}

	public void setSciener_username(String sciener_username) {
		this.sciener_username = sciener_username;
	}

	public String getSciener_password() {
		return sciener_password;
	}

	public void setSciener_password(String sciener_password) {
		this.sciener_password = sciener_password;
	}

	public String getFullname() {
		return fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}
	
}
