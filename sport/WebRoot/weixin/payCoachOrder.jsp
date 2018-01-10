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
    <link rel="stylesheet" type="text/css" href="weixin/res/css/sportSelectPay.css"  />
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
		ul.site-box li {
			border:1px solid #39c;
			text-align:center;
			height:20px;
			line-height:20px;
			font-size:14px;
			margin:4px 0px;
			padding:2px 0px;
		}
		c{
			color:#f60;
		}
	</style>
	
	<script type="text/javascript">
		$(function() {
			
			$(".m-bbtn").click(function(){
				window.history.back(-1);
			});
			
			$(".m-hbtn").click(function(){
				self.location='<%=basePath%>/weixin/weixinandchooseCoach'; 
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
                确认订单
            </div>
            <div class="clear"></div>
        </div>
        <!-- top banner -->  	
	</div>

	<div id="content">

		<div class="detailBox">
                        <h2>请再次认真核对预定信息：</h2>
            <table class="orderdetailContentTable">
				<tr>
					<th>教　　练：</th>
					<td><s:property value='order.coach.realName'/></td>
				</tr>
				<tr>
					<th>日　　期：</th>
					<td class="orderdetailDate"><s:date name="order.preOrderTime" format="yyyy-MM-dd" /> (<s:property value='order.week'/>) </td>
				</tr>
				<tr>
					<th>运动项目：</th>
					<td><s:if test="order.items[0].product!=null">
							<s:property value='order.coach.skillType.typeName'/>
						</s:if>
						<s:else>
							教练自行安排
						</s:else>
					</td>
				</tr>
				<tr>
					<th>运动时间：</th>
					<td>
						<ul class="site-box">
							<s:iterator value="order.items"> 							
								<li class='coach-list' id="<s:property value='coach.id'/><s:property value='coachPreOrder.id'/><s:property value='time'/>"
						 			orderItemId="<s:property value='id'/>">
						 			<!--  
						 			<s:date name="useDate" format="MM.dd" />/<s:property value='week'/>
						 			-->
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
						</ul>
					</td>
				</tr>
			
			</table>
	    </div>

	    <div class="detailPriceBox">
            <table class="orderdetailContentTable">
				<tr>
					<th>总　　价：</th>
					<td class="orderdetailPrice">&yen;<s:property value='order.totalAcount'/></td>
				</tr>
			</table>
	    </div>
	    <div class="clear"></div>
	    <div style="padding:0px 10px;font-size:12px;">请在10分钟内完成支付,否则场地不予保留!</div>
	    
		 <div class="selectPayBox">
	    	<ul >
	    		<li class="payType">
	    			<div class="payBtn">
	    				<input type="radio" name="payStyle" checked="checked" value="1"/>
	    			</div>
	    			<div class="payPic">
	    				<img src="weixin/res/images/weixinpay.png" />
	    			</div>
	    			
	    		</li>
	    		<li class="payType">
	    			<div class="payBtn">
	    				<input type="radio" name="payStyle" value="2"/>
	    			</div>
	    			<div class="payPic">
	    				<img src="weixin/res/images/bank.jpg" />
	    			</div>	    			
	    		</li>
	    	</ul>
	    </div>
	    <div class="clear"></div>
	    <div class="confirmOrder"> 
	    	<div class="confirmBtn">
	    		<a href="javascript:void(0);" id="payBtn" orderId="<s:property value='order.id'/>" 
	    		 	redirectUrl="weixin/orderandpayedOrder?order.id=<s:property value='order.id'/>"
	    		 	failRedirectUrl="weixin/orderandpayFailed?order.id=<s:property value='order.id'/>"> 确认支付</a>
	    	</div>	
	    </div>

	</div>
	<script type="text/javascript">
		$(function(){
			var redirectUrl;
			var failRedirectUrl;
			$("#payBtn").click(function(){
				var payStyle=$("input[name=payStyle]:checked").val();
				var orderId=$(this).attr("orderId");
				redirectUrl=$(this).attr("redirectUrl");
				failRedirectUrl=$(this).attr("failRedirectUrl");
				if(payStyle=="1"){
					$.post("weixin/orderandwxJsPay", {"order.id":orderId},
					   function(data){
					   	 var arr=[];
    						$.each(data, function(i, item) {
    							arr.push(item);					           
    						});		
    						
    						if(arr[0]){//true时表示操作成功	    							
    							var jsonObj=JSON.parse("{"+arr[1]+"}");
    							jsPay(jsonObj);
    						}else{
    							alert(arr[1]);
    						}		
					   },'json');
					
				}else{
					alert("不好意思,暂时不支持支付宝支付!");
				}
			});
			function jsPay(param){				
				WeixinJSBridge.invoke('getBrandWCPayRequest',param,
					 function(res){
					  //支付成功或失败前台判断
					  if(res.err_msg=='get_brand_wcpay_request:ok'){
					     alert('恭喜您，支付成功!');
					     document.location=redirectUrl;
					   }else{
					   	alert('支付失败,请重试！');
					   	document.location=failRedirectUrl;
					 }
				});
			}
			$(".m-bbtn").click(function(){
				window.history.back(-1);
			});
			
			$(".m-hbtn").click(function(){
				self.location='<%=basePath%>/weixin/weixinandchooseCoach'; 
			});
		});		
	</script>
</body>
</html>
