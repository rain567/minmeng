<%
/**
	栏目
	2014-12-28创建@杨大江
*/
%> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://tag.fixwork.org/taglib/core" prefix="t" %>
<!DOCTYPE html>
<html> 
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="keywords" content="${page.keywords }">
<meta name="description" content="${page.descri }">
<title>${title }</title>
<link rel="stylesheet" href="${SITE_RESOURCE_PREFIX }/css/form.css" />
<link rel="stylesheet" href="${RESOURCE_PREFIX}/fixwork/src/button/css/default.css">
<jsp:include page="include/css.jsp"></jsp:include>
<style type="text/css">
.center dd.ll{width:80px;text-align:right}
.main-content-title .right a span{font-size:12px;padding-left:5px;padding-right:5px;padding-bottom:3px;padding-top:3px;background:#0066cc;color:#fff}
.main-content-title .right a span:hover{background:#ff6600}
</style>
</head>
<body>
<!-- body start -->
	<c:set var="urlPrefix" value="${ATTACH_PREFIX}/"></c:set>
<jsp:include page="include/top.jsp"></jsp:include>
	<div class="page-banner" style="background-image:url(${urlPrefix}${bannerData.image})"></div>
	<jsp:include page="include/searchbar.jsp"></jsp:include>
	<div class="main">
	<div class="main-content  ${page.contentStyle }">
		<div class="main-content-title">
			<div class="left">
				<span class="title">欢迎您给我们留言！</span>
			</div>
			<div class="right">
				<a href="http://www.${DEFAULT_DOMAIN }/board/"><span>留言列表</span></a>
			</div>
			<div style="clear:both"></div>
		</div>
		<div class="main-content-form center">
		<form action="${path }/board/save" method="post" id="myForm">
			<dl>
				<dd class="ll"><font color="red">*</font>标题：</dd>
				<dd>
					<input type="text" class="text long" name="title" />
					<div class="msg tip">请输入留言标题</div>
				</dd>
			</dl>
			<dl>
				<dd class="ll">内容：</dd>
				<dd>
					<textarea name="content" style="width:500px;height:80px"></textarea>
					<div class="msg tip">请详细描述您的问题，以便我们更好的为您服务！</div>
				</dd>
			</dl>
			<dl>
				<dd class="ll">
					手机号：
				</dd>
				<dd>
					<input type="text" class="text normal" name="mobile"/>	
					<div class='msg tip'>请输入有效的手机号，方便我们联系。</div>	
				</dd>
			</dl> 
			<dl>
				<dd class="ll">
					电话/传真：
				</dd>
				<dd>
					<input type="text" class="text normal" name="fax"/>	
					<div class='msg tip'>多个电话用英文逗号分隔。</div>	
				</dd>
			</dl> 
			<dl>
				<dd class="ll">
					姓名：
				</dd>
				<dd>
					<input type="text" class="text normal" name="name"/>	
					<div class='msg tip'></div>	
				</dd>
			</dl> 
			<dl>
				<dd class="ll">
					地址：
				</dd>
				<dd>
					<input type="text" class="text long" name="address"/>	
					<div class='msg tip'></div>	
				</dd>
			</dl> 
			<dl>
				<dd class="ll">&nbsp;</dd>
				<dd>
					<button type="submit" class="f-button submit" style="margin-right:10px">保 存</button> 
					<button type="reset" class="f-button reset" >重 填</button>
				</dd>
			</dl>
		</form>
		</div>
	</div>
	</div>
<jsp:include page="include/footer.jsp"></jsp:include>
<jsp:include page="include/js.jsp"></jsp:include>
<script type="text/javascript" src="${RESOURCE_PREFIX}/jquery/jquery.form.js"></script> 
<script type="text/javascript" src="${RESOURCE_PREFIX}/custom/base.js"></script>
<script type="text/javascript" src="${RESOURCE_PREFIX}/fixwork/fixwork.js"></script>
<script type="text/javascript" src="${RESOURCE_PREFIX}/lhgdialog/lhgdialog.min.js?self=true&skin=mdiscuz"></script>
<script type="text/javascript">
	$('.button').each(function(){
		$(this).button();
	});
	/** 验证标题 */
	$('input[name="title"]').blur(function(){
		var msg = $(this).parent().find('.msg');
		var url = '${path }/board/checkTitle';
		var data = {
				"title":$(this).val()
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

	/** 验证手机号 */
	$('input[name="mobile"]').blur(function(){
		var msg = $(this).parent().find('.msg');
		var url = '${path }/board/checkMobile';
		var data = {
				"mobile":$(this).val()
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
		 success:function(result){
			 if(!result || result == ''){
				 $.dialog.tips('留言失败',1,'32X32/error.png');
				 return false;
			 }
			 var data = $.parseJSON(result);
			 if(data.success){
					$.dialog.tips('留言成功提交，我们会尽快处理，感谢您的支持...',1,'success.gif');
					$('#myForm')[0].reset();
			 }else if(data.error){
					// 失败
					$.dialog.tips(data.error.message,1,'32X32/error.png');				
			 }else{
					$.dialog.tips('留言失败',1,'32X32/error.png');
			 }
			return false;
		 },
		 value:''
	}); 
</script>
</body>
</html>
