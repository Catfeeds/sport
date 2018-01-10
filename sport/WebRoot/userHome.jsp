<%@ page language="java"  contentType="text/html; charset=UTF-8" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en"><head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">  
    <title>用户家园</title>
    <meta name="description" content="">
    <meta name="author" content="templatemo">
    
    <link href='http://fonts.useso.com/css?family=Open+Sans:400,300,400italic,700' rel='stylesheet' type='text/css'>
    <link href="res/css/font-awesome.min.css" rel="stylesheet">
    <link href="res/css/bootstrap.min.css" rel="stylesheet">
    <link href="res/css/templatemo-style.css" rel="stylesheet">
    <!-- 弹出登录注册对话框 -->
	<link rel="stylesheet" href="res/commonComponents/loginPopDialog/css/loginbox.css"  type="text/css"/>
	<script type="text/javascript" src="res/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="res/js/header.js"></script>
	<!-- 弹出框结束 -->
    <style>
    .index-pic-li li{
		float:left; width:20%; padding:10px;
		text-align:center;}
	.index-pic-li img{
		width:95%;
		border: 1px solid #DADADA;
		border-radius: 10px;;
		height:50%}	
    </style>
  <body>  
    <!-- header -->
<iframe src="header" scrolling="no" frameborder="0" width="100%" height="190px"></iframe>
<!-- /header -->
    <!-- Left column -->
<div style="width:1000px; margin: auto auto 20px auto;">
    <div class="templatemo-flex-row">
     <div class="templatemo-sidebar" style="font-size: 14px;float: left;">
				<div class="profile-photo-container">
					<img src=".<s:property value='#session.currentUser.image.pathName'/>"  alt="个人头像" class="img-responsive">
						<h3 style="text-align: center; padding: 5px;"><s:property value='#session.currentUser.realName'/></h3>
				</div>
				
				<nav class="templatemo-left-nav">
				<ul>
						<li><a href="javascript:void(0)"  class="active"><i class="fa fa-home fa-fw"></i>个人首页</a></li>
			            <li><a href="useranduserDetail"  >个人资料管理</a></li>
			            <li><a href="orderanduserOrderList">订单管理</a></li>
			            <li><a href="forumanduserCaredForum">关注的圈子</a></li>
			            <li><a href="articleanduserArticleList">我的帖子</a></li>
					</ul>
				</nav>
			</div>
      <!-- Main content --> 
      <div class="templatemo-content col-1 lightQ1Q-gray-bg">
        <div class="templatemo-content-container">
          <div class="templatemo-flex-row flex-content-row">
            <div class="templatemo-content-widget white-bg col-2">
              <h2 class="templatemo-inline-block">亲爱的XXZ欢迎来到个人中心</h2><hr>
              <p>我只见雨淋淋写出潇湘景，更和这云淡淡妆成墨水天</p>
              <br>
              <ul class="index-pic-li">	
				<li><a href="useranduserDetail"  ><img src="res/images/toMrZhang4.png"></a></li>
                <li><a href="orderanduserOrderList"><img src="res/images/toMrZhang1.png"></a></li>
                <li><a href="forumanduserCaredForum"><img src="res/images/toMrZhang3.png"></a></li>
                <li><a href="articleanduserArticleList"><img src="res/images/toMrZhang2.png"></a></li>
              </ul>              
            </div>
          </div>
                       
          </div> <!-- Second row ends -->
                  
        </div>
      </div>
    </div>
    <iframe src="footer.jsp" scrolling="no" frameborder="0" width="100%" height="165px"></iframe>
    <!-- JS -->
   


  </body>
</html>