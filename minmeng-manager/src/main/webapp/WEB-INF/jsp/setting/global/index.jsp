<%
/**
	编辑
	2014-7-23创建@杨大江
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
			<a class="dialog-title">全局设置</a>
		</div>
		<div style="float:right;margin-right:20px;margin-top:5px;">
			<a class="button refresh" >刷新</a>
		</div>
	</div>
	<div class="content">
		<form action="${path }/setting/global/save" method="post" id="myForm">
			<dl>
				<dd class="l">网站名称：</dd>
				<dd>
					<input type="text" class="text long" name="siteName" value="${siteName }" />
					<div class="msg tip"></div>
				</dd>
			</dl>
			<dl>
				<dd class="l">
					网站邮箱：
				</dd>
				<dd>
					<input type="text" class="text normal" name="siteEmail" value="${siteEmail }" />
					<div class="msg tip"></div>
				</dd>
			</dl> 
			<dl>
				<dd class="l">
					网站电话：
				</dd>
				<dd>
					<input type="text" class="text normal" name="sitePhone" value="${sitePhone }" />
					<div class="msg tip"></div>
				</dd>
			</dl> 
			<dl>
				<dd class="l">
					技术支持：
				</dd>
				<dd>
					<input type="text" class="text normal" name="development" value="${development }" />
					<div class="msg tip"></div>
				</dd>
			</dl> 
			<dl>
				<dd class="l">
					备案信息：
				</dd>
				<dd>
					<input type="text" class="text normal" name="icp" value="${icp }" />
					<div class="msg tip">示例：黔ICP备14000123号</div>
				</dd>
			</dl> 
			<dl>
				<dd class="l">
					公安备案：
				</dd>
				<dd>
					<input type="text" class="text normal" name="icpGongan" value="${icpGongan }" />
					<div class="msg tip"></div>
				</dd>
			</dl> 
			<dl>
				<dd class="l">页脚内容：</dd>
				<dd class="c">
					<textarea name="footerHtml" style="width:680px;height:180px">${footerHtml }</textarea>
					<div class="msg tip">可以插入HTML标签，以及JS脚本。</div>
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

/* KindEditor.ready(function(K) {
	var textarea = $('textarea[name="footerHtml"]');
	var width = textarea.parents('form').width() - (textarea.offset().left - textarea.parents('form').offset().left )- $('dd.l').width();
	K.create('textarea[name="footerHtml"]', {
		uploadJson : '${path}/uploadJson',
		fileManagerJson : '${path}/fileManagerJson',
		allowFileManager : true,
		width:width+15,
		items : [
			 		'source', 
			 		'formatcomponent', 'fontname', 'fontsize', 'justifyleft', 'justifycenter', 'justifyright','|', 'forecolor', 'hilitecolor', 'bold',
			 		'italic', 'underline', 'strikethrough', 'lineheight', 'removeformat'
			 	],
		urlType : 'domain'
	});
}); */

/** 提交 */
$('#myForm').form({
	 onSubmit:function(){
		$.dialog.tips('正在提交...',600,'loading.gif');
		return true;
	 },
	 success:function(data){
		$.dialog.tips('提交完成,刷新页面...',1,'success.gif',function(){
			window.location.reload(true);
		});
		return false;
	 },
	 value:''
}); 
</script>
</body>
</html>
