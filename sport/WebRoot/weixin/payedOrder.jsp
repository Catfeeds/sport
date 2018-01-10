<%@ page language="java"  contentType="text/html; charset=UTF-8" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
	
	<title>享动</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <link rel="stylesheet" type="text/css" href="weixin/res/css/sportPaySuccess.css"  />
    <link rel="stylesheet" type="text/css" href="weixin/res/css/style.css"  />
    <script type="text/javascript" src="weixin/res/js/jquery-1.7.2.min.js"></script>

	
	<style type="text/css">
		/* Anonymous ---------------------------*/
		.m-bbtn {
			width:32px;
			height:32px;
			position:absolute;
			left:4px;
			top:0px;
			padding:4px 4px;
		}
		.m-hbtn {
			width:32px;
			height:32px;
			position:absolute;
			right:4px;
			top:0px;
			padding:4px 4px;
		}
		.m-bbtn img, .m-hbtn img {
			width:32px;
			height:32px;
		}
	</style>
	<script type="text/javascript">
		$(function() {
			
			$(".m-bbtn").click(function(){
				window.history.back(-1);
			});
			
			$(".m-hbtn").click(function(){
				self.location='<%=basePath%>/weixin/weixinandchoosePlace'; 
			});
		});
	</script> 

</head>
<body>
	
	<div id="header">
		<div class="m-bbtn">
			<img alt="" src="<%=basePath%>/weixin/res/images/back.png" />
		</div>
		<div class="m-hbtn">
			<img alt="" src="<%=basePath%>/weixin/res/images/home.png" />
		</div>
		<!-- top banner -->
        <div class="topbanner">
            <div class="topbannerWord" style="z-index:1;">    
                支付成功
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
					<td><s:property value='order.items[0].place.site.siteName' default="场馆名"/>/<s:property value='order.items[0].place.product.productName' default="项目名"/></td>
				</tr>
				<tr>
					<th>地　　址：</th>
					<td class="orderdetailDate"><s:property value='order.items[0].place.site.siteAddress'/>
					</td>
				</tr>
				<tr>
					<th>日　　期：</th>
					<td class="orderdetailDate"><s:date name='order.items[0].placePreOrder.date' format="yyyy年MM月dd日"/>
					 (<s:property	value="weeks[week]" />) </td>
				</tr>
				<tr>
					<th>运动项目：</th>
					<td><s:property value='order.items[0].place.product.productName'/></td>
				</tr>
				<tr>
					<th>预定场地：</th>
					<td style="overflow: hidden;">
						<ul class="orderdetailPlace">
							<s:iterator value="order.items" status="status">
									<li>
									场地：<s:property value='time'/>-<s:property value='time+1'/>时
									<s:property value='place.placeName'/>号场 
									<s:property value='place.prices[time]'/>元</li>
								</s:iterator>	
						</ul>
					</td>
				</tr>
			</table>
	    </div>

	    <div class="detailPriceBox">
            <table class="orderdetailContentTable">
				<tr>
					<th>总　　价：</th>
					<td class="orderdetailPrice">&yen;<s:property value='order.totalAcount'/> </td>
				</tr>
			</table>
	    </div>
	    <div class="clear"></div>
	    <div class="infoBox">
	    	<div class="showInfo">订单支付成功</div>
	    </div>
	    
	    
	    
	    <div class="clear"></div>
	    <div class="confirmOrder"> 
	    	<div class="confirmBtn">
	    		 <a href="weixin/weixinandchoosePlace">返回场馆预订</a>
	    	</div>	
	    </div>

	</div>
	
</body>
</html>
