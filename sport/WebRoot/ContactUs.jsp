<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE HTML >
<html>
  <head>
    <base href="<%=basePath%>">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>联系我们</title>
    <link href="res/css/sport.css" rel="stylesheet" type="text/css" />
    <!-- 弹出登录注册对话框 -->
	<link rel="stylesheet" href="res/commonComponents/loginPopDialog/css/loginbox.css"  type="text/css"/>
	<script type="text/javascript" src="res/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="res/js/header.js"></script>
	<!-- 弹出框结束 -->
</head>

<body>

    <iframe src="header" scrolling="no" frameborder="0" width="100%" height="190px;"></iframe>

    <div style="margin:0 auto;width:800px;margin-top:10px;margin-bottom:30px;border:0px solid black;height:325px;">
        <!--这里是图片-->
        <div style="width:500px;height:325px; float:left;" >
            <img src="res/images/map_company.png" width="500px"/>
        </div>

        <!--这里是地址-->
        <div style="width:300px;height:325px; float:right;">
           <div style="margin-top:50px">
            <p style="font-family:微软雅黑;font-size:20px;color:#333;margin-bottom:25px;margin-left:10px" >岳阳米可网络有限公司</p>
            <p style="font-family:微软雅黑;font-size:15px;color:#333;margin-bottom:20px;margin-left:10px" >地&emsp;&emsp;址：湖南省岳阳市岳阳楼区洛王社区</p>
            <p style="font-family:微软雅黑;font-size:15px;color:#333;margin-bottom:20px;margin-left:10px" >客服电话：0730-8330846</p>
            <p style="font-family:微软雅黑;font-size:15px;color:#333;margin-bottom:20px;margin-left:10px" >邮&emsp;&emsp;箱：Jatcoco@sina.com</p>
        </div>
    </div>
</div>

<iframe src="footer.jsp".html" scrolling="no" frameborder="0" width="100%" height="150px"></iframe>

</body>
</html>
