<%
	/**
	 底部
	 v1.0
	 2014-8-6创建@杨大江
	 */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="friendurls">

	<div class="main">
		<div class="title">友情链接</div>
		<div class="content">
		<c:forEach items="${friendUrls }" var="fu" varStatus="status">
			
			<a href="${fu.url}" target=_blank>
				<c:if test="${!empty(fu.logo) }"><span><img src="${ATTACH_PREFIX}/${fu.logo }" height=16 border=0/></span></c:if> 
				<span>${fu.sitename }</span> 
			</a>
		</c:forEach>
		</div>
	</div>
</div>
<div style="clear:both"></div>
<div id="footer">
		<div>
				<div style="margin:5px"><a href="${path }/">网站首页</a> |  <a href="/c/mwyw">盟务要闻</a> </div>
				网站E-mail：${setting["siteEmail"] } 联系电话：${setting["sitePhone"] }<br>
				版权所有：${setting["siteName"] } ${setting["icp"] } <br>技术支持：${setting["development"] }<br>
				${setting["icpGongan"] }<br>
		</div>
</div>