<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
        
    <title>xx租房</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
	<link type="text/css" href="<%=basePath%>css/index.css" rel="Stylesheet" />
 	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/icon.css">
	<script type="text/javascript" src="<%=basePath%>js/easyui/jquery-1.4.4.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui/easyui-lang-zh_CN.js"></script>
	
	
</head>
<body class="easyui-layout">
	<div id="mm" class="easyui-menu" style="width:150px;display: none;">  
		<div id="mm-tabclose" >关闭</div>  
		<div id="mm-tabcloseall">关闭全部</div>  
		<div id="mm-tabcloseother" >关闭其他</div>  
		<div class="menu-sep" ></div>  
		<div id="mm-tabcloseright" >关闭右侧标签</div>  
		<div id="mm-tabcloseleft" >关闭左侧标签</div>  
	</div>
	
	<div region="north" split="true" style="height:78px;padding:0px; background-image:url(images/lstopbg_02.gif);">
		<div style="width:100%; height:70px;">
			<div style="height:37px; width:202px;float:left;margin-left:20px;margin-top:28px;" ></div>
			<div style="float:left; padding-top:25px; padding-left:20px;">
				<div style="padding:10px;width:600px;" id="myMenus">
				
				</div>
		    </div>
	    	<div style="padding-top:8px; padding-right:15px; float:right; ">
	    		姓名:
	    		<a href="<%=basePath %>login" class="easyui-linkbutton" plain="true">退出</a>
	    	</div>
			<%--<div id="mm1" style="width:150px;">
				<div id="01" class="removediv" onclick="addTab('待售球员信息','common/player!skip.action')" title="待售球员信息" >待售球员信息</div>
			</div>
			<div id="mm2" style="width:150px;">
				<div id="02" class="removediv" onclick="addTab('用户管理','system/user!skip.action')" title="用户管理" >用户管理</div>
				<div id="03" class="removediv" onclick="addTab('角色管理','system/role!skip.action')" title="角色管理" >角色管理</div>
			</div>
			<div id="mm3" style="width:150px;">
				<div id="12" class="removediv" onclick="addTab('俱乐部管理','common/club!skip.action')" title="俱乐部管理" >俱乐部管理</div>
			</div>
			<div id="mm4" style="width:150px;">
				<div id="14" class="removediv" onclick="addTab('球员管理','common/player!skip1.action')" title="球员管理">球员管理</div>
			</div>
		--%></div>
	</div>
	<div region="center" style="overflow:hidden;">
		<div class="easyui-tabs" fit="true" border="false"  id="main">
			<div title="首页" icon="icon-reload" style="overflow:hidden;padding:5px;">
	        	<div style="width:700px;margin:0 auto;">
				</div>		
	        </div>
	    </div>
	</div>
	<%--<s:hidden id="powermanage" value="%{#session.u.Rol_Power}"></s:hidden>
	    <s:hidden id="pageid" value="20"></s:hidden>
	--%>
	<script type="text/x-handlebars-template" id="tmp_menu">
		{{#each menus}}
		<a href="javascript:void(0)" id="{{id}}" class="easyui-menubutton" menu="{{menu}}">{{text}}</a>
		{{/each}}
	</script>
	
	<script type="text/x-handlebars-template" id="tmp_menu_item">
		{{#each menus}}
		<div id="{{updateMenu menu}}" style="width:150px;">
			{{#each children}}
			<div id="{{id}}" class="removediv" onclick="addTab('{{tab}}','{{url}}')" title="{{title}}" >{{text}}</div>
			{{/each}}
		</div>
		{{/each}}
	</script>
	<script type="text/javascript" src="<%=basePath%>js/handlebars.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/underscore.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/backbone.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/system/main.js"></script>
	
</body>
</html>