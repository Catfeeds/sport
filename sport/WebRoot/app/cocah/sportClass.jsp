<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
basePath += "cocah/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>享动</title>
<style>
body{	margin:0; padding:0;}
a{ color:#000;text-decoration:none;}
.mainbody{
	margin:0;
	width:100%;
	border-left: #FFF solid 2px;
	border-right: #FFF solid 2px;}
.maintitle{
	height:30px;
	margin:0 auto;
	padding:inherit;
	background-color:#3cf;}
.maintitle_unit{
	width:20%; height:30px;  float:left;
	}
.title_p1{
	font-size:20px; 
	font-weight:bolder;
	line-height:30px;
	margin-left:10px;
	color:#FFF;}
homeico{
	background:url(../res/images/ico.png) no-repeat -110px 0px;
	margin:auto;
	width:50px;
	height:30px;
	float:right;
	display: inline-block;
	vertical-align:middle;
	cursor:pointer;}
backico{
	background:url(../res/images/ico.png) no-repeat -60px 0px;
	margin:auto;
	width:60px;
	height:30px;
	float:left;
	display: inline-block;
	vertical-align:middle;
	cursor:pointer;}

.sport_list_unit{
	height:70px;
	margin:5px 10px;
	padding-right:10px;
	cursor:pointer;
	font-size:16px;
	border-bottom:dashed #666666 1px;}
.sport_list_unit span{line-height:30px; margin:5px 10px; font-size:14px; color:#666;}
.sport_list_unit b{
	color:#F00;}
.sport_list_l{
	height:60px;
	width:30%;
	float:left;}
.sport_list_l img{
	height:60px;
	width:90%;
	float:left;}
.sport_list_r{
	font-size:14px !important;
	width:65%;
	float:right;}
.sport_list_r strong{
	text-align:center;}
.sport_list_r p{
	line-height:20px;
	margin:0;}

</style>


</head>

<body>
<div class="mainbody">
	<div  class="maintitle">
        <div class="maintitle_unit"><a href="sport.jsp"><backico></backico></a></div>
        <div class="maintitle_unit" style="width:56% !important; text-align:center; margin-left:3% ">
        <b class="title_p1">羽毛球教练</b>
        </div>
               <div class="maintitle_unit"><a href="sport.jsp">
          <homeico></homeico>
        </a></div>
    </div>
    <div class="sport_list_unit">
    	<a href="sportBook.jsp" >
		<div class="sport_list_l">
        	<img src="../res/images/02856300.jpg"  style="margin:auto;" >
        </div>
        <div class="sport_list_r">
         <strong>张天辉</strong><span>羽毛球教练</span>
         <p></p>
        <p><b>40</b>元/小时</p>
        </div>
        </a>
    </div>
    
        <div class="sport_list_unit">
    	<a href="sportBook.jsp" >
		<div class="sport_list_l">
        	<img src="../res/images/02856300.jpg"  style="margin:auto;" >
        </div>
        <div class="sport_list_r">
         <strong>张天辉</strong><span>羽毛球陪练</span>
         <p></p>
        <p><b>40</b>元/小时</p>
        </div>
        </a>
    </div>
        <div class="sport_list_unit">
    	<a href="sportBook.jsp" >
		<div class="sport_list_l">
        	<img src="../res/images/02856300.jpg"  style="margin:auto;" >
        </div>
        <div class="sport_list_r">
         <strong>张天辉</strong><span>羽毛球教练</span>
         <p></p>
        <p><b>40</b>元/小时</p>
        </div>
        </a>
    </div>
        <div class="sport_list_unit">
    	<a href="sportBook.jsp" >
		<div class="sport_list_l">
        	<img src="../res/images/02856300.jpg"  style="margin:auto;" >
        </div>
        <div class="sport_list_r">
         <strong>张天辉</strong><span>羽毛球教练</span>
         <p></p>
        <p><b>40</b>元/小时</p>
        </div>
        </a>
    </div>
    
</div>
</body>
</html>
