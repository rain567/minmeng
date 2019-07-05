<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<script type="text/javascript" src="${RESOURCE_PREFIX}/jquery/jquery.min.js"></script> 
<script type="text/javascript" src="${RESOURCE_PREFIX}/jquery/jquery.form.js"></script> 
<script type="text/javascript" src="${RESOURCE_PREFIX}/custom/base.js"></script>
<script type="text/javascript" src="${RESOURCE_PREFIX}/custom/password.strong.js"></script>
<script type="text/javascript" src="${RESOURCE_PREFIX}/lhgdialog/lhgcore.lhgdialog.min.js?self=true&skin=mdiscuz"></script>
<script type="text/javascript" src="${RESOURCE_PREFIX}/fixwork/fixwork.js"></script>
<script type="text/javascript" src="${path}/resources/fixupload/swfupload.js" charset="utf-8"></script>
<script type="text/javascript" src="${path}/resources/fixupload/fixupload.js" charset="utf-8"></script>
<script type="text/javascript" src="${path}/resources/kindeditor/kindeditor-all-min.js" charset="utf-8"></script>
<script type="text/javascript" src="${path}/resources/kindeditor/lang/zh-CN.js" charset="utf-8"></script>
<script type="text/javascript" src="${RESOURCE_PREFIX}/My97DatePicker/WdatePicker.js" charset="utf-8"></script>

<script type="text/javascript" src="${RESOURCE_PREFIX}/common/js/tree.js"></script>
<script type="text/javascript" src="${RESOURCE_PREFIX}/resize-column/jquery.resizableColumns.js"></script>


<script type="text/javascript">
$("table.list").resizableColumns({});


var buttons = [];
$('.button').each(function(){
	var id = $(this).attr('id');
	if(id && id!=''){
		buttons.push({
			id:id,
			button:$(this).button()
		});
	}else{
		$(this).button();
	}
});

/**
 * æ ¹æ®IDæ¥è¯¢æé®
 */
function getButton(id){
	var button = null;
	$.grep(buttons,function(item){
		if(item.id == id){
			button = item.button;
		}
	});
	return button;
}

var closeButton = $('#closeButton');
if(closeButton.size()>0)
	closeButton.click(function(){
		window.parent.dialog.close();
	});

var closeButtons = $('.closeButton');
if(closeButtons.size()>0)
	closeButtons.click(function(){
		window.parent.dialog.close();
	});

var closeButtons = $('.close-button');
if(closeButtons.size()>0)
	closeButtons.click(function(){
		window.parent.dialog.close();
	});

	
function resize(){
	var c = $('.c');
	if(c.size()>0){
		var input = $('.c').find('input');
		if(input.size()>0)
			input.each(function(){
				var width = $(this).parents('form').width() - ($(this).offset().left - $(this).parents('form').offset().left )- $('dd.l').width();
				$(this).width(width);
				//$('#defaultUploadAuto').width(width);
			});
	}
}
resize();
$(window).resize(function(){
	resize();
});

Date.prototype.Format = function(fmt) 
{ //author: meizz 
	var o = { 
			 "M+" : this.getMonth()+1,                
			 "d+" : this.getDate(),                    
			 "h+" : this.getHours(),                   
			 "m+" : this.getMinutes(),                 
			 "s+" : this.getSeconds(),                 
			 "q+" : Math.floor((this.getMonth()+3)/3),
			 "S"  : this.getMilliseconds()            
			}; 
	if(/(y+)/.test(fmt)) 
		 fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
	for(var k in o) 
		 if(new RegExp("("+ k +")").test(fmt)) 
				fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length))); 
	return fmt; 
};

</script>
