<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@page import="com.lingtong.model.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>房源分享</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bootstrap.css">
<style>
body {
	overflow-x: hidden;
}
roomDetail


hr {
	margin-top: 2px;
	margin-bottom: 2px;
}

table#config td {
	width: 33.3%
}

table#detail td {
	width: 50%;
}
</style>
<script type="text/javascript"
	src="<%=basePath%>js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/bootstrap.js"></script>

</head>

<body> 
	<div class="container">
	  <div class="row">
	  <% System.out.println( "session de "+request.getSession().getAttribute("appimages")) ;%>
		 <div id="myCarousel" class="carousel slide" style="height:50%">
			<ol class="carousel-indicators">
			<% 
				List<Image> images = (List)request.getSession().getAttribute("appimages");
				for(int i = 0 ; i < images.size() ; i ++)
				{
					if(i == 0){
					%>
					<li data-target="#myCarousel" data-slide-to="<%= i%>" class="active" ></li>
					<% 
					}else
					{
					%>
					<li data-target="#myCarousel" data-slide-to="<%= i%>"></li>
					<%
					}
				}
				
			 %>
				 </ol>
		   <!-- 轮播(Carousel)项目 -->
			<div class="carousel-inner">
			
				<% 
				for(int i = 0 ; i < images.size() ; i ++)
				{
					//String url = images.get(i).getUrl();
					if(i == 0){
					%>
					<div class="item active">
		         				<img style="width:100%;height:100%" src="<%=images.get(i).getUrl() %>" alt="<%=i %> "  >
		      		</div>
					<% 
					}else
					{
					%>
					<div class="item">
						         <img style="width:100%;height:100%" src="<%=images.get(i).getUrl() %>" alt="<%=i %>"  >
					</div>
					<%
					}
				}
				
			 %>
				
			</div>
		   	<!-- 轮播(Carousel)导航 -->
		   		
		   	<a class="carousel-control left" href="#myCarousel"
				data-slide="prev">&lsaquo;</a>
			<a class="carousel-control right" href="#myCarousel"
				data-slide="next">&rsaquo;</a>
	     
 			</div>
		</div>
	  <div class="row">
		 <div class="span2">
			<div id="roomDetail"> 
			</div>
 		 </div>
		</div>
	 </div>
	<input type="hidden" id="roomSeq" value="${param.roomSeq}" />
	<script type="text/x-handlebars-template" id="tmp_room_detail">
		<div style="display:none">
		<img src="{{picture}}" class="img-rounded img-responsive">-->
 		</div>
		
		{{comm_name}}&nbsp;&nbsp;&nbsp;{{kind}}<br>
 		{{busiCircle}}<br>
 		{{price}}元/月
 		<table id="detail" class="table" style="margin-bottom:5px;border:0px">
 			<tr>
 				<td>类型:{{rent_type}}</td>
 				<td>朝向:{{orient}}</td>
 			</tr>
 			
 			<tr>
 				<td>楼层:{{floor}}</td>
 				<td>面积:{{size}}/平方米</td>
 			</tr>
 		</table>
 		可入住时间 {{#compare rental_start_time '==' '' }} 
					暂无该数据
					{{else}}
					{{rental_start_time}}至{{rental_end_time}}
					{{/compare}}
 		<hr style="margin:5px 0;"/>
 		房屋配置
 		<table id="config" class="table" style="margin-bottom:5px;">
 			<tr>
 				<td>
					{{#compare bed '==' 1}}
					<img src="images/app/details_page_ bed@2x.png"/>
					{{else}}
					<img src="images/app/details_page_ bed_gray@2x.png"/>
					{{/compare}}
					床</td>
 				<td>
					{{#compare wardrobe '==' 1}}
					<img src="images/app/details_page_ wardrobe@2x.png"/>
					{{else}}
					<img src="images/app/details_page_ wardrobe_gray@2x.png"/>
					{{/compare}}
					衣柜</td>
 				<td>
					{{#compare air_conditioning '==' 1}}
					<img src="images/app/details_page_air_conditioning@2x.png"/>
					{{else}}
					<img src="images/app/details_page_air_conditioning_gray@2x.png"/>
					{{/compare}}
					空调</td>
 			</tr>
 			
 			<tr>
 				<td>
					{{#compare tv '==' 1}}
					<img src="images/app/details_page_tv@2x.png"/>
					{{else}}
					<img src="images/app/details_page_tv_gray@2x.png"/>
					{{/compare}}
					电视</td>
 				<td>
					{{#compare gasstove '==' 1}}
					<img src="images/app/details_page_ gas_ranges@2x.png"/>
					{{else}}
					<img src="images/app/details_page_ gas_ranges_gray@2x.png"/>
					{{/compare}}
					燃气灶</td>
 				<td>
					{{#compare microwaveOven '==' 1}}
					<img src="images/app/details_page_ microwave_oven@2x.png"/>
					{{else}}
					<img src="images/app/details_page_ microwave_oven_gray@2x.png"/>
					{{/compare}}
					微波炉</td>
 			</tr>
 			
 			<tr>
 				<td>
					{{#compare refrigerator '==' 1}}
					<img src="images/app/details_page_ refrigerator@2x.png"/>
					{{else}}
					<img src="images/app/details_page_ refrigerator_gray@2x.png"/>
					{{/compare}}
					冰箱</td>
 				<td>
					{{#compare heater '==' 1}}
					<img src="images/app/details_page_shower@x.png"/>
					{{else}}
					<img src="images/app/details_page_shower_gray@x.png"/>
					{{/compare}}
					热水器</td>
 				<td>
					{{#compare washing '==' 1}}
					<img src="images/app/details_page_washer@2x.png"/>
					{{else}}
					<img src="images/app/details_page_washer_gray@2x.png"/>
					{{/compare}}
					洗衣机</td>
 			</tr>
 		</table>
	</script>

	<script type="text/javascript" src="<%=basePath%>js/handlebars.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/underscore.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/backbone.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/json2.js"></script>
	<script type="text/javascript"
		src="<%=basePath%>js/app/app_room_detail.js"></script>
</body>
</html>
