<%@ page language="java"  contentType="text/html; charset=UTF-8" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>享动</title>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<link rel="stylesheet" type="text/css" href="weixin/res/css/based.css"  />
<link rel="stylesheet" type="text/css" href="weixin/res/css/myOrder.css"  />
<script type="text/javascript" src="weixin/res/js/jquery-1.8.3.min.js"></script>
<style>
.discountList li table {
	width:98%;
	margin:0px auto;
}
.discountList li table tr td{
	padding:2px 0px;
	color:#999;
}
.discountList li table td.bf-t {
	font-size:24px;
	color:#f60 !important;
}
.discountList li table td.cf-t {
	color:#f60 !important;
}
.discountList li table td.frtd {
	text-align:right;
	color:#111;
}
.discountList li table tr td ul.site-box {

}
.discountList li table tr td ul.site-box li {
	border:1px solid #39c;
	text-align:center;
	height:26px;
	line-height:26px;
	margin:4px 0px;
	padding:2px 0px;
}
/* 未支付订单样式 *************************************/
.discountList .pay-box .pay-btn, .discountList .pay-box .return-btn, .discountList .pay-box .bi-btn {
	width:48%;
	background:#f60;
	float:left;
	margin:0px 1%;
	height:36px;
	text-align:center;
	line-height:36px;
	
}
.discountList .pay-box .return-btn {
	background:#3cf;
	margin-left:25%;
	margin-top:10px;
}
.discountList .pay-box .bi-btn {
	background:#3cf;
}

.discountList .pay-box .pay-btn a, .discountList .pay-box .return-btn a, .discountList .pay-box .bi-btn a {
	color:#fafafa;
	font-size:16px;
}
/* 确认订单样式 *************************************/
.discountList .confirm-box .pay-btn, .discountList .confirm-box .quit-btn {
	width:48%;
	background:#f60;
	float:left;
	margin:0px 1%;
	height:36px;
	text-align:center;
	line-height:36px;
	
}
.discountList .confirm-box .quit-btn {
	background:#3cf;
}
.discountList .confirm-box .pay-btn a, .discountList .confirm-box .quit-btn a{
	color:#fafafa;
	font-size:16px;
}
/* 已支付样式 *************************************/
.discountList .return-box {
	width:50%;
	background:#3cf;
	float:left;
	margin-left:25%;
	height:36px;
	text-align:center;
	line-height:36px;
}
.discountList .return-box a {
	color:#fafafa;
	font-size:16px;
}

c{
	color:#f60;
}
.coach-list {
	text-align:center;
}
</style>

</head>

