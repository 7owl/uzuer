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

		<title>查看管家信息</title>
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
								<option value="hm_name">
									管家名称
								</option>
							</select>
							<input id="queryWord" type="text" name="queryWord" />
							<a href="javascript:void(0)" onclick="searcher()"
								class="easyui-linkbutton" iconCls="icon-search" plain="true" style="display:'';color:green;">搜索</a>
							<a href="javascript:void(0)" onclick="openWindow()"  
    							class="easyui-linkbutton" iconCls="icon-add" plain="true" style="display:'';color:green;">添加</a>
							<a href="javascript:void(0)" onclick="del()"  
    							class="easyui-linkbutton" iconCls="icon-cut" plain="true" style="display:'';color:green;">删除</a>
						</td>
					</tr>
				</table>
			</div>
		</div>
		
		<!-- 添加,修改窗口 -->
	    <div id="w_Add" class="easyui-window" title="" iconCls="icon-save"
	    	 style="width:450px;height:200px;padding:5px;">
	    	<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;height:208px;">
	    		<form id="saveForm">
	    		</form>
	    	</div>
	    	<div region="south" border="false" style="text-align:right;margin:10px 0;">
	    		<a class="easyui-linkbutton button" iconCls="icon-ok"
						href="javascript:void(0)" onclick="save()">保存</a>
				<a class="easyui-linkbutton" iconCls="icon-cancel"
						href="javascript:void(0)" onclick="cancel()">取消</a>
	    	</div>
	    </div>
		
		<script type="text/x-handlebars-template" id="tmp_save">
      			<label for="hm_name">管家姓名</label>
    			<input type="text" name="hm_name" id="hm_name" placeholder="请输入管家名字" value="{{getValue hm_name}}"><br>
				
				<label for="hm_number">管家联系方式</label>
    			<input type="text" name="hm_number" id="hm_number" placeholder="请输入管家联系方式" value="{{getValue hm_number}}"><br>
		</script>
		<%--<s:hidden id="powermanage" value="%{#session.u.Rol_Power}"></s:hidden>
		<s:hidden id="pageid" value="05"></s:hidden>
		--%>
		<script type="text/javascript" src="<%=basePath%>js/handlebars.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/underscore.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/backbone.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/common/common.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/json2.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/system/homemaker.js"></script>
	</body>
</html>
