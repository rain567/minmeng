<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 

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