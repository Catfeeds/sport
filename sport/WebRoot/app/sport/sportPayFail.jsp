<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
basePath += "sport/";
%>

<!DOCTYPE HTML>
<html>
  <head>
 
	
	<title>享动</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<!--    <link rel="stylesheet" type="text/css" href="res/css/base.css"  /> -->
    <link rel="stylesheet" type="text/css" href="../res/css/sportPayFail.css"  />
    <link rel="stylesheet" type="text/css" href="../res/css/style.css"  />
    <script type="text/javascript" src="../res/js/jquery-1.7.2.min.js"></script>

	
	<style type="text/css">

	</style>

</head>
<body>
	
	<div id="header">
		<!-- top banner -->
        <div class="topbanner">
            <div class="topbannerWord" style="z-index:1;">    
                支付失败
            </div>
            <div class="clear"></div>
        </div>
        <!-- top banner -->  	
	</div>

	<div id="content">

		<div class="detailBox">
            <table class="orderdetailContentTable">
				<tr>
					<th>场　　馆：</th>
					<td>岳阳市体育中心/羽毛球馆</td>
				</tr>
				<tr>
					<th>日　　期：</th>
					<td class="orderdetailDate">2015-08-21 (周五) </td>
				</tr>
				<tr>
					<th>运动项目：</th>
					<td>球类/羽毛球</td>
				</tr>
				<tr>
					<th>预定场地：</th>
					<td style="overflow: hidden;">
						<ul class="orderdetailPlace">
							<li>15:00 - 16:00 1号场 38元</li>
							<li>15:00 - 16:00 4号场 38元</li>
							
						</ul>
					</td>
				</tr>
			</table>
	    </div>

	    <div class="detailPriceBox">
            <table class="orderdetailContentTable">
				<tr>
					<th>总　　价：</th>
					<td class="orderdetailPrice">￥ 76 </td>
				</tr>
			</table>
	    </div>
	    <div class="clear"></div>
	    <div class="infoBox">
	    	<div class="showInfo">T_T 订单支付失败</div>
	    </div>
	    
	    
	    
	    <div class="clear"></div>
	    <div class="confirmOrder"> 
	    	<div class="confirmBtn">
	    		<a href="#">返回支付页面</a>
	    	</div>	
	    </div>

	</div>
	
</body>
</html>
