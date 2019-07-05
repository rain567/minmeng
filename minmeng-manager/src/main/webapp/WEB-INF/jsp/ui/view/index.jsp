<%
/**
	列表
	2014-7-23创建@杨大江
	v1.0
*/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${title }</title>
<!-- 加载样式文件 -->
<jsp:include page="../../include/easy-ui-header.jsp"></jsp:include>
</head>
<body>
<!-- body start -->
<table id="dg" class="easyui-datagrid">
	</table>
	<div id="tb" style="padding:2px 5px;">
		<a href="javascript:reload()" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true" >刷新</a>
		<a href="javascript:edit('添加控件');" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加</a>
		<a href="javascript:addChild();" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加子控件</a>
		<a href="javascript:modi();" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">修改</a>
		<a href="javascript:items();" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">管理控件条目</a>
		<a href="javascript:remove();" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除</a>
	</div>
	
	<script type="text/javascript">

	var defaultPageSize = 15;
	var pageList = [10, 15, 20, 30];

	function edit(title,id,parentId) {
		id = id?id:"";
		var url = '${path}/ui/view/edit?id='+ id+(parentId?'&parentId='+parentId:'');
		dialog = $.dialog({
			title : title,
			content : 'url:' + encodeURI(url),
			lock : true,
			max:false,
			min:false,
			close:function(){
				reload();
			}
		}).max();
		
	}

	function reload(){
		$('#dg').datagrid('reload');
	}
	function modi(){
		var row = $('#dg').datagrid('getSelected');
		if (row){
			edit('修改控件',row.id);
		}
	}
	function addChild(){
		var row = $('#dg').datagrid('getSelected');
		if (row){
			edit('添加控件','',row.id);
		}
	}
	function items(){
		var row = $('#dg').datagrid('getSelected');
		if (row){
			window.parent.openTab(window.parent.navid,'view-item','viewId='+row.id);
		}
	}

	function remove(){

		var ss = [];
		var rows = $('#dg').datagrid('getSelections');
		for(var i=0; i<rows.length; i++){
			var row = rows[i];
			ss.push(row.id);
		}
		if(ss.length > 0)
		$.messager.confirm('提示','你确定要删除该数据么?',function(r){
		    if (r){
				// 提交URL
				var url = '${path }/ui/view/del';
				$.ajax({
					type : 'POST',
					async: false,
					dataType : 'JSON',
					url : url,
					data : {
						printMode: 'JSON',
						"ids" : ss.toString()
					},
					beforeSend : function() {
					},
					success : function(data) {
						if (data && data.success) {
							// 成功
							$('#dg').datagrid('reload');
						} else if(data.error){
							$.messager.alert('提示',data.error.message);
						}else{
							$.messager.alert('提示','删除失败!');
						}
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						alert(errorThrown);
					}
				});
		    }
		});
	}
	
	$(function(){
		
		 $('#dg').datagrid({ 
				toolbar: '#tb',
		        loadMsg:'正在加载数据......',
		        columns: [[{
		            field: 'ck',
		            checkbox:true
		        },{
		            field: 'parentName',
		            title: '上级控件',
		            sortable:true
		        },{
		            field: 'name',
		            title: '控件名称',
		            sortable:true
		        },{
		            field: 'link',
		            title: '链接地址',
		            sortable:true
		        },{
		            field: 'mode',
		            title: '类型',
		            sortable:true,
					formatter:function(value,row){
						if(value == '0')
							return '容器';
						else if(value == '1')
							return '关联分类';
						else if(value == '2')
							return '自定义内容';
						else 
							return '未设置';
					}
		        },{
		            field: 'style',
		            title: '样式',
		            sortable:true
		        },{
		            field: 'maxItems',
		            title: '最大数据条目',
		            sortable:true
		        },{
		            field: 'itemCount',
		            title: '当前控件条目总数',
		            sortable:true
		        },{
		            field: 'status',
		            title: '状态',
		            sortable:true,
					formatter:function(value,row){
						if(value == '1')
							return '启用';
						if(value == '0')
							return '未启用';
						else
							return '未设置';
					}
		        },{
		            field: 'outMode',
		            title: '输出方式',
		            sortable:true,
					formatter:function(value,row){
						if(value == 'before')
							return '靠前输出';
						if(value == 'after')
							return '靠后输出';
						else
							return '';
					}
		        },{
		            field: 'sorter',
		            title: '排序',
		            sortable:true
		        },{
		            field: 'createTime',
		            title: '发布时间',
		            sortable:true
		        },{
		            field: 'updateTime',
		            title: '修改时间',
		            sortable:true
		        }]],
		        remoteSort:false,
		        multiSort:false,
		       	rownumbers: true,
				fit: true,   //自适应大小
		        loadMsg:'正在加载数据......   ',
				striped:true,
				pagination: true,     //开启分页  
				pageSize:defaultPageSize,
		        pageList: pageList, //设置每页记录条数的列表 
		        url: '${path}/ui/view/getList', //获取数据地址
	    		queryParams:{
					pageSize:defaultPageSize,
		    	}, 
		        showFooter:true , 
				onLoadSuccess:function(){
					//onLoadSuccess();
				},
		    	loadFilter:function(data){
		    		if(!data.rows){
		    			data.rows = [];
		    		}
		    		return data;
		    	}
		 });

		 $('#dg').datagrid('getPager').pagination({ 
		    	onSelectPage:function(pageNumber, pageSize){
		            var opts = $('#dg').datagrid('options');
		            opts.pageNumber = pageNumber;
		            opts.pageSize = pageSize;
		            opts.queryParams.pageNumber = pageNumber;
		            opts.queryParams.pageSize = pageSize;
		    		defaultPageSize = pageSize;
		            $('#dg').datagrid('reload'); //重新加载表格
		    	}
			});

	});

	</script> 
	
	
</body>
</html>
