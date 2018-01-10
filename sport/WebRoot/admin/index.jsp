<%@ page language="java" import="java.util.*"  contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	basePath+="admin/";
%>
<head>
 <base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>商城后台管理系统</title>
<link rel="stylesheet" href="../res/css/common.css" type="text/css" />
</head>
<frameset rows="50,*" cols="*" frameborder="no" border="0" framespacing="0">
  <frame src="topframe.jsp" name="topFrame" frameborder="no" scrolling="No" noresize="noresize" id="topFrame" title="topFrame" />
  <frameset name="myFrame" cols="199,7,*" frameborder="no" border="0" framespacing="0">
    <frame src="leftframe.jsp" name="leftFrame" frameborder="no" scrolling="No" noresize="noresize" id="leftFrame" title="leftFrame" />
	<frame src="switchframe.jsp" name="midFrame" frameborder="no" scrolling="No" noresize="noresize" id="midFrame" title="midFrame" />
    <frameset name="contentFrame" rows="59,*" cols="*" frameborder="no" border="0" framespacing="0">
         <frame src="mainframe.jsp" name="mainFrame" frameborder="no" scrolling="No"  noresize="noresize" id="mainFrame" title="mainFrame" />
         <frame src="notice.jsp" name="manFrame" frameborder="no" id="manFrame" title="manFrame" />
     </frameset>
  </frameset>
</frameset>
<noframes><body>
</body>
</noframes>
</html>
