package com.lingtong.model;



/*
  合同类型 合同类型

contract_type(合同类型)
//合同类型
----------------------------------
id(编号)            PKInteger(20) //编号
pay_kind(付款方式)  String(20)  //付款方式
*/

/**
 * 合同类型 合同类型 */
public class ContractType
{
  private Integer  id;// 合同類型標號
  private String pay_kind;//該類型付款方式

  public ContractType()
  {
  }

  /**
   * 获取 编号
   * @return
   */
  public Integer getId()
  {
    return id;
  }
  /**
   * 设置编号
   * @param value
   */
  public void setId(Integer value)
  {
    this.id = value;
  }
  /**
   * 获取 付款方式
   * @return
   */
  public String getPay_kind()
  {
    return pay_kind;
  }
  /**
   * 设置付款方式
   * @param value
   */
  public void setPay_kind(String value)
  {
    this.pay_kind = value;
  }

  public boolean equals(Object obj) {
		// TODO Auto-generated method stub
		if(obj ==null)
		return false ;
		else 
			if (obj instanceof ContractType) {
				ContractType contractType =  (ContractType)obj;
			 if(contractType.id == this.id)
				 return true ;
			} 
		return false ;
  }
  }

