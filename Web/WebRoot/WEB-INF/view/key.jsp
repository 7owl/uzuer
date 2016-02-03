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

		<title>查看钥匙信息</title>
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
								<option value="room_id">
									锁编号
								</option>
								<option value="key_id">
									钥匙编号
								</option>
							</select>
							<input id="queryWord" type="text" name="queryWord" />
							<a href="javascript:void(0)" onclick="searcher()"
								class="easyui-linkbutton 05" iconCls="icon-search" plain="true" style="display:'';color:green;">搜索</a>
							<a href="javascript:void(0)" onclick="openSendWindow()"  
    							class="easyui-linkbutton 02" iconCls="icon-add" plain="true" style="display:'';color:green;">发送电子钥匙</a>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<!-- 发送电子锁 -->
	    <div id="sendKey" class="easyui-window" title="" iconCls="icon-save"
	    	 style="width:1200px;height:500px;padding:5px;">
	    	<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
	    		<table id="keyTable" toolbar="#keyTb"></table>
				<div id="keyTb" style="padding: 2px 0">
					<table cellpadding="0" cellspacing="0" style="width: 100%">
						<tr>
							<td>
								<select id="queryTypeRoom">
									<option value="">
										--请选择--
									</option>
									<option value="room.roomSeq">
										房源编号
									</option>
									<option value="room_name">
										房源名
									</option>
									<option value="comm_name">
										所在小区
									</option>
								</select>
								<input id="queryWordRoom" type="text" name="queryWordRoom" />
								<a href="javascript:void(0)" onclick="searcherRoom()"
									class="easyui-linkbutton 05" iconCls="icon-search" plain="true" style="display:'';color:green;">搜索</a>
								<a href="javascript:void(0)" onclick="delUnlock()"  
    							class="easyui-linkbutton 02" iconCls="icon-remove" plain="true" style="display:'';color:green;">删除</a>
								<label for="start_date">发送对象:</label>
								<select name="tenant_id" id="tenant_id">
								<select>
								<label for="start_date">开始时间:</label><input id="start_date" type="text" name="state_date"/>
								<label for="start_date">结束时间:</label><input id="end_date" type="text" name="end_date"/>
							</td>
						</tr>
					</table>
		    	</div>
		    	<div region="south" border="false" style="text-align:right;padding:5px 0;">
		    		<a class="easyui-linkbutton button" iconCls="icon-ok"
							href="javascript:void(0)" onclick="send()">发送</a>
					<a class="easyui-linkbutton" iconCls="icon-cancel"
							href="javascript:void(0)" onclick="cancel()">取消</a>
		    	</div>
	    	</div>
	    </div>
		
		<%--<s:hidden id="powermanage" value="%{#session.u.Rol_Power}"></s:hidden>
		<s:hidden id="pageid" value="05"></s:hidden>
		--%>
		<script type="text/javascript" src="<%=basePath%>js/handlebars.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/underscore.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/backbone.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/common/common.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/json2.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/moment.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/system/key.js"></script>
	</body>
</html>
