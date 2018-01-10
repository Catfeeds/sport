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
<title>场馆预定</title>
<style>
body{	padding:0; margin:0;}
a{ color:#000;text-decoration:none;}
.mainbody{
	margin:auto;
	width:device-width;
	border-left: #FFF solid 2px;
	border-right: #FFF solid 2px;}
.maintitle{
	height:30px;
	margin:auto;
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



</style>
<style>
.selecttime{
	width:device-width;
	height:60px;
	padding-top:5px;
	padding-left:40px;
	padding-right:40px;
	border-bottom:1px solid #ccc;
	cursor:pointer;}
.selecttime span{
	color:#39c;
	font-size:20px;
	font-weight:400;}
.selecttime p{

	color:#777;
	font-size:14px;}
.selecttime b{
	color:#EE5528;
	font-size:20px;
	float:right;
	font-weight:400;}
.buttona{ 
	margin-bottom:20px;
	width:device-width;
	text-align:center; 
	height:100px;
	padding:40px inherit;}
.buttona a{
	font-size:16px;
	font-weight:800;
	width:99%;
	padding:10px 155px;
	line-height:80px;
	text-align:center;
	background-color:#f60;		
	color:#fff;border-radius:10px;
	text-decoration:none;}
.buttona a:hover{ color:#000; background-color:39c;}
</style>

</head>

<body>
<div class="mainbody">
	<div  class="maintitle">
        <div class="maintitle_unit"><a href="sportBook.jsp"><backico></backico></a></div>
        <div class="maintitle_unit" style="width:56% !important; text-align:center; margin-left:3% ">
        <b class="title_p1">9月1日 周二</b>
        </div>
        <div class="maintitle_unit"><homeico></homeico></div>
  </div>
    <div style="clear:both;"></div>

	<label for="ck2"> 
	<div class="selecttime">
		<span><input id="ck2" type="checkbox" value=""></span>
        
        <span> 羽毛球陪练</span>
        <p>全天&emsp;09:00-22:00<b>￥120</b></p>
      
    </div>  </label>
		<label for="ck3"> 
	<div class="selecttime">
		<span><input id="ck3" type="checkbox" value=""></span>
        
        <span> 羽毛球陪练</span>
        <p>全天&emsp;09:00-22:00<b>￥120</b></p>
      
    </div>  </label>
    	<label for="ck4"> 
	<div class="selecttime">
		<span><input id="ck4" type="checkbox" value=""></span>
        
        <span> 羽毛球陪练</span>
        <p>全天&emsp;09:00-22:00<b>￥120</b></p>
      
    </div>  </label>
    	<label for="ck5"> 
	<div class="selecttime">
		<span><input id="ck5" type="checkbox" value=""></span>
        
        <span> 羽毛球陪练</span>
        <p>全天&emsp;09:00-22:00<b>￥120</b></p>
      
    </div>  </label>	<label for="ck6"> 
	<div class="selecttime">
		<span><input id="ck6" type="checkbox" value=""></span>
        
        <span> 羽毛球陪练</span>
        <p>全天&emsp;09:00-22:00<b>￥120</b></p>
      
    </div>  </label>
    	
    	
<div style="clear:both;"></div>
	   <div>
			<div class="buttona">
				<a href="sportBookDetail.jsp">预定</a>
			</div>
		</div>
</div>

    
</body>
</html>
