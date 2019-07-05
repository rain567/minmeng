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
    <meta name="viewport" content="width=device-width,  initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>${title }</title>
<jsp:include page="../include/css.jsp"></jsp:include>
</head>
<body>
<!-- body start -->
<c:set var="urlPrefix" value="${ATTACH_PREFIX}/"></c:set>
<jsp:include page="../include/top.jsp"></jsp:include>
	<div class="page-banner" style="background-image:url(${urlPrefix}${bannerData.image})"></div>
	<jsp:include page="../include/searchbar.jsp"></jsp:include>
	<jsp:include page="../include/subnavbar.jsp"></jsp:include>
	<div class="main">
		<div class="page-title">
			<div class="left">
				<span class="title"><a href="${path}/">首页</a> &raquo; ${catname }</span>
			</div>
			<div style="clear:both"></div>
		</div>
		<div class="info-page" style="padding:0">
			<c:if test="${fn:length(info.video) > 32  }">
				<c:if test="${fn:endsWith(info.video,'.swf') }">
				<div id="video" style="position:relative;margin:0 auto;margin-bottom:20px;margin-top:20px;z-index: 100;width:980px;height:550px;">
					<embed src="${ATTACH_PREFIX}/${info.video }&isAutoPlay=false&isShowRelatedVideo=false&embedid=-&showAd=0"quality="high"width="980"height="550" align="middle" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" wmode="transparent"></embed>
				</div>	
				</c:if>	
				<c:if test="${!fn:endsWith(info.video,'.swf') }">	
				<div id="video" style="position:relative;margin:0 auto;margin-bottom:20px;margin-top:20px;z-index: 100;width:980px;height:550px;"><div id="a1"></div></div>
				<!--
				上面一行是播放器所在的容器名称，如果只调用flash播放器，可以只用<div id="a1"></div>
				-->
				<script type="text/javascript" src="${path}/resources/ckplayer/ckplayer.js" charset="utf-8"></script>
				<script type="text/javascript">
					//如果你不需要某项设置，可以直接删除，注意var flashvars的最后一个值后面不能有逗号
					var flashvars={
						//视频地址
						f:'${info.video}', 
						a:'',//调用时的参数，只有当s>0的时候有效
						s:'0',//调用方式，0=普通方法（f=视频地址），1=网址形式,2=xml形式，3=swf形式(s>0时f=网址，配合a来完成对地址的组装)
						c:'0',//是否读取文本配置,0不是，1是
						x:'',//调用xml风格路径，为空的话将使用ckplayer.js的配置
						i:'',//初始图片地址
						d:'',//暂停时播放的广告，swf/图片,多个用竖线隔开，图片要加链接地址，没有的时候留空就行
						u:'',//暂停时如果是图片的话，加个链接地址
						l:'',//前置广告，swf/图片/视频，多个用竖线隔开，图片和视频要加链接地址
						r:'',//前置广告的链接地址，多个用竖线隔开，没有的留空
						t:'',//视频开始前播放swf/图片时的时间，多个用竖线隔开
						y:'',//这里是使用网址形式调用广告地址时使用，前提是要设置l的值为空
						z:'',//缓冲广告，只能放一个，swf格式
						e:'2',//视频结束后的动作，0是调用js函数，1是循环播放，2是暂停播放并且不调用广告，3是调用视频推荐列表的插件，4是清除视频流并调用js功能和1差不多，5是暂停播放并且调用暂停广告
						v:'80',//默认音量，0-100之间
						p:'0',//视频默认0是暂停，1是播放
						h:'0',//播放http视频流时采用何种拖动方法，=0不使用任意拖动，=1是使用按关键帧，=2是按时间点，=3是自动判断按什么(如果视频格式是.mp4就按关键帧，.flv就按关键时间)，=4也是自动判断(只要包含字符mp4就按mp4来，只要包含字符flv就按flv来)
						q:'',//视频流拖动时参考函数，默认是start
						m:'0',//默认是否采用点击播放按钮后再加载视频，0不是，1是,设置成1时不要有前置广告
						o:'',//当m=1时，可以设置视频的时间，单位，秒
						w:'',//当m=1时，可以设置视频的总字节数
						g:'',//视频直接g秒开始播放
						j:'',//视频提前j秒结束
						k:'',//提示点时间，如 30|60鼠标经过进度栏30秒，60秒会提示n指定的相应的文字
						n:'',//提示点文字，跟k配合使用，如 提示点1|提示点2
						b:'1'
						//调用播放器的所有参数列表结束
						};
					  CKobject.embedSWF('${path}/resources/ckplayer/ckplayer.swf','a1','ckplayer_a1','980','550',flashvars);
					  /*CKobject.embedSWF(播放器路径,容器id,播放器id/name,播放器宽,播放器高,flashvars的值,其它定义也可省略);*/
						//调用ckplayer的flash播放器结束
					/*
					下面三行是调用html5播放器用到的
					var video='视频地址和类型';
					var support='支持的平台或浏览器内核名称';	
					*/
					var video={'${info.video}':'video/mp4'};
					var support=['iPad','iPhone','ios','android+false','msie10+false'];//默认的在ipad,iphone,ios设备中用html5播放,android,ie10上没有安装flash的也调用html5
					CKobject.embedHTML5('video','ckplayer_a1',980,550,video,flashvars,support);
					//如果不想使用html5播放器，只要把上面三行去掉就可以了
				  </script>
				</c:if>	
			</c:if>	
			<div style="clear:both"></div>
			<div class=content>
			${info.content }
			</div>
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
		</div>
	</div>
<jsp:include page="../include/footer.jsp"></jsp:include>
<jsp:include page="../include/js.jsp"></jsp:include>
<!-- body end -->
</body>
</html>
