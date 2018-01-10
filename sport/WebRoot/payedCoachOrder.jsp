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

	<meta charset="UTF-8">
	<meta name="Generator" content="EditPlus®">
	<meta name="author" content="">
	<meta name="Keywords" content="">
	<meta name="Description" content="" />

	<title>支付成功</title>


	<link href="res/css/base.css" rel="stylesheet" type="text/css">
	<link href="res/css/coachBookedSuccess.css" rel="stylesheet" type="text/css">
	<!-- 弹出登录注册对话框 -->
	<link rel="stylesheet" href="res/commonComponents/loginPopDialog/css/loginbox.css"  type="text/css"/>
	<script type="text/javascript" src="res/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="res/js/header.js"></script>
	<!-- 弹出框结束 -->
<Style>
.coach-list{
			float: left;
			font-size:12px;
			 width: 250px; 
			padding:0 10px;
			margin: 5px; 
			border: 1px solid #6495ED;
		}
		.coach-list b{
			color:#f00;
			padding-left:20px;
		}
</Style>
</head>
<body>
	

	<iframe src="header" width="100%" height="190px" frameborder="0" scrolling="no"></iframe>
	

	<!-- order detail start -->
	<div class="orderdetail">
		<div class="orderdetailState">
			<ul>
				<li class="orderdetailStateOne">选择教练</li>
				<li class="orderdetailStateTwo">确认订单</li>
				<li class="orderdetailStateThree">选择支付方式</li>
				<li class="orderdetailStateFour">购买成功</li>
			</ul>
		</div>
		<div id="progressBar">
		     <!-- 进度条 -->
		     <div>
		         <span></span>
		     </div>
		     <!-- 五个圆 -->
		     <span class="spanOne"></span>
		     <span class="spanTwo"></span>
		     <span class="spanThree"></span>
		     <span class="spanFour"></span>
		</div>
	</div>
	<div class="orderdetailBox">
		<div class="orderdetailTitle">
			订单详情
		</div>
		<div class="orderdetailContentBox">
			<div class="orderdetailContentBoxBody">
				<div class="orderdetailName"><s:property value='order.items[0].coach.realName'/></div>
				<div class="orderdetailContent">
					<table class="orderdetailContentTable">
						<tr>
							<th width="100px">居住地：</th>
							<td><s:property value='order.items[0].coach.homeAddress.parentAddress.addressName'/>>
            			<s:property value='order.items[0].coach.homeAddress.addressName'/></td>
						</tr>
						<tr>
							<th>日　　期：</th>
							<td class="orderdetailDate"><s:date name="order.preOrderTime" format="yyyy-MM-dd" /> (<s:property value='order.week'/>)</td>
						</tr>
						<tr>
							<th>运动项目：</th>
							<s:if test="order.items[0].product!=null">
								<td><s:property value='order.items[0].product.productName'/></td>
							</s:if>
							<s:else>
								<td>教练自行安排</td>
							</s:else>	
						</tr>
						<tr>
							<th>预定场次：</th>
							<td style="overflow: hidden;">
							<s:iterator value="order.items"> 
						 		<span class='coach-list' id="<s:property value='coach.id'/><s:property value='coachPreOrder.id'/><s:property value='time'/>"
						 			orderItemId="<s:property value='id'/>">
						 			<s:date name="useDate" format="MM.dd" />/<s:property value='week'/>&nbsp;
						 			<s:if test="time==0">
						 				上午&emsp; 09：00--12：00
						 			</s:if>
						 			<s:elseif test="time==1">
						 				下午&emsp; 14：00--17：00
						 			</s:elseif>
						 			<s:elseif test="time==2">
						 				晚上&emsp; 18：00--21：00
						 			</s:elseif>
						 			<s:else>
						 				全天&emsp; 09：00--21：00
						 			</s:else>
						 			<b><s:property value='price'/></b>
						 		</span>
						 	</s:iterator>
							</td>
						</tr>
					</table>
				</div>
				<div class="orderdetailPrice">
					共&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;计：<span><s:property value='order.totalAcount'/></span>元
				</div>
			</div>
			<div class="orderdetailSuccessBox">
				<div class="orderdetailSuccessTitle">
					<h6>订单支付成功</h6>
				</div>
				
				<div class="orderdetailSuccessBtn">
					<ul>
						<li class="backToHome"><a href="index" >返回首页</a></li>
						<li class="moveNow"><a href="orderanduserOrderList" >马上跳转</a></li>
					</ul>		
				</div>
			</div>
		</div>

	</div>

	
	<!-- order detail end -->

	<iframe src="footer.jsp" width="100%" height="180px" frameborder="0" scrolling="no"></iframe>



	<!-- mainbanner select start -->
	<script type="text/javascript">
		$(".mainbannerNav ul li").hover(function(){
		$(this).addClass("mainbannerSelected").siblings().removeClass("mainbannerSelected");
		});
	</script>
	<!-- mainbanner select end -->
		

</body>
</html>
