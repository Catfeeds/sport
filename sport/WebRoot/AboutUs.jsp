<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>"> 
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>关于我们</title>
	<!-- 弹出登录注册对话框 -->
	<link rel="stylesheet" href="res/commonComponents/loginPopDialog/css/loginbox.css"  type="text/css"/>
	<script type="text/javascript" src="res/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="res/js/header.js"></script>
	<!-- 弹出框结束 -->
</head>
<body style="padding:0px;margin:0px;">
	<div>
		<iframe src="header" frameborder="0" scrolling="no" width="100%" height="190px" ></iframe>
	</div>

	<div style="margin-top:10px;margin-bottom:30px;border:0px solid black;height:800px;">
		<div style="border:0px solid black;width:800px;height:300px;margin:0px auto;">
			<!--这里放图片-->
			<div style="border:0px solid red;width:800px;height:300px;">
				<img src="res/images/240437_13041PK10417.jpg" height="300px" width="800px"> 
			</div>
			<br/>
			<!--这里放关于我们的介绍-->
			<div style="border:0px solid blue;width:100%;height:300px;padding:0px;">
			<!-- <h2 style="color:rgb(81,110,180);">公司简介：</h2><br/>
				<p style="font-size:18px;font-family:微软雅黑;margin-top:0px;color:#333;line-height:22px">
					  &emsp;&emsp;米可网络是由几个80后的运动爱好者创建而成，我们发现人们都希望自己有一个健康的体魄和愉悦的健身氛围，但运动，健身往往是一件看上去很美好实际上要操很多心的事，我们想通过“享动”提供一种更实在而纯粹的运动体验，力求只呈现给你最有用，最合适的信息，不再有借口去拒绝运动，拒绝健康。就如同它的名字，享受运动，享受生活！
				</p>
				<br>  -->	
				<h2 style="color:rgb(81,110,180);">享动想做什么：</h2><br/>
				<p style="font-size:18px;font-family:微软雅黑;margin-top:0px;color:#333;line-height:22px">
					*提供专业、简洁、实用、有特色的运动场馆和私人教练信息，节省运动前做计划的时间和精力
					<br>
					*充分利用手机端优势，一站式收纳场馆，教练信息，成为运动健身的信息中枢和爱好者的聚集地
					<br>
					*基于享动平台智能推荐产品，减少预订运动场馆和教练的搜索成本和决策成本
				</p>
			</div>
		</div>

	</div>

	<div>
		<iframe src="footer.jsp" width="100%" height="165px" frameborder="0" scrolling="no"></iframe>
	</div>

</body>
</html>
