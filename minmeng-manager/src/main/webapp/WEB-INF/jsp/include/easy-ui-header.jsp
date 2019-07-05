<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 

<!-- 加载样式文件 -->
<link rel="stylesheet" type="text/css" href="${RESOURCE_PREFIX}/easyui/themes/gray/easyui.css">
<link rel="stylesheet" type="text/css" href="${RESOURCE_PREFIX}/easyui/themes/icon.css">
<style type="text/css">
.mini-button{
	float:left;margin:1px;
	font-size:10px;text-decoration:none;
	background:url(${path}/resources/css/images/background.png) repeat-x 0 0px;
	border:1px solid #ccc;cursor:pointer;
	padding-left:5px;padding-right:5px;
	line-height:18px;
	border-radius:3px;
	-moz-border-radius:3px;
	-webkit-border-radius:3px;}
.mini-button:hover{background-position:0 -216px;border:1px solid #777;color:#000}
</style>
<jsp:include page="../include/js.jsp"></jsp:include>
<script type="text/javascript" src="${RESOURCE_PREFIX}/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${RESOURCE_PREFIX}/easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
function formatCurrency(num) {
    num = num.toString().replace(/\$|\,/g,'');
    if(isNaN(num))
        num = "0";
    sign = (num == (num = Math.abs(num)));
    num = Math.floor(num*100+0.50000000001);
    cents = num%100;
    num = Math.floor(num/100).toString();
    if(cents<10)
    cents = "0" + cents;
    for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
    num = num.substring(0,num.length-(4*i+3))+','+
    num.substring(num.length-(4*i+3));
    return (((sign)?'':'-') + num + '.' + cents);
}

// 格式化数字栏
function formatNumber(number){
	var v = parseFloat(number);
	if(!isNaN(v))
		if(v < 0){
			return '<font color=red>'+formatCurrency(v)+'</font>';
		}else{
			return formatCurrency(v);
		}
}

//格式化数字栏
function formatNaN(number){
	var v = parseFloat(number);
	if(!isNaN(v))
		if(v < 0){
			return '<font color=red>'+v+'</font>';
		}else{
			return v;
		}
}
</script>