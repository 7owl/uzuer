(function(Handlebars) {
	Handlebars.registerHelper('getValue', function( value ) {
		if( !value ){
			return "";
		}
		return value;
	});
})(Handlebars);

$(function(){
	//窗口控件初始化
	$('#w_Add').window('close');
	
	//表格控件
	$('#test').datagrid({
		width:'auto',
		height:'auto',
		nowrap: false,
		striped: true,
		collapsible:true,
		url:'queryCompany',
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
            {field:'c',title:'全选',checkbox:true,align:'center'}
		]],
		columns:[[
			{field:'company_name',title:'公司名称',width:100,sortable:true},
			{field:'company_address',title:'公司地址',width:100,sortable:true},
			{field:'company_ceo',title:'公司负责人',width:100,sortable:true},
			{field:'room_number',title:'旗下房源数量',width:100,sortable:true},
			{field:'company_number',title:'公司客服电话',width:100,sortable:true},
			{field:'company_desc',title:'公司描述',width:120,sortable:true},
			{field:'re',title:'操作',width:100,align:'center',
				formatter:function(value,rec,index){
					return "<a style='display:'';color:green' class='04' href='javascript:void(0)' onclick='openWindow("+index+")'>修改</a>"
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

});

//清空
function clearup(){
	$("#rental_start_time").datebox('setValue', '');
	$("#rental_end_time").datebox('setValue', '');
} 

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
	for(var i=0;i<rows.length;i++){
		ids.push(rows[i].id);
	}
	if(ids.join(',') == "")
		$.messager.alert('警告','请选中至少一条记录！','warning');
	else{
		$.messager.confirm('警告','确认删除？',function(r){
			if(r){
				$.ajax({
					url:'deleteCompany',
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

var Company = Backbone.Model.extend({
	validate: function(attrs, options) {
	    if( $.trim(attrs.company_name) == "" ){ return "公司名称不能为空..."; }
	    
	   //if( $.trim(attrs.address) == "" ){ return "地址不能为空..."; }
	    
//	    var reg = /\d+$/;
//	    if( reg.test( attrs.price ) === false )  {    
//	        return "请输入整数的租金...";  
//	    }
//	    
//        if ( reg.test( attrs.size ) === false ) {
//           return "请输入整数的面积...";
//        }
	}
});

var WinView = Backbone.View.extend({
	el: '#saveForm',
	template: Handlebars.compile($("#tmp_save").html()),
	render: function(){
		this.$el.html( this.template( this.model.attributes ) );	
		return this;
	},
	getModel: function(){//序列化对象的值,返回model对象
		var obj = this.$el.serializeObject();
		this.model.set( obj );
		return this.model;
	}
});
var company = new Company();
var winView = new WinView({model: company});

var dateBoxOpt = {
	panelWidth:180,//弹出日期选择面板的宽度
	width: 300,
	formatter: function (date) {
		var y = date.getFullYear();
	    var m = date.getMonth() + 1;
	    var d = date.getDate();
	    return y + "-" + (m < 10 ? ("0" + m) : m) + "-" + (d < 10 ? ("0" + d) : d);
	} 
};

//打开添加,修改窗口
function openWindow(index){
	//console.log( index + ":" + _.isNumber(index) );
	
	if( _.isNumber(index) ){//修改
		var rec = $('#test').datagrid('getRows');
		company.set( rec[Number(index)] );
		winView.model = company;
		winView.render();
		//console.log( tenant.get("id") + "修改");
		$('#w_Add').window({title:'修改信息', iconCls:'icon-save', modal: true, height: 280});
		$('#w_Add').window('open');
		//日期控件初始化
		$("#rental_start_time").datebox(dateBoxOpt);
		$("#rental_end_time").datebox(dateBoxOpt);
		return;
	}
	company.clear();
	winView.model = company;
	winView.render();
	$('#w_Add').window({title:'添加信息', iconCls:'icon-ok', modal: true, height:280});
	$('#w_Add').window('open');
	//日期控件初始化
	$("#rental_start_time").datebox(dateBoxOpt);
	$("#rental_end_time").datebox(dateBoxOpt);
}
//保存或修改操作
function save(index){
	//console.log($("#rental_start_time").datebox('getValue'));
	//console.log($("#rental_end_time").datebox('getValue'));
	winView.getModel();
	console.log( company.toJSON() );
	if (!company.isValid()) {
		$.messager.alert("信息", company.validationError, "warning");
		return ;
	}
	
	//验证成功删除repwd属性
	var datas = company.toJSON();
	//var rec = $('#test').datagrid('getRows');
	//var params=$("#form_add").serialize(); //序列化表单的值
    $.ajax({
    		type: "POST",
            dataType:'json',//接受数据格式
            url:'saveCompany',
            data: { company: JSON.stringify(datas)},//要传递的数据
            success: function(resp){
            	if( resp.success != "" && resp.success ){
            		$("#test").datagrid("load");
            		if( datas.id ){
            			$.messager.confirm('信息','修改成功!是否继续？',function(r){
                			if (!r){
                				$("#w_Add").window("close");
                			}
                		});
            		} else {
            			$.messager.confirm('信息','添加成功!是否继续？',function(r){
                			if (!r){
                				$("#w_Add").window("close");
                			}
                			//clearup();
                		});
            		}
            		
				}
            	else if(resp.error != "" && resp.error){
            		$.messager.alert('信息',resp.error,'info');
            	}
            }
    });
}