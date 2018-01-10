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

.selecthail{
	width:device-width;
	height:300px;
	font-size:10px;
	padding:0;
	text-align:center;}
	
.selecthail tr{
	width:device-width;
	height:10px;}
#r0{height:10px; background-color:#D4D4D4;width:50px;}
#r1,#r2,#r3,#r4,#r5,#r6,#r7,#r8,#r9,#r10{
	height:10px;}
#d0{ background-color:#D4D4D4; }
	
.selecthail td{
	width:50px;
	height:13px;
	}
.occupy_td{
	background-color:#BBBBBB; 
	}
.able_td{
	background-color:#3F6;;
	cursor:pointer;}
.selected_td{
	background-color:#39C;
	cursor:pointer;}
.order{
	width:device-width;
	font-size:14px;
	padding:0 10px;}
.order p{
	width:90%;
	margin:10px auto;}
.order span{
	width:50%;
	margin:1px 5px;
	padding:2px 5px;
	border:#39C 1px solid;
	height:20px;}
.buttona{ 
	margin:0 auto;
	margin-bottom:20px !important;
	width:99%;
	text-align:center;
	padding:inherit;}
.buttona a{
	font-size:16px;
	font-weight:800;
	height:40px;
	padding:10px 120px;
	line-height:40px;
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
                <div class="maintitle_unit"><a href="sport.jsp">
          <homeico></homeico>
        </a></div>
  </div>
    <div style="clear:both;"></div>
    <div >
<table class="selecthail">
    <tr id=r0>
    	<td id=d0>时间</td>
        <td>场馆1</td><td> 场馆2</td><td> 场馆3</td>
        <td>场馆4</td><td> 场馆5</td><td>场馆6</td><td>场馆7</td>

    </tr>
    <tr id=r1>
    	<td id=d0>9-10时</td>	<td id=d1 class="occupy_td"></td>
        <td class="occupy_td" id=d1></td><td id=d2 class="occupy_td"></td><td id=d3 class="occupy_td"></td>
        <td id=d4 class="occupy_td"></td><td id=d5 class="occupy_td"></td><td id=d6 class="occupy_td"></td>
    </tr>
    <tr id=r2>
    	<td id=d0>10-11时</td><td id=d1 class="occupy_td"></td>	
        <td id=d1 class="occupy_td"></td><td id=d2 class="occupy_td"></td><td id=d3 class="occupy_td"></td>
        <td id=d4 class="occupy_td"></td><td id=d5 class="occupy_td"></td><td id=d6 class="occupy_td"></td>
    </tr>    
    <tr id=r3>
    	<td id=d0>11-12时</td>	<td id=d1 class="occupy_td"></td>
		<td id=d1 class="occupy_td"></td><td id=d2 class="occupy_td"></td><td id=d3 class="occupy_td"></td>
        <td id=d4 class="occupy_td"></td><td id=d5 class="occupy_td"></td><td id=d6 class="occupy_td"></td>
    </tr>    
    <tr id=r4>
    	<td id=d0>12-13时</td>	<td id=d1 class="occupy_td"></td>
        <td id=d1 class="occupy_td"></td><td id=d2 class="occupy_td"></td><td id=d3 class="occupy_td"></td>
        <td id=d4 class="occupy_td"></td><td id=d5 class="occupy_td"></td><td id=d6 class="occupy_td"></td>
    </tr>    
    <tr id=r5>
    	<td id=d0>13-14时</td>	<td id=d1 class="occupy_td"></td>
        <td id=d1 class="occupy_td"></td><td id=d2 class="occupy_td"></td><td id=d3 class="occupy_td"></td>
        <td id=d4 class="occupy_td"></td><td id=d5 class="occupy_td"></td><td id=d6 class="occupy_td"></td>
    </tr>    
    <tr id=r6>
    	<td id=d0>14-15时</td>	<td id=d1 class="occupy_td"></td>
        <td id=d1 class="occupy_td"></td><td id=d2 class="occupy_td"></td><td id=d3 class="occupy_td"></td>
        <td id=d4 class="occupy_td"></td><td id=d5 class="able_td"></td><td id=d6 class="occupy_td"></td>
    </tr>
    <tr id=r7>
   		<td id=d0>15-16时</td>	<td id=d1 class="occupy_td"></td>
        <td id=d1 class="able_td"></td><td id=d2 class="able_td"></td><td id=d3 class="occupy_td"></td>
        <td id=d4 class="able_td"></td><td id=d5 class="able_td"></td><td id=d6 class="occupy_td"></td>
    </tr>
    <tr id=r8>
    	<td id=d0>16-17时</td>	<td id=d1 class="occupy_td"></td>
        <td id=d1 class="able_td"></td><td id=d2 class="able_td"></td><td id=d3 class="occupy_td"></td>
        <td id=d4 class="occupy_td"></td><td id=d5 class="occupy_td"></td><td id=d6 class="occupy_td"></td>
    </tr>
    <tr id=r9>
   		 <td id=d0>17-18时</td>	<td id=d1 class="occupy_td"></td>
         <td id=d1 class="occupy_td"></td><td id=d2 class="able_td"></td><td id=d3 class="occupy_td"></td>
        <td id=d4 class="occupy_td"></td><td id=d5 class="occupy_td"></td><td id=d6 class="occupy_td"></td>
    </tr>   
    <tr id=r10>
    	<td id=d0>18-19时</td>	<td id=d1 class="occupy_td"></td>
        <td id=d1 class="able_td"></td><td id=d2 class="occupy_td"></td><td id=d3 class="occupy_td"></td>
        <td id=d4 class="occupy_td"></td><td id=d5 class="occupy_td"></td><td id=d6 class="occupy_td"></td>
    </tr>
	    <tr id=r10>
    	<td id=d0>19-20时</td>	<td id=d1 class="occupy_td"></td>
        <td id=d1 class="able_td"></td><td id=d2 class="occupy_td"></td><td id=d3 class="occupy_td"></td>
        <td id=d4 class="occupy_td"></td><td id=d5 class="occupy_td"></td><td id=d6 class="occupy_td"></td>
    </tr>
	    <tr id=r10>
    	<td id=d0>20-21时</td>	<td id=d1 class="occupy_td"></td>
        <td id=d1 class="able_td"></td><td id=d2 class="occupy_td"></td><td id=d3 class="occupy_td"></td>
        <td id=d4 class="occupy_td"></td><td id=d5 class="occupy_td"></td><td id=d6 class="occupy_td"></td>
    </tr>
	    <tr id=r10>
    	<td id=d0>21-22时</td>	<td id=d1 class="occupy_td"></td>
        <td id=d1 class="able_td"></td><td id=d2 class="occupy_td"></td><td id=d3 class="occupy_td"></td>
        <td id=d4 class="occupy_td"></td><td id=d5 class="occupy_td"></td><td id=d6 class="occupy_td"></td>
    </tr>
</table>
</div>
	<div style="border:hidden">
        <div style="height:20px;">
            <img src="../res/images/tishi.png" height="20">
        </div>
        <div class="order">
        <p>您已选择</p>
            <p style="text-align:center;"><span>17-18时 场馆1</span><span>17-18时 场馆1</span></p>
            <p style="text-align:center;"><span>17-18时 场馆1</span><span>17-18时 场馆1</span></p>
        </div>
       </div>
	   <div>
			<div class="buttona">
				<a href="sportBookDetail.jsp">预定</a>
			</div>
		</div>
<script src="../res/js/jquery-1.7.2.min.js" type="text/javascript"></script>
<script>
$(document).ready(function(e) {
    $('.able_td').mouseup(function(){
		$(this).toggleClass('selected_td');
		var tdid=$(this).eq(0).attr('id');
		var trid = $(this).parent().attr('id');
		})
});
</script>    
    
</body>
</html>
