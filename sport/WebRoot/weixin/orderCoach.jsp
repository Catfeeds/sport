<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
        
<title>享动</title>
<script type="text/javascript" src="weixin/res/js/jquery-1.7.2.min.js">
</script>

<style>
*{margin:0;padding:0;list-style-type:none;}
a,img{border:0;}

.mainbody {
	margin:auto;
	width:99%;
	border-left: #FFF solid 2px;
	border-right: #FFF solid 2px;
}
.maintitle {
	height:40px;
	margin:auto;
	padding:inherit;
	background-color:#3cf;
}
.maintitle_unit {
	width:20%;
	height:40px;
}
.title_p1 {
	font-size:16px;
	font-weight:bold;
	line-height:40px;
	color:#FFF;
}

/* Anonymous ---------------------------*/

.slides li img {
	height:170px;
}

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

.cts-box ul li {
	width:99%;
	margin:0px auto;
	height:40px;
	line-height:40px;
	font-size:14px;
	border-bottom:1px dashed #999;
	margin-top:5px;
}

.cts-box ul li span {
	display:-moz-inline-box; 
	display:inline-block;
	text-align:center;
}

.cts-box ul li .cts-cbox {
	width:20%;
}

.cts-box ul li .cts-time {
	width:57%;
	white-space:nowrap; 
	overflow : hidden;
	text-overflow: ellipsis;
}

.cts-box ul li .cts-money {
	width:20%;
	color: red;
	float:right;
}

.buttona{ 
	margin-bottom:20px;
	width:99%;
	text-align:center; 
	height:50px;
	margin-top:20px;
}
.buttona a:hover{ 
	color:#000; 
	background-color:39c;
}
input[type=submit] {
	font-size:16px;
	padding:10px 20%;
	text-align:center;
	background-color:#f60;		
	color:#fff;
	border-radius:5px;
	text-decoration:none;
	border:0px solid red;
}
#focusme {
	position:absolute;
	top:400px;
	border:1px solid #fff;
	width:0px;
	color:#fff;
	opacity: 0.0; 
}
</style>

	<script type="text/javascript">
		$(function() {
			
			document.getElementById("focusme").focus();
			
			$(".m-bbtn").click(function(){
				window.history.back(-1);
			});
			
			$(".m-hbtn").click(function(){
				self.location='weixin/weixinandchooseCoach'; 
			});
			
			//控制选择的时间段
			$("#cts-c-4").click(function(){
				if(this.checked)
				{
					$("#cts-c-1").removeAttr("checked");
					$("#cts-c-2").removeAttr("checked");
					$("#cts-c-3").removeAttr("checked");
				}
			});
			$("#cts-c-1").click(function(){
				if(this.checked)
				{
					$("#cts-c-4").removeAttr("checked");
				}
			});
			$("#cts-c-2").click(function(){
				if(this.checked)
				{
					$("#cts-c-4").removeAttr("checked");
				}
			});
			$("#cts-c-3").click(function(){
				if(this.checked)
				{
					$("#cts-c-4").removeAttr("checked");
				}
			});
		});
	</script> 
	
</head>

