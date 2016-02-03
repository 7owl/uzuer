$(function(){
	//表格控件
	$('#test').datagrid({
		width:'auto',
		height:'500',
		nowrap: false,
		striped: true,
		collapsible:true,
		url:'queryUnlock',
		sortName: 'kid',
		sortOrder: 'desc',
		remoteSort: false,
		queryParams : {
			//关键字
			"queryWord" : "",
			//关键字类型
			"queryType" : ""
		},
		loadMsg : '正在加载中.....',
		idField:'id',
		frozenColumns:[[
            {field:'c',title:'全选',checkbox:true,align : 'center'}
		]],
		columns:[[
			{field:'roomid',title:'锁编号',width:80,sortable:true},
			{field:'roomSeq',title:'房源编号',width:100,sortable:true},
			{field : 'comm_address',title : '小区地址',width : 160, sortable : false}, 
			{field : 'comm_name',title : '小区名称', width : 100,sortable : false},
			{field : 'room_name',title : '房源详细地址',width : 110,sortable : false}
		]],
		pagination:true,
		pageSize : 10,//页数
		pageList : [ 10, 15 ,20,25,30 ],//每页多少条记录
		rownumbers:true,
		onLoadSuccess : function(){
		}
		
	});

});
//点击搜索
function searcher(){

	$("#test").datagrid('load',{
		//关键字内容
		"queryWord" : $('#queryWord').val(),
		//关键字类型
		"queryType" : $('#queryType').val()                                                         
	});
}

function cancel(){
	$('#w_Add').window('close');
}

function updatebuttonchage(){
	$('.button').linkbutton('enable');
}

//删除
function del(){
	var ids = [];
	var rows = $('#test').datagrid('getSelections');
	//alert(rows);
	for(var i=0;i<rows.length;i++){
		ids.push(rows[i].roomid);
	}
	if(ids.join(',') == "")
		$.messager.alert('警告','请选中至少一条记录！','warning');
	else{
		//$.messager.alert('警告',ids,'warning');
		$.messager.confirm('警告','确认删除？',function(r){
			if(r){
				$.ajax({
					url:'deleteUnlock',
		            type:'post',
		            dataType:'json',
		            data:"delIds="+ids.join(','),
		            success: function(resp){
		            	if( resp.success ){
		            		$.messager.alert('警告',resp.success,'info');
		            	} else {
		            		$.messager.alert('警告',resp.error,'info');
		            	}
		            	$("#test").datagrid("load");
		            }
				});
			}
		});
	}
}