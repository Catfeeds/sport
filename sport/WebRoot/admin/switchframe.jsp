<%@ page language="java"  contentType="text/html; charset=UTF-8" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	basePath+="admin/";
%>
<!DOCTYPE html >
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="../res/admin/css/common.css" type="text/css" />
<title>显示/隐藏左侧导航栏</title>
<script src='../res/admin/js/jquery-1.8.3.js' type="text/javascript"></script>
</head>
<script language="JavaScript">

$('body').ready(function(){
		if(window.parent.location.href.indexOf("MainUrl")>0) {
		$("#ImgArrow").attr('src','../res/admin/images/switch_right.gif');
		}
	}	
);
function Submit_onclick(){
	if(	$("frameset[name='myFrame']",parent.document).attr('cols')=='199,7,*')
	{
		$("frameset[name='myFrame']",parent.document).attr('cols','0,7,*');
		$("#ImgArrow").attr('src','../res/admin/images/switch_right.gif');
		$("#ImgArrow").attr('alt','打开左侧导航栏');
	} else {
		$("frameset[name='myFrame']",parent.document).attr('cols','199,7,*');
		$("#ImgArrow").attr('src','../res/admin/images/switch_left.gif');
		$("#ImgArrow").attr('alt','隐藏左侧导航栏');
	}
}


</script>
<body">
<div id="switchpic"><a href="javascript:Submit_onclick();"><img src="../res/admin/images/switch_left.gif" alt="隐藏左侧导航栏" id="ImgArrow" /></a></div>
</body>
</html>
