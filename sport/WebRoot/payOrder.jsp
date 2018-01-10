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

	<meta charset="UTF-8">
	<meta name="Generator" content="EditPlus®">
	<meta name="author" content="">
	<meta name="Keywords" content="">
	<meta name="Description" content="" />

	<title>动起来</title>


	<link href="res/css/base.css" rel="stylesheet" type="text/css">
	<link href="res/css/coachSelectPay.css" rel="stylesheet" type="text/css">
<!-- 弹出登录注册对话框 -->
	<link rel="stylesheet" href="res/commonComponents/loginPopDialog/css/loginbox.css"  type="text/css"/>
	<script type="text/javascript" src="res/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="res/js/header.js"></script>
	<!-- 弹出框结束 --><style>
.orderdetailContentTable th {
	width:80px;
}

.orderdetailPlace li {
	margin-top:10px;
	padding:0 5px;
	width:250px;
}
</style>
</head>
<body onload="timedCount();">
	

	<iframe src="header" width="100%" height="190px" frameborder="0" scrolling="no"></iframe>

	<!-- order detail start -->
	<div class="orderdetail">
		<div class="orderdetailState">
			<ul>
				<li class="orderdetailStateOne">选择场地</li>
				<li class="orderdetailStateTwo">确认订单</li>
				<li class="orderdetailStateThree">选择支付方式</li>
				<li class="orderdetailStateFour">购买成功</li>
			</ul>
		</div>
		<div id="progressBar">
		     <!-- 进度条 -->
		     <div>
		         <span></span>
		     </div>
		     <!-- 五个圆 -->
		     <span class="spanOne"></span>
		     <span class="spanTwo"></span>
		     <span class="spanThree"></span>
		     <span class="spanFour"></span>
		</div>
	</div>
	<div class="orderdetailBox">
		<div class="orderdetailTitle">
			订单详情
		</div>
		<div class="orderdetailContentBox">
			<div class="orderdetailName"><s:property value='order.items[0].place.site.siteName' default="场馆名"/></div>
			<div class="orderdetailContent">
				<table class="orderdetailContentTable">
					<tr>
						<th>地　　址：</th>
						<td><s:property value='order.items[0].place.site.siteAddress'/></td>
					</tr>
					<tr>
						<th>日　　期：</th>
						<td class="orderdetailDate"><s:date name='order.items[0].placePreOrder.date' format="yyyy年MM月dd日"/> </td>
					</tr>
					<tr>
						<th>运动项目：</th>
						<td><s:property value='order.items[0].place.product.productName'/></td>
					</tr>
					<tr>
						<th>预定场次：</th>
						<td style="overflow: hidden;">
							<ul class="orderdetailPlace">
								<s:iterator value="order.items" status="status">
									<li>
									场地：<s:property value='time'/>-<s:property value='time+1'/>时
									<s:property value='place.placeName'/>号场 
									<s:property value='place.prices[time]'/>元</li>
								</s:iterator>
							</ul>
						</td>
					</tr>
				</table>
			</div>
			<div class="orderdetailPrice">
				共&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;计：<span><s:property value='order.totalAcount'/></span>元
			</div>
			<div class="orderdetailSelectPay">	
				<form action="" method="" class="orderdetailPayForm">
					<ul>
						<li>支付方式：</li>
						<li class="orderdetailPayStyle">
							<div class="orderdetailPayBtn">
								<input type="radio" name="payStyle" checked="checked" value="weixinPayUrl"/>
							</div>
							<div class="orderdetailPayPic">
								<img src="res/images/weixinpay.png" />
							</div>
						</li>
						<li class="orderdetailPayStyle">
							<div class="orderdetailPayBtn">
								<input type="radio" name="payStyle"  value="alipay"/>
							</div>
							<div class="orderdetailPayPic">
								<img src="res/images/alipay.png" />
							</div>
						</li>
						<li class="orderdetailPayStyle">
							<div class="orderdetailPayBtn">
								<input type="radio" name="payStyle"  value="bank"/>
							</div>
							<div class="orderdetailPayPic">
								<img src="res/images/bank.png" />
							</div>
						</li>
					</ul>
				</form>
			</div>
		</div>

		<div class="orderdetailPay">
			<div class="orderdetailCountdown"> 
				请在&nbsp;&nbsp;<input id="orderdetailCountdownMinuete" type="text" value="9"/>
				&nbsp;&nbsp;分&nbsp;&nbsp;<input id="orderdetailCountdownSecond" type="text" value="59"/>&nbsp;&nbsp;秒内完成支付！
			</div>
			<div class="orderdetailBtn">
				<!-- 
					<a href="orderandweixinScanPay?order.id=<s:property value='order.id'/>">确定</a> 
				 -->
				 <a href="javascript:void(0);" id="payBtn" 
				 	weixinPayUrl="orderandweixinScanPay?order.id=<s:property value='order.id'/>"
				 >确定</a>
			</div>
			<div class="orderdetailTotal">应付总额：<span><s:property value='order.totalAcount'/></span>元</div>
		</div>	
	</div>
	<!-- order detail end -->

	<iframe src="footer.jsp" width="100%" height="180px" frameborder="0" scrolling="no"></iframe>


	

	<!-- mainbanner select start -->
	<script type="text/javascript">
		$(function(){
			$("#payBtn").click(function(){
				var payMethod=$("input[name=payStyle]:checked").val();
				var payUrl;
				if(payMethod=="weixinPayUrl"){
					payUrl=$(this).attr("weixinPayUrl");
					document.location=payUrl;
				}else if(payMethod="alipay"){
					alert("不好意思，暂时不支持支付宝支付方式，敬请期待此功能！");
				}else if(payMethod="bank"){
					alert("不好意思，暂时不支持银联支付方式，敬请期待此功能！");
				}
			});
		});
		$(".mainbannerNav ul li").hover(function(){
		$(this).addClass("mainbannerSelected").siblings().removeClass("mainbannerSelected");
		});
	</script>
	<!-- mainbanner select end -->
	
	<!-- countdown start -->
	<script language="JavaScript" type="text/javascript">
	<!--
		var c=599;	//10分钟
		var t;
		var m =10;
		var s = 0;
		function timedCount()
		{

			document.getElementById('orderdetailCountdownMinuete').value=m;
			document.getElementById('orderdetailCountdownSecond').value=s;

			if(c>=0) 
			{		
				m = Math.floor(c/60);
				s = Math.floor(c%60);
				if (s < 10) { s = "0" +s};
				if (m < 10) { m = "0" +m};
				c=c-1;
			}
			else 
			{
				window.history.back(-1); //返回到上一个页面
			}
			t=setTimeout("timedCount()",1000)
		}
	//-->
	</script>
	<!-- countdown end -->

</body>
</html>
