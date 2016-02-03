package com.lingtong.model;

/** 
 * 房屋配置 房屋配置
 */
public class RoomConfiguration
{
 
	public static final String TABLENAME = "room_configuration";
	
  private Integer id; // 配置Id
  private Integer room_id;//房源id
  private Integer bed;// 床
  private Integer wardrobe;// 衣柜
  private Integer air_conditioning;//空调
  private Integer tv;//电视
  private Integer kitchen;//厨房
  private Integer bashroom;// 浴室

  public RoomConfiguration()
  {
  }

  /**
   * 获取编号 编号
   */
  public Integer getId()
  {
    return id;
  }
  /**
   * 设置编号 编号
   */
  public void setId(Integer value)
  {
    this.id = value;
  }
  /**
   * 获取房源编号 房源编号
   */
  public Integer getRoom_id()
  {
    return room_id;
  }
  /**
   * 设置房源编号 房源编号
   */
  public void setRoom_id(Integer value)
  {
    this.room_id = value;
  }
  /**
   * 获取床 床
   */
  public Integer getBed()
  {
    return bed;
  }
  /**
   * 设置床 床
   */
  public void setBed(Integer value)
  {
    this.bed = value;
  }
  /**
   * 获取衣柜 衣柜
   */
  public Integer getWardrobe()
  {
    return wardrobe;
  }
  /**
   * 设置衣柜 衣柜
   */
  public void setWardrobe(Integer value)
  {
    this.wardrobe = value;
  }
  /**
   * 获取空调 空调
   */
  public Integer getAir_conditioning()
  {
    return air_conditioning;
  }
  /**
   * 设置空调 空调
   */
  public void setAir_conditioning(Integer value)
  {
    this.air_conditioning = value;
  }
  /**
   * 获取电视 电视
   */
  public Integer getTv()
  {
    return tv;
  }
  /**
   * 设置电视 电视
   */
  public void setTv(Integer value)
  {
    this.tv = value;
  }
  /**
   * 获取厨房 厨房
   */
  public Integer getKitchen()
  {
    return kitchen;
  }
  /**
   * 设置厨房 厨房
   */
  public void setKitchen(Integer value)
  {
    this.kitchen = value;
  }
  /**
   * 获取浴室 浴室
   */
  public Integer getBashroom()
  {
    return bashroom;
  }
  /**
   * 设置浴室 浴室
   */
  public void setBashroom(Integer value)
  {
    this.bashroom = value;
  }
  
  public boolean equals(Object obj) {
		// TODO Auto-generated method stub
		if(obj ==null)
		return false ;
		else 
			if (obj instanceof RoomConfiguration) {
				RoomConfiguration roomConfiguration =  (RoomConfiguration)obj;
			 if(roomConfiguration.id == this.id)
				 return true ;
			} 
		return false ;
}
}

