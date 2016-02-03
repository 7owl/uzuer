package com.lingtong.dao;

import java.util.List;
import java.util.Map;

import com.lingtong.model.Pagination;
import com.lingtong.model.Tenants;

/**
 * @author xqq
 * @date 2015-8-2 下午12:03:02
 * 
 */
public interface TenantsDao {
	/**
	 * 房客增加或修改
	 * @return
	 */
	public Map<String, Object> save( Tenants tenant );
	
	/**
	 * 检查是否存在
	 * */
	public boolean isExist( Tenants tenant );
	
	/***
	 * 分页查询
	 * @param page
	 * @param results
	 * @return
	 */
	public List<Tenants> query( Pagination page, Map<String, Object> results );
	
	/**
	 * 删除
	 * @param delIds
	 * @return
	 */
	public Map<String, Object> delete(String delIds);
	
	
	/**********************************app 专用接口*****************************************/
	/***
	 * 根据手机号获得租客
	 * @param tel_number,手机号码
	 * @param smsCode,短信验证码
	 * @return
	 */
	public Map<String, Object> getTenantByCell( String tel_number, String smsCode );
	
	/***
	 * 修改租客资料信息
	 * @param tenant
	 * @return
	 */
	public Map<String, Object> edit( Tenants tenant ,String platform );
	/**
	 * 获取详情
	 * @param tenantid
	 * @return
	 */
	public Map<String, Object> getTenantDetail(String tenantid,String uuid ,String clientid, String devicetoken);	
	/**
	 * 激活邮箱
	 * @param tenantid
	 * @param token
	 * @return
	 */
	public Map<String, Object> activeEmail(String tenantid, String token,String platform);


	public Tenants findTenantById(String id);

	public List<Tenants> findTenantsByIds(String ids);
	
	public Map<String, Object> updateAuthState(String tenantid);
	/***
	 * 上传证件照
	 * @param bytes
	 * @param tenantid
	 * @return
	 */
	public Map<String, Object> uploadFile(byte[][] bytes, Tenants tenant);
	
	
}
