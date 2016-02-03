(function(Handlebars) {
	Handlebars.registerHelper('getValue', function( value ) {
		if( !value ){
			return "";
		}
		return value;
	});
})(Handlebars);

$(function(){
	
	$('#w_Add').window('close');
	
	//表格控件
	$('#test').datagrid({
		width:'auto',
		height:'auto',
		nowrap: false,
		striped: true,
		collapsible:true,
		url:'queryHost',
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
			{field:'username',title:'用户名',width:100,sortable:true},
			{field:'fullname',title:'全名',width:80,sortable:true,
					formatter:function(value, rec, index){
						return rec["first_name"] + rec["last_name"];
					}
			},
			{field:'id_card',title:'身份证号码',width:100,sortable:true},
			{field:'bank_card',title:'银行卡号',width:100,sortable:true},
			{field:'tel_number',title:'手机号码',width:100,sortable:true},
			{field:'email',title:'邮箱',width:100,sortable:true},
			{field:'native_place',title:'籍贯',width:100,sortable:true},
			{field:'work_unit',title:'工作单位',width:100,sortable:true},
			{field:'work_place',title:'单位地址',width:100,sortable:true},
			{field:'work_place_number',title:'单位电话号码',width:100,sortable:true},
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
					url:'deleteHost',
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

var Host = Backbone.Model.extend({
	validate: function(attrs, options) {
	    if( $.trim(attrs.username) == "" ){ return "用户名不能为空..."; }
	    
	    //if( $.trim(attrs.pwd) == "" ){ return "密码不能为空..."; }
	    
	    //if( attrs.pwd != attrs.repwd ){ return "用户密码不一致..."; }
	    
	    if( $.trim(attrs.first_name) == "" ){ return "姓氏不能为空..."; }
	    
	    if( $.trim(attrs.last_name) == "" ){ return "名字不能为空..."; }
	    
	    var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
	    if( reg.test( attrs.id_card ) === false )  {    
	        return "身份证输入不合法...";  
	    }
	    
	    reg = /^1\d{10}$/;
        if ( reg.test( attrs.tel_number ) === false ) {
           return "手机号码输入不合法...";
        }
        
        reg =  /^\d{19}$/g;
        if ( reg.test( attrs.bank_card ) === false ) {
           return "银行卡号输入不合法,应该是19为数字...";
        }
        
        reg = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/;
        if ( reg.test( attrs.email ) === false ) {
           return "电子邮箱输入不合法...";
        }
        
        reg = /^0\d{2,3}-?\d{7,8}$/;
        if( $.trim(attrs.work_unit) != "" || $.trim(attrs.work_place) != "" ){
        	if ( reg.test( attrs.work_place_number ) === false ) {
                return "单位号码输入不合法...";
            }
        }
	}
});

var WinView = Backbone.View.extend({
	el: '#saveForm',
	template: Handlebars.compile($("#tmp_save").html()),
	render: function(){
		//console.log( this.model.attributes );
		this.$el.html( this.template( this.model.attributes ) );	
		//console.log( this.$el.html() );
		return this;
	},
	getModel: function(){//序列化对象的值,返回model对象
		var obj = this.$el.serializeObject();
		//console.log(obj);
		this.model.set( obj );
		return this.model;
	}
});
var host = new Host();
var winView = new WinView({model: host});

//打开添加,修改窗口
function openWindow(index){
	//console.log( index + ":" + _.isNumber(index) );
	if( _.isNumber(index) ){//修改
		var rec = $('#test').datagrid('getRows');
		host.set( rec[Number(index)] );
		winView.model = host;
		winView.render();
		//console.log( host.get("id") + "修改");
		$('#w_Add').window({title:'修改信息', iconCls:'icon-save', modal: true, height: 400});
		$('#w_Add').window('open');
		return;
	}
	host.clear();
	winView.model = host;
	winView.render();
	$('#w_Add').window({title:'添加信息', iconCls:'icon-ok', modal: true, height:400});
	$('#w_Add').window('open');
}
//保存或修改操作
function save(index){
	
	winView.getModel();
	
	if (!host.isValid()) {
		$.messager.alert("信息", host.validationError, "warning");
		return ;
	}
	
	//验证成功删除repwd属性
	var datas = host.toJSON();
	delete datas.repwd;
	//var rec = $('#test').datagrid('getRows');
	//var params=$("#form_add").serialize(); //序列化表单的值
    $.ajax({
    		type: "POST",
            dataType:'json',//接受数据格式
            url:'saveHost',
            data: { host: JSON.stringify(datas)},//要传递的数据
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