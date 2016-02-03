<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

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
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bootstrap.css">
	<style>
		hr{
			margin-top:2px;
			margin-bottom:2px;
		}
		table#config td{
			width:33.3%
		}
		table#detail td{
			width:50%;
		}
		
	</style>
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/bootstrap.js"></script>

  </head>
  
  <body>
 	<div id="roomDetail">
 		
 	</div>
 	<input type="hidden" id="roomSeq" value="${param.roomSeq}"/>
 	<script type="text/x-handlebars-template" id="tmp_room_detail">
		<img src="http://7xl031.com1.z0.glb.clouddn.com/1440684070645.jpg" class="img-rounded img-responsive">
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
 		可入住时间 {{rental_start_time}}至{{rental_end_time}}
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
	<script type="text/javascript" src="<%=basePath%>js/app/app_room_detail.js"></script>
  </body>
</html>