<body>
	<div id="header">
	    <!-- top banner -->
		<div class="topbanner">
	        订单详情
	    </div>
	    <!-- top banner -->   
	</div>
	
	<div id="content">
		<div class="discountListBox">
			<ul class="discountList">
        		<li>
        			<div>
        				<table>
        					<tr>
        						<td>付款金额</td>
        						<td class="frtd bf-t">&yen;<s:property value='order.totalAcount'/></td>
        					</tr>
        					<tr>
        						<td>类　　型</td>
        						<s:if test="order.coach==null">
        						<td class="frtd">场馆预定</td>
        						</s:if>
        						<s:else>
        						<td class="frtd">教练预定</td>
        						</s:else>
        					</tr>
        					<tr>
        						<td>项　　目</td>
        						<s:if test="order.coach==null">
        							<td class="frtd"><s:property value="items[0].product.productName"/></td>
        						</s:if>
        						<s:else>
        							<td class="frtd"><s:property value="items[0].coach.realName"/>&nbsp;
									<s:if test="items[0].product!=null">
										<s:property value="items[0].product.productName"/>
									</s:if>
									<s:else>
										教练自行安排
									</s:else></td>
        						</s:else>
        					</tr>
        					<tr>
        						<s:if test="order.coach==null">
        						<td>场　　馆</td>
        						<td class="frtd"><s:property value="order.items[0].place.site.siteName"/></td>
        						</s:if>
        						<s:else>
        						<td>教        练</td>
        						<td class="frtd"><s:property value="order.coach.realName"/></td>
        						</s:else>
        					</tr>
        					<tr>
        						<td>预定消费时间</td>
        						<td class="frtd cf-t"><s:date name='order.preOrderTime' format="yyyy-MM-dd"/> (<s:property value='order.week'/>)</td>
        					</tr>
        					<tr>
        						<td>订单状态</td>
        						<s:if test="order.orderStatus<3">
									<td class="frtd">未支付</td>									
								</s:if>
								<s:elseif test="order.orderStatus==3">
									<td class="frtd">已支付（未确认消费）</td>	
								</s:elseif>
								<s:elseif test="order.orderStatus==4">
									<td class="frtd">已经消费</td>	
								</s:elseif>
								<s:elseif test="order.orderStatus==5">
									<td class="frtd">已失效（建议删除）</td>	
								</s:elseif>
								<s:elseif test="order.orderStatus==6">
									<td class="frtd">订单正在支付中</td>	
								</s:elseif>
								<s:elseif test="order.orderStatus==7">
									<td class="frtd">支付失败（建议删除）</td>	
								</s:elseif>
								<s:elseif test="order.orderStatus==8">
									<td class="frtd">正在申请退款</td>	
								</s:elseif>
								<s:elseif test="order.orderStatus==9">
									<td class="frtd">已经退款成功</td>	
								</s:elseif>
								<s:elseif test="order.orderStatus==10">
									<td class="frtd">已经短信验证成功</td>	
								</s:elseif>
        					</tr>
        					<tr>
        						<s:if test="order.coach==null">
        						<td>预定场地</td>
        						<td class="frtd">
        							<ul class="site-box">
        								<s:iterator value="order.items">
											<li>场地<s:property value='place.placeName'/>&emsp;
											<s:property value='time'/>：00-<s:property value='time+1'/>：00</li>
										</s:iterator>
        							</ul>
								</td>
								</s:if>
								<s:else>
									<s:iterator value="order.items"> 
									 		<li class='coach-list' id="<s:property value='coach.id'/><s:property value='coachPreOrder.id'/><s:property value='time'/>"
									 			orderItemId="<s:property value='id'/>">
									 			<s:date name="useDate" format="MM.dd" />/<s:property value='week'/>&nbsp;
									 			<s:if test="time==0">
									 				上午&nbsp;09:00--12:00
									 			</s:if>
									 			<s:elseif test="time==1">
									 				下午&nbsp;14:00--17:00
									 			</s:elseif>
									 			<s:elseif test="time==2">
									 				晚上&nbsp;18:00--21:00
									 			</s:elseif>
									 			<s:else>
									 				全天&nbsp;09:00--21:00
									 			</s:else>
									 			<c>￥<s:property value='price'/></c>
									 		</li>
									</s:iterator>
								</s:else>
        					</tr>
        					<tr>
        						<td>订单编号</td>
        						<td class="frtd"><s:property value='order.orderNumber'/></td>
        					</tr>
        				</table>
        			</div>
        		</li>
        		<div class="pay-box" >
					<s:if test="order.orderStatus<3||(order.orderStatus==6)||(order.orderStatus==10)">
						<div class="pay-btn"><a
							href="weixin/orderandresubmitOrder?order.id=<s:property value='order.id'/>">
								去支付 </a>
						</div>
						<div class="pay-btn"><a class="deleteBtn"  href="javascript:void(0);"
							orderId="<s:property value='order.id'/>">删除</a>
						</div>
						<div class="return-btn">
							<a href="javascript:history.go(-1);">返回上一级</a>
						</div>
					</s:if>
					<s:elseif test="order.orderStatus==3">
						<div class="pay-btn"><a class="confirmUseBtn" href="javascript:void(0);"
							orderId="<s:property value='order.id'/>">确认已消费</a>
						</div>
						<div class="pay-btn"><a class="refoundBtn"
							href="weixin/orderandrefound?order.id=<s:property value='order.id'/>"
							orderId="<s:property value='order.id'/>" >申请退款</a>
						</div>
						<div class="return-btn">
							<a href="javascript:history.go(-1);">返回上一级</a>
						</div>
					</s:elseif>
					<s:elseif test="order.orderStatus==4">
						<div class="pay-btn">
							<a class="deleteBtn" href="javascript:void(0);" orderId="<s:property value='order.id'/>">删除</a>
						</div>
						<div class="bi-btn">
							<a href="javascript:history.go(-1);">返回上一级</a>
						</div>
					</s:elseif>
					<s:elseif test="order.orderStatus==5||(order.orderStatus==7)||(order.orderStatus==9)">
						<div class="pay-btn">
							<a class="deleteBtn"  href="javascript:void(0);" orderId="<s:property value='order.id'/>" >删除</a>
						</div>
						<div class="bi-btn">
							<a href="javascript:history.go(-1);">返回上一级</a>
						</div>
					</s:elseif>
					<s:elseif test="order.orderStatus==8">
						<div class="pay-btn">
							<a href="weixin/refoundandrefoundDetail?refound.order.id=<s:property value='order.id'/>">
								申请详情								
							</a>
						</div>
						<div class="bi-btn">
							<a href="javascript:history.go(-1);">返回上一级</a>
						</div>
					</s:elseif>
				</div>
       		</ul>
		</div>
	</div>
<script type="text/javascript">
	$(function(e) {
				$(".confirmUseBtn").click(function(){//确认该订单已经消费了
					$.post("weixin/orderanduseOrder",
					 	{   "order.id":$(this).attr("orderId")
					 	 },
						function(data){
							var arr=new Array();
							$.each(data, function(i, item) {
								arr.push(item);					           
							});
							if(arr[0]){//true时表示操作成功，更改界面元素状态								
								//这里刷新整个页面
					   			window.top.location=window.top.location;
							}else{
								alert(arr[1]);
							}												
					},'json'); 
				});
				$(".refoundBtn").click(function(){//确认该订单已经消费了
					var refoundUrl=$(this).attr("refoundUrl");
					$.post("weixin/orderandaplyRefound",
					 	{   "order.id":$(this).attr("orderId")
					 	 },
						function(data){
							var arr=new Array();
							$.each(data, function(i, item) {
								arr.push(item);					           
							});
							if(arr[0]){//true时表示操作成功，更改界面元素状态								
								//这里刷新整个页面
					   			window.top.location=refoundUrl;
							}else{
								alert(arr[1]);
							}												
					},'json'); 
				});
				$(".deleteBtn").click(function(){//确认该订单已经消费了
					$.post("weixin/orderanddeleteOrder",
					 	{   "order.id":$(this).attr("orderId")
					 	 },
						function(data){
							var arr=new Array();
							$.each(data, function(i, item) {
								arr.push(item);					           
							});
							if(arr[0]){//true时表示操作成功，更改界面元素状态								
								
					   			history.go(-1);
							}else{
								alert(arr[1]);
							}												
					},'json'); 
				});
							
				
	});
</script>
</body>
</html>
