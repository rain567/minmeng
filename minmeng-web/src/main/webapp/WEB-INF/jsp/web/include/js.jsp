<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<script type="text/javascript" src="${SITE_RESOURCE_PREFIX }/jquery-1.11.3.min.js"></script> 
<script type="text/javascript" src="${SITE_RESOURCE_PREFIX }/bootstrap/js/bootstrap.min.js" charset="utf-8"></script>
<script type="text/javascript" src="${RESOURCE_PREFIX}/jquery/jquery.lazyload.js"></script> 
<script type="text/javascript">

/** 获取数字 */
function getNumeric(v) {
	if (!v)
		return 0;
	var re = /[^a-zA-Z\d\u4e00-\u9fa5,.!?()，。．；;？]/g;
	v = v.replace(re, "");
	return v.match(/\d+/) ? parseInt(v) : 0;
}
function getRealWidth(_target, width) {
	width -= getNumeric(_target.css('border-left-width'));
	width -= getNumeric(_target.css('border-right-width'));
	width -= getNumeric(_target.css('margin-left'));
	width -= getNumeric(_target.css('margin-right'));
	width -= getNumeric(_target.css('padding-left'));
	width -= getNumeric(_target.css('padding-right'));
	return width;
}
function getRealHeight(_target, height) {
	height -= getNumeric(_target.css('border-bottom-width'));
	height -= getNumeric(_target.css('border-top-width'));
	height -= getNumeric(_target.css('margin-bottom'));
	height -= getNumeric(_target.css('margin-top'));
	height -= getNumeric(_target.css('padding-bottom'));
	height -= getNumeric(_target.css('padding-top'));
	return height;
}
/**
 * 导航
 */
function nav(name){
	if($("#"+name).size()>0)
    $('html, body').animate({
        scrollTop: $("#"+name).offset().top
    }, 2000);
}
$('.scroll-nav').click(function(){
	var name = $(this).attr('name');
	nav(name)
});

$('input[name="k"]').focus(function(){
	$(this).addClass("focus");
	if($.trim($(this).val()) == "请输入搜索关键字"){
		$(this).val("");
	}
});

$('input[name="k"]').blur(function(){
	if($.trim($(this).val()) == ""){
		$(this).val("请输入搜索关键字");
	}
	$(this).removeClass('focus');
});
$('#searchform').submit(function(){
	if($.trim($('input[name="k"]').val()) == "请输入搜索关键字"){
		$('input[name="k"]').val("");
	}
	if($.trim($('input[name="k"]').val()) == ""){
		$('input[name="k"]').val("请输入搜索关键字");
		$('input[name="k"]').focus();
		return false;
	}else{
		$('input[name="k"]').val(encodeURIComponent($('input[name="k"]').val()));
		return true;
	}		
});

function resize(){
	var minWidth = 1200;
	if($('.footer').width()<minWidth){
		$('.footer').width(minWidth);
	}else{
		$('.footer').width(ww);
	}
}
resize();
$(window).resize(function(){
	resize();
});

// 九宫格
if($('.views .sudoku .view-list .item-content').size()>0)
$('.views .sudoku .view-list .item-content').each(function(){
	var _this = $(this);
	_this.find('*').css({'color':'#ccc'});
	_this.hover(function(){
		_this.find('*').hide();
	},function(){
		_this.find('*').show();
	});
})
// 轮播
$('.carousel').carousel({
	interval: 3000
});

var img = $("img");
if(img.size()>0)
	img.lazyload({
	 	threshold : 13080,
	 	effect : "fadeIn",
		skip_invisible : false
	});

//导航栏 
$('.navbar').find('li.nav').each(function(){
	var subnavbar = $(this).find('.subnavbar:first');
	if(subnavbar.size()>0){
		subnavbar.css({
			'position':'absolute',
			'left': '0px'
		});
		$(this).hover(function(){
			$(this).addClass('active');
			subnavbar.slideDown();
		},function(){
			$(this).removeClass('active');
			subnavbar.hide();
		});
	}else{
		var moresubnavbar =  $(this).find('.moresubnavbar:first');
		if(moresubnavbar.size()>0){
			$(this).find('a:first').addClass('has-more');
			$(this).hover(function(){
				moresubnavbar.css({
					'position':'absolute',
					'top':0,
					'left': $(this).outerWidth()+'px'
				});
				moresubnavbar.slideDown();
			},function(){
				moresubnavbar.hide();
			});
		}
	}
});
/**
 * 标签页切换
 */
function resizeTabs(target){
	var width = 0;
	if(target.size()>0){
		target.find('.list-tab').each(function(){
			width += $(this).outerWidth();
		});
		target.width(width);
	}
}
$('.views .list-tabs').each(function(){
	var _this = $(this);
	if(_this.is(':visible')){
		resizeTabs(_this);
		tabEvents(_this.parent());
	}
});

function tabEvents(target){
	var tabs = target.find('.list-tab');
	var size = tabs.size();
	function show(index){
		for(var i=0;i<size;i++){
			if(i == index){
				target.find('.list-item:eq('+i+')').show();
				target.find('.list-tab:eq('+i+')').addClass('active');
			}else{
				target.find('.list-item:eq('+i+')').hide();
				target.find('.list-tab:eq('+i+')').removeClass('active');
			}
		}
	}
	tabs.hover(function(){
		var index = $(this).index();
		show(index);
	},function(){
	});
	show(0);
}
$('.weather').each(function(){
	var _this = $(this);
	$.ajax({
		dataType:'json',
		url:'https://www.tianqiapi.com/api/',
		success:function(result){
			var today = result.data[0];
			var html = result.city
			+" "+today.date+" "+today.week
			+" "+today.wea
			+" "+today.tem1+"~"+today.tem2;
			_this.html(html);
		}
	});
});
	 $('.jcdt').each(function(){//.xxyd,.ndzd,.czyz,.shfw,
		 var _this = $(this);
		 _this.find('ul li').each(function(i){
		 	var _li = $(this);
		 	var _catIcon = _li.parents('.list-item').find('.list-item-icon');
			var _catLink = _catIcon.find('a');
			var catIcon = _catIcon.css('background-image');
			var catUrl = _catLink.attr('href');
			function setImage(){
				 var imgSrc = _li.find('.item-img').css('background-image');
				 var url = _li.find('a').attr('href');
				 if(imgSrc && imgSrc.length > 5){
					 _catIcon.css('background-image',imgSrc);
					 _catLink.attr('href',url);
				 }
				 else{
					 _catIcon.css('background-image',catIcon);
					 _catLink.attr('href',catUrl);
				 }
			}
		 	if(i == 0){
				 setImage();
			 }
		 	_li.hover(function(){
			 setImage();
		 	});
		 });
	 }); 
</script>

