<%
    /**
     栏目
     2014-12-28创建@杨大江
     */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
    <link rel="stylesheet" href="${RESOURCE_PREFIX }/PhotoSwipe/css/photoswipe.css"/>
    <link rel="stylesheet prefetch" href="${RESOURCE_PREFIX }/PhotoSwipe/css/default-skin/default-skin.css">


    <link rel="stylesheet" href="../../pdf/web/viewer.css">
     

           locale.properties文件地址：
    <link rel="resource" type="application/l10n" href="../../pdf/web/locale/locale.properties">

           <!-- pdf.js文件地址：-->
    <script src="../../pdf/web/build/pdf.js"></script>

            <!--viewer.js文件地址：-->
    <script src="../../pdf/web/viewer.js"></script>

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
                        <c:when test="${fn:endsWith(info.video,'.mp4') }">
                            <video controls="controls" width="100%" height="300">
                                <source src="${ATTACH_PREFIX}/${info.video }" type="video/mp4">
                                您的浏览器不支持播放该视频！
                            </video>
                        </c:when>
                        <c:when test="${fn:endsWith(info.video,'.ogg') }">
                            <video controls="controls" width="100%" height="300">
                                <source src="${ATTACH_PREFIX}/${info.video }" type="video/ogg">
                                您的浏览器不支持播放该视频！
                            </video>
                        </c:when>
                        <c:otherwise>
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
                            <span class="name"><t:subLastIndexOf source="${ file.url }"
                                                                 regex="/"></t:subLastIndexOf></span>
                            <c:if test="${fn:endsWith(file.url, '.doc')
									 || fn:endsWith(file.url, '.docx')
									 || fn:endsWith(file.url, '.xls')
									 || fn:endsWith(file.url, '.xlsx')
									 || fn:endsWith(file.url, '.ppt')
									 || fn:endsWith(file.url, '.pdf')
									 || fn:endsWith(file.url, '.htm')
									 || fn:endsWith(file.url, '.html')
									 || fn:endsWith(file.url, '.txt')}">
                                <a href="${path }/reader?f=<t:md5 source="${file.url}"></t:md5>" style="color: blue ">查看</a>
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

                    <div id="bdshare" class="bdshare_t bds_tools get-codes-bdshare">
                        <a class="bds_qzone"></a>
                        <a class="bds_tsina"></a>
                        <a class="bds_tqq"></a>
                        <a class="bds_renren"></a>
                        <a class="bds_t163"></a>
                        <span class="bds_more">更多</span>
                        <a class="shareCount"></a>
                    </div>
                    <script type="text/javascript" id="bdshare_js" data="type=tools&amp;uid=6561134"></script>
                    <script type="text/javascript" id="bdshell_js"></script>
                    <script type="text/javascript">
                        document.getElementById("bdshell_js").src = "http://bdimg.share.baidu.com/static/js/shell_v2.js?cdnversion=" + Math.ceil(new Date() / 3600000)
                    </script>
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

