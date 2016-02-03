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
    
    <title>上传成功</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/main.css" />
	<link rel="stylesheet" href="<%=basePath%>css/demo.css" type="text/css"></link>
	<link rel="stylesheet" type="text/css"
		href="<%=basePath%>css/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/icon.css">
	<script type="text/javascript"
		src="<%=basePath%>js/jquery.min.js"></script>
	<script type="text/javascript"
		src="<%=basePath%>js/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript"
		src="<%=basePath%>js/easyui/easyui-lang-zh_CN.js"></script>
</head>

<body>
	<a href="${url}">${fileName}</a>
</body>
</html>
