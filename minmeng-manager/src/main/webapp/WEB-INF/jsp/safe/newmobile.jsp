<%
/**
	安全设置-发送验证码
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
		<form action="${path }/safe/mobile/saveNewMobile" method="post" id="myForm">
			<input type="hidden" name="bindCode" value="${bindCode }"/>
			<input type="hidden" name="bindMobile" value="${bindMobile }"/>
			<dl>
				<dd class="l">
					<font color=red>*</font>新手机号：
				</dd>
				<dd>
					<input type="text" class="text normal" name="mobile"/>
					<button type="button" id="sendcode" class="icon sendcode"> 发送短信验证码 </button>
					<div class="tip">手机号(用于找回密码).</div>
					<div class="msg tip"></div>
				</dd>
			</dl>
			<br><br>
			<br><br>
			<br><br>
			<dl>
				<dd class="l">短信验证码：</dd>
				<dd>
					<input type="text" class="text short" name="code"  />
					<div class="tip">请填写手机收到的短信验证码.</div>
					<div class="msg tip"></div>
				</dd>
			</dl>
			<br><br>
			<br><br>
			<br><br>
			<dl>
				<dd class="l">&nbsp;</dd>
				<dd>
					<button type="submit" class="icon icon-submit"><i></i><font>提 交</font></button> 
				</dd>
			</dl>
		</form>
	</div>
</div>
<jsp:include page="../include/js.jsp"></jsp:include>
<script type="text/javascript">

var t = null,
	cross = 0,
	end = 60;
var Timer = {
		start:function(){
			cross = 0;
  			t = self.setInterval("Timer.starting()",1000);
			$('#sendcode').attr('disabled',true);
			$('#sendcode').addClass('disabled');
		},
		stop:function(){
			t = window.clearInterval(t);
			$('#sendcode').removeClass('disabled');
			$('#sendcode').attr('disabled',false);
		},
		starting:function(){
			cross ++; 
			if(cross < end){
				$('#sendcode').html(cross+"秒后重新发送");
			}else{
				this.stop();
				$('#sendcode').html("重新发送");
			}
		}
}
/** 验证用户手机号*/
$('#sendcode').click(function(){
	var _this = $(this);
	var url = '${path }/safe/mobile/sendNewCode';
	var data = {"mobile":$('input[name="mobile"]').val()};
	jqueryAjax("post","json",false,url,data,
			function(){
				_this.html("正在发送短信验证码...");
			},
			function(result){
				if(!result){
					// 失败
					_this.html("发送短信验证码失败，点击重试");
					return;
				}
				if(result.success){
					// 成功
					Timer.start();
				}else if(result.error){
					// 失败
					_this.html(result.error.message);
					Timer.stop();
				}else{
					// 失败
					_this.html("发送短信验证码失败，点击重试");
					Timer.stop();
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
		var result = $.parseJSON(data);
		if(!result){
			// 失败
			$.dialog.tips('提交失败...',1,'error.gif');
			return;
		}
		if(result.success){
			// 成功
			$.dialog.tips(result.success.message,1,'32X32/success.png');
			window.top.location.href="${path}/login";
		}else if(result.error){
			// 失败
			$.dialog.tips(result.error.message,1,'error.gif');
		}else{
			// 失败
			$.dialog.tips('提交失败...',1,'error.gif');
		}
	 }
}); 
</script>
</body>
</html>