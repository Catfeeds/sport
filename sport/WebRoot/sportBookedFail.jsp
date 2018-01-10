<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
	<link href="res/css/coachBookedFail.css" rel="stylesheet" type="text/css">
	<!-- 弹出登录注册对话框 -->
	<link rel="stylesheet" href="res/commonComponents/loginPopDialog/css/loginbox.css"  type="text/css"/>
	<script type="text/javascript" src="res/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="res/js/header.js"></script>
	<!-- 弹出框结束 -->
<style>
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
	
	<div class="orderdetailFailBox">
		<div class="orderdetailFailPic">
			<img src="res/images/orderFail.png" />
		</div>
		<div class="orderdetailFailWord">
			系统将在&nbsp;<input id="second" type="text" value="5"/>&nbsp;秒后自动跳转
		</div>
		<div class="orderdetailFailBtn">
			<ul>
				<li class="backToHome"><a href="index.html" >返回首页</a></li>
				<li class="moveNow"><a href="myorderindex.jsp" >马上跳转</a></li>
			</ul>		
		</div>
	</div>

	<iframe src="footer.jsp" width="100%" height="180px" frameborder="0" scrolling="no"></iframe>


	<!-- mainbanner select start -->
	<script type="text/javascript">
		$(".mainbannerNav ul li").hover(function(){
		$(this).addClass("mainbannerSelected").siblings().removeClass("mainbannerSelected");
		});
	</script>
	<!-- mainbanner select end -->
		
	<!-- countdown start -->	
	<script language="JavaScript" type="text/javascript">
	<!--
		var c=5;	
		var t;
		function timedCount()
		{
			document.getElementById('second').value=c;
			
			if(c>0) 
			{
				c=c-1;
			}
			
			t=setTimeout("timedCount()",1000)
		}
	//-->
	</script>
	<!-- countdown end -->

</body>
</html>
