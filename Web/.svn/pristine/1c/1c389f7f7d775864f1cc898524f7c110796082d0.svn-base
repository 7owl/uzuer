package com.lingtong.bo;

import java.util.List;
import java.util.Map;

import com.lingtong.model.Pagination;
import com.lingtong.model.Community;
import com.lingtong.vo.CommunityVo;

/**
 * 
 * @author MTT
 * @date 2015-8-5
 */
public interface CommunityBo {
	/**
	 * 房源保存修改
	 * @param Community
	 * @return
	 */
	public Map<String, Object> save (Community community);
	/**
	 * 角色是否存在
	 * @param Community
	 * @return
	 */
	public boolean isExist(Community community);
	/**
	 * 分页查询
	 * @param page
	 * @param results
	 * @return
	 */
	public List<CommunityVo> query ( Pagination page, Map<String, Object> results );
 
	/**
	 * 删除 房源
	 * @param delIds
	 * @return
	 */
	public Map<String, Object> delete(String delIds);
	
	/**
	 * 获取房源地址
	 * @param comm_id
	 * @return
	 */
	public List<Community> getCommAddressById(int comm_id);
	
	
}
