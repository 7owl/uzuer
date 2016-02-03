package com.lingtong.interfaces;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.NumberUtils;
import org.apache.commons.lang.StringUtils;

import com.google.gson.Gson;
import com.lingtong.dao.ContractDao;
import com.lingtong.dao.RoomDao;
import com.lingtong.dao.TenantsDao;
import com.lingtong.dao.impl.ContractDaoImpl;
import com.lingtong.dao.impl.RoomDaoImpl;
import com.lingtong.dao.impl.TenantsDaoImpl;
import com.lingtong.interfaces.interceptor.Auth;
import com.lingtong.interfaces.interceptor.ReturnJSON;
import com.lingtong.interfaces.message.CommonErrorEnum;
import com.lingtong.interfaces.message.FaultTolerant;
import com.lingtong.model.Contract;
import com.lingtong.model.Tenants;
import com.lingtong.vo.ContractVo;
import com.lingtong.vo.RoomVo;
import com.lingtong.word.Word;
import com.ssqian.signature.open.action.sign.MutinContractdocUploadSendall;
import com.ssqian.signature.open.action.sign.ViewContract;
import com.ssqian.signature.testdemo.GetSignPage;
import com.sun.tools.javac.resources.compiler;

/**
 * @author xqq
 * @date 2015-9-19 下午10:33:15
 * 
 */
public class ContractServiceImpl implements ContractService {
	private ContractDao contractDao = new ContractDaoImpl();
	private TenantsDao tenantsDao = new TenantsDaoImpl();
	private RoomDao roomDao = new RoomDaoImpl();
	/**
	 * 调用上上签接口 返回上传的合同的http 
	 */
	public Response viewConstract(String auth, String roomid, String constractType) {
		
		
		return null;
	}
	/**
	 * 调用上上签接口 和 合同生成模板 生成doc 上传到 上上签 
	 * 
	 * 
	 */
	public Response uploadConstract(String auth, String roomid,
			String constractType) {
		return null;
	}

	
	/**
	 * 确定 签署合同 
	 * 1、调用上上签自动签合同 在合同表里添加合同记录
	 * 2、根据房源自动生成 对应的订单 
	 * 3、返回最早的订单  
	 */
	public Response signConstract(String auth, String roomid,
			String constractType, String tenantid) {
		Map<String, Object> result = new HashMap<String, Object>();
		FaultTolerant fault = new Gson().fromJson(auth, FaultTolerant.class);
		// 进行验证
		if (Auth.auth(fault) == false) {
			result.put("code", CommonErrorEnum.FAULT_FOLERANT.getCode());
			result.put("msg", CommonErrorEnum.FAULT_FOLERANT.getMessage());
			return ReturnJSON.getInstance().ret(result);
		}

		Contract contract = new Contract();
		if (StringUtils.isNumeric(roomid)
				&& StringUtils.isNumeric(constractType)
				&& StringUtils.isNumeric(tenantid)) {
			Map<String, Object> roomres = roomDao.getRoomVoById(roomid);

			Date date = new Date();
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(date);
			
			SimpleDateFormat format = new SimpleDateFormat(
					"yyyy-MM-dd HH:mm:ss");
			if ("0".equals(roomres.get("code").toString())) {
				List roomvos = (List) (roomres.get("data"));
				RoomVo roomVo = new RoomVo();
				if (roomvos != null && roomvos.size() > 0) {
					roomVo = (RoomVo) roomvos.get(0);
				}else {
					result.put("code", "12012");
					result.put("msg", "没有获取到房源");
				}

				// 当前房源没有出租过 设置合同的签订时间是当前时间
				if ("0".equals(roomVo.getStatus())) {
					// RoomVo roomVo=
					
					// 设置付款类型
					calendar.set(Calendar.YEAR, calendar.get(Calendar.YEAR) + 1);
					
					contract.setContract_type_id(Integer
							.parseInt(constractType));
					// 设置房客
					contract.setTenant_id(Integer.parseInt(tenantid));
					// 房源ID
					contract.setRoom_id(Integer.parseInt(roomid));
					// 合同签署时间
					contract.setSign_time(format.format(date));
					contract.setEnd_time(format.format(calendar.getTime()));
					// 下面是添加 room中的信息
					contract.setCompany_id(roomVo.getCompany_id());
					contract.setHost_id(roomVo.getRoom_host());
					contract.setCompletedState("0");
					result = contractDao.save(contract, roomVo);
					//保存生成成功
				} else {
					// 获取已出租的房间的 出租结束时间
					try {
						Calendar calendar2 = Calendar.getInstance();
						Date roomendDate = format.parse(roomVo
								.getRental_end_time());
						calendar2.setTime(roomendDate);

						// 当前时间加 一个月
						int compare1 = calendar.compareTo(calendar2);
						calendar.add(Calendar.MONTH, 1);
						int compare2 = calendar.compareTo(calendar2);
						if (compare1 < 0 && compare2 > 0) {

							contract.setContract_type_id(Integer
									.parseInt(constractType));
							// 设置房客
							//设置结束时间是 该房间到期日最后一天加一年
							calendar2.set(Calendar.YEAR, calendar.get(Calendar.YEAR) + 1);
							contract.setTenant_id(Integer.parseInt(tenantid));
							// 房源ID
							contract.setRoom_id(Integer.parseInt(roomid));
							// 合同签署时间
							contract.setSign_time(format.format(roomendDate));
							contract.setEnd_time(format.format(calendar2.getTime()));
							// 下面是添加 room中的信息
							contract.setCompany_id(roomVo.getCompany_id());
							contract.setHost_id(roomVo.getRoom_host());
							contract.setCompletedState("0");
							result = contractDao.save(contract, roomVo);
							//保存生成成功
							}else {
							result.put("code", "12010");
							result.put("msg", "该房源现有租户合同结束时间超过一个月，暂不支持签订租房协议，请重新选择房源");
						}
					} catch (ParseException e) {
						e.printStackTrace();
					}
				}
			} else {
				result.put("code", "12000");
				result.put("msg", "获取合同房源失败");
			}
			return ReturnJSON.getInstance().ret(result);
		} else {
			result.put("code", "12006");
			result.put("msg", "传入参数异常");
			return ReturnJSON.getInstance().ret(result);
		}
	}
 
