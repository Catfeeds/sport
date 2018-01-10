<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE HTML>
<html>
  <head>
    

 <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
</head>
<body>
	<a href="sport/sport.jsp">运动场馆预定</a>
    <a href="cocah/sport.jsp">私人教练预定</a>
  	<a href="discountList.jsp">优惠信息</a>
    <a href="myorder.jsp">我的订单</a>
    <a href="myforum.jsp">我的圈子</a>
    <a href="vcommunity.jsp">v社区</a>
</body>
</html>