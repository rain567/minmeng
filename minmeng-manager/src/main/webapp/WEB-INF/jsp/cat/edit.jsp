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
<title>Edit Cat</title> 
<!-- 加载样式文件 -->
<jsp:include page="../include/css.jsp"></jsp:include>
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
			<a class="dialog-title">编辑分类</a>
		</div>
		<div style="float:right;margin-right:20px;margin-top:5px;">
			<a class="button refresh" corner-right="no">刷新</a>
			<a class="button" id="closeButton" border-left="no" >关闭</a>
		</div>
	</div>
	<div class="content">
		<form action="${path }/cat/save" method="post" id="myForm">
			<input type="hidden" value="${id }" name="id">
			<dl>
				<dd class="l"><font color="red">*</font>上级分类：</dd>
				<dd>
					<input type="hidden" name="parentId" value="${parentId }" />
					<a class="button" id="setParent">选择上级分类</a>
					<div style="clear:both"></div>
					<div style='font-size:13px;padding-top:10px;color:#666'>
						<span id='parentname'></span>
					</div>
				</dd>
			</dl>
			<dl>
				<dd class="l"><font color="red">*</font>分类名称：</dd>
				<dd>
					<input type="text" class="text normal" name="name" value="${cat.name }" />
					<div class="msg tip">分类名称不能为空</div>
				</dd>
			</dl>
			<dl>
				<dd class="l"><font color="red">*</font>分类URI：</dd>
				<dd>
					<input type="text" class="text normal" name="uri" value="${cat.uri }" />
					<div class="msg tip">分类URI为访问地址，子域名由<font color=#ff6600>英文小写字母、-、数字</font>组成，如文章模块URI：articles</div>
				</dd>
			</dl>
			<dl>
				<dd class="l">分类别名：</dd>
				<dd>
					<input type="text" class="text normal" name="alias" value="${cat.alias }" />
					<div class="msg tip"></div>
				</dd>
			</dl>
			<dl>
				<dd class="l">
					<font color="red">*</font>状态：
				</dd>
				<dd>
					<div style="margin-top:5px">
					<input type="radio" value="1" name="status" 
							<c:if test="${cat.status == 1 }">checked=checked</c:if>>启用
					<input type="radio" value="0" name="status" 
							<c:if test="${cat.status == 0 }">checked=checked</c:if>>未启用
					</div>
					<div class="msg tip"></div>
				</dd>
			</dl>
			<dl>
				<dd class="l">分类类型:</dd>
				<dd id="catType">
					<c:forEach items="${typeDescris }" var="entry">
						<div class='i'>
							<input type='radio' name='catType' value="${entry.key }"
							<c:if test="${entry.key == cat.catType }">checked=true</c:if> />
								${entry.value }
						</div>
					</c:forEach>
				</dd>
			</dl>
			<div id="listStyleContainer">
			<dl>
				<dd class="l">列表默认显示:</dd>
				<dd id="listStyle">
					<c:forEach items="${listStypeDescris }" var="entry">
						<div class='i'>
							<input type='radio' name='listStyle' value="${entry.key }"
							<c:if test="${entry.key == cat.listStyle }">checked=true</c:if> />
								${entry.value }
						</div>
					</c:forEach>
				</dd>
			</dl>
			</div>
			<dl>
				<dd class="l">分类图标：</dd>
				<dd>
						<input type="hidden" name="icon" value="${cat.icon }"/>
						<div id="imageUpload"></div>
						<div id="uploadTip"></div>
						<div class="tip">
						 	<font color=gray>分类图片上传未定尺寸，根据前端设计要求上传，大小不能超过1M。</font>
						</div>
				</dd>
			</dl>
			<dl>
				<dd class="l">
					别名：
				</dd>
				<dd>
					<input type="text" class="text normal" name="alias" value="${cat.alias }" />
				</dd>
			</dl> 
			<dl>
				<dd class="l">
					排序：
				</dd>
				<dd>
					<input type="text" class="text short" name="sorter" value="${cat.sorter }" />
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
<jsp:include page="../include/js.jsp"></jsp:include>
<script type="text/javascript">
	
	function showListStyleContainer(){
		var catType = $.trim($('input[name="catType"]:checked').val());
		if(catType == '${CAT_TYPE_LIST}' || 
				catType == '${CAT_TYPE_IMAGE}'){
			// 显示列表显示样式
			$('#listStyleContainer').show();
		}else{
			$('#listStyleContainer').hide();
		}
	}
	showListStyleContainer();
	$('input[name="catType"]').change(function(){
		showListStyleContainer();
	});

	$('#imageUpload').fixupload({
		uploadUrl : "${path}/upload",			// 提交上传URL
		progressUrl : "${path}/progress",		// 获取进度条URL
		width: 160,
		height:120,
		skin : 'min',	
		type : 'image',
		buttonVAlign: 'center',
		buttonText:'上传图片',
		buttonSuccessText:'更换图片',
		urlPrefix:'${ATTACH_PREFIX}/',
		urls:['${cat.icon }'],
		success	:function(urls){
			$('input[name="icon"]').val(urls);
			$('#uploadTip').removeClass('error');
			$('#uploadTip').html('');
		},
		error :function(message){
			$('#uploadTip').addClass('error');
			$('#uploadTip').html(message);
		},
		reset :function(){
			$('#uploadTip').removeClass('error');
			$('#uploadTip').html('');
			$('input[name="icon"]').val('');
		}
	}); 

	var dialog;
	function opdb(){		
		var url = '${path}/cat/tree?id=${id}';	
		dialog = $.dialog({ 
			id:'L1310',
			title:"选择上级分类",
		    width:'400px',
		    height:'280px',
			max: false,
		    min: false,
			content: "url:"+url,
		    close: function(){ 
	        	var parentId = dialog.content.document.getElementById('catId').value;
	        	var refresh = dialog.content.document.getElementById('refresh').value;
	        	if(refresh == "true"){
	            	$('input[name="parentId"]').val(parentId);
	            	refreshCatName();
	            	// 更新类型区域
	            	//refreshCatType();
	        	}
	        	
		    } ,
	    	lock:true
		});
	};
	$('#setParent').click(function(){
		opdb();
	});
	/**
	 * 刷新分类名称
	 */
	function refreshCatName(){
		$.ajax({
	       type: "get",
	       dataType: "html", 
	       url: "${path}/cat/parents?id="+$('input[name="parentId"]').val(),
	       success: function(data) { 
		     	$('#parentname').html(data);
	       },
	       error: function(XMLHttpRequest, textStatus, errorThrown) {
	            alert(errorThrown);
	       }
	    });
	}
	refreshCatName();
	
	/** 验证名称*/
	$('input[name="name"]').blur(function(){
		var msg = $(this).parent().find('.msg');
		var url = '${path }/cat/checkName';
		var data = {
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

	/** 验证URI*/
	$('input[name="uri"]').blur(function(){
		var msg = $(this).parent().find('.msg');
		var url = '${path }/cat/checkUri';
		var data = {
				"uri":$(this).val(),
				"id":"${id}"
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
			var listUri = '${path }/cat';
			var editUri = '${path }/cat/edit?id=${id}';
			var addUri = '${path }/cat/edit?parentId=${parentId}';
			resultConfirm($.parseJSON(data),listUri,editUri,addUri,'parent');
			return false;
		 },
		 value:''
	}); 
</script>
</body>
</html>
