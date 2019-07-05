<%
/**
	安全设置-修改密码
	2014-3-29创建@杨大江
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
<jsp:include page="../include/css.jsp"></jsp:include>
</head>
<body>

<!-- 正文 -->
<div class="center">
	<div class="content">
		<c:if test="${error !=null}">
			<div style="margin:20px;*margin:20px">
			<div style="margin-bottom:20px;font-size:14px;color:#666">${error }</div>
			<a type="submit" class="icon sendcode" href="code"><i></i><font>重新发送验证码</font></a> 
			</div>
		</c:if>
		<c:if test="${error == null }">
		<form action="${path }/safe/pass/savePass" method="post" id="myForm">
			<input type="hidden" name="mobilephone" value="${mobilephone }" />
			<input type="hidden" name="code"  value="${code }" />
			<dl>
				<dd class="l">
					<font color=red>*</font>密码：
				</dd>
				<dd>
					<input type="password" class="text normal" name="password" />
					<div class="strength">
						密码强度:<span id="text"></span>
						<div id="pwdstrong">
							<div id="strength_L">&nbsp;</div>
							<div id="strength_M">&nbsp;</div>
							<div id="strength_H">&nbsp;</div>
						</div>
					</div>
					<div class="msg tip"></div>
				</dd>
			</dl>
			<dl>
				<dd class="l">
					<font color=red>*</font>确认密码：
				</dd>
				<dd>
					<input type="password" class="text normal" name="confirmPassword" />
					<div class="msg tip"></div>
				</dd>
			</dl>
			<dl>
				<dd class="l">&nbsp;</dd>
				<dd>
					<button type="submit" class="icon icon-submit"><i></i><font>提 交</font></button> 
				</dd>
			</dl>
		</form>
		</c:if>
	</div>
</div>
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
			if(!result){
				// 失败
				$.dialog.tips('提交失败...',1,'32X32/error.png');
				return;
			}
			if(result.success){
				 // 成功
					$.dialog.tips("<font size=4>"+result.success.message+"</font>",1,'32X32/success.png');
					window.top.location.href="${path}/login";
				}else if(result.error){
					// 失败
					$.dialog.tips("<font size=4>"+result.error.message+"</font>",1,'32X32/error.png');
				}else{
					// 失败
					$.dialog.tips("<font size=4>提交失败</font>",1,'32X32/error.png');
				}				
	 }
}); 
</script>
</body>
</html>