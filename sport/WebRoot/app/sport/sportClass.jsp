<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
basePath += "sport/";
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
	background:url(../images/ico.png) no-repeat -110px 0px;
	margin:auto;
	width:50px;
	height:30px;
	float:right;
	display: inline-block;
	vertical-align:middle;
	cursor:pointer;}
backico{
	background:url(../images/ico.png) no-repeat -60px 0px;
	margin:auto;
	width:60px;
	height:30px;
	float:left;
	display: inline-block;
	vertical-align:middle;
	cursor:pointer;}

.sport_list_unit{
	height:60px;
	margin:10px 10px;
	padding-right:10px;
	cursor:pointer;
	border-bottom:dashed #666666 1px;}
.sport_list_unit strong{
	line-height:20px;
	font-size:16px;
	float:left;}
.sport_list_unitline2{
	float:right;}
.sport_list_unitline3{
	float:left;}

.sport_list_unit b{
	color:#F00;}

.sport_list_unit span{line-height:30px;}

</style>


</head>

<body>
<div class="mainbody">
	<div  class="maintitle">
        <div class="maintitle_unit"><a href="sport.jsp"><backico></backico></a></div>
        <div class="maintitle_unit" style="width:56% !important; text-align:center; margin-left:3% ">
        <b class="title_p1">羽毛球馆</b>
        </div>
        <div class="maintitle_unit"><homeico></homeico></div>
    </div>
    <div class="sport_list_unit">
        <a href="sportBook.jsp"><strong>湖南理工学院体育学院羽毛球馆</strong><br/>
        </a>
        <p class="sport_list_unitline2"><a href="sportBook.jsp"><b>30</b>元</a></p>
        <p class="sport_list_unitline3"><a href="sportBook.jsp">岳阳楼区 学院路 湖南理工学院</a></p>
    </div>
    <div class="sport_list_unit">
        <strong>湖南理工学院体育学院羽毛球馆</strong><br/>
        <p class="sport_list_unitline2"><b>30</b>元</p>
        <p class="sport_list_unitline3">岳阳楼区 学院路 湖南理工学院</p>
    </div>
    <div class="sport_list_unit">
        <strong>湖南理工学院体育学院羽毛球馆</strong><br/>
        <p class="sport_list_unitline2"><b>30</b>元</p>
        <p class="sport_list_unitline3">岳阳楼区 学院路 湖南理工学院</p>
    </div><div class="sport_list_unit">
        <strong>湖南理工学院体育学院羽毛球馆</strong><br/>
        <p class="sport_list_unitline2"><b>30</b>元</p>
        <p class="sport_list_unitline3">岳阳楼区 学院路 湖南理工学院</p>
    </div><div class="sport_list_unit">
        <strong>湖南理工学院体育学院羽毛球馆</strong><br/>
        <p class="sport_list_unitline2"><b>30</b>元</p>
        <p class="sport_list_unitline3">岳阳楼区 学院路 湖南理工学院</p>
    </div>
    
    
</div>
</body>
</html>
