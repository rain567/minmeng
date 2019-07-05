<%
	/**
	 底部
	 v1.0
	 2014-8-6创建@杨大江
	 */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="friendurls.jsp"></jsp:include>
<div id="footer">
	<div class="main">
		<div class="siteinfo">
				<div style="margin:5px"><a href="${path }/">网站首页</a> |  <a href="/c/mwyw">盟务要闻</a> </div>
				网站E-mail：${setting["siteEmail"] } 联系电话：${setting["sitePhone"] }<br>
				版权所有：${setting["siteName"] } ${setting["icp"] } 技术支持：${setting["development"] }<br>
				${setting["icpGongan"] }<br>
		</div>
	</div>
</div>
<div class="main">
		${setting["footerHtml"] }
</div>