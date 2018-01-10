<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>">
<title>享动</title>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />

<link rel="stylesheet" type="text/css" href="weixin/res/css/based.css" />
<link rel="stylesheet" type="text/css" href="weixin/res/css/address.css" />

<script type="text/javascript" src="weixin/res/js/jquery-1.7.2.min.js"></script>

<script>
	$(document).ready(function(){
		$(".firstaddress li").bind("click",function(){
			if($(this).find("span").html() == "↓")
			{	
				$(this).find("span").html("↑");
				$(this).find("ul").slideDown(300);
			}
			else if($(this).find("span").html() == "↑")
			{	
				$(this).find("span").html("↓");
				$(this).find("ul").slideUp(300);
			}
		});
		
		$(".secondaddress li").click(function(){
			window.history.back(-1); 
		});
	});	
</script>

</head>

<body>

	<!--页眉开始-->
	<div id="header">
		<!-- top banner -->
		<div class="topbanner" style="position:relative;">
			<div class="topbannerWord" style="z-index:1;">选择地点</div>
			<div class="clear"></div>
		</div>
		<!-- top banner -->
	</div>
	<!--页眉结束-->

	<!--主体开始-->
	<div id="content">
		<div>
			<ul class="firstaddress">
				<li>
					岳阳<span style="display:none">↓</span>
					<ul class="secondaddress">
						<li>岳阳楼区</li>
						<li>君山区</li>
						<li>岳阳县</li>
						<div class="clearfix"></div>
					</ul>
				</li>
				<li>
					长沙<span style="display:none">↓</span>
					<ul class="secondaddress">
						<li>岳麓区</li>
						<li>雨花区</li>
						<li>芙蓉区</li>
					</ul>
				</li>
				
			</ul>
		</div>
	</div>
	<!--主体结束-->
</body>

</html>