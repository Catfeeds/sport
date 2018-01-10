<%@ page language="java"  contentType="text/html; charset=UTF-8" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">  
    <title>用户关注的社交圈</title>
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
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="js/html5shiv.min.js"></script>
      <script src="js/respond.min.js"></script>
    <![endif]-->
<style>
	.focusul li{
		float: left;
		width: 220px;
	}
</style>

  </head>
  <body> 
    <!-- header -->
<iframe src="header" scrolling="no" frameborder="0" width="100%" height="190px"></iframe>
<!-- /header --> 
    <!-- Left column -->
<div style="width:1000px; margin: auto auto 20px auto;">
<div class="templatemo-flex-row">
		<div class="templatemo-sidebar" style="float: left;">
				<div class="profile-photo-container">
					<img src=".<s:property value='#session.currentUser.image.pathName'/>" alt="个人头像" class="img-responsive">
						<h3 style="text-align: center; padding: 5px;"><s:property value='#session.currentUser.realName'/></h3>
				</div>
				
				<nav class="templatemo-left-nav">
					<ul>
						<li><a href="userHome"><i class="fa fa-home fa-fw"></i>个人首页</a></li>
			            <li><a href="useranduserDetail" >个人资料管理</a></li>
			            <li><a href="orderanduserOrderList">订单管理</a></li>
			            <li><a href="forumanduserCaredForum"  class="active">关注的圈子</a></li>
			            <li><a href="articleanduserArticleList">我的帖子</a></li>
					</ul>
				</nav>
			</div>
      <!-- Main content --> 
      <div class="templatemo-content col-1 light-gray-bg">
        <div class="templatemo-content-container">       
          <ul class="focusul">
         	 <s:iterator value="forums">
	            <li id="forumItem<s:property value='id'/>">
	            <div class="templatemo-content-widget white-bg col-1 text-center templatemo-position-relative margin-bottom-30">
	            	
	              <i class="fa fa-times" forumId="<s:property value='id'/>"></i>
	              <a href="forum/articleandtypeForum?forum.id=<s:property value='id'/>">
	              <img src=".<s:property value='logoImage.pathName'/>" alt="Bicycle" class="img-circle img-thumbnail margin-bottom-30">
	              </a>
	              <h2 class="text-uppercase blue-text margin-bottom-5"><s:property value='forumName'/></h2>
	            	
	            </div>
	           </li>
       		</s:iterator>
          </ul>
          
        </div>
      </div>
    </div>
    </div>
    <!-- JS -->
    <script>
      $(function(){ 
        // Content widget with background image
				$(".fa").click(function(){//disCareForum
					if(!confirm("取消关注？"))
						return;
					var forumId=$(this).attr("forumId");
					var thisObj=this;
					$.post("forumanddisCareForum",
					 	{"forum.id":forumId},
						function(data){
							var arr=new Array();
							$.each(data, function(i, item) {
								arr.push(item);					           
							});
							if(arr[0]){//true时表示操作成功，更改界面元素状态								
								$("#forumItem"+forumId).remove();
							}else{
								alert(arr[1]);
							}												
					},'json'); 					
				});
      });
    </script>
    <iframe src="footer.jsp" scrolling="no" frameborder="0" width="100%" height="165px"></iframe>
  </body>
</html>