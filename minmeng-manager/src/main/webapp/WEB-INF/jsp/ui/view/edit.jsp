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
	<div class="content">
		<form action="${path }/ui/view/save" method="post" id="myForm">
			<input type="hidden" name="id" value="${id }"/>
			<dl>
				<dd class="l"><font color="red">*</font>父层控件：</dd>
				<dd>
					<input type="hidden" name="parentId" value="${view.parentId }" />
					<a class="button" id="setParent">选择父层控件</a>
					<div style="clear:both"></div>
					<div style='font-size:13px;padding-top:10px;color:#666'>
						<span id='viewname'>${view.parentName }</span>
					</div>
				</dd>
			</dl>
			<dl>
				<dd class="l"><font color="red">*</font>控件名称：</dd>
				<dd>
					<input type="text" class="text normal" name="name" value="${view.name }">
					<div class="msg tip">控件名称不能为空。</div>
				</dd>
			</dl>
			<dl>
				<dd class="l">链接地址：</dd>
				<dd>
					<input type="text" class="text long" name="link" value="${view.link }">
					<div class="msg tip">通常为“更多”按钮点击跳转的链接地址。</div>
				</dd>
			</dl>
			<dl>
				<dd class="l"><font color="red">*</font>类型：</dd>
				<dd>
					<div style="margin-top:5px">
					<input type="radio" value="0" name="mode" 
							<c:if test="${view.mode eq '0' }">checked=checked</c:if>>容器
					<input type="radio" value="1" name="mode" 
							<c:if test="${view.mode eq '1' }">checked=checked</c:if>>关联分类
					<input type="radio" value="2" name="mode" 
							<c:if test="${view.mode eq '2' }">checked=checked</c:if>>自定义内容
					</div>
					<div style="clear:both"></div>
					<div class="msg tip"></div>
				</dd>
			</dl>
			<dl>
				<dd class="l"><font color="red">*</font>样式：</dd>
				<dd>
					<input type="text" class="text normal" name="style" value="${view.style }">
					<div class="msg tip">通常为样式class,与前端样式表对应。</div>
				</dd>
			</dl>
			<dl>
				<dd class="l"><font color="red">*</font>最大数据条目：</dd>
				<dd>
					<input type="text" class="text short" name="maxItems" value="${view.maxItems }" />
					<div class="msg tip">允许的最大控件条目数，多余的条目在前端无法显示，且只显示启用的条目。</div>
				</dd>
			</dl>
			<dl>
				<dd class="l">
					<font color="red">*</font>状态：
				</dd>
				<dd>
					<div style="margin-top:5px">
					<input type="radio" value="1" name="status" 
							<c:if test="${view.status == 1 }">checked=checked</c:if>>启用
					<input type="radio" value="0" name="status" 
							<c:if test="${view.status == 0 }">checked=checked</c:if>>未启用
					</div>
					<div class="msg tip"></div>
				</dd>
			</dl> 
			<dl>
				<dd class="l">
					输出方式：
				</dd>
				<dd>
					<div style="margin-top:5px">
					<input type="radio" value="before" name="outMode" 
							<c:if test="${view.outMode eq 'before' }">checked=checked</c:if>>靠前输出
					<input type="radio" value="after" name="outMode" 
							<c:if test="${view.outMode eq 'after' }">checked=checked</c:if>>靠后输出
					</div>
					<div class="msg tip"></div>
				</dd>
			</dl> 
			<dl>
				<dd class="l">
					排序：
				</dd>
				<dd>
					<input type="text" class="text short" name="sorter" value="${view.sorter }" />
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


var dialog;
function opdb(){		
	var url = '${path}/ui/view/tree?id=${id}';	
	dialog = $.dialog({ 
		id:'L1310',
		title:"选择上级控件",
	    width:'400px',
	    height:'280px',
		max: false,
	    min: false,
		content: "url:"+url,
	    close: function(){ 
        	var parentId = dialog.content.document.getElementById('viewId').value;
        	var refresh = dialog.content.document.getElementById('refresh').value;
        	if(refresh == "true"){
            	$('input[name="parentId"]').val(parentId);
            	refreshViewName();
        	}
        	
	    } ,
    	lock:true
	});
};
$('#setParent').click(function(){
	opdb();
});
/**
 * 刷新控件名称
 */
function refreshViewName(){
	$.ajax({
       type: "get",
       dataType: "html", 
       url: "${path}/ui/view/parents?id="+$('input[name="parentId"]').val(),
       success: function(data) { 
	     	$('#viewname').html(data);
       },
       error: function(XMLHttpRequest, textStatus, errorThrown) {
            alert(errorThrown);
       }
    });
}
refreshViewName();

	/** 验证识别名称 */
	$('input[name="name"]').blur(function(){
		var msg = $(this).parent().find('.msg');
		var url = '${path }/ui/view/checkName';
		var data = {
				"module":"${module.id}",
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

	/** 验证样式 */
	$('input[name="style"]').blur(function(){
		var msg = $(this).parent().find('.msg');
		var url = '${path }/ui/view/checkStyle';
		var data = {
				"style":$(this).val()
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
			 var parentId = $('input[name="parentId"]').val();
			$.dialog.tips('提交完成...',1,'success.gif');
			var editUri = '${path }/ui/view/edit?id=${id}';
			var addUri = '${path }/ui/view/edit?parentId='+parentId;
			resultConfirm($.parseJSON(data),null,editUri,addUri,'parent');
			return false;
		 },
		 value:''
	}); 
</script>
</body>
</html>
