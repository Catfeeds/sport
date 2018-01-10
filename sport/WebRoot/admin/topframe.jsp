<%@ page language="java"  contentType="text/html; charset=UTF-8" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	basePath+="admin/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="../res/admin/css/common.css" type="text/css" />
<title>二维码防伪平台后台管理系统</title>
</head>

<body>
<div class="header_content">
     <div class="logo"><img src="../res/images/logo.jpg" style="width:50px;height:50px;margin-left:80px;"/></div>
	 <div class="right_nav">
	    <div class="text_left"><ul class="nav_list"><li><img src="../res/admin/images/direct.gif" width="8" height="21" />享动后台管理系统</li></ul>
	    </div>
		<div class="text_right"><ul class="nav_return">
		<li><img src="../res/admin/images/return.gif" width="13" height="21" />&nbsp;返回首页 [ <a href="../index" target="_top">首页</a> | 
		 <a href="../forum/articleandforumIndex" target="_top">到贴吧逛逛</a> ]</li>
		</ul>
		</div>
	 </div>
</div>
</body>
</html>
