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
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${title }</title>
<jsp:include page="../include/css.jsp"></jsp:include>
</head>
<body>
<!-- body start -->
<c:set var="urlPrefix" value="${ATTACH_PREFIX}/"></c:set>
<jsp:include page="../include/top.jsp"></jsp:include>
	<jsp:include page="../include/subnavbar.jsp"></jsp:include>
	<div class="main" style="overflow:hidden">
	<div class="page-title">
			<div class="left">
				<span class="title"><a href="${path}">首页</a> &raquo; ${catname }</span>
			</div>
			<div class="right">
			<%-- 	<a href='${url}&ls=${LIST_STYLE_TEXT }' class="ls-btn <c:if test="${ls eq LIST_STYLE_TEXT}">select</c:if>">文字列表</a>
				<a href='${url}&ls=${LIST_STYLE_TEXT_IMAGE}' class="ls-btn <c:if test="${ls eq LIST_STYLE_TEXT_IMAGE}">select</c:if>">图文并茂</a>
			 --%>
			</div>
			<div style="clear:both"></div>
	</div>
	<div class="info-page">
		<div class="info-content">
			<div class="title">
				${info.title }
			</div>
			<div class="subtitle">
				<c:if test="${info.source != '' }">
				<span class="time">
					作者/来源：<font color=#4C91E3>${info.source }</font>
				</span>
				</c:if>
				<span class="time">
					发布时间：
					<font color=#4C91E3><t:dateFormat source="${info.createTime }" force="true"></t:dateFormat></font>
				</span>
				<span class="time">
					浏览次数：<font color=#4C91E3>${info.brower }</font>
				</span>
			</div>
			<div>
			<c:if test="${fn:length(info.video) > 32  }">
				<c:choose>
					<c:when test="${fn:endsWith(info.video,'.swf') }">
						<div id="video" style="position:relative;margin:0 auto;margin-bottom:20px;margin-top:20px;z-index: 100;width:1100px;height:620px;">
							<embed src="${ATTACH_PREFIX}/${info.video }&isAutoPlay=false&isShowRelatedVideo=false&embedid=-&showAd=0"quality="high"width="1100"height="620" align="middle" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" wmode="transparent"></embed>
						</div>
					</c:when>
					<c:otherwise>
					<div id="video" style="position:relative;margin:0 auto;margin-bottom:20px;margin-top:20px;z-index: 100;width:1100px;height:620px;">
						<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553620000"
							codebase="${SITE_RESOURCE_PREFIX }/swflash.cab" width="1100" height="620">
						  <param name="movie" value="${SITE_RESOURCE_PREFIX }/flvplayer.swf">
						  <param name="quality" value="high">
						  <param name="allowFullScreen" value="true">
						  <param name="FlashVars" value="vcastr_file=${ATTACH_PREFIX}/${info.video}&LogoText==${SITENAME}&BufferTime=3&IsAutoPlay=0">
						  <embed src="${SITE_RESOURCE_PREFIX }/flvplayer.swf" allowfullscreen="true" flashvars="vcastr_file=${ATTACH_PREFIX}/${info.video}&LogoText=${SITENAME}&IsAutoPlay=0"
							  quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer"
							  type="application/x-shockwave-flash" width="1100" height="620"></embed>
						</object>
					</div>
					</c:otherwise>
				</c:choose>
			</c:if>
			</div>
			<div class="content">
				${html }
			</div>
		</div>
		<c:if test="${!empty nodata }">
		<div class="no-data">${nodata }</div>
		</c:if>
		<c:if test="${!empty paginationHtml }">
		<div style="text-align:center">
		${paginationHtml }
		</div>
		</c:if>
		<c:if test="${fn:length(info.files) > 0 }">
			<div class="content-files">
				<div class="content-files-title">附件：</div>
				<div class="content-files-content">
				<c:forEach items="${info.files }" var="file" varStatus="status">
					<div class="item">
						<span class="name"><t:subLastIndexOf source="${ file.url }" regex="/"></t:subLastIndexOf></span>
						<a href="${path }/download?f=<t:md5 source="${file.url}"></t:md5>">下载</a>
						<c:if test="${fn:endsWith(file.url, '.doc')
									 || fn:endsWith(file.url, '.docx')
									 || fn:endsWith(file.url, '.xls')
									 || fn:endsWith(file.url, '.xlsx')
									 || fn:endsWith(file.url, '.ppt')
									 || fn:endsWith(file.url, '.pdf')
									 || fn:endsWith(file.url, '.htm')
									 || fn:endsWith(file.url, '.html')
									 || fn:endsWith(file.url, '.txt')}">
							<a href="${path }/reader?f=<t:md5 source="${file.url}"></t:md5>" target=_blank>查看内容</a>
						</c:if>
					</div>
				</c:forEach>
				</div>
			</div>
			<div style="clear:both;height:10px"></div>
		</c:if>
		<div class="info-bottom">
			<div class="left" style="margin-top:20px;margin-left:10px">
				<c:if test="${!empty prev }">
					上一条：<a href="${path}/c/${cat.uri}/${prev.id}">${prev.title }</a>
				</c:if>
				<br>
				<br>
				<c:if test="${!empty next }">
					下一条：<a href="${path}/c/${cat.uri}/${next.id}">${next.title }</a>
				</c:if>
			</div>
			<div class="right">
					<div style="margin-right:10px;margin-top:20px">
						<!-- Baidu Button BEGIN -->
						<div class="bdsharebuttonbox"><a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_qzone" data-cmd="qzone"></a><a href="#" class="bds_tsina" data-cmd="tsina"></a><a href="#" class="bds_tqq" data-cmd="tqq"></a><a href="#" class="bds_renren" data-cmd="renren"></a><a href="#" class="bds_weixin" data-cmd="weixin"></a></div>
<script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdPic":"","bdStyle":"0","bdSize":"16"},"share":{},"image":{"viewList":["qzone","tsina","tqq","renren","weixin"],"viewText":"分享到：","viewSize":"16"},"selectShare":{"bdContainerClass":null,"bdSelectMiniList":["qzone","tsina","tqq","renren","weixin"]}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];</script>
						<!-- Baidu Button END -->
					</div>
			</div>
		</div>
	</div>
	</div>
	<div style="clear:both"></div>
<jsp:include page="../include/footer.jsp"></jsp:include>
<jsp:include page="../include/js.jsp"></jsp:include>
<!-- body end -->
</body>
</html>
