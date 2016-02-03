package com.lingtong.model;

public class BankInfo {

	public static final String TABLENAME ="bankInfo" ;
	
	private Integer id;
	private String bankName;//开户行
	private String bankNum ;//账号
	private String bankPerson;//开户人
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	public String getBankNum() {
		return bankNum;
	}
	public void setBankNum(String bankNum) {
		this.bankNum = bankNum;
	}
	public String getBankPerson() {
		return bankPerson;
	}
	public void setBankPerson(String bankPerson) {
		this.bankPerson = bankPerson;
	}
	
}
