<%
/**
	单页
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
<title>Indexed </title>
<!-- 加载样式文件 -->
<jsp:include page="../include/css.jsp"></jsp:include>
<style type="text/css">
div.center form dl dd.l{width:60px}
div.center form dl dd{margin-bottom:10px;}
div.center form .text {padding:8px;border:1px solid #ccc}
</style>
</head>
<body>
<!-- body start -->
<!-- 正文 -->
<div class="center">
	<div class="content">
		<form action="${path }/setting/indexed-all" method="post" id="myForm">
			<dl>
				<dd class="l"></dd>
				<dd>
					<div class="tip">
					此功能为提供前端模糊搜索功能创建列表或商品类栏目索引。
					</div>
				</dd>
			</dl>	
			<dl>
				<dd class="l">&nbsp;</dd>
				<dd>
					<button type="submit" class="f-button submit" style="margin-right:10px">创建全站索引</button> 
				</dd>
			</dl>
		</form>
	</div>
</div>
<!-- body end -->
<jsp:include page="../include/js.jsp"></jsp:include>
<script type="text/javascript">

	/** 提交 */
	$('#myForm').form({
		 onSubmit:function(){
			$.dialog.tips('正在提交...',600,'loading.gif');
			return true;
		 },
		 success:function(data){
			var result = $.parseJSON(data);
			if (!result) {
				// 失败
				$.dialog.tips('提交失败...', 1, 'error.gif');
				return;
			}
			if (result.success) {
				// 成功
				$.dialog.tips(result.success.message, 1, '32X32/success.png');
			} else if (result.error) {
				// 失败
				$.dialog.tips(result.error.message, 1, 'error.gif');
			} else {
				// 失败
				$.dialog.tips('提交失败...', 1, 'error.gif');
			}
			return false;
		},
		value : ''
	});
</script>
</body>
</html>