	/*********************************************上上签,合同签署开始***************************************************/
	public Response save(String auth, String contractno) {
		Map<String, Object> result = new HashMap<String, Object>();
		FaultTolerant fault = new Gson().fromJson(auth, FaultTolerant.class);
		//进行验证
		if( !"0".equals( fault.getUid() ) ){
			if( Auth.auth( fault ) == false ){
				result.put("code", CommonErrorEnum.FAULT_FOLERANT.getCode());
				result.put("msg", CommonErrorEnum.FAULT_FOLERANT.getMessage());
				return ReturnJSON.getInstance().ret(result);
			}
		}
		ContractVo contractVo = contractDao.getContractByNo(contractno);
		if( contractVo != null ){
			String filepath = Word.createContractDoc(contractVo);
			if( !filepath.equals("ERROR") ){
				List<Tenants> tenants = tenantsDao.findTenantsByIds(contractVo.getTenant_id()+"");
				String ret = MutinContractdocUploadSendall.execute(tenants, "合同发送", "注意查收...", filepath);
				if( StringUtils.isBlank(ret) ){
					result.put(CommonErrorEnum.CONTRACT_UPLOAD_ERROR.getCode()+"", CommonErrorEnum.CONTRACT_UPLOAD_ERROR.getMessage());
				} else {
					JSONObject retObj = JSONObject.fromObject(ret);
					JSONObject resp = (JSONObject) retObj.get("response");
					if( resp != null ){
						JSONObject info = (JSONObject) resp.get("info");
						String code = String.valueOf( info.get("code") );
						if( 100000 == Integer.parseInt(code) ){
							JSONObject content = (JSONObject) resp.get("content");
							JSONArray contlist = (JSONArray) content.get("contlist");
							JSONObject ele = (JSONObject)contlist.get(0);
							JSONObject contInfo = (JSONObject)ele.get("continfo");
							String signid = contInfo.getString("signid");
							String docid = contInfo.getString("docid");
							String ssq_email = contInfo.getString("email");
							System.out.println(signid + ":" + docid + ":" + ssq_email);
							boolean flag = contractDao.editContract(contractno, docid, signid, ssq_email);
							if( flag ){
								result.put("code", "0");
								result.put("msg", "合同上传成功");
							}
						} else {
							result.put("code", code);
							result.put("msg", "合同上传失败");
						}
						
					}
				}
			} else {
				result.put("code", CommonErrorEnum.CONTRACT_PRODUCE_ERROR.getCode()+"");
				result.put("msg", CommonErrorEnum.CONTRACT_PRODUCE_ERROR.getMessage());
			}
		} else {
			result.put("code", CommonErrorEnum.CONTRACT_IS_NOT_EXIST.getCode()+"");
			result.put("msg", CommonErrorEnum.CONTRACT_IS_NOT_EXIST.getMessage());
		}
		return ReturnJSON.getInstance().ret(result);
	}
	
	public static void main(String[] args) {
		new ContractServiceImpl().save("", "contract001000043");
	}

	
	
