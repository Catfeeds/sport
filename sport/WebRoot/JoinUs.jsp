<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  
    <title>加入我们</title>
  <!-- 弹出登录注册对话框 -->
	<link rel="stylesheet" href="res/commonComponents/loginPopDialog/css/loginbox.css"  type="text/css"/>
	<script type="text/javascript" src="res/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="res/js/header.js"></script>
	<!-- 弹出框结束 -->
	<style>
	.sport .join-us .row1 {
  text-align: center;
  margin-top: 36px;
  width: 100%;
}
.sport .join-us .resume {
  color: #7b7b7b;
  margin-top: 18px;
}
.sport .join-us .email {
  color: #3ecff0;
}
.sport .join-us .row2 {
  margin-top: 66px;
}
	.sport .join-us h1 {
  color: #0ac3ec;
  font-size: 24px;
  margin-bottom: 16px;
}
.sport .join-us .job p {
  margin-bottom: 18px;
  margin-left:40px;
  line-height: 28px;
}
.job {
margin:0 auto;}
	</style>
</head>
<body>

<div>
	<iframe src="header" frameborder="0" scrolling="no" width="100%" height="190px" ></iframe>
</div>


<div style="margin:0px auto;">
	<center>
	</center>
	
</div>

  <div class="sport">
    <div class="join-us">
      <div class="row1">
        <p class="resume">简历投递</p>
        <p class="email">jatcoco@sina.com</p>
      </div>
      
      
        <div class="row2" style="text-align:center; width:100%;">
          <div  style="width:350px;text-align:left;margin:0 auto;" >
            <h1>产品推广运营(实习生)</h1>
            <h2>岗位职责： </h2>
            <p>
             1、调试和解决系统测试中发现的问题。<br>2、设计和需求人员沟通和合作。<br>
              </p>
            <h2>任职要求：</h2>
            <p>热爱运动又恰好想把这个兴趣变成事业，有热情帮助到更多运动爱好者。</p>
          </div>
        </div>
      
    </div>
  </div>
  
<div>
	<iframe src="footer.jsp" frameborder="0" scrolling="no" width="100%" height="150px" ></iframe>
</div>
</body></html>