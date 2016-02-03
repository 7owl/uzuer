<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>查看房东信息</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link type="text/css" href="<%=basePath%>css/index.css" rel="Stylesheet" />
	 	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/default/easyui.css">
		<link rel="stylesheet" type="text/css" href="<%=basePath%>css/icon.css">
		
		<script type="text/javascript" src="<%=basePath%>js/easyui/jquery-1.4.4.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/easyui/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/easyui/easyui-lang-zh_CN.js"></script>
	</head>

	<body>
		<div>
			<table id="test" toolbar="#tb"></table>
			<div id="tb" style="padding: 2px 0">
				<table cellpadding="0" cellspacing="0" style="width: 100%">
					<tr>
						<td>
							<select id="queryType">
								<option value="">
									--请选择--
								</option>
								<option value="username">
									用户名
								</option>
								<option value="full_name">
									姓名
								</option>
							</select>
							<input id="queryWord" type="text" name="queryWord" />
							<a href="javascript:void(0)" onclick="searcher()"
								class="easyui-linkbutton 05" iconCls="icon-search" plain="true" style="display:'';color:green;">搜索</a>
							<a href="javascript:void(0)" onclick="openWindow()"  
    							class="easyui-linkbutton 02" iconCls="icon-add" plain="true" style="display:'';color:green;">添加</a>
							<a href="javascript:void(0)" onclick="del()"  
    							class="easyui-linkbutton 03" iconCls="icon-cut" plain="true" style="display:'';color:green;">删除</a>
						</td>
					</tr>
				</table>
			</div>
		</div>
		
		<!-- 添加,修改窗口 -->
	    <div id="w_Add" class="easyui-window" title="" iconCls="icon-save"
	    	 style="width:450px;height:330px;padding:5px;">
	    	<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
	    		<form id="saveForm">
	    		</form>
	    	</div>
	    	<div region="south" border="false" style="text-align:right;padding:5px 0;">
	    		<a class="easyui-linkbutton button" iconCls="icon-ok"
						href="javascript:void(0)" onclick="save()">保存</a>
				<a class="easyui-linkbutton" iconCls="icon-cancel"
						href="javascript:void(0)" onclick="cancel()">取消</a>
	    	</div>
	    </div>
		
		<script type="text/x-handlebars-template" id="tmp_save">
      			<label for="username">用户名</label>
    			<input type="text" name="username" id="username" placeholder="请输入名称" value="{{getValue username}}"><br>
				
				<label for="repwd">姓氏</label>
    			<input type="text" name="first_name" id="first_name" placeholder="请输入姓氏" value="{{getValue first_name}}"><br>

				<label for="last_name">名字</label>
    			<input type="text" name="last_name" id="last_name" placeholder="请输入名字" value="{{getValue last_name}}"><br>
				
				<label for="id_card">身份证号</label>
    			<input type="text" name="id_card" id="id_card" placeholder="请输入身份证号" value="{{getValue id_card}}"><br>

				<label for="bank_card">银行卡号</label>
    			<input type="text" name="bank_card" id="bank_card" placeholder="请输入银行号" value="{{getValue bank_card}}"><br>
					
				<label for="tel_number">手机号码</label>
    			<input type="text" name="tel_number" id="tel_number" placeholder="请输入手机号码" value="{{getValue tel_number}}"><br>

				<label for="email">电子邮箱</label>
    			<input type="text" name="email" id="email" placeholder="请输入电子邮箱" value="{{getValue email}}"><br>

				<label for="native_place">籍贯</label>
    			<input type="text" name="native_place" id="native_place" placeholder="请输入籍贯" value="{{getValue native_place}}"><br>

				<label for="work_unit">单位名称</label>
    			<input type="text" name="work_unit" id="work_unit" placeholder="请输入工作单位名称" value="{{getValue work_unit}}"><br>

				<label for="work_place">单位地址</label>
    			<input type="text" name="work_place" id="work_place" placeholder="请输入工作单位地址" value="{{getValue work_place}}"><br>

				<label for="work_place_number">单位电话号码</label>
    			<input type="text" name="work_place_number" id="work_place_number" placeholder="请输入工作单位电话号码" value="{{getValue work_place_number}}"><br>				
		</script>
		<%--<s:hidden id="powermanage" value="%{#session.u.Rol_Power}"></s:hidden>
		<s:hidden id="pageid" value="05"></s:hidden>
		--%>
		<script type="text/javascript" src="<%=basePath%>js/handlebars.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/underscore.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/backbone.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/common/common.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/json2.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/system/host.js"></script>
	</body>
</html>
