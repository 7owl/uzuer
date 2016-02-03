package com.lingtong.interfaces;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.ws.rs.core.Response;
import javax.xml.ws.WebServiceContext;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.impl.Log4jFactory;
import org.apache.cxf.jaxrs.ext.multipart.MultipartBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.lingtong.dao.TenantsDao;
import com.lingtong.dao.impl.TenantsDaoImpl;
import com.lingtong.interfaces.interceptor.Auth;
import com.lingtong.interfaces.interceptor.ReturnJSON;
import com.lingtong.interfaces.message.CommonErrorEnum;
import com.lingtong.interfaces.message.FaultTolerant;
import com.lingtong.model.Image;
import com.lingtong.model.Tenants;
import com.lingtong.util.FileUtils;

public class TenantServiceImpl implements TenantService {
	private TenantsDao tenantDao = new TenantsDaoImpl();

	public Response save(String tel_number, String smsCode) {
		Map<String, Object> result = new HashMap<String, Object>();
		if (StringUtils.isBlank(tel_number)) {
			result.put("code", CommonErrorEnum.TENANT_CELL_IS_NULL.getCode()+"");
			result.put("msg", CommonErrorEnum.TENANT_CELL_IS_NULL.getMessage());
		} else {
			result = tenantDao.getTenantByCell(tel_number, smsCode);
		}
		Tenants tenant = (Tenants) result.get("data");

		//result.put("code", 0);
		return ReturnJSON.getInstance().ret(result);
	}

	public Response edit(String tenant, String auth) {
		Map<String, Object> result = new HashMap<String, Object>();
		FaultTolerant fault = new Gson().fromJson(auth, FaultTolerant.class);
		// 进行验证
		if (Auth.auth(fault) == false) {
			result.put("code", CommonErrorEnum.FAULT_FOLERANT.getCode());
			result.put("msg", CommonErrorEnum.FAULT_FOLERANT.getMessage());
			return ReturnJSON.getInstance().ret(result);
		}

		if (StringUtils.isBlank(tenant)) {
			result.put("code", CommonErrorEnum.EDIT_INFO_NULL.getCode());
			result.put("msg", CommonErrorEnum.EDIT_INFO_NULL.getMessage());
			return ReturnJSON.getInstance().ret(result);
		}
		Tenants ten = new Gson().fromJson(tenant, Tenants.class);
		if (ten == null) {
			result.put("code", CommonErrorEnum.EDIT_INFO_FORMAT_FAULT.getCode());
			result.put("msg",
					CommonErrorEnum.EDIT_INFO_FORMAT_FAULT.getMessage());
			return ReturnJSON.getInstance().ret(result);
		}

		result = tenantDao.edit(ten, fault.getPlatform());
		return ReturnJSON.getInstance().ret(result);
	}

	public Response getDetail(String tenantid, String uuid, String clientid,
			String auth, String devicetoken) {

		Map<String, Object> result = new HashMap<String, Object>();
		FaultTolerant fault = new Gson().fromJson(auth, FaultTolerant.class);
		// 进行验证
		if (Auth.auth(fault) == false) {
			result.put("code", CommonErrorEnum.FAULT_FOLERANT.getCode());
			result.put("msg", CommonErrorEnum.FAULT_FOLERANT.getMessage());
			return ReturnJSON.getInstance().ret(result);
		}

		if (StringUtils.isBlank(tenantid)) {
			result.put("code", CommonErrorEnum.TENANT_IS_NOT_EXIST.getCode());
			result.put("msg", CommonErrorEnum.TENANT_IS_NOT_EXIST.getMessage());
			return ReturnJSON.getInstance().ret(result);
		}

		result = tenantDao.getTenantDetail(tenantid, uuid, clientid,
				devicetoken);

		return ReturnJSON.getInstance().ret(result);
	}

	public Response activeEmail(String tenantid, String token, String platform) {
		Map<String, Object> result = new HashMap<String, Object>();
		result = tenantDao.activeEmail(tenantid, token, platform);
		return ReturnJSON.getInstance().ret(result);
	}

	public Response uploadFile(String tenant, byte[] image1, byte[] image2, byte[] image3, String auth) {
		Log log = Log4jFactory.getLog(this.getClass());
		byte[][] images = new byte[3][];
		images[0] = image1;
		images[1] = image2;
		images[2] = image3;
		log.info("hello");
		Map<String, Object> result = new HashMap<String, Object>();
		FaultTolerant fault = new Gson().fromJson(auth, FaultTolerant.class);
		Tenants tenants = new Gson().fromJson(tenant, Tenants.class);
		try {
			String full_name = new String(tenants.getFull_name_valid().getBytes("ISO-8859-1"),"utf-8");
			tenants.setFull_name_valid( full_name );
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		// 进行验证
		if (Auth.auth(fault) == false) {
			result.put("code", CommonErrorEnum.FAULT_FOLERANT.getCode());
			result.put("msg", CommonErrorEnum.FAULT_FOLERANT.getMessage());
			return ReturnJSON.getInstance().ret(result);
		}
		result = tenantDao.uploadFile(images, tenants);
		return ReturnJSON.getInstance().ret(result);
	}
}