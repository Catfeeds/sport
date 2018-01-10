<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	basePath += "admin/";
%>

<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">

<title>入站须知</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<style>
p{
	letter-spacing:3px;
	line-height:30px;
	font-size:18px;
	font-family:"微软雅黑";
	color:#333;
}
</style>

</head>

<body>
	<div style="margin-left:30px;margin-top:30px;">
	<p>入驻享动平台需知</p>
	<p>如果您是新入驻享动平台的商家/教练，请看这里:</p>
	<p>1、欢迎您入驻享动平台！<br />
	2、新入驻享动平台的商家/教练，暂时还没有添加商品/服务的功能哦。<br />
	3、只有通过审核的公司,公司管理账号才能生效,请耐心等待。<br />
	4、审核通过后，您才能使用本平台提供的服务。<br />
	5、在此期间，你可以完善您的信息，以便通过平台管理员的审核。<br/>
	6、私人教练请联系平台管理员进行添加，联系电话如下。<br/>
	7、如有问题，请联系 0730-8330846。
	</p>
	</div>

</body>
</html>
