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
dl{border-bottom:1px solid #ccc;padding:10px;*padding:5px;_padding:5px;margin-bottom:10px}
dl dt{font-weight:bold;padding-bottom:5px}
dl dd{color:#666}
dl dd a{cursor:pointer;color:#0066cc}
.item-layer{display:none;background:#efefef;margin-top:5px;padding:5px;border:1px dotted #aaa;}
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
				<span class="title">留言列表</span>
			</div>
			<div class="right">
				<a href="http://www.${DEFAULT_DOMAIN }/board/write"><span>给我们留言</span></a>
			</div>
			<div style="clear:both"></div>
		</div>
		<c:forEach items="${list }" var="item" varStatus="status">
			<dl>
				<dt>${item.title }</dt>
				<dd>
					<div>
					手机：${fn:substring(item.mobile,0,2) }***${fn:substring(item.mobile,9,11) }
					时间：<t:dateFormat source="${item.createTime }" force="true"></t:dateFormat>
					<a class="content-btn">留言内容</a>
					<c:if test="${!empty item.remark }">
						<a class="remark-btn">查看回复</a>
						<t:dateFormat source="${item.updateTime }" force="true"></t:dateFormat>
						<div class="item-layer item-remark">
							${item.remark}
						</div>
					</c:if>
					</div>
					<div class="item-layer item-content">
						${item.content}
					</div>
				</dd>
			</dl>
			</c:forEach>
		<div class="no-data">${nodata }</div>
		${paginationHtml }
		</div>
	</div>
<jsp:include page="include/footer.jsp"></jsp:include>
<jsp:include page="include/js.jsp"></jsp:include>
<script type="text/javascript">
	var contentBtns = $('.content-btn');
	var remarkBtns = $('.remark-btn');
	if(contentBtns.size()>0){
		contentBtns.click(function(){
			var layer = $(this).parents('dd').find('.item-content');
			if(layer.css('display') == 'none'){
				$('.item-layer').hide();
				layer.slideDown();
			}else{
				layer.slideUp();
			}
		});
	}
	if(remarkBtns.size()>0){
		remarkBtns.click(function(){
			var layer = $(this).parents('dd').find('.item-remark');
			if(layer.css('display') == 'none'){
				$('.item-layer').hide();
				layer.slideDown();
			}else{
				layer.slideUp();
			}
		});
	}
</script>
</body>
</html>
