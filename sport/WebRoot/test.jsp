<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'test.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

</head>

<body>

	<form action="orderandaddItem" method="post" enctype="multipart/form-data">
		订单项折扣：<input type="text" name="item.discount" /><br>
		价格：<input type="text" name="item.price" /><br>		
		哪个时间段 :<input type="text" name="item.time"/><br/>
		<input type="submit" value="提交" /><br>
	</form>
	<hr><br>
	
	<form action="orderanddeleteItem" method="post" enctype="multipart/form-data">
		<input type="text" name="item.id" /><br>
		<input type="submit" value="提交" /><br>
	</form>
	<hr><br>
	
	<form action="orderanddeleteOrder" method="post" enctype="multipart/form-data">
		<input type="text" name="order.id" /><br>
		<input type="submit" value="提交" /><br>
	</form>
	<hr><br>
	
	<form action="orderanduserOrderList" method="post" enctype="multipart/form-data">
		<input type="submit" value="userOrderList" /><br>
	</form>
	<hr><br>
	
	<form action="orderandsubmitOrder" method="post" enctype="multipart/form-data">
		<input type="text" name="order.id" /><br>
		<input type="submit" value="submitOrder" /><br>
	</form>
	<hr><br>
	
</body>
</html>
