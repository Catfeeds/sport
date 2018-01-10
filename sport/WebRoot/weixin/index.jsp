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
  <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
</head>
<body>
	<a href="weixin/weixinandchoosePlace">运动场馆预定</a><br /><br />
    <a href="weixin/weixinandchooseCoach">私人教练预定</a><br /><br />
  	<a href="weixin/discountanddiscountList">优惠信息</a><br /><br />
    <a href="weixin/orderanduserOrderList">我的订单</a><br /><br />
    <a href="weixin/forumanduserCaredForum">我的圈子</a><br /><br />
    <a href="weixin/articleanduserArticleList">我的帖子</a><br/><br/>
    <a href="weixin/articleandforumIndex">v社区</a><br /><br />
    <!-- 
    <a href="weixin/weixinandtopCoachList">推荐教练</a><br /><br />
    <a href="weixin/weixinandtopSiteList">推荐场馆</a><br /><br />
     -->
</body>
</html>