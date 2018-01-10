<%@ page language="java"  contentType="text/html; charset=UTF-8" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html >
<html>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	basePath+="admin/";
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Login</title>
<base href="<%=basePath%>">
<meta name="viewport" content="width=device-width, initial-scale=1">

	<link href="../res/admin/css/style.css" rel='stylesheet'
		type='text/css' />

	<script type="text/javascript" src="../res/js/jquery-1.8.3.min.js"></script>
	<script type="application/x-javascript"> 
		addEventListener("load", 
		function() {
			setTimeout(hideURLbar, 0); 
		}, 
		false);
		function hideURLbar(){ window.scrollTo(0,1); } 
	</script>


</head>
<body>
	<script>
		$(document).ready(function(c) {
	$('.close').on('click', function(c){
		$('.login-form').fadeOut('slow', function(c){
	  		$('.login-form').remove();
		});
	});	  
});
	</script>

	<h1>管理员登录</h1>
	<div class="login-form">
		<div class="close"></div>
		<div class="head-info">
			<label class="lbl-1"> </label> <label class="lbl-2"> </label> <label
				class="lbl-3"> </label>
		</div>
		<div class="clear"></div>
		<div class="avtar">
			<img src="../res/admin/images/avtar.png" />
		</div>
		<form method="post" action="managerandlogin" target="_top">
			<input name="manager.userName" type="text" class="text" value="用户名"
				onFocus="this.value = '';">
				<div class="key">
					<input name="manager.password" type="password" value="密码"
						onFocus="this.value = '';">
				</div>
				<div class="signin">
					<input type="submit" value="登录">
				</div>
		</form>

	</div>

</body>
</html>