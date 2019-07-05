<%
/**
	友情链接
	@version 1.0 2014-8-27创建@杨大江
*/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${title }</title>
<!-- 加载样式文件 -->
<jsp:include page="../../include/css.jsp"></jsp:include>
<style type="text/css">
a{
	cursor:pointer;
	color:#0066cc;
}
.text.long{width:350px}
a:hover{color:#ff6600}
table.list .editrow td .text{background:#fff}
</style>
</head>
<body>
<div class="center">
	<div class="buttons">
		<div class="left">
			<a id="add"  class="button" corner-right=no>新增</a> 
			<a id="delmutil"  class="button" border-left=no corner-right=no>删除</a> 
			<a class="button refresh" border-left=no >刷新</a>
		</div>
		<div class="right"></div>
	</div>
	<div class="content">
		<table class="list">
			<tr id="header">
				<th width=30><input type="checkbox" name="picks"></th>
				<th width=200>滚动链接标题</th>
				<th>链接地址</th>
				<th width=70 align=left>排序</th>
				<th width=140></th>
			</tr>
			<c:forEach items="${list }" var="item" varStatus="status">
				<tr class="editrow">
					<td>
						<input type="checkbox" name="pick" value="${item.id }">
					</td>
					<td><input type="text" name="text" class="text long" value="${item.text }"/></td>
					<td><input type="text" name="url" class="text normal" value="${item.url }"/></td>
					<td><input type="text" name="sorter" class="text short" value="${item.sorter }"/></td>
					<td>
						<a id="modi" style="margin-right:10px">修改</a> 
						<a id="save" style="margin-right:10px">保存</a> 
						<a id="del">删除</a>
						<a id="cancel">取消</a>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>
<jsp:include page="../../include/js.jsp"></jsp:include>
<script type="text/javascript">
	var enabledel;
	var delmutilButton = getButton('delmutil');
	function setEnabel(){
		var picks = getCheckboxValues("pick");
		if(picks.length > 0){
			if(delmutilButton)
				delmutilButton.setDisable(false);
			enabledel = true;
		}else{
			if(delmutilButton)
				delmutilButton.setDisable(true);
			enabledel = false;
		}
	}
	function setPicksEvent(){
		/**
		 * 切换全选/全不选
		 */
		 $(':checkbox[name="picks"]').click(function(){
				if($(this).attr('checked') == 'checked'){
					$(':checkbox[name="pick"]').prop("checked",true);
				}else{
					$(':checkbox[name="pick"]').prop("checked",false);
				}
				tiggerdelmutil();
		 });
		$(':checkbox[name="pick"]').click(function(e){
			tiggerdelmutil();
		 }); 
	}
	function tiggerdelmutil(){
		var picks = getCheckboxValues("pick");
		if(picks.length > 0){
			if(delmutilButton)
				delmutilButton.setDisable(false);
			enabledel = true;
		}else{
			enabledel = false;
			if(delmutilButton)
				delmutilButton.setDisable(true);
		}
	}
	setPicksEvent();
	tiggerdelmutil();
	if($('#delmutil').size()>0)
	$('#delmutil').click(function(){
		if(!enabledel){
			return;
		}
		var picks = getCheckboxValues("pick");
		handle("你确定要删除选中条目么？",function(){
			// 提交URL
			var url = '${path }/setting/slide-link/del';
			var data = {
					"ids":picks.toString()
				};
			delDatas(url,data);
		},function(){
			return false;
		});
	}); 
	var url = '${path }/setting/slide-link/save';
	function save(_target){
		var id = _target.find('input[name="pick"]').size()>0?
						_target.find('input[name="pick"]').val()
						:(new Date()).Format("yyyyMMddhhmmss") +parseInt(Math.random()*10000+1);
		var text = _target.find('input[name="text"]').val();
		var siteurl = _target.find('input[name="url"]').val();
		var sorter = _target.find('input[name="sorter"]').val();
		var data = {
				'moduleId':'${module.id}',
				"id":id,
				"text":text,
				"url":siteurl,
				"sorter":sorter
		};
		var left = $(window).width() /2 - 100;
		jqueryAjax("post","json",false,url,data,
				function(){
					$.dialog.tips('正在保存...',600,'loading.gif').position(left,0);
				},
				function(data){
					if(data.success){
						$.dialog.tips("<font size=3>"+data.success.message+"</font>",2,'32X32/success.png',function(){
						}).position(left,0);
						_target.removeClass('add');
						_target.removeClass('edit');
						if(_target.find('input[name="pick"]').size() == 0){
							var _pick = $('<input type="checkbox" name="pick" value="'+id+'">');
							_target.find('td:first').append(_pick);
						}
						setRowEvent(_target);
					}else if(data.error){
						$.dialog.tips("<font size=3>"+data.error.message+"</font>",2,'32X32/error.png').position(left,0);
					}else{
						$.dialog.tips("<font size=3>保存失败</font>",2,'32X32/error.png').position(left,0);
					}
				});
		return false;
	}
	$('#add').click(function(){
		if($('table.list').find('.editrow.add').size()>0){
			var top = $(this).height() + $(this).offset().top + 2;
			var left = $(this).offset().left-2;
			$.dialog.tips('您有正在编辑的内容尚未保存。',2).position(left,top);
		}else{
			var addPanel = $('<tr class="editrow add">'+
							'<td></td>'+
							'<td><input type="text" name="text" class="text  long"/></td>'+
							'<td><input type="text" name="url" value="http://" class="text  normal"/></td>'+
							'<td><input type="text" name="sorter" class="text short"/></td>'+ 
							'<td>'+
							'<a id="modi" style="margin-right:10px">修改</a> '+
							'<a id="save" style="margin-right:10px">保存</a> '+
							'<a id="del">删除</a>'+
							'<a id="cancel">取消</a>'+
							'</td>'+
							'</tr>');
			$('table.list').find('#header').after(addPanel);
			var saveBtn = addPanel.find('#save');
			var cancelBtn = addPanel.find('#cancel');
			tiggerDCBtn(addPanel);
			saveBtn.click(function(){
				save(addPanel);
			});
			cancelBtn.click(function(){
				addPanel.remove();
			});
		}
	});
	/**
	 * 设置删除事件
	 */
	function setdel(_row,response){
		var pick = _row.find('input[name="pick"]').val();
		handle("你确定要删除选中条目么？",function(){
			// 提交URL
			var url = '${path }/setting/slide-link/del';
			var data = {"ids":pick};
			delDatas(url,data,response);
		});
	} 
	/**
	 * 设置取消事件
	 */
	function setCancel(_row){
		tiggerDCBtn(_row);
	}
	/**
	 * 判断设置事件
	 */
	function setEvents(_row){
		_row.find('#cancel').click(function(){
			_row.removeClass('edit');
			_row.removeClass('add');
			setCancel(_row);
			return false;
		});
		_row.find('#del').click(function(){
			setdel(_row,function(){
				if(_row.size()>0)
					_row.remove();
			});
			return false;
		});
		_row.find('#save').click(function(){
			save(_row);
		});
	}
	/**
	 * 更改删除、取消按钮状态及事件
	 */
	function tiggerDCBtn(_row){
		if(_row.hasClass('edit') || _row.hasClass('add')){
			_row.find('#cancel').show();
			_row.find('#save').show();
			_row.find('#del').hide();
			_row.find('#modi').hide();
		}else{
			_row.find('#cancel').hide();
			_row.find('#save').hide();
			_row.find('#del').show();
			_row.find('#modi').show();
		}
	} 
	$('table.list').find('.editrow').each(function(){
		setRowEvent($(this));
	}); 
	function setRowEvent(_row){
		tiggerDCBtn(_row);
		setEvents(_row);
		_row.click(function(e){
			if(e.target.name != 'pick' 
					&& e.target.id != 'save'  
					&& e.target.id != 'cancel' 
					&& !_row.hasClass('edit') 
					&& !_row.hasClass('add')){
				_row.addClass('edit');
				tiggerDCBtn(_row);
			}
		});
	}
</script>