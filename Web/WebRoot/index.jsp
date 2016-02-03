<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <base href="<%=basePath%>">
    
    <title></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link href="<%=basePath%>css/business.css" rel="stylesheet" type="text/css" />
	
	<script type="text/javascript" src="<%=basePath%>js/jquery.min.js"></script>
  </head>
  
  <body>
  	上传测试:
	<form action="<%=basePath%>uploadImage" method="post" enctype="multipart/form-data">
		<input type="file" name="myfiles" multiple="multiple"/><br/>
		<input type="text" name="room_id" /><br/>
		<input type="submit" value="登录"/>
	</form>
	<br>
	删除图片测试:
	<form action="<%=basePath%>delImage" method="post">
		<input type="text" name="delIds" placeholder="图片id以逗号作间隔"/>
		<input type="submit" value="登录"/>
	</form>
	<br>
	根据查询测试:
	<form action="<%=basePath%>queryByRoomId" method="post">
		<input type="text" name="room_id" placeholder="请输入房源id"/><br/>
		<input type="submit" value="登录"/>
	</form>
	
	
	根据登录注册:
	<form action="<%=basePath%>services/tenant/save/" method="post">
		<input type="text" name="tel_number"/><br/>
		<input type="submit" value="登录"/>
	</form>
	
	上传图片测试:
	<form action="<%=basePath%>services/tenant/authentication/" method="post" enctype="multipart/form-data">
		<input type="file" name="imageFile" multiple="multiple"/><br/>
		<input type="text" name="tenant" /><br/>
		<input type="text" name="auth" /><br/>
		<input type="text" name="first_name" /><br/>
		<input type="submit" value="登录"/>
	</form>

	上传图片测试:
	<form action="<%=basePath%>services/tenant/authenticationtest" method="post" enctype="multipart/form-data">
		<input type="file" name="imageFile" multiple="multiple"/><br/>
		<input type="text" name="id" /><br/>
		<input type="submit" value="提交"/>
	</form>
  </body>
</html>
