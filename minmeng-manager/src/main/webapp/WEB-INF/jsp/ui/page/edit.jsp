<%
/**
	编辑
	2014-12-23创建@杨大江
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
div.center form .text {padding:8px;border:1px solid #ababab}
</style>
</head>
<body>
<!-- body start -->
<!-- 正文 -->
<div class="center">
	<div class="buttons">
		<div class="left">
			<a class="dialog-title">编辑页面</a>
		</div>
		<div style="float:right;margin-right:20px;margin-top:5px;">
			<a class="button refresh" corner-right="no">刷新</a>
			<a class="button" id="closeButton" border-left="no" >关闭</a>
		</div>
	</div>
	<div class="content">
		<form action="${path }/ui/page/save" method="post" id="myForm">
			<input type="hidden" name="id" value="${id }">
			<dl>
				<dd class="l"><font color="red">*</font>页面类型：</dd>
				<dd>
					<input type="hidden" name="name" value="${page.name }"/>
					<div style="clear:both"></div>
					<div class="msg tip"></div>
				</dd>
			</dl>
			<dl>
				<dd class="l">页面标题：</dd>
				<dd>
					<input type="text" class="text long" name="title" value="${page.title }" />
					<div class="msg tip">设置页面标题，将显示在浏览器标题栏，如果设置将覆盖默认设置，示例：float-left red-border。</div>
				</dd>
			</dl>
			<dl>
				<dd class="l">关键字：</dd>
				<dd>
					<input type="text" class="text long" name="keywords" value="${page.keywords }" />
					<div class="msg tip">设置页面SEO关键词，将会覆盖默认设置关键词设置。</div>
				</dd>
			</dl>
			<dl>
				<dd class="l">页面说明：</dd>
				<dd>
					<input type="text" class="text long" name="descri" value="${page.descri }" />
					<div class="msg tip">设置页面SEO页说明“description"，将会覆盖默认设置描述设置。</div>
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
	
	$('input[name="name"]').combox({
		width:200,
		labelShowChange:true,
		label:'请选择页面',
		value:'${page.name }',
		onChange:function(data){
		},
		source:$.parseJSON('${PAGE_NAMES}')
	});


	/** 提交 */
	$('#myForm').form({
		 onSubmit:function(){
			$.dialog.tips('正在提交...',600,'loading.gif');
			return true;
		 },
		 success:function(data){
			$.dialog.tips('提交完成...',1,'success.gif');
			var listUri = '${path }/ui/page/';
			var editUri = '${path }/ui/page/edit?id=${id}';
			var addUri = '${path }/ui/page/edit';
			resultConfirm($.parseJSON(data),listUri,editUri,addUri,'parent');
			return false;
		 },
		 value:''
	}); 
</script>
</body>
</html>
