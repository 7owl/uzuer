var dateBoxOpt = {
	panelWidth : 180,// 弹出日期选择面板的宽度
	width : 250,
	formatter : function(date) {
		var y = date.getFullYear();
		var m = date.getMonth() + 1;
		var d = date.getDate();
		return y + "-" + (m < 10 ? ("0" + m) : m) + "-"
				+ (d < 10 ? ("0" + d) : d);
	}
};

$(function(){
	//窗口控件初始化
	$('#w_View').window('close');
	
	//表格控件
	$('#test').datagrid({
		width:'auto',
		height: 500,
		nowrap: false,
		striped: true,
		collapsible:true,
		url:'queryContract',
		sortName: 'id',
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
			{field:'contractno',title:'合同编号',width:120,sortable:true},
			{field:'company_name',title:'甲方',width:100,sortable:true},
			{field:'full_name',title:'乙方',width:80,sortable:true},
			{field:'tel_number',title:'乙方号码',width:100,sortable:true},
			{field:'roomSeq',title:'房源编号',width:100,sortable:true},
			{field:'room_address',title:'房源地址',width:300,sortable:true,
				formatter:function(value,rec,index){
					var str = rec.comm_address + "-" + rec.comm_name + "-" + rec.room_name;  
					return str;
				}
			},
			{field:'sign_time',title:'签约时间',width:120,sortable:true},
			{field:'end_time',title:'到期时间',width:120,sortable:true},
			{field:'completedState',title:'合同状态',width:80,sortable:true,
				formatter:function(value,rec,index){
					if( value == "0" ) {
						return "<span style='color:red'>未签</span>";
					} else if( value == "1" ) {
						return "<span style='color:green'>执行中</span>";
					} else if( value == "2" ) {
						return "<span style='color:yellow'>结束</span>";
					}  
				}
			},
			{field:'re',title:'操作',width:150,align:'center',
				formatter:function(value,rec,index){
					var str = "<a style='color:green' class='04' href='previewContract?id=" + rec.id + "' target='_blank'>合同预览</a>&nbsp;&nbsp;" + 
							  "<a style='color:green' class='04' href='javascript:void(0)' onclick=\"viewOrder('" + rec.id + "')\">订单详情</a>";
					return str;
				}
			}
		]],
		pagination:true,
		pageSize : 10,//页数
		pageList : [ 10, 15 ,20,25,30 ],//每页多少条记录
		rownumbers:true,
		onLoadSuccess : function(){
			//$.getScript("js/own/power.js");
		}
		
	});
	
	//表格控件
	$('#order').datagrid({
		width:'auto',
		height:'auto',
		nowrap: false,
		striped: true,
		collapsible:true,
		url:'queryOrderByContractno',
		sortName: 'id',
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
			{field:'orderno',title:'订单编号',width:100,sortable:true},
			{field:'amount',title:'订单金额',width:80,sortable:true},
			{field:'paystate',title:'订单状态',width:80,sortable:true,
				formatter:function(value,rec,index){
					if( value == "0" ) {
						return "<span style='color:red'>未支付</span>";
					} else if( value == "1" ) {
						return "<span style='color:green'>已支付</span>";
					} else if( value == "-1" ) {
						return "<span style='color:yellow'>已失效</span>";
					}  
				}
			},
			{field:'paytime',title:'付款时间',width:100,sortable:true},
			{field:'createtime',title:'签订时间',width:100,sortable:true}
		]],
		pagination:true,
		pageSize : 10,//页数
		pageList : [ 10, 15 ,20,25,30 ],//每页多少条记录
		rownumbers:true
	});
	
	//房源查询条件类型
	$("#queryType").change(function(){
		val = $(this).val();
		$(".selCond").hide();
		if( val == "sign_time" || val == "end_time" ){
			$("#sign").show();
		} else {
			$("#sign").hide();
			$("#queryWord").show();
		}
	});
	
	$("#sign_time").datebox(dateBoxOpt);
	$("#end_time").datebox(dateBoxOpt);
	$("#sign").hide();
});
//点击搜索
function searcher(){
	var type = $('#queryType').val();
	/*
		var val = "";
	 	$("select.selCond").each(function(index){
		if( $(this).is(":visible") ){
			val = $(this).val();
		}
	});*/
	if( type == "sign_time" || type == "end_time" ){
		var start = $("#sign_time").datebox('getValue');
		var end = $("#end_time").datebox('getValue');
		
		if( !moment(start).isValid() ){
			start = "0000-00-00"
		}
		
		if( !moment(end).isValid() ){
			end = "9999-12-30"
		} else {
			end = moment(end).add(1, 'days').format('YYYY-MM-DD');
		}
		$("#test").datagrid('load',{
			//关键字内容
			"queryWord" : start + "," + end,
			//关键字类型
			"queryType" : $('#queryType').val()                                                         
		});
		return ;
	}
	$("#test").datagrid('load',{
		//关键字内容
		"queryWord" : $('#queryWord').val() + '',
		//关键字类型
		"queryType" : $('#queryType').val()                                                         
	});
}

//打开添加,修改窗口
function viewOrder(id){
	$('#w_View').window({title:'订单信息', iconCls:'icon-ok', modal: true, height:400});
	$('#w_View').window('open');
	
	$("#order").datagrid('load',{
		"contractno" : id                                                         
	});
}