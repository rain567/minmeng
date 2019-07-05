<%
/**
	系统管理员登录
	2014-3-30创建@杨大江
*/
%> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>管理员登录</title>
<link rel="icon" href="${favicon}" type="image/x-icon"/> 
<link rel="shortcut icon" href="${favicon}" type="image/vnd.microsoft.icon">
<link rel="icon" href="${favicon}" type="image/vnd.microsoft.icon">
<!-- 加载样式文件 -->
<link rel="stylesheet" href="${SITE_STYLE_PREFIX }/login.css" rel="stylesheet"/>
</head>
<body>
<!-- body start --> 
	<div id="top">
		<div class="main">
		 <a class="logo" href="http://www.mmgzsw.org.cn//">${SITENAME_ADMIN }</a>
		 
		</div>
	</div>
	<div id="center">
		
		<div class="main">
		
		<div id="login">
			<div style="clear:both"></div>
			<div id="contents">
				<div class="content" style="display:block">
					<form action="${path }/login?method=submit" method="post" id="myForm" target=_top>
						<input type="hidden" value="${id }" name="id"> 
						<dl>
							<dd class="l">
								<div class="left">登录名：</div>
							</dd>
							<dd>
								<input type="text" class="text long" name="username" value="${username }" tabindex="1"/>
								<div class="msg"></div>
							</dd>
						</dl>
						<dl>
							<dd class="l">
								<div class="left">登录密码：</div>
								<div class="right"><a href="${path }/forget">忘记密码&gt;&gt;</a></div>
							</dd>
							<dd>
								<input type="password" class="text password" name="password" tabindex="2"/>
								<div class="msg"></div>
							</dd>
						</dl>	
					    <dl>
							<dd class="l">
								<div class="left">验证码：</div>
							</dd>
							<dd>
								<span style="float:left;">
									<input type="text" name="code" class="text short" tabindex="3" > 	
								</span>		
								<span style="float:left;margin-left:10px">
									<img id="imgobj" alt="点击更换验证码" style="cursor:pointer" src="${path }/show-identify-code"/> 
								</span>	
								<span style="float:left;margin-left:10px">
									<a  style="cursor:pointer" id="identify-code-change">换一张</a>
								</span>	
							</dd>
						</dl>						
						<dl>
							<dd class="l">&nbsp;</dd>
							<dd>
								<button type="submit" tabindex="3" class="submit">登录</button>
							</dd>
						</dl>
					</form>			
				</div>
			</div>
		</div>
		</div>
	
	</div>
	<div style="clear:both"></div>
	<div id="footer">
		${SITENAME_EDIT } ${VERSION} &copy 2014-4 
	</div>


<!-- body end -->
<script type="text/javascript" src="${RESOURCE_PREFIX}/jquery/jquery.js"></script> 
<script type="text/javascript" src="${RESOURCE_PREFIX}/jquery/jquery.form.js"></script> 
<script type="text/javascript" src="${RESOURCE_PREFIX}/lhgdialog/lhgdialog.js?self=true&skin=discuz"></script>
<script type="text/javascript">

//时间戳
//为了使每次生成图片不一致，即不让浏览器读缓存，所以需要加上时间戳
function chgUrl(url){   
 var timestamp = (new Date()).valueOf();  
 url = url.indexOf("?")!=-1?url.substring(0,url.indexOf("?")):url;
 url = url + '?timestamp=' + timestamp;  
 return url;   
}   
function changeImg(){   
 var imgSrc = $("#imgobj");   
 var src = imgSrc.attr("src");   
 imgSrc.attr("src",chgUrl(src));   
}   
$("#imgobj").click(function(){
	changeImg();
});
$("#identify-code-change").click(function(){
	changeImg();
});

$(function(){
	if($('#myForm input[name="username"]').val() == ''){
		$('#myForm input[name="username"]').val('用户名/手机号');
	}
	$('#myForm input[name="username"]').live("focus",function(){ 
		$(this).addClass('focus');
		if($(this).val().indexOf('用户')!=-1 || $(this).val().indexOf('手机')!=-1 ){
			$(this).val('');
		}
		$(this).one("blur",function(){	
			$(this).removeClass('focus');
			if($.trim($(this).val()) == ''){
				$(this).val('用户名/手机号');
			}
		});	
	});
	$('#myForm').form({
		 onSubmit:function(){
			$.dialog.tips('数据加载中...',600,'loading.gif');
			return true;
		 },
		 success:function(result){
			 var data = $.parseJSON(result);
			 if(data.success){
					// 成功			
					$.dialog.tips(data.success.message,1,'32X32/success.png',function(){
						// 刷新界面
						window.top.location.href="${path}/";
					});
				
			 }else if(data.error){
					// 失败
					$.dialog.tips(data.error.message,1,'32X32/error.png',function(){
						// 不做操作
					});				
			 }else{
					$.dialog.tips('提交失败',1,'32X32/error.png',function(){
						// 不做操作
					});
			 }
		 }
	}); 
});
</script>
</body>
</html>
