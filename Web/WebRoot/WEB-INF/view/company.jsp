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

		<title>查看小区信息</title>
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
								<option value="company_name">
									公司名称
								</option>
								<option value="company_address">
									公司地址
								</option>
								<option value="company_ceo">
									公司负责人
								</option>
								<option value="company_number">
									公司客服电话
								</option>
								<option value="company_desc">
									公司介绍
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
	    	 style="width:450px;height:425px;padding:5px;">
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
      			<label for="company_name">公司名称</label>
    			<input type="text" name="company_name" id="company_name" placeholder="请输入公司名称" value="{{getValue company_name}}"><br>
				<br>
				<label for="company_address">公司地址</label>
    			<input type="text" name="company_address" id="company_address" placeholder="请输入公司地址" value="{{getValue company_address}}"><br>
				<br>
				<label for="company_ceo">公司负责人</label>
    			<input type="text" name="company_ceo" id="company_ceo" placeholder="请输入公司负责人" value="{{getValue company_ceo}}"><br>
				<br>
				<label for="company_number">公司客服电话</label>
    			<input type="text" name="company_number" id="company_number" placeholder="请输入公司客服电话" value="{{getValue company_number}}"><br>
				<br>
				<label for="company_desc">公司介绍</label>
    			<input type="text" name="company_desc" id="company_desc" placeholder="请输入公司介绍" value="{{getValue company_desc}}"><br>

		</script>
		<%--<s:hidden id="powermanage" value="%{#session.u.Rol_Power}"></s:hidden>
		<s:hidden id="pageid" value="05"></s:hidden>
		--%>
		<script type="text/javascript" src="<%=basePath%>js/handlebars.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/underscore.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/backbone.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/common/common.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/json2.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/system/company.js"></script>
	</body>
</html>