	public Response sign(String auth, String contractno) {
		//Map<String, Object> result = new HashMap<String, Object>();
		JSONObject result = new JSONObject();
		FaultTolerant fault = new Gson().fromJson(auth, FaultTolerant.class);
		//进行验证
		if( !"0".equals( fault.getUid() ) ){
			if( Auth.auth( fault ) == false ){
				result.put("code", CommonErrorEnum.FAULT_FOLERANT.getCode());
				result.put("msg", CommonErrorEnum.FAULT_FOLERANT.getMessage());
				return ReturnJSON.getInstance().ret(result);
			}
		}
		ContractVo contractVo = contractDao.getContractByNo(contractno);
		if( contractVo != null ){
			try {
				System.out.println("sign:"+contractVo.getSignid() + "," + contractVo.getSsq_email());
				String url = GetSignPage.excute(contractVo.getSignid(), contractVo.getSsq_email());
				result.put("url", url);
				result.put("code", "0");
				result.put("msg", "确认页面获取成功");
			} catch (IOException e) {
				result.put("code", CommonErrorEnum.CONTRACT_CONFIREM_SIGN_FAIL.getCode()+"");
				result.put("msg", CommonErrorEnum.CONTRACT_CONFIREM_SIGN_FAIL.getMessage());
				e.printStackTrace();
			}
		} else {
			result.put("code", CommonErrorEnum.CONTRACT_IS_NOT_EXIST.getCode() + "");
			result.put("msg", CommonErrorEnum.CONTRACT_IS_NOT_EXIST.getMessage());
		}
		return Response.ok()
				   .entity(result.toString())
				   .header(HttpHeaders.CONTENT_TYPE,
	                 MediaType.APPLICATION_JSON + ";charset=UTF-8").build();
	}
	
	public Response view(String auth, String contractno) {
		//Map<String, Object> result = new HashMap<String, Object>();
		JSONObject result = new JSONObject();
		FaultTolerant fault = new Gson().fromJson(auth, FaultTolerant.class);
		//进行验证
		if( !"0".equals( fault.getUid() ) ){
			if( Auth.auth( fault ) == false ){
				result.put("code", CommonErrorEnum.FAULT_FOLERANT.getCode());
				result.put("msg", CommonErrorEnum.FAULT_FOLERANT.getMessage());
				return ReturnJSON.getInstance().ret(result);
			}
		}
		ContractVo contractVo = contractDao.getContractByNo(contractno);
		if( contractVo != null ){
			try {
				String url = ViewContract.excute(contractVo.getSignid(), contractVo.getDocid());
				result.put("url", url);
				result.put("code", "0");
				result.put("msg", "合同查看页面获取成功");
			} catch (IOException e) {
				result.put("code", CommonErrorEnum.CONTRACT_VIEW_FAIL.getCode()+"");
				result.put("msg", CommonErrorEnum.CONTRACT_VIEW_FAIL.getMessage());
				e.printStackTrace();
			}
		} else {
			result.put("code", CommonErrorEnum.CONTRACT_IS_NOT_EXIST.getCode() + "");
			result.put("msg", CommonErrorEnum.CONTRACT_IS_NOT_EXIST.getMessage());
		}
		return Response.ok()
				   .entity(result.toString())
				   .header(HttpHeaders.CONTENT_TYPE,
	                 MediaType.APPLICATION_JSON + ";charset=UTF-8").build();
	}
	/*********************************************上上签,合同签署结束***************************************************/
	public static void main2(String[] args) {//Gson会对URL中的特殊字符进行解析,而JSONObject,不会
		JSONObject obj = new JSONObject();
		obj.put("url", "https://www.ssqsign.com/openpagec/getSignPagePc.json?fsid=1442720960300UKKK2&pagenum=1&signx=0.5&signy=0.3&typedevice=1&returnurl=http://www.baidu.com&email=15215731373@nomail.pvisual&mid=E0000000000000000112&sign=S4YjQ84W%2FzKHzDEM899QjC4gau%2BtDWyYMOSnTovMyHKkED6soi1onbWgjlcC50GijGIPQZikdWhLPSHvM3zUcXMq%2BqOKxivmE5O6bAsu3C2H7%2F3hto2LQvKMm4s5BoGduJsKRuO9qia954iQgXyExCqYamoLtsjYWJgbn0jAYtg%3D");
		System.out.println(obj.toString());
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("url", "https://www.ssqsign.com/openpagec/getSignPagePc.json?fsid=1442720960300UKKK2&pagenum=1&signx=0.5&signy=0.3&typedevice=1&returnurl=http://www.baidu.com&email=15215731373@nomail.pvisual&mid=E0000000000000000112&sign=S4YjQ84W%2FzKHzDEM899QjC4gau%2BtDWyYMOSnTovMyHKkED6soi1onbWgjlcC50GijGIPQZikdWhLPSHvM3zUcXMq%2BqOKxivmE5O6bAsu3C2H7%2F3hto2LQvKMm4s5BoGduJsKRuO9qia954iQgXyExCqYamoLtsjYWJgbn0jAYtg%3D");
		System.out.println(new Gson().toJson(map));
	}


	public Response getContractByTenantId(String auth, String tenantid) {
		Map<String, Object> result = new HashMap<String, Object>();
		FaultTolerant fault = new Gson().fromJson(auth, FaultTolerant.class);
		// 进行验证
		if (Auth.auth(fault) == false) {
			result.put("code", CommonErrorEnum.FAULT_FOLERANT.getCode());
			result.put("msg", CommonErrorEnum.FAULT_FOLERANT.getMessage());
			return ReturnJSON.getInstance().ret(result);
		}
		result = contractDao.getContractByTenantId(tenantid);
		return ReturnJSON.getInstance().ret(result);
	}
}
