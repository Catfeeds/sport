<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path ;
			basePath+=request.getServletPath();
			//out.println(basePath);
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>404</title>

<link type="text/css" rel="stylesheet" href="res/css/404.css" />

<!--[if IE 6]>
<script src="res/js/png.js"></script>
<script>DD_belatedPNG.fix('*')</script>
<![endif]-->

</head>
<body>

	<div id="wrap">
		<div>
			<img src="res/img/404.png" alt="404" />
		</div>
		<div id="text">
			<strong> <span></span>
			 <a href="../index" target="_top"
				>返回首页</a> <a href="javascript:history.back()">返回上一页</a>
			</strong>
		</div>
	</div>

	<div class="animate below"></div>
	<div class="animate above"></div>
</body>
</html>
