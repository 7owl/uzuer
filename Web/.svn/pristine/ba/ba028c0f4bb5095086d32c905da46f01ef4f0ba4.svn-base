package com.lingtong.model ;
/*
 
audit(审核表)
//审核表
----------------------------------------
id(编号)                  PKInteger(20) //编号
auditer(房客)             FKInteger(20) //被审核人,即房客
auditee(审核人)           String(20)  //审核人
valid_form(审核开始时间)  String(20)  //审核开始时间
valid_to(审核结束时间)    String(20)  //审核结束时间
audit_content(审核内容)   String(1000) //审核内容
audit_result(审核结果)    String(2)   //审核结果
*/
 

/***
 * 
 * @author MTT
 * 审核表 
 */
public class Audit
{
  private Integer id; // 审核表编号
  private Integer auditer;// 被审核人 房客
  private String auditee;// 审核人
  private String valid_form;// 开始时间
  private String valid_to;// 结束时间
  private String audit_content;// 审核内容
  private String audit_result;// 审核结果

  public Audit()
  {
  }

  /**
   * 获取 编号
   * */
  public Integer getId()
  {
    return id;
  }
  /**
   *  设置ID
   * @param value
   */
  public void setId(Integer value)
  {
    this.id = value;
  }
  /**获取 房客 被审核人,即房客*/
  public Integer getAuditer()
  {
    return auditer;
  }
  /**
   * 设置被审核人 房客
   * @param value
   */
  public void setAuditer(Integer value)
  {
    this.auditer = value;
  }
  /**
   * 获取审核人
   * */
  public String getAuditee()
  {
    return auditee;
  }
  /***
   * 设置审核人 
   * @param value
   */
  public void setAuditee(String value)
  {
    this.auditee = value;
  }
  /**获取审核开始时间 审核开始时间*/
  public String getValid_form()
  {
    return valid_form;
  }
  /***
   * 设置审核开始时间
   * @param value
   */
  public void setValid_form(String value)
  {
    this.valid_form = value;
  }
  /***
   * 设置审核结束时间 审核结束时间
   * */
  public String getValid_to()
  {
    return valid_to;
  }
  /***
   * 设置审核结束时间
   * @param value
   */
  public void setValid_to(String value)
  {
    this.valid_to = value;
  }
  /***
   * 获取审核内容 审核内容
   * */
  public String getAudit_content()
  {
    return audit_content;
  }
  /***
   * 设置审核内容
   * @param value
   */
  public void setAudit_content(String value)
  {
    this.audit_content = value;
  }
  /**获取 审核结果 审核结果*/
  public String getAudit_result()
  {
    return audit_result;
  }
  /***
   * 设置审核接结果
   * @param value
   */
  public void setAudit_result(String value)
  {
    this.audit_result = value;
  }

  public boolean equals(Object obj) {
		if(obj ==null)
		return false ;
		else 
			if (obj instanceof Audit) {
				Audit audit =  (Audit)obj;
			 if(audit.id == this.id)
				 return true ;
			} 
		return false ;
}

 
}

