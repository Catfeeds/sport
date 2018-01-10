<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE HTML>
<html>
  <head>
    
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>去运动</title>
<style type="text/css">
body{	margin:0; padding:0;}
a{ text-decoration:none;}
.clearfix{ clear:both;}
.mainbody{
	margin:0;
	width:99%;
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
	color:#FFF;}
homeico{
	background:url(res/images/ico.png) no-repeat -110px 0px;
	margin:auto;
		position:absolute; top:0px; right:0px;
	width:60px;
	height:30px;
	float:right;
	display: inline-block;
	vertical-align:middle;
	cursor:pointer;}
backico{
	background:url(res/images/ico.png) no-repeat -60px 0px;
	margin:auto;
		position:absolute; top:0px; left:0px;
	width:60px;
	height:30px;
	float:left;
	display: inline-block;
	vertical-align:middle;
	cursor:pointer;}
.order_unit{
	width:device-width;
	margin:0px;
	padding:0;
	height:180px;;
	}
.order_unit p{
	margin:0px;	padding:0px 10px;
	font-size:14px;
	line-height:28px;
	font-weight:500;
}
.order_unit b{
	font-weight:800;
	font-size:18px;
	color:#444;}
.order_line1{
	text-align:center !important; 
	background-color:#C2E7FC;
	border-top:#000 2px solid;
	color:#333;
	line-height:30px;}
.order_line2{ 
	border-bottom:#36C 1px dashed;}
.order_line2 span{
	margin-right:10px;}
.order_line3{	border-bottom:#36C 1px dashed;}
.order_line4{
	height:auto;
	}
.time_li{
	float:left;
	border:#39C 1px solid;
	background:#eee;
	width:40%;
	line-height:20px;
	padding:2px 5px;
	margin:2px 1px;}
.order_line5{
	line-height:35px;
	height:30px;
	margin:3px 0px;
	border-top:#333 1px dashed;
	border-bottom:#36C 1px dashed;}
.order_line6{ height:35px; 
	margin-left:0px; 
	padding-left:80px; 
	margin-top:5px;
	margin-bottom:5px; }
.order_line6 a{
	font-size:16px;
	font-weight:800;
	height:25px;
	width:80px;
	line-height:25px;
	padding:5px 10px;
	text-align:center;
		
	color:#fff;
	margin-right:20px;
	text-decoration:none;
	}
.order_line6  a:hover{ color:#000; background-color:#666;}
</style>


</head>

<body>
<div class="mainbody">
	<div  class="maintitle">
        <div class="maintitle_unit"><a href="sport/sport.jsp"><backico></backico></a></div>
        <div class="maintitle_unit" style="width:56% !important; text-align:center; ">
        <b class="title_p1">我的订单</b>
        </div>
        <div class="maintitle_unit"><homeico></homeico></div>
    </div>
  	<div style="border:1px solid #Fff;margin-bottom:10px; background:#eee;">
        <div class="order_unit">
            <p class="order_line1"><b>订单号：&emsp;</b>07308845612396515478</p>
            <p class="order_line2">
                <span><b>类型: </b>场馆预定</span>
                <span><b>项目: </b>羽毛球</span>
            </p>
            <p class="order_line3"><b>场馆：</b>理工学院体育学院羽毛球馆</p>
            <div class="order_line4">
               <p> <b>订单详情：</b>2015-09-02 周二</p>
            </div>
            <div>
                <div class="time_li">9:00-10:00 vip场1</div><div class="time_li">9:00-10:00 vip场1</div>
                <div class="time_li">9:00-10:00 vip场1</div><div class="time_li">9:00-10:00 vip场1</div>
            </div>
        </div>
        <div>
        	<p class="order_line5"><b>总金额：</b><b style="color: #F00 !important;">150</b> 元 
        	 <b style="margin-left:20px;">订单状态 : 未支付</b>  </p>
		</div>
        <div class="order_line6">
            <div style="float:left;"><a href="#" style="background-color:#EE5528;	">支 付</a></div> 
            <div style="float:leftt;"><a href="#" style=" background-color:#39c">取 消</a></div>
        </div>
        
         
    </div>
    
    <div style="border:1px solid #Fff; margin-bottom:10px;background:#eee;">
        <div class="order_unit">
            <p class="order_line1"><b>订单号：&emsp;</b>07308845612396515478</p>
            <p class="order_line2">
                <span><b>类型: </b>教练预定</span>
                <span><b>项目: </b>羽毛球</span>
            </p>
            <p class="order_line3"><b>教练信息：</b>张天辉 </p>
               <div class="order_line4">
                <b>订单详情：</b>2015-09-02 周二<br/>
          
                教练电话：15778963214<br>
                
            </div>
        </div>
              <div>
        	<p class="order_line5"><b>总金额：</b><b style="color: #F00 !important;">150</b> 元 
        	 <b style="margin-left:20px;">订单状态 : 未支付</b>  </p>
		</div>
        <div class="order_line6">
            <div style="float:left;"><a href="sport/sportSelectPay.jsp" style="background-color:#EE5528;	">支 付</a></div> 
            <div style="float:leftt;"><a href="#" style=" background-color:#39c">取 消</a></div>
        </div>
    </div>  	
    
    
    
      	<div style="border:1px solid #Fff;margin-bottom:10px;background:#eee;">
        <div class="order_unit">
            <p class="order_line1"><b>订单号：&emsp;</b>07308845612396515478</p>
            <p class="order_line2">
                <span><b>类型: </b>场馆预定</span>
                <span><b>项目: </b>羽毛球</span>
            </p>
            <p class="order_line3"><b>场馆：</b>理工学院体育学院羽毛球馆</p>
            <div class="order_line4">
               <p> <b>订单详情：</b>2015-09-02 周二</p>
            </div>
            <div>
                <div class="time_li">9:00-10:00 vip场1</div><div class="time_li">9:00-10:00 vip场1</div>
                <div class="time_li">9:00-10:00 vip场1</div><div class="time_li">9:00-10:00 vip场1</div>
            </div>
        </div>
        <div>
        	<p class="order_line5"><b>总金额：</b><b style="color: #F00 !important;">150</b> 元 
        	 <b style="margin-left:20px;">订单状态 :已支付</b>  </p>
		</div>
        <div class="order_line6">支付时间：2015-08-27 20：30：33
        </div>
        
         
    </div>
    
    
</div>
</body>
</html>
