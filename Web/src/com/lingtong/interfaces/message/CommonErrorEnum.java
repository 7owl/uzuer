package com.lingtong.interfaces.message;

/**
 * @author xqq
 * @date 2015-8-13 下午8:27:47
 * 
 */
public enum CommonErrorEnum implements ErrorEnum {
	EDIT_INFO_NULL(10000, "房客修改信息为空"),
	
	
	EDIT_INFO_FORMAT_FAULT(10001, "房客修改信息字段格式不对"),
	
	EDIT_INFO_FAIL(10002, "房客信息修改失败"),
	
	TENANT_IS_NOT_EXIST(10003, "房客不存在"),
	
	TENANT_CELL_IS_NULL(10003, "用户名不能为空"),

	FAULT_FOLERANT(10101, "token验证失败,请重新登录"),
	
	REQUEST_SMS_CODE_OUT_FALI(10201, "对不起,您登录过于频繁,请稍后再试"),
	REQUEST_SMS_CODE_IN_FALI(10202, "获取验证码失败,内部程序出错"),
	LOGIN_FALI(10203, "登录失败"),
	
	ROOM_IS_NOT_EXIST(10301, "房源不存在"),
	
	COMPLAINT_INSERT_FAIL(10301, "抱怨生成失败"),
	
	TENANTMAIL_NEED_ACTIVE(10401,"请登录邮箱校验完成修改设置"),
	TENANTMAIL_ACTIVE_FAIL(10402,"邮箱验证操作状态更新异常"),
	COMPLAINT_IS_NULL(10301, "抱怨信息不能为空"),
	
	IDAUTH_PICUPLOAD_FAIL(10501,"认证图片上传失败"),
	IDAUTH_INFOLOAD_FAIL(10502,"认证信息上传失败"),
	
	CONTRACT_NO_IS_NULL(10601, "合同编号为空"),
	CONTRACT_IS_NOT_EXIST(10602, "合同不存在"),
	CONTRACT_PRODUCE_ERROR(10603, "合同文件生成失败"),
	CONTRACT_UPLOAD_ERROR(10604, "合同文件上传失败"),
	CONTRACT_CONFIREM_SIGN_FAIL(10605, "确认页面获取失败"),
	CONTRACT_VIEW_FAIL(10605, "查看页面获取失败"),
	CONTRACT_VALIDATE_ERROR(10606,"用户未通过实名认证请先认证"),
	CONTRACT_FULLNAMEVALIDATE_ERROR(10607,"用户名为空，请先编辑用户信息"),
	UNLOCK_CREATE_FAIL(10700, "锁创建失败"),
	UNLOCK_AUTH_FAIL(10701, "锁认证失败")
	;
	
	
	
	private Integer code;
	private String message;
	
	private CommonErrorEnum(Integer code, String message){
		this.code = code;
		this.message = message;
	}
	public Integer getCode() {
		return code;
	}

	public String getMessage() {
		return message;
	}

}