<div id="gallery" class="pswp" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="pswp__bg"></div>

    <div class="pswp__scroll-wrap">

        <div class="pswp__container">
            <div class="pswp__item"></div>
            <div class="pswp__item"></div>
            <div class="pswp__item"></div>
        </div>

        <div class="pswp__ui pswp__ui--hidden">

            <div class="pswp__top-bar">

                <div class="pswp__counter"></div>

                <button class="pswp__button pswp__button--close" title="Close (Esc)"></button>


                <button class="pswp__button pswp__button--fs" title="Toggle fullscreen"></button>

                <button class="pswp__button pswp__button--zoom" title="Zoom in/out"></button>

                <div class="pswp__preloader">
                    <div class="pswp__preloader__icn">
                        <div class="pswp__preloader__cut">
                            <div class="pswp__preloader__donut"></div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="pswp__share-modal pswp__share-modal--hidden pswp__single-tap">
                <div class="pswp__share-tooltip">
                </div>
            </div>

            <button class="pswp__button pswp__button--arrow--left" title="Previous (arrow left)"></button>
            <button class="pswp__button pswp__button--arrow--right" title="Next (arrow right)"></button>
            <div class="pswp__caption">
                <div class="pswp__caption__center">
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="${RESOURCE_PREFIX }/PhotoSwipe/js/photoswipe.js"></script>
<script type="text/javascript" src="${RESOURCE_PREFIX }/PhotoSwipe/js/photoswipe-ui-default.min.js"></script>
<script type="text/javascript">
    (function () {
        function getImgNaturalDimensions(oImg) {
            var size = [];
            if (oImg.naturalWidth) { // 现代浏览器

                nWidth = oImg.naturalWidth;
                nHeight = oImg.naturalHeight;
                size = [nWidth, nHeight];
            } else { // IE6/7/8
                var nImg = new Image();
                nImg.src = oImg.src;
                if (nImg.complete) { // 图片已经存在于浏览器缓存
                    size = [nImg.width, nImg.height];
                } else {
                    nImg.onload = function () {
                        w = nImg.width;
                        h = nImg.height;
                        size = [w, h];
                    }
                }
            }
            return size;
        };

        $('#clauseDetail').click(function () {
            window.open('../viewer.html?file=xxx-clause.pdf');
        });

        var initPhotoSwipeFromDOM = function (gallerySelector) {

            var parseThumbnailElements = function () {
                var nodes = $(gallerySelector).find('img');
                items = [];
                nodes.each(function (i, node) {

                    var size = getImgNaturalDimensions(node);
                    // create slide object
                    var item = {
                        src: node.getAttribute('src'),
                        w: parseInt(size[0], 10),
                        h: parseInt(size[1], 10),
                        author: '图片'
                    };
                    items.push(item);
                })
                return items;
            };

            // find nearest parent element
            var closest = function closest(el, fn) {
                return el && (fn(el) ? el : closest(el.parentNode, fn));
            };

            var onThumbnailsClick = function (e) {
                e = e || window.event;
                //e.preventDefault ? e.preventDefault() : e.returnValue = false;

                var eTarget = e.target || e.srcElement;

                var clickedListItem = closest(eTarget, function (el) {
                    return el.tagName === 'IMG';
                });

                if (!clickedListItem) {
                    return;
                }

                var clickedGallery = clickedListItem.parentNode;

                var childNodes = clickedListItem.parentNode.childNodes,
                    numChildNodes = childNodes.length,
                    nodeIndex = 0,
                    index;

                for (var i = 0; i < numChildNodes; i++) {
                    if (childNodes[i].nodeType !== 1) {
                        continue;
                    }

                    if (childNodes[i] === clickedListItem) {
                        index = nodeIndex;
                        break;
                    }
                    nodeIndex++;
                }

                if (index >= 0) {
                    openPhotoSwipe(index, clickedGallery);
                }
                return false;
            };

            var photoswipeParseHash = function () {
                var hash = window.location.hash.substring(1),
                    params = {};

                if (hash.length < 5) { // pid=1
                    return params;
                }

                var vars = hash.split('&');
                for (var i = 0; i < vars.length; i++) {
                    if (!vars[i]) {
                        continue;
                    }
                    var pair = vars[i].split('=');
                    if (pair.length < 2) {
                        continue;
                    }
                    params[pair[0]] = pair[1];
                }

                if (params.gid) {
                    params.gid = parseInt(params.gid, 10);
                }

                return params;
            };

            var openPhotoSwipe = function (index, galleryElement, disableAnimation, fromURL) {
                var pswpElement = document.querySelectorAll('.pswp')[0],
                    gallery,
                    options,
                    items;

                items = parseThumbnailElements();

                // define options (if needed)
                options = {

                    galleryUID: galleryElement.getAttribute('data-pswp-uid'),

                    getThumbBoundsFn: function (index) {
                        // See Options->getThumbBoundsFn section of docs for more info
                        var thumbnail = items[index], width = items[index].w;
                        pageYScroll = window.pageYOffset || document.documentElement.scrollTop;

                        return {x: 0, y: 0 + pageYScroll, w: width};
                    },

                    addCaptionHTMLFn: function (item, captionEl, isFake) {
                        if (!item.title) {
                            captionEl.children[0].innerText = '';
                            return false;
                        }
                        captionEl.children[0].innerHTML = item.title + '<br/><small>Photo: ' + item.author + '</small>';
                        return true;
                    }

                };


                if (fromURL) {
                    if (options.galleryPIDs) {
                        // parse real index when custom PIDs are used
                        // http://photoswipe.com/documentation/faq.html#custom-pid-in-url
                        for (var j = 0; j < items.length; j++) {
                            if (items[j].pid == index) {
                                options.index = j;
                                break;
                            }
                        }
                    } else {
                        options.index = parseInt(index, 10) - 1;
                    }
                } else {
                    options.index = parseInt(index, 10);
                }

                // exit if index not found
                if (isNaN(options.index)) {
                    return;
                }


                var radios = document.getElementsByName('gallery-style');
                for (var i = 0, length = radios.length; i < length; i++) {
                    if (radios[i].checked) {
                        if (radios[i].id == 'radio-all-controls') {

                        } else if (radios[i].id == 'radio-minimal-black') {
                            options.mainClass = 'pswp--minimal--dark';
                            options.barsSize = {top: 0, bottom: 0};
                            options.captionEl = false;
                            options.fullscreenEl = false;
                            options.shareEl = false;
                            options.bgOpacity = 0.85;
                            options.tapToClose = true;
                            options.tapToToggleControls = false;
                        }
                        break;
                    }
                }

                if (disableAnimation) {
                    options.showAnimationDuration = 0;
                }

                // Pass data to PhotoSwipe and initialize it
                gallery = new PhotoSwipe(pswpElement, PhotoSwipeUI_Default, items, options);

                // see: http://photoswipe.com/documentation/responsive-images.html
                var realViewportWidth,
                    useLargeImages = false,
                    firstResize = true,
                    imageSrcWillChange;

                gallery.listen('beforeResize', function () {

                    var dpiRatio = window.devicePixelRatio ? window.devicePixelRatio : 1;
                    dpiRatio = Math.min(dpiRatio, 2.5);
                    realViewportWidth = gallery.viewportSize.x * dpiRatio;


                    if (realViewportWidth >= 1200 || (!gallery.likelyTouchDevice && realViewportWidth > 800) || screen.width > 1200) {
                        if (!useLargeImages) {
                            useLargeImages = true;
                            imageSrcWillChange = true;
                        }

                    } else {
                        if (useLargeImages) {
                            useLargeImages = false;
                            imageSrcWillChange = true;
                        }
                    }

                    if (imageSrcWillChange && !firstResize) {
                        gallery.invalidateCurrItems();
                    }

                    if (firstResize) {
                        firstResize = false;
                    }

                    imageSrcWillChange = false;

                });

                gallery.listen('gettingData', function (index, item) {
                    item.src = item.src;
                    item.w = item.w;
                    item.h = item.h;
                });

                gallery.init();
            };

            // select all gallery elements
            var galleryElements = document.querySelectorAll(gallerySelector);
            for (var i = 0, l = galleryElements.length; i < l; i++) {
                galleryElements[i].setAttribute('data-pswp-uid', i + 1);
                galleryElements[i].onclick = onThumbnailsClick;
            }

            // Parse URL and open gallery if it contains #&pid=3&gid=1
            var hashData = photoswipeParseHash();
            if (hashData.pid && hashData.gid) {
                openPhotoSwipe(hashData.pid, galleryElements[hashData.gid - 1], true, true);
            }
        };

        initPhotoSwipeFromDOM('.info-page');

    })();

</script>
</body>
</html>
