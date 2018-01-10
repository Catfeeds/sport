<%@ page language="java" import="java.util.*"  contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	basePath+="admin/";
%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
 <base href="<%=basePath%>">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>教练登录</title>

<link href="../res/css/bootstrap.min.css" rel="stylesheet">
<link href="../res/css/signin.css" rel="stylesheet">

</head>

<body>

<div class="signin">
	<div class="signin-head"><img src="../res/images/head_120.png" alt="" class="img-circle"></div>
	<form class="form-signin" role="form" action="coachandlogin" method="post">
		<input type="text" class="form-control" name="coach.userName" placeholder="用户名" required autofocus />
		<input type="password" class="form-control" name="coach.password" placeholder="密码" required />
		<button class="btn btn-lg btn-warning btn-block" type="submit">登录</button>
	</form>
</div>

</body>
</html>
