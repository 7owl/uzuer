package com.lingtong.interfaces.message;

import java.util.Map;

/**
 * @author xqq
 * @date 2015-8-23 下午12:53:44
 * 
 */
public class AppRoomPage {
	private Integer curPage = 0;//当前页
	private Integer rows = 20;//每页显示多少条,默认是20
	
	private Map<String, String> filter;//过滤条件
	
	private Map<String, String> sort;//排序字段

	public Integer getCurPage() {
		return curPage;
	}

	public void setCurPage(Integer curPage) {
		this.curPage = curPage;
	}

	public Integer getRows() {
		return rows;
	}

	public void setRows(Integer rows) {
		this.rows = rows;
	}

	public Map<String, String> getFilter() {
		return filter;
	}

	public void setFilter(Map<String, String> filter) {
		this.filter = filter;
	}

	public Map<String, String> getSort() {
		return sort;
	}

	public void setSort(Map<String, String> sort) {
		this.sort = sort;
	}
}
