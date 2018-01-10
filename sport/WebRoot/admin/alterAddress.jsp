<%@ page language="java"  contentType="text/html; charset=UTF-8" isELIgnored="false" import="java.util.*" pageEncoding="UTF-8"%>
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
<title>修改地区信息</title>
<base href="<%=basePath%>">
<link href="../res/css/component.css" type="text/css" rel="stylesheet" />
<link href="../res/admin/css/wordsRecord.css" rel="stylesheet" type="text/css">
</head>
<body>
	<center>
	<h1>修改地区信息</h1>	
		<form  action="addressandupdateAddress" method="post">
			<input type="hidden" name="address.id" value="<s:property value='address.id'/>"/>
			地区名：&nbsp;&nbsp;&nbsp;&nbsp;<input name="address.addressName" type="text"  value="<s:property value='address.addressName'/>"/>
				<div class="intro" style="margin-top:20px;">
					<span >地区简介：</span>
					<textarea cols="40" rows="10" name="address.introduction" ><s:property value='address.introduction'/></textarea>
				</div>
				<div class="modify">
					<input type="submit"  class="button blue middle" value="修改">
				</div>
		</form>
	</center>
</body>
</html>