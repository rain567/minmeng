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
		<form action="${path }/ui/view-item/save" method="post" id="myForm">
			<input type="hidden" name="viewId" value="${view.id }"/>
			<input type="hidden" name="id" value="${viewItem.id }"/>
				<dl>
					<dd class="l">当前控件：</dd>
					<dd class="c">
						<div class="msg tip">${view.name }</div>
					</dd>
				</dl>
			<c:choose>  
				<c:when test="${view.mode eq '0' }">
					<% // 容器  %>
				<dl>
					<dd class="l"></dd>
					<dd>
						<h2>容器控件不能添加条目</h2>
					</dd>
				</dl>
				</c:when>
				<c:when test="${view.mode eq '1' }">
					<% // 分类 %>
				<dl>
					<dd class="l"><font color="red">*</font>栏目：</dd>
					<dd>
						<input type="hidden" name="catId" value="${viewItem.cat.id }" />
						<a class="button" id="setCat">选择栏目</a>
						<div style="clear:both"></div>
						<div style='font-size:13px;padding-top:10px;color:#666'>
							<span id='catname'></span>
						</div>
					</dd>
				</dl>
				</c:when>
				<c:when test="${view.mode eq '2' }">
					<% // 自定内容 %>
				<dl>
					<dd class="l">图片：</dd>
					<dd>
							<input type="hidden" name="image" value="${viewItem.image }"/>
							<div id="imageUpload"></div>
							<div id="uploadTip"></div>
							<div class="tip">
							 	<font color=gray>分类图片上传未定尺寸，根据前端设计要求上传，大小不能超过1M。</font>
							</div>
					</dd>
				</dl>
				<dl>
					<dd class="l">内容：</dd>
					<dd class="c">
						<textarea name="content" style="width:690px;height:100px">${viewItem.content }</textarea>
						<div class="msg tip"></div>
					</dd>
				</dl>
				<dl>
					<dd class="l">链接地址：</dd>
					<dd>
						<input type="text" class="text long" name="link" value="${viewItem.link }">
						<div class="msg tip">通常为“更多”按钮点击跳转的链接地址。</div>
					</dd>
				</dl>
				<dl>
					<dd class="l">
						<font color="red">*</font>链接目标：
					</dd>
					<dd>
						<div style="margin-top:5px">
						<input type="radio" value="_blank" name="target" 
								<c:if test="${viewItem.target == '_blank' }">checked=checked</c:if>>新窗口
						<input type="radio" value="_parent" name="target" 
								<c:if test="${viewItem.target == '_parent' }">checked=checked</c:if>>父窗体
						<input type="radio" value="_self" name="target" 
								<c:if test="${viewItem.target == '_self' }">checked=checked</c:if>>当前窗体
						<input type="radio" value="_top" name="target" 
								<c:if test="${viewItem.target == '_top' }">checked=checked</c:if>>顶部窗体
						</div>
						<div class="msg tip"></div>
					</dd>
				</dl>
				
				<dl>
					<dd class="l">
						生效时间：
					</dd>
					<dd>
						<input type="text" class="Wdate text" name="effectTime"
							 style="width:176px;padding-top:0;padding-bottom:0;" id="d412" 
							 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" 
							 value="${viewitem.effectTime }"/>
						<span class='msg'></span>
						<div style='clear:both'></div>
						<div class="msg tip">可在控件内选择日期时间，格式如：1999-11-11 11:11:11</div>
					</dd>
				</dl>
				<dl>
					<dd class="l">
						过期时间：
					</dd>
					<dd>
						<input type="text" class="Wdate text" name="expireTime"
							 style="width:176px;padding-top:0;padding-bottom:0;" id="d413" 
							 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" 
							 value="${viewitem.expireTime }"/>
						<span class='msg'></span>
						<div style='clear:both'></div>
						<div class="msg tip">可在控件内选择日期时间，格式如：1999-11-11 11:11:11</div>
					</dd>
				</dl>
				<dl>
					<dd class="l">
						<font color="red">*</font>是否为广告：
					</dd>
					<dd>
						<div style="margin-top:5px">
						<input type="radio" value="true" name="ad" 
								<c:if test="${viewitem.ad== true }">checked=checked</c:if>>是
						<input type="radio" value="false" name="ad" 
								<c:if test="${viewitem.ad == false }">checked=checked</c:if>>否
						</div>
						<div class="msg tip"></div>
					</dd>
				</dl>
				<dl>
					<dd class="l">价格：</dd>
					<dd>
						<input type="text" class="text short" name="price" value="${viewitem.price }" />
						<div class="msg tip"></div>
					</dd>
				</dl>
				</c:when>
			</c:choose>
			<c:if test="${view.mode eq '1' or view.mode eq '2'}">
			<dl>
				<dd class="l">
					<font color="red">*</font>状态：
				</dd>
				<dd>
					<div style="margin-top:5px">
					<input type="radio" value="1" name="status" 
							<c:if test="${viewItem.status == 1 }">checked=checked</c:if>>启用
					<input type="radio" value="0" name="status" 
							<c:if test="${viewItem.status == 0 }">checked=checked</c:if>>未启用
					</div>
					<div class="msg tip"></div>
				</dd>
			</dl> 
			<dl>
				<dd class="l">排序：</dd>
				<dd>
					<input type="text" class="text short" name="sorter" value="${viewItem.sorter }" />
				</dd>
			</dl> 
			<dl>
				<dd class="l">&nbsp;</dd>
				<dd>
					<button type="submit" class="f-button submit"  style="margin-right:10px">保 存</button> 
					<button type="reset" class="f-button reset" >重 填</button>
				</dd>
			</dl>
			</c:if>
		</form>
	</div>
</div>
<!-- body end -->
<jsp:include page="../../include/js.jsp"></jsp:include>
<script type="text/javascript">
if($('#imageUpload').size()>0)
$('#imageUpload').fixupload({
	uploadUrl : "${path}/upload",			// 提交上传URL
	progressUrl : "${path}/progress",		// 获取进度条URL
	width: 240,
	height:80,
	skin : 'min',	
	type : 'image',
	buttonVAlign: 'center',
	buttonText:'上传图片',
	buttonSuccessText:'更换图片',
	urlPrefix:'${ATTACH_PREFIX}/',
	urls:['${viewItem.image }'],
	success	:function(urls){
		$('input[name="image"]').val(urls);
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
		$('input[name="image"]').val('');
	}
}); 

var dialog;
function opdb(){		
	var url = '${path}/cat/tree?id=123&type=1&module=cms';	
	dialog = $.dialog({ 
		id:'L1310',
		title:"选择栏目",
	    width:'400px',
	    height:'280px',
		max: false,
	    min: false,
		content: "url:"+url,
	    close: function(){ 
        	var parentId = dialog.content.document.getElementById('catId').value;
        	var refresh = dialog.content.document.getElementById('refresh').value;
        	if(refresh == "true"){
            	$('input[name="catId"]').val(parentId);
            	refreshCatName();
            	// 更新类型区域
            	//refreshCatType();
        	}
        	
	    } ,
    	lock:true
	});
};
if($('#setCat').size()>0){
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
}

if($('textarea[name="content"]').size()>0)
KindEditor.ready(function(K) {
	setTimeout(function(){
		//var textarea = $('textarea[name="content"]');
		//var width = textarea.parents('form').width() - (textarea.offset().left - textarea.parents('form').offset().left )- $('dd.l').width();
		K.create('textarea[name="content"]', {
			uploadJson : '${path}/uploadJson',
			fileManagerJson : '${path}/fileManagerJson',
			allowFileManager : true,
			//width:width+15,
			items : [
			         'source','fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
					 'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
					 'insertunorderedlist','lineheight','anchor','link', '|','table', 'image', 'map','|','code','clearhtml', 'fullscreen','preview'],
			urlType : 'domain'
		});
	},300);
});
	/** 提交 */
	$('#myForm').form({
		 onSubmit:function(){
			$.dialog.tips('正在提交...',600,'loading.gif');
			return true;
		 },
		 success:function(data){
			$.dialog.tips('提交完成...',1,'success.gif');
			var editUri = '${path }/ui/view-item/edit?id=${viewItem.id}';
			var addUri = '${path }/ui/view-item/edit?viewId=${view.id}';
			resultConfirm($.parseJSON(data),null,editUri,addUri,'parent');
			return false;
		 },
		 value:''
	}); 
</script>
</body>
</html>
