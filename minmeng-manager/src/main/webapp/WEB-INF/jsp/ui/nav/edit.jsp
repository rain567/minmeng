<%
/**
	编辑导航
	2014-12-22创建@杨大江
	v1.0
*/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Live Info</title>
<!-- 加载样式文件 -->
<jsp:include page="../../include/css.jsp"></jsp:include>
<style type="text/css">
div.center form dl dd.l{width:120px}
div.center form dl dd{margin-bottom:10px;}
div.center form .text {padding:8px;border:1px solid #ccc}
div.center form dl dd a{color:#999;}
</style>
</head>
<body>
<!-- body start -->
<!-- 正文 -->
<div class="center">
	<div class="buttons">
		<div class="left">
			<a class="dialog-title">编辑导航</a>
		</div>
		<div style="float:right;margin-right:20px;margin-top:5px;">
			<a class="button refresh" corner-right="no">刷新</a>
			<a class="button" id="closeButton" border-left="no" >关闭</a>
		</div>
	</div>
	<div class="content">
		<form action="${path }/ui/nav/save" method="post" id="myForm">
			<input type="hidden" value="${id }" name="id">
			<dl>
				<dd class="l">
					<font color="red">*</font>栏目类型：
				</dd>
				<dd>
					<div style="margin-top:7px">
					<input type="radio" value="1" name="navType" 
							<c:if test="${nav.navType == '1' }">checked=checked</c:if>>文本导航
					<input type="radio" value="2" name="navType" 
							<c:if test="${nav.navType == '2' }">checked=checked</c:if>>栏目导航
					</div>
					<div class="msg tip"></div>
				</dd>
			</dl>
			<div id="text-nav">
			<dl>
				<dd class="l"><font color="red">*</font>导航名称：</dd>
				<dd>
					<input type="text" class="text short" name="name" value="${nav.name }" />
					<div class="msg tip">导航名称不能为空，通常纯中文组成。</div>
				</dd>
			</dl>
			<dl>
				<dd class="l">导航链接：</dd>
				<dd>
					<input type="text" class="text short" name="link" value="${nav.link}" />
					<div class="msg tip">请确保链接能正常访问，如果跨域链接，必须以http://或https://开头。</div>
				</dd>
			</dl>
			<dl>
				<dd class="l">导航别名：</dd>
				<dd>
					<input type="text" class="text short" name="alias" value="${nav.alias }" />
					<div class="msg tip"></div>
				</dd>
			</dl>
			</div>
			<div id="cat-nav">
			<dl>
				<dd class="l"><font color="red">*</font>栏目：</dd>
				<dd>
					<input type="hidden" name="catId" value="${cat.id }" />
					<a class="button" id="setCat">选择栏目</a>
					<div style="clear:both"></div>
					<div style='font-size:13px;padding-top:10px;color:#666'>
						<span id='catname'></span>
					</div>
				</dd>
			</dl>
			<dl>
				<dd class="l">
					<font color="red">*</font>子栏目深度：
				</dd>
				<dd>
					<input type="text" class="text short" name="subDepth" value="${nav.subDepth }" />
				</dd>
			</dl> 
			
			</div>
			<dl>
				<dd class="l">
					排序：
				</dd>
				<dd>
					<input type="text" class="text short" name="sorter" value="${nav.sorter }" />
				</dd>
			</dl> 
			<dl>
				<dd class="l">
					<font color="red">*</font>启用状态：
				</dd>
				<dd>
					<div style="margin-top:5px">
					<input type="radio" value="1" name="status" 
							<c:if test="${nav.status == 1 }">checked=checked</c:if>>启用
					<input type="radio" value="0" name="status" 
							<c:if test="${nav.status == 0 }">checked=checked</c:if>>未启用
					</div>
					<div class="msg tip"></div>
				</dd>
			</dl> 
			<dl>
				<dd class="l">&nbsp;</dd>
				<dd>
					<button type="submit" class="f-button submit"  style="margin-right:10px">保 存</button> 
					<button type="reset" class="f-button reset" >重 填</button>
				</dd>
			</dl>
		</form>
	</div>
</div>
<!-- body end -->
<jsp:include page="../../include/js.jsp"></jsp:include>
<script type="text/javascript">

	function showCatNav(){
		var navType = $.trim($('input[name="navType"]:checked').val());
		if(navType == '2'){
			// 栏目导航
			$('#cat-nav').show();
			$('#text-nav').hide();
		}else{
			$('#cat-nav').hide();
			$('#text-nav').show();
		}
	}
	showCatNav();
	$('input[name="navType"]').change(function(){
		showCatNav();
	});
	
	var dialog;
	function opdb(){		
		var url = '${path}/cat/tree?id=${id}';	
		dialog = $.dialog({ 
			id:'L1310',
			title:"选择栏目",
		    width:'400px',
		    height:'280px',
			max: false,
		    min: false,
			content: "url:"+url,
		    close: function(){ 
	        	var catId = dialog.content.document.getElementById('catId').value;
	        	var refresh = dialog.content.document.getElementById('refresh').value;
	        	if(refresh == "true"){
	            	$('input[name="catId"]').val(catId);
	            	refreshCatName();
	            	
	        	}
	        	
		    } ,
	    	lock:true
		});
	};
	$('#setCat').click(function(){
		opdb();
	});
	
	/**
	 * 刷新栏目名称
	 */
	function refreshCatName(){
		$.ajax({
	       type: "get",
	       dataType: "html", 
	       url: "${path}/cat/parents?id="+$('input[name="catId"]').val(),
	       success: function(data) { 
		     	$('#catname').html(data);
	       },
	       error: function(XMLHttpRequest, textStatus, errorThrown) {
	            alert(errorThrown);
	       }
	    });
	}
	refreshCatName();

	/** 验证识别名称 */
	$('input[name="name"]').blur(function(){
		var msg = $(this).parent().find('.msg');
		var url = '${path }/ui/nav/checkName';
		var data = {
				"moduleId":"${module.id}",
				"name":$(this).val(),
				"id":'${id}'
		};
		jqueryAjax("post","json",false,url,data,
				function(){
					msg.removeClass('success');
					msg.removeClass('error');
					msg.addClass('loading');
					msg.html("正在验证......");
				},
				function(result){
					if(result.success){
						// 成功，未注册
						msg.addClass('success');
						msg.html(result.success.message);
					}else if(result.error){
						// 失败，已注册
						msg.addClass('error'); 
						msg.html(result.error.message);
					}else{
						// 失败
						msg.addClass('error');
						msg.html("验证失败.");
					}
				});
	});

	/** 提交 */
	$('#myForm').form({
		 onSubmit:function(){
			$.dialog.tips('正在提交...',600,'loading.gif');
			return true;
		 },
		 success:function(data){
			$.dialog.tips('提交完成...',1,'success.gif');
			var listUri = '${path }/ui/nav';
			var editUri = '${path }/ui/nav/edit?id=${id}';
			var addUri = '${path }/ui/nav/edit';
			resultConfirm($.parseJSON(data),listUri,editUri,addUri,'parent');
			return false;
		 },
		 value:''
	}); 
</script>
</body>
</html>
