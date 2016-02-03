package com.lingtong.model;

/**
 * 房东 
 * */
public class Hosts {
	public static final String TABLENAME = "hosts";
	private Integer id;// 房东编号
	private Integer role_id;//角色ID
	private Integer company_id;// 公司ID
	private String username;// 用户名
	private String pwd;// 密码
	private String first_name;//姓氏
	private String last_name;//名字
	private String tel_number;//联系电话
	private String email;//邮箱
	private String id_card;//身份证
	private String native_place;//籍贯
	private String work_unit;//工作单位
	private String work_place;//工作地址
	private String work_place_number;//工作单位号码
	
	//新增字段
	private Integer isDel;//级联删除,逻辑字段
	private String bank_card;//银行卡号
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer value) {
		this.id = value;
	}

	public Integer getRole_id() {
		return role_id;
	}

	public void setRole_id(Integer value) {
		this.role_id = value;
	}

	public Integer getCompany_id() {
		return company_id;
	}

	public void setCompany_id(Integer value) {
		this.company_id = value;
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

	public String getBank_card() {
		return bank_card;
	}

	public void setBank_card(String bank_card) {
		this.bank_card = bank_card;
	}
	
}
