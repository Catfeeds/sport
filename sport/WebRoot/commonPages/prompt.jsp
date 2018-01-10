<%@ page language="java"  contentType="text/html; charset=UTF-8" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	basePath+="admin/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>操作提示页面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">

	.msgBox {
		font: 13px 'Lucida Sans', 'trebuchet MS', Arial, Helvetica;     
		background: #fff;      
		border: 1px solid #ddd;
		color: #333;
		padding: 20px;
		width: 500px;
		_display: inline; /* IE6 double margin fix */
		position: relative;
		margin: 0px auto;
		-moz-box-shadow: 0 2px 2px -1px rgba(0,0,0,.3);
		-webkit-box-shadow: 0 2px 2px -1px rgba(0,0,0,.3);
		box-shadow: 0 2px 2px -1px rgba(0,0,0,.3);		
	}

	.msgBox:after {
	  z-index: -1; 
	  position: absolute; 
	  content: "";
	  bottom: 10px;
	  right: 4px;
	  width: 80%; 
	  top: 80%; 
	  -webkit-box-shadow: 0 12px 5px rgba(0, 0, 0, .3);   
	  -moz-box-shadow: 0 12px 5px rgba(0, 0, 0, .3);
	  box-shadow: 0 12px 5px rgba(0, 0, 0, .3);
	  -webkit-transform: rotate(3deg);    
	  -moz-transform: rotate(3deg);   
	  -o-transform: rotate(3deg);
	  -ms-transform: rotate(3deg);
	  transform: rotate(3deg);	
	}	

	.BD .header{
		border-bottom-color: #45D0DA;
	}

	.header:after {
		position: absolute;
		bottom: -8px; left: 0;
		height: 3px; width: 100%;
		content: '';
	}

	.header {
		position: relative;
		font-size: 20px;
		font-weight: normal;
		text-transform: uppercase;
		padding: 40px;
		margin: -20px -20px 20px -20px;
		border-bottom: 8px solid;
		background-color: #eee;
		background-image: -moz-linear-gradient(#fff,#eee);
		background-image: -webkit-gradient(linear, left top, left bottom, from(#fff), to(#eee));    
		background-image: -webkit-linear-gradient(#fff, #eee);
		background-image: -o-linear-gradient(#fff, #eee);
		background-image: -ms-linear-gradient(#fff, #eee);
		background-image: linear-gradient(#fff, #eee);
	}

</style>
  </head>
  
  <body>
    <div class="msgBox BD">
		<div class="header">
			消息：<s:property value="errorMsg"/> 
		</div>
	</div>
  </body>
</html>
