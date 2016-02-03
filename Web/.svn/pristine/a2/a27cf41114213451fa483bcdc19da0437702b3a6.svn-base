package com.lingtong.model;

import org.apache.commons.lang.StringUtils;

import com.mysql.jdbc.StatementInterceptor;

/**
 * 房源
 * */
public class Room {
	public static final String TABLENAME = "room";
	private Integer id;
	private Integer comm_id;// 小区
	private Integer room_host;// 房东
	private String room_name;// 具体地址
	private String address;// 省市区/县,改成是路,如学院路
	private Integer price;// 租金高
	private String rental_start_time;// 出租时间
	private String rental_end_time;// 结束时间
	private String status;// 是否已租
	private String desc;// 描述,跟mysql关键字重名了`mysql`
	private String picture;// 照片
	private Integer size;// 面积
	private String kind;// 种类 厅室
	private String floor;// 楼层
	private String orient;// 朝向
	private String occupancy;// 使用情况
	private String metro;// 附近地铁情况
	private String recommend;// 推荐字段
	private String recommendTarget;// 推荐标签
	// private Integer id; // 配置Id
	// private Integer room_id;//房源id
	// 整数型数据 0 无 1 有 checkbox
	private Integer bed;// 床
	private Integer wardrobe;// 衣柜
	private Integer air_conditioning;// 空调
	private Integer tv;// 电视
	// private Integer kitchen;// 厨房
	// private Integer bashroom;// 浴室

	// -----
	// 新增字段,作为省市区/县
	private String cityid;

	private Integer gasstove; // 燃气灶

	private Integer washing;// 洗衣机

	private Integer heater;// 热水器

	private Integer refrigerator;// 冰箱

	private Integer microwaveOven; // 微波炉

	// private Integer balcony ;//阳台

	private String createtime;// 房源创建时间

	private String decoration;// 装修类型:毛坯,简装,中等,精装,豪华

	private String rent_type;// 出租类型,整租,合租

	private Integer company_id; // 公司 id

	private String roomSeq;// 房源编号'
	 
	
	private Integer smartlock ;// 是否支持智能锁
	
	private Integer isRecommend ;//是否是推荐房源

	public Integer getSmartlock() {
		return smartlock;
	}

	public void setSmartlock(Integer smartlock) {
		this.smartlock = smartlock;
	}

	public Integer getCompany_id() {
		return company_id;
	}

	public void setCompany_id(Integer company_id) {
		this.company_id = company_id;
	}

	public Integer getGasstove() {
		return gasstove;
	}

	public void setGasstove(Integer gasstove) {
		this.gasstove = gasstove;
	}

	public Integer getWashing() {
		return washing;
	}

	public void setWashing(Integer washing) {
		this.washing = washing;
	}

	public Integer getHeater() {
		return heater;
	}

	public void setHeater(Integer heater) {
		this.heater = heater;
	}

	public Integer getRefrigerator() {
		return refrigerator;
	}

	public void setRefrigerator(Integer refrigerator) {
		this.refrigerator = refrigerator;
	}

	public Integer getMicrowaveOven() {
		return microwaveOven;
	}

	public void setMicrowaveOven(Integer microwaveOven) {
		this.microwaveOven = microwaveOven;
	}

	public String getCityid() {
		return cityid;
	}

	public void setCityid(String cityid) {
		this.cityid = cityid;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getComm_id() {
		return comm_id;
	}

	public void setComm_id(Integer comm_id) {
		this.comm_id = comm_id;
	}

	public Integer getRoom_host() {
		return room_host;
	}

	public void setRoom_host(Integer room_host) {
		this.room_host = room_host;
	}

	public String getRoom_name() {
		return room_name;
	}

	public void setRoom_name(String room_name) {
		this.room_name = room_name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Integer getPrice() {
		return price;
	}

	public void setPrice(Integer price) {
		this.price = price;
	}

	public String getRental_start_time() {
		return rental_start_time;
	}

	public void setRental_start_time(String rental_start_time) {
		this.rental_start_time = rental_start_time;
	}

	public String getRental_end_time() {
		return rental_end_time;
	}

	public void setRental_end_time(String rental_end_time) {
		this.rental_end_time = rental_end_time;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	public Integer getSize() {
		return size;
	}

	public void setSize(Integer size) {
		this.size = size;
	}

	public String getKind() {
		return kind;
	}

	public void setKind(String kind) {
		this.kind = kind;
	}

	public String getFloor() {
		return floor;
	}

	public void setFloor(String floor) {
		this.floor = floor;
	}

	public String getOrient() {
		return orient;
	}

	public void setOrient(String orient) {
		this.orient = orient;
	}

	public String getOccupancy() {
		return occupancy;
	}

	public void setOccupancy(String occupancy) {
		this.occupancy = occupancy;
	}

	public String getMetro() {
		return metro;
	}

	public void setMetro(String metro) {
		this.metro = metro;
	}

	public Integer getBed() {
		return bed;
	}

	public void setBed(Integer bed) {
		this.bed = bed;
	}

	public Integer getWardrobe() {
		return wardrobe;
	}

	public void setWardrobe(Integer wardrobe) {
		this.wardrobe = wardrobe;
	}

	public Integer getAir_conditioning() {
		return air_conditioning;
	}

	public void setAir_conditioning(Integer air_conditioning) {
		this.air_conditioning = air_conditioning;
	}

	public Integer getTv() {
		return tv;
	}

	public void setTv(Integer tv) {
		this.tv = tv;
	}

	public String getRecommend() {
		return recommend;
	}

	public void setRecommend(String recommend) {
		this.recommend = recommend;
	}

	public String getRecommendTarget() {
		return recommendTarget;
	}

	public void setRecommendTarget(String recommendTarget) {
		this.recommendTarget = recommendTarget;
	}

	public String getCreatetime() {
		return createtime;
	}

	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}

	public String getDecoration() {
		return decoration;
	}

	public void setDecoration(String decoration) {
		this.decoration = decoration;
	}

	public String getRent_type() {
		return rent_type;
	}

	public void setRent_type(String rent_type) {
		this.rent_type = rent_type;
	}
	
	public String getRoomSeq() {// 4位的小区id+3位的公司id+年月日6位+房源的id5位(房源id只有在插入之后,再更新才可以)
		if (StringUtils.isBlank(roomSeq)) {
			this.roomSeq = new StringBuilder()
					.append("uz")
					.append(StringUtils.leftPad(comm_id + "", 4, "0"))
					.append(StringUtils.leftPad(company_id + "", 3, "0"))
//					.append(StringUtils.leftPad(CalendarUtil.getInstance().getCurrentTime(new SimpleDateFormat("yyMMdd")) + "", 6, "0"))
					.toString();
		}
		return roomSeq;
	}

	public void setRoomSeq(String roomSeq) {
		this.roomSeq = roomSeq;
	}

	public Integer getIsRecommend() {
		return isRecommend;
	}

	public void setIsRecommend(Integer isRecommend) {
		this.isRecommend = isRecommend;
	}
}
