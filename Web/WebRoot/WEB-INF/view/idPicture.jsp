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
		<title>身份认证图片</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">

		<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bootstrap.css">
		<script type="text/javascript" src="<%=basePath%>js/jquery-1.11.3.min.js"></script>
 		<script type="text/javascript" src="<%=basePath%>js/bootstrap.js"></script>
 		<script type="text/javascript" src="<%=basePath%>js/system/idPicture.js"></script>
	</head>

	<body>
		<div id="myCarousel" class="carousel slide">
			<ol class="carousel-indicators">
				<c:forEach items="${idPictures}" varStatus="status">
					<c:choose>
	                	<c:when test="${status.index == 0}">
							<li data-target="#myCarousel" data-slide-to="${status.index}" class="active"></li>
						</c:when>
						<c:otherwise>
							<li data-target="#myCarousel" data-slide-to="${status.index}"></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
		    </ol>
		   
		   <!-- 轮播(Carousel)项目 -->
			<div class="carousel-inner">
				<c:forEach items="${idPictures}" varStatus="status" var="url">
					<c:choose>
	                	<c:when test="${status.index == 0}">
							<div class="item active">
		         				<img style="width:100%;height:100%" src="${url}" alt="${status.index}">
		      				</div>
						</c:when>
						<c:otherwise>
							 <div class="item">
						         <img style="width:100%;height:100%" src="${url}" alt="${status.index}">
						      </div>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</div>
		   	<!-- 轮播(Carousel)导航 -->
		   		
		   	<a class="carousel-control left" href="#myCarousel"
				data-slide="prev">&lsaquo;</a>
			<a class="carousel-control right" href="#myCarousel"
				data-slide="next">&rsaquo;</a>
	     
 		</div>
	</body>
</html>