<body>
<div class="mainbody">
	<input type="text" id="focusme"  />
	<div class="m-bbtn">
		<img alt="" src="weixin/res/images/back.png" />
	</div>
	<div class="m-hbtn">
		<img alt="" src="weixin/res/images/home.png" />
	</div>
	<div  class="maintitle">
        <div class="maintitle_unit" style="width:100% !important; text-align:center; margin:0px auto;">
       		<b class="title_p1"><s:date name="dates[week]" format="MM月 dd日/" timezone="ch" /> 
	        		<s:property	value="weeks[week]" />(教练：<s:property value='coachPreOrderInfo.coach.realName'/>)</b>
        </div>
	</div>
    <div style="clear:both;"></div>
	<form action="weixin/orderandcreateAndSubmitOrder" method="post">
		<input type="hidden" name="week" value="<s:property value='week'/>"/>
		<s:if test="coachProduct!=null">
			<input type="hidden" name="coachProduct.id" value="<s:property value='coachProduct.id'/>"/>
		</s:if>
		<input type="hidden" name="item.coachPreOrder.id" value="<s:property value='coachPreOrderInfo.order.id'/>"/>
	<div class="cts-box">		
		<ul >
			<s:if test="coachPreOrderInfo.order.orderInfos[0]>0&&(coachPreOrderInfo.coach.dayJobTimeArr[0]==1)">
				<label for="cts-c-1">
				<li>
					<span class="cts-cbox"><input type="checkbox" name="times" value="0" id="cts-c-1" /></span>
					<span class="cts-time">上午 (09:00-12:00)&nbsp;<s:property value='coachProduct.productName'/></span>
					<s:if test="coachProduct!=null">
						<span class="cts-money">￥ <s:property value="coachPreOrderInfo.costInfo.prices[0]"/></span>	
					</s:if>
					<s:else>
						<span class="cts-money">￥ <s:property value="coachPreOrderInfo.coach.baseCostPrices[0]"/></span>
					</s:else>	
				</li>
				</label>
			</s:if>
			<s:else>
				<label >
				<li>
					<span class="cts-cbox"></span>
					<span class="cts-time">上午 (09:00-12:00)&nbsp;<s:property value='coachProduct.productName'/></span>
					<s:if test="coachProduct!=null">
						<span class="cts-money">￥ <s:property value="coachPreOrderInfo.costInfo.prices[0]"/></span>	
					</s:if>
					<s:else>
						<span class="cts-money">￥  <s:property value="coachPreOrderInfo.coach.baseCostPrices[0]"/></span>
					</s:else>	
				</li>
				</label>		
			</s:else>
			
			<s:if test="coachPreOrderInfo.order.orderInfos[1]>0&&(coachPreOrderInfo.coach.dayJobTimeArr[1]==1)">
				<label for="cts-c-2">
				<li>
					<span class="cts-cbox"><input type="checkbox"  name="times" value="1" id="cts-c-2" /></span>
					<span class="cts-time">下午 (14:00-17:00)&nbsp;<s:property value='coachProduct.productName'/></span>
					<s:if test="coachProduct!=null">
						<span class="cts-money">￥ <s:property value="coachPreOrderInfo.costInfo.prices[1]"/></span>	
					</s:if>
					<s:else>
						<span class="cts-money">￥ <s:property value="coachPreOrderInfo.coach.baseCostPrices[1]"/></span>
					</s:else>	
				</li>
				</label>
			</s:if>
			<s:else>
				<label >
				<li>
					<span class="cts-cbox"></span>
					<span class="cts-time">下午 (14:00-17:00)&nbsp;<s:property value='coachProduct.productName'/></span>
					<s:if test="coachProduct!=null">
						<span class="cts-money">￥ <s:property value="coachPreOrderInfo.costInfo.prices[1]"/></span>	
					</s:if>
					<s:else>
						<span class="cts-money">￥ <s:property value="coachPreOrderInfo.coach.baseCostPrices[1]"/></span>
					</s:else>	
				</li>
				</label>		
			</s:else>
			<s:if test="coachPreOrderInfo.order.orderInfos[2]>0&&(coachPreOrderInfo.coach.dayJobTimeArr[2]==1)">
				<label for="cts-c-3">
				<li>
					<span class="cts-cbox"><input type="checkbox" name="times" value="2"  id="cts-c-3" /></span>
					<span class="cts-time">晚上 (18:00-21:00)&nbsp;<s:property value='coachProduct.productName'/></span>
					<s:if test="coachProduct!=null">
						<span class="cts-money">￥ <s:property value="coachPreOrderInfo.costInfo.prices[2]"/></span>	
					</s:if>
					<s:else>
						<span class="cts-money">￥ <s:property value="coachPreOrderInfo.coach.baseCostPrices[2]"/></span>
					</s:else>	
				</li>
				</label>
			</s:if>
			<s:else>
				<label >
				<li>
					<span class="cts-cbox"></span>
					<span class="cts-time">晚上 (18:00-21:00)&nbsp;<s:property value='coachProduct.productName'/></span>
					<s:if test="coachProduct!=null">
						<span class="cts-money">￥ <s:property value="coachPreOrderInfo.costInfo.prices[2]"/></span>	
					</s:if>
					<s:else>
						<span class="cts-money">￥ <s:property value="coachPreOrderInfo.coach.baseCostPrices[2]"/></span>
					</s:else>	
				</li>
				</label>		
			</s:else>
			<s:if test="coachPreOrderInfo.order.orderInfos[0]>0&&(coachPreOrderInfo.order.orderInfos[1]>0)&&(coachPreOrderInfo.order.orderInfos[2]>0)&&(coachPreOrderInfo.coach.dayJobTimeArr[0]==1)&&(coachPreOrderInfo.coach.dayJobTimeArr[1]==1)&&(coachPreOrderInfo.coach.dayJobTimeArr[2]==1)">
				<label for="cts-c-4">
				<li>
					<span class="cts-cbox"><input type="checkbox" name="times" value="3" id="cts-c-4" /></span>
					<span class="cts-time">全天 (09:00-21:00)&nbsp;<s:property value='coachProduct.productName'/></span>
					<s:if test="coachProduct!=null">
						<span class="cts-money">￥ <s:property value="coachPreOrderInfo.costInfo.prices[3]"/></span>	
					</s:if>
					<s:else>
						<span class="cts-money">￥ <s:property  value="coachPreOrderInfo.coach.baseCostPrices[3]"/></span>
					</s:else>	
				</li>
				</label>
			</s:if>
			<s:else>
				<label >
				<li>
					<span class="cts-cbox"></span>
					<span class="cts-time">全天 (09:00-21:00)&nbsp;<s:property value='coachProduct.productName'/></span>
					<s:if test="coachProduct!=null">
						<span class="cts-money">￥ <s:property value="coachPreOrderInfo.costInfo.prices[0]*3"/></span>	
					</s:if>
					<s:else>
						<span class="cts-money">￥ <s:property value="coachPreOrderInfo.coach.basePrice*3"/></span>
					</s:else>					
				</li>
				</label>		
			</s:else>		
			
		</ul>
	</div>
	
	<div class="cst-box">
	</div>    	
    	
	<div style="clear:both;"></div>
	<div class="buttona">
		<input type="submit" value="提交预定"/>
	</div>
	</form>
</div>

    
</body>
</html>
