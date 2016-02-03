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
		url:'queryRole',
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
			{field:'role_name',title:'角色名称',width:200,sortable:true},
			{field:'re',title:'操作',width:100,align:'center',
				formatter:function(value,rec,index){
					var str =  "<a style='display:'';color:green' class='04' href='javascript:void(0)' onclick='openWindow("+index+")'>修改</a>&nbsp;&nbsp;" + 
							   "<a style='display:none;color:green' class='05' href='javascript:void(0)'>修改权限</a>";
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
		ids.push(rows[i].id);
	}
	if(ids.join(',') == "")
		$.messager.alert('警告','请选中至少一条记录！','warning');
	else{
		//$.messager.alert('警告',ids,'warning');
		$.messager.confirm('警告','确认删除？',function(r){
			if(r){
				$.ajax({
					url:'deleteRole',
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

var Role = Backbone.Model.extend({
	validate: function(attrs, options) {
	    if( $.trim(attrs.role_name) == "" ){ return "角色名称不能为空..."; }
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
var role = new Role();
var winView = new WinView({model: role});

//打开添加,修改窗口
function openWindow(index){
	if( _.isNumber(index) ){//修改
		var rec = $('#test').datagrid('getRows');
		role.set( rec[Number(index)] );
		winView.model = role;
		winView.render();
		$('#w_Add').window({title:'修改信息', iconCls:'icon-save', modal: true, height: 320});
		$('#w_Add').window('open');
		return;
	}
	role.clear();
	winView.model = role;
	winView.render();
	$('#w_Add').window({title:'添加信息', iconCls:'icon-ok', modal: true, height:320});
	$('#w_Add').window('open');
}
//保存或修改操作
function save(index){
	winView.getModel();
	//console.log( role.toJSON() );
	if (!role.isValid()) {
		$.messager.alert("信息", role.validationError, "warning");
		return ;
	}
	//验证成功删除repwd属性
	var datas = role.toJSON();
    $.ajax({
    		type: "POST",
            dataType:'json',//接受数据格式
            url:'saveRole',
            data: { role: JSON.stringify(datas)},//要传递的数据
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
                		});
            		}
				}
            	else if(resp.error != "" && resp.error){
            		$.messager.alert('信息',resp.error,'info');
            	}
            }
    });
}