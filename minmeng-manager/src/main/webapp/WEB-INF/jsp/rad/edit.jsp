<%
	/**
	 列表类
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
	<title>Edit Content </title>
	<!-- 加载样式文件 -->
	<jsp:include page="../include/css.jsp"></jsp:include>
	<style type="text/css">
		div.center form dl dd.l{width:80px}
		div.center form dl dd{margin-bottom:10px;}
		div.center form .text {padding:8px;border:1px solid #ccc}
	</style>
</head>
<body>
<!-- body start -->
<!-- 正文 -->
<div class="center">
	<div class="content">
		<form action="${path }/cms/save1" method="post" id="myForm">
			<input type="hidden" value="${id }" name="id">
			<dl>
				<dd class="l"><font color="red">*</font>栏目：</dd>
				<dd>
					<input type="hidden" name="catId" value="${catId }" />
					<a class="button" id="setCat">选择栏目</a>
					<div style="clear:both"></div>
					<div style='font-size:13px;padding-top:10px;color:#666'>
						<span id='catname'></span>
					</div>
				</dd>
			</dl>
			<dl>
				<dd class="l">推荐到：</dd>
				<dd class="c">
					<input type="hidden" name="recom" value="${info.recom }" />
					<div style="clear:both"></div>
					<div class="msg tip">推荐到指定类型的页面，默认状态由系统决定。</div>
				</dd>
			</dl>
			<dl>
				<dd class="l">&nbsp;</dd>
				<dd>
					<button type="submit" class="f-button submit" style="margin-right:10px">保 存</button>
				</dd>
			</dl>
		</form>
	</div>
</div>
<!-- body end -->
<jsp:include page="../include/js.jsp"></jsp:include>
<script type="text/javascript">
	$('#defaultUpload').fixupload({
		uploadUrl : "${path}/upload",			// 提交上传URL
		progressUrl : "${path}/progress",		// 获取进度条URL
		exticonUrl : "${path}/exticon",		// 获取文件图标URL
		ext:'*.mp4;*.flv;*.f4v,*.mpeg,*.3gp',
		maxSize:300*1024*1024, // 最大50M
		urls:'${info.video}',
		success:function(data){
			$('input[name="video"]').val(data);
		},
		error:function(data){
		}
	} );

	$('input[name="recom"]').combox({
		width:200,
		labelShowChange:true,
		label:'选择推荐类型',
		value:'${info.recom }',
		onChange:function(data){
		},
		source:$.parseJSON('${RECOM_VALUES}')
	});

	$('#defaultUploadAuto').fixupload({
		uploadUrl : "${path}/upload",			// 提交上传URL
		progressUrl : "${path}/progress",		// 获取进度条URL
		exticonUrl : "${path}/exticon",		// 获取文件图标URL
		buttonImage:"upload-image.png",
		button:$('#upload'),
		skin : 'default',
		type : 'image',
		urlInput:'images',
		width:128,
		height:128,
		urlPrefix:'${ATTACH_PREFIX}/',
		urls:'${fn:join(images,",")}'.split(','),
		maxSize:300*1024*1024, // 最大50M
		autoCreate:true,
		fileSizeLimit:1024*1024*1024,
		params:[{
			key:'adminSessionid',
			value:'${adminSessionid}'
		}],
		success	:function(urls){
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
		}
	});

	$('#fileUploadAuto').fixupload({
		uploadUrl : "${path}/uploadFile",		// 提交上传URL
		progressUrl : "${path}/progress",		// 获取进度条URL
		exticonUrl : "${path}/exticon",			// 获取文件图标URL
		button:$('#upload'),
		skin : 'default',
		type : 'file',
		urlInput:'files',
		width:260,
		ext:'*.doc;*.docx;*.xls;*.xlsx;*.ppt;*.txt;*.zip;*.rar;*.tar;*.gz;*.bz2;*.pdf;*.avi;*.mp3;*.mp4',
		urls:'${fn:join(files,",")}'.split(','),
		maxSize:50*1024*1024, // 最大50M
		autoCreate:true,
		fileSizeLimit:1024*1024*1024,
		fileData:function(response){
			var url = "${path}/fileData?urls="+'${fn:join(files,",")}'.split(',');
			$.ajax({
				type: "get",
				dataType: "json",
				url: url,
				success: function(data) {
					if($.isArray(data))
						response($.map( data, function( item ) {
							return {
								info:{
									url:item.url,
									percent:100,
									filename:item.url.substring(item.url.lastIndexOf('/')+1,url.length),
									filepath:item.filePath,
									byesRead:'文件长度',
								}
							};
						}));
				},
				error: function(XMLHttpRequest, textStatus, errorThrown) {
					alert(errorThrown);
				}
			});
		},
		params:[{
			key:'adminSessionid',
			value:'${adminSessionid}'
		}],
		success	:function(urls){
			$('#fileUploadTip').removeClass('error');
			$('#fileUploadTip').html('');
		},
		error :function(message){
			$('#fileUploadTip').addClass('error');
			$('#fileUploadTip').html(message);
		},
		reset :function(){
			$('#fileUploadTip').removeClass('error');
			$('#fileUploadTip').html('');
		}
	});

	var dialog;
	function opdb(){
		var url = '${path}/cat/tree?id=${id}&type=1&module=cms';
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

	KindEditor.ready(function(K) {
		setTimeout(function(){
			//var textarea = $('textarea[name="content"]');
			//var width = textarea.parents('form').width() - (textarea.offset().left - textarea.parents('form').offset().left )- $('dd.l').width();
			K.create('textarea[name="content"]', {
				uploadJson : '${path}/uploadJson',
				fileManagerJson : '${path}/fileManagerJson',
				allowFileManager : true,
				//width:width+15,
				//items : [
				//         'source','fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
				//		 'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
				//		 'insertunorderedlist','lineheight','anchor','link', '|','table', 'image', 'map','|','code','clearhtml', 'fullscreen','preview'],
				//urlType : 'domain'
			});
		},300);
	});


	/** 验证标题*/
	$('input[name="title"]').blur(function(){
		var msg = $(this).parent().find('.msg');
		var url = '${path }/cms/checkTitle';
		var data = {
			"title":$(this).val(),
			"id":$('input[name="id"]').val()};
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
			var cid = $('input[name="catId"]').val();
			$.dialog.tips('提交完成.',1,'');
			//var listUri = '${path }/cms/list?cid='+cid;
			var editUri = '${path }/cms/edit1?id=${id}';
			var addUri = '${path }/cms/edit1?cid='+cid;
			resultConfirm($.parseJSON(data),null,editUri,addUri,'parent');
			return false;
		},
		value:''
	});
</script>
</body>
</html>
