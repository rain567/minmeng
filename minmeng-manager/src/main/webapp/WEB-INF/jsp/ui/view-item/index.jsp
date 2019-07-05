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
		<a href="javascript:edit('添加控件条目');" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加</a>
		<a href="javascript:modi();" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">修改</a>
		<a href="javascript:remove();" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除</a>
		<a href="javascript:viewContent();" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">查看内容</a>
	</div>
	
	<script type="text/javascript">

	var viewId = '${view.id}';
	var defaultPageSize = 15;
	var pageList = [10, 15, 20, 30];

	function edit(title,id) {
		id = id?id:"";
		var url = '${path}/ui/view-item/edit?id='+ id+'&viewId=${view.id}';
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
			edit('修改控件条目',row.id);
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
				var url = '${path }/ui/view-item/del';
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

	function viewContent(id){
		var row = $('#dg').datagrid('getSelected');
		if (row){
			$.dialog({
				content: 'url:${path}/ui/view-item/content?id='+row.id,
				resize: true,
			});
		}
	}
	
	$(function(){
		
		 $('#dg').datagrid({ 
				toolbar: '#tb',
		        loadMsg:'正在加载数据......',
		        columns: [[{
		            field: 'ck',
		            checkbox:true
		        },{
		            field: 'viewName',
		            title: '控件名称',
		            sortable:true
		        },{
		            field: 'catName',
		            title: '分类名称',
		            sortable:true
		        },{
		            field: 'link',
		            title: '链接地址',
		            sortable:true
		        },{
		            field: 'image',
		            title: '图片',
					formatter:function(value,row){
						if(value && value != '' && value.length > 0){
							return '<img src="${ATTACH_PREFIX}/'+value+'"  border=0 width="22" height="22"/>';
						}else{
							return '<span></span>';
						}
					}
		        },{
		            field: 'target',
		            title: '打开目标',
		            sortable:true,
					formatter:function(value,row){
						if(value == '_blank')
							return '新窗口';
						else if(value == '_parent')
							return '父窗体';
						else if(value == '_self')
							return '当前窗体';
						else if(value == '_top')
							return '顶部窗体';
						else  
							return '';
					}
		        },{
		            field: 'ad',
		            title: '是否为广告',
		            sortable:true,
					formatter:function(value,row){
						if(value == true)
							return '是';
						else if(value == false)
							return '否';
						else
							return '';
					}
		        },{
		            field: 'price',
		            title: '价格',
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
		            field: 'effectTime',
		            title: '生效时间',
		            sortable:true
		        },{
		            field: 'expireTime',
		            title: '过期时间',
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
		        url: '${path}/ui/view-item/getList', //获取数据地址
	    		queryParams:{
					pageSize:defaultPageSize,
					viewId:viewId
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
