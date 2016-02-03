package com.lingtong.model;

import java.util.List;

/***
 * 小区
 * @author MTT
 * 
 */
public class Region {
	public Double region_id; //地址ID
	public String region_code;//地址代码
	public String region_name;//地址名称
	
	public List<Region> children;

	public Double getRegion_id() {
		return region_id;
	}

	public void setRegion_id(Double region_id) {
		this.region_id = region_id;
	}

	public String getRegion_code() {
		return region_code;
	}

	public void setRegion_code(String region_code) {
		this.region_code = region_code;
	}

	public String getRegion_name() {
		return region_name;
	}

	public void setRegion_name(String region_name) {
		this.region_name = region_name;
	}

	public List<Region> getChildren() {
		return children;
	}

	public void setChildren(List<Region> children) {
		this.children = children;
	}
}
