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

		<title>合同信息</title>
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
								<option value="contractno">
									合同编号
								</option>
								<option value="company_name">
									甲方
								</option>
								<option value="full_name">
									乙方
								</option>
								<option value="roomSeq">
									房源编号
								</option>
								<option value="sign_time">
									签约时间
								</option>
								<option value="end_time">
									到期时间
								</option>
							</select>
							<input id="queryWord" type="text" name="queryWord" class="selCond"/>
							<span id="sign">
								<input id="sign_time" type="text" placeholder="请选择签约时间" style="display:none;" class="selCond"/>&nbsp;&nbsp;
								<input id="end_time" type="text" placeholder="请选择到期时间" style="display:none;" class="selCond"/>
							</span>
							<a href="javascript:void(0)" onclick="searcher()"
								class="easyui-linkbutton" iconCls="icon-search" plain="true" style="display:'';color:green;">搜索</a>
						</td>
					</tr>
				</table>
			</div>
		</div>
		
		<!-- 添加,修改窗口 -->
	    <div id="w_View" class="easyui-window" title="" iconCls="icon-save"
	    	 style="width:600px;height:400px;padding:5px;">
	    	<table id="order" toolbar="#ordertb"></table>
	    </div>
		<%--<s:hidden id="powermanage" value="%{#session.u.Rol_Power}"></s:hidden>
		<s:hidden id="pageid" value="05"></s:hidden>
		--%>
		<script type="text/javascript" src="<%=basePath%>js/handlebars.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/underscore.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/backbone.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/moment.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/json2.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/system/contract.js"></script>
	</body>
</html>
