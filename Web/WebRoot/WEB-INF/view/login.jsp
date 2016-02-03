<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
response.setHeader("Pragma","No-cache"); 
response.setHeader("Cache-Control","no-cache"); 
response.setDateHeader("Expires", 0); 
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>xx租房登录</title>
    
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
	
	<script type="text/javascript">
		$(function(){
			$('#login').submit(function(){
				if(""==$("#username").val()){
					$.messager.alert("信息","用户名不能为空！","warning");
					return false;
				}
				else if(""==$("#password").val()){
					$.messager.alert('My Title','Here is a warning message!','warning');
					$.messager.alert("信息","密码不能为空！","warning");
					return false;
				}
				else
					return true;
			});
		});
		window.history.forward(1); 
	</script>
</head>

<body style="width:100%;heigth:100%;padding:0">
<center>
 <div class="dlpicC">
 	<form id="login" method="post" action="<%=basePath%>main">
  		<input name="username" id="username" type="text" style="margin-left:182px; margin-top:155px\9; _margin-top:155px *margin-top:155px; margin-top:152px; float:left; width:170px; height:25px; background-color:#b5d5fe; border:none;"/>
  		<input name="password" type="password" id="password" style="margin-left:-170px; margin-top:155px\9; _margin-top:155px *margin-top:155px; margin-top:197px; float:left; width:170px; height:25px; background-color:#b5d5fe;  border:none;"/>
  		<input id="IbtnEnter" type="image" style="margin-left:-170px; margin-top:260px; float:left; width:70px; height:40px;" src="img/kongbai.gif"; >
 	</form>

 </div>
 <center><div style=" color:#9e9e9e; font-size:18px; margin-bottom:20px;  "><b>XX租房————用户登录</b></div></center>
</center>
<div id="mess">
	<%--<s:property value="#session.mess" escape="false"/>
	<s:set name="mess" value="" scope="session" />
--%></div>
</body>
</html>
