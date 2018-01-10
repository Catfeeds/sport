<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
<link href="res/css/base.css" rel="stylesheet" type="text/css">
<!-- 弹出登录注册对话框 -->
	<link rel="stylesheet" href="res/commonComponents/loginPopDialog/css/loginbox.css"  type="text/css"/>
	<script type="text/javascript" src="res/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="res/js/header.js"></script>
	<!-- 弹出框结束 -->
<meta charset="utf-8">
<title>预定流程</title>
</head>

<body>
<div><iframe src="header" width="100%" height="190px" frameborder="0" scrolling="no"></iframe></div>
    <div>
    <center>
    <img src="res/flow/pay.png"></center>
    </div>
<div class="mainbody"><iframe src="footer.jsp" width="100%" height="200px" frameborder="0" scrolling="no"></iframe>
</body>
</html>
