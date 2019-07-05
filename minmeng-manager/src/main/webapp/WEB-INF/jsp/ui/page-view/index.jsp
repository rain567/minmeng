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
<jsp:include page="../../include/easy-ui-header.jsp"></jsp:include>
<script type="text/javascript">
		
</script>
</head> 
<body>
<!-- body start -->
<!-- 正文 -->
	<div style="margin:1px">
	<table id="dg" class="easyui-datagrid" width=690>
		<thead>
			<tr>
				<th data-options="field:'id',checkbox:true"></th>
				<th data-options="field:'viewId',width:220,
							formatter:function(value,row){
								if(row.view){
									var parentName = row.view.parentName;
									return  (parentName && parentName != '' ? parentName + ' &raquo; ':'')  +  row.view.name;
								}else{
									return getViewName(value);
								}
							},
							editor:{
								type:'combotree',
								options:{
									url:'${path }/ui/view/query',
									method:'get',
									required:true
								}
							}">控件</th>
				<th data-options="field:'status',width:120,
							formatter:function(value,row){
								if(row){
									if(value == '0'){
										return '未启用';
									}else if(value == '1'){
										return '启用';
									}else{
										
									}
								}
							},
							editor:{
								type:'combobox',
								options:{
									valueField:'value',
									textField:'label',
		   							value : '1',
									data:[
										{value:'1',label:'启用'},
										{value:'0',label:'未启用'}
									],
									required:true
								}
						}">状态</th>
				<th data-options="field:'sorter',width:80,editor:{type:'numberbox',options:{precision:0,required:true}}">排序</th>
			</tr>
		</thead>
	</table>
	<div id="tb" style="height:auto;padding:5px 0 5px ">
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true" onclick="reload()">刷新</a>
		<select class="easyui-combobox" name="pageCombobox" id="pageCombobox" style="width:100px"></select>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="append()">添加</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="remove()">删除</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="reject()">撤消</a>
		
	</div>
	</div>
	
	<script type="text/javascript">
	function getViewName(id){
		var name = id;
		$.ajax({
			type : 'POST',
			dataType : 'JSON',
			url : '${path}/ui/view/get',
			async:false,
			data : {
				id : id
			},
			success : function(data) {
				if (data)
					if(data.id){
						var parentName = data.parentName;
						name = (parentName && parentName != '' ? parentName + ' &raquo; ':'') + data.name;
					}
			}
		});
		return name;
	}
	var pageName = "${pageName}";
	pageName = pageName == ''?'index':pageName;
	$("#pageCombobox").combobox({  
		   data:[
			 {value:'index',label:'首页'},
			 {value:'list',label:'列表页'},
			 {value:'detail',label:'详情页'}
			],
		   editable:true,  
		   valueField:'value',    
		   textField:'label',  
		   value : pageName,
		   onChange:function(newValue){  
			   pageName = newValue;
		       //对选中的值进行处理  
	   	    	$('#dg').datagrid('load',{
					pageName:pageName
		    	});//重新加载table 
		   }  
	});  
	/*清除数据表格中的数据*/  
	  function clearDataGrid(){ 
			//获取当前页的记录数  
			var item = $('#dg').datagrid('getRows');
			for ( var i = item.length - 1; i >= 0; i--) {
				var index = $('#dg').datagrid('getRowIndex', item[i]);
				$('#dg').datagrid('deleteRow', index);
			}
		}

		$('#dg').datagrid({
			rownumbers : true,
			iconCls : 'icon-edit',
			//singleSelect : true,
			toolbar : '#tb',
			url : '${path }/ui/page-view/getList',
			method : 'get',
			onClickCell : onClickCell,
			onEndEdit : onEndEdit,
			remoteSort : false,
			multiSort : false,
			queryParams : {
				pageName : pageName
			},
			loadFilter : function(data) {
				if (data && data != null) {
					if(data.total == 0){
						clearDataGrid();
					}else{
						var rows = [];
						$.map(data.rows, function(item) {
							if(item){
								item.stored = true;
								rows.push(item);
							}
						});
						return {total:data.total,rows:rows};
					}
				} else {
					clearDataGrid();
				}
				return {total:0,rows:[]};
			}
		});
		
		var editIndex = undefined;
		function endEditing() {
			if (editIndex == undefined) {
				return true;
			}
			if ($('#dg').datagrid('validateRow', editIndex)) {
				$('#dg').datagrid('endEdit', editIndex);
				editIndex = undefined;
				return true;
			} else {
				return false;
			}
		}
		function onClickCell(index, field) {
			if (editIndex != index) {
				if (endEditing()) {
					$('#dg').datagrid('selectRow', index).datagrid('beginEdit',
							index);
					var ed = $('#dg').datagrid('getEditor', {
						index : index,
						field : field
					});
					if (ed) {
						($(ed.target).data('textbox') ? $(ed.target).textbox(
								'textbox') : $(ed.target)).focus();
					}
					editIndex = index;
				} else {
					setTimeout(function() {
						$('#dg').datagrid('selectRow', editIndex);
					}, 0);
				}
			}
		}
		function onEndEdit(index, row) {
			var id = row.id ? row.id : (new Date()).Format("yyyyMMddhhmmss")
					+ parseInt(Math.random() * 10000 + 1);
			// 提交
			$.ajax({
				type : 'POST',
				dataType : 'JSON',
				url : '${path}/ui/page-view/save',
				data : {
					id : id,
					pageName : pageName,
					viewId : row.viewId,
					sorter : row.sorter,
					status : row.status
				},
				beforeSend : function() {
				},
				success : function(data) {
					if (data)
						if(data.row){
							// 成功		
							reload();
							
						}else if (data.success) {
							// 成功			
							$.dialog.tips(data.success.message, 1);

						} else if (data.error) {
							// 失败
							$.dialog.tips(data.error.message, 1, 'error.png');
						} else {
							$.dialog.tips('提交失败', 1, 'error.png');
						}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					alert(errorThrown);
				}
			});
		}

		function reload() {
			$('#dg').datagrid('reload');
		}
		function append() {
			if (endEditing()) {
				 $('#dg').datagrid('appendRow', {
					viewId : '',
					status : '1',
					sorter : 99
				}); 
				editIndex = $('#dg').datagrid('getRows').length - 1;
				$('#dg').datagrid('selectRow', editIndex).datagrid('beginEdit',editIndex);
			}
		}

		function removeit() {
			var arr = [];
			if (editIndex == undefined) {
				// 没有编辑
				row = $('#dg').datagrid('getSelected');
				if(row && row.id){
					arr.push(row.id);
				}
			}else{
				row = $('#dg').datagrid('getData').rows[editIndex];
		    	var stored = row.stored;
		    	if(row && stored == true){
					arr.push(row.id);
		    	}else{
					$('#dg').datagrid('cancelEdit', editIndex).datagrid('deleteRow',editIndex);
					editIndex = undefined;
		    	}
			}
	    	
	    	if(arr.length> 0){
				$.messager.confirm('提示','你确定要删除选定条目么?',function(r){
					   if (r){
					    	// 提交
							$.ajax({
								type : 'POST',
								dataType : 'JSON',
								url : '${path}/ui/page-view/del',
								data : {
									"ids" : arr.toString()
								},
								beforeSend : function() {
								},
								success : function(data) {
									if (data)
										if (data.success) {
											// 成功		
											$('#dg').datagrid('cancelEdit', editIndex).datagrid('deleteRow',editIndex);
											editIndex = undefined;	
										} else if (data.error) {
											// 失败
											$.dialog.tips(data.error.message, 1, 'error.png',
													function() {
														// 不做操作
													});
										} else {
											$.dialog.tips('提交失败', 1, 'error.png', function() {
												// 不做操作
											});
										}
								},
								error : function(XMLHttpRequest, textStatus, errorThrown) {
									alert(errorThrown);
								}
							});
					    }
					});	
	    	}
		}

		function remove() {

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
					var url = '${path }/ui/page-view/del';
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
		function accept() {
			if (endEditing()) {
				$('#dg').datagrid('acceptChanges');
			}
		}
		function reject(){
			$('#dg').datagrid('rejectChanges');
			editIndex = undefined;
		}
	</script>
</body>
</html>
