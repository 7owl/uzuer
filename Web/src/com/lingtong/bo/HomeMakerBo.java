package com.lingtong.bo;

import java.util.List;
import java.util.Map;

import com.lingtong.model.Pagination;
import com.lingtong.model.HomeMaker;

public interface HomeMakerBo {
	/**
	 * 管家保存修改
	 * @param HomeMaker
	 * @return
	 */
	public Map<String, Object> save (HomeMaker homeMaker);
	/**
	 * 房源是否存在
	 * @param HomeMaker
	 * @return
	 */
	public boolean isExist(HomeMaker homeMaker);
	/**
	 * 分页查询
	 * @param page
	 * @param results
	 * @return
	 */
	public List<HomeMaker> query ( Pagination page, Map<String, Object> results );
 
	/**
	 * 删除 管家
	 * @param delIds
	 * @return
	 */
	public Map<String, Object> delete(String delIds);
	
	/***
	 * 根据id获得管家
	 * @param id
	 * @return
	 */
	public HomeMaker getHomeMakerById( Integer id );
}
