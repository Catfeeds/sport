<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
<title>享动用户登录</title>
<meta http-equiv="content-Type" content="text/html" charset="utf-8">
<link rel="stylesheet" type="text/css" href="res/css/indexUserLoad.css">
<link rel="icon" href="./res/images/headPic.ico" type="image/x-icon" />
<link rel="shortcut icon" href="headPic.ico" type="image/x-icon" />

<script type="text/javascript" src="res/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="res/js/userLoadindex.js"></script>

</head>
<body>
	<div class="content">
		<div class="ucSimpleHeader">
			<a href="index.jsp" class="meizuLogo"></a>
			<div class="trigger">
				<a href="javascript:void(0)">登录</a>
				<span>&nbsp;|&nbsp;</span>
				<a href="register.jsp">注册</a>
			</div>
		</div>
		<form id="#mainForm1" method="post" action="userandlogin" class="mainForm mainForm1">
			<div class="number" style="text-align:center;">
				<div style="width:100px;margin:0 auto;"><a href="##" class="linkABlue" style="float:left;margin-left:5px;">用户登录</a></div>
			</div>
			<div class="normalInput">
				<input type="text" class="username" name="user.userName" maxlength="32" placeholder="用户名">	
			</div>
			<span class="error error1"></span>			
			<div class="normalInput">
				<input type="text" class="password" name="user.password" maxlength="16" autocomplete="off" placeholder="密码">
				<input type="password" class="password1" name="user.passwordConfirm" maxlength="16" autocomplete="off" placeholder="密码">
				<a id="pwdBtn" href="javascript:void(0);" class="pwdBtnShow" isshow="false">
					<i class="i_icon"></i>
				</a>
			</div>
			<span class="error error3"></span>
			<input type="submit"  class="fullBtnBlue" value="登录"/>	
		</form>
	</div>
	</div>
	<div id="mz_Float">
		<div class="mz_FloatBox">
			<div class="mz3AngleL">
				<i class="i_icon"></i>
			</div>
			<div class="mzFloatTip bRadius2">长度为8-16个字符，区分大小写，至少包含两种类型</div>
		</div>
	</div>
	<div style="text-align:center;">
</div>
</body>
</html>