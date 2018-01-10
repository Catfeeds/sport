<%@ page language="java"  contentType="text/html; charset=UTF-8" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>微信扫一扫完成支付</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="res/commonComponents/weixinscanpage/css/scanPay.css" rel="stylesheet" type="text/css"/>
	<script src='res/js/jquery-1.8.3.min.js' type="text/javascript"></script>
	<script src="res/js/qrcode.js"></script>
	<!-- 弹出登录注册对话框 -->
	<link rel="stylesheet" href="res/commonComponents/loginPopDialog/css/loginbox.css"  type="text/css"/>
	<script type="text/javascript" src="res/js/header.js"></script>
	<!-- 弹出框结束 -->
  </head>
  
  <body>
   <!--固定头部-->
    <iframe src="header" frameborder="0" scrolling="no" width="100%" height="190px"></iframe>
   	<input type="hidden" name="codeUrl" value="<s:property value='nativePayUrl'/>"/>
   	<input type="hidden" name="orderId" value="<s:property value='order.id'/>"/>
    <div class="mainContent">
    	<div class="wechat-pay">
			<h4>订单信息</h4>
			<p>订单编号：<s:property value="order.orderNumber"/></p>
			<div class="wechat-pay-value">
				订单金额<b>&yen<s:property value='order.totalAcount'/>元</b>
			</div>
			<h4>订单支付</h4>
			<p>您已选择了<i>微信支付</i> </p>
			
			<div id="qrcodeImgWrap">
				<!-- <img  src="images/index.gif" width="250px" height="250px" style="border: 1px  #FF7800 solid;"/>
				 -->
				 
				<div class="wechat-pay-button">请用微信扫一扫<br />扫描二维码支付</div>
			</div>
		</div>
    </div>
    <!-- 成功和失败后需要重定向到指定页面 -->  
    <input type="hidden" name="successRedirectUrl" value="orderandpayedOrder?order.id=<s:property value='order.id'/>"/>
    <input type="hidden" name="failRedirectUrl" value="orderandtoPayOrder?order.id=<s:property value='order.id'/>"/>
    <!--固定尾部-->
    <div>
      <iframe src="footer.jsp" frameborder="0" scrolling="no" width="100%" height="175px"></iframe>
    </div>
 <script type="text/javascript">
 	//这个地址是Demo.java生成的code_url,这个很关键
	var url = $("input[name=codeUrl]").val();
	//参数1表示图像大小，取值范围1-10；参数2表示质量，取值范围'L','M','Q','H'
	var qr = qrcode(10, 'M');
	qr.addData(url);
	qr.make();	
	var contentHtml = qr.createImgTag();
	$("#qrcodeImgWrap").prepend(contentHtml);
	$("#qrcodeImgWrap img").css("width","250px").css("height","250px").css("border","1px  #FF7800 solid");
	///$(function(){
		var orderId=$("input[name=orderId]").val();
		var timer;
		var count=0;
		setTimer();		
		//向后台发起查询订单状态请求
		function queryOrderStatus(){
			$.post("orderandqueryOrderStatus",
	    			{"order.id":orderId},
	    			function(data){
	    				var arr=new Array();
	    				$.each(data, function(i, item) {
							arr.push(item);					           
						});
						/*if(count==1)
							arr[0]=true;*/
	    				if(arr[0]){
	    					clearInterval(timer);
	    					alert("支付成功！")
	    					document.location=$("input[name=successRedirectUrl]").val();
	    				}else{
	    					//alert(arr[1]);
	    				}
	    				count++;
	    				if(count>=120){//10分钟
	    					alert("您已经超过支付时间，从重新支付！");
	    					document.location=$("input[name=failRedirectUrl]").val();
	    				}
	    	},"json");
	    	//alert();
		}
		//定时向后台发送请求查询订单支付情况，如果在10分钟内，用户未支付成功，则需要重新发起支付请求
		function setTimer(){
			timer=setInterval("queryOrderStatus();",5000);//每5秒查询一次订单状态
		}
	//});
 </script>
  </body>
</html>
