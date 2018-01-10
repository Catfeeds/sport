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
<!--    <link rel="stylesheet" type="text/css" href="weixin/res/css/base.css"  /> -->
    <link rel="stylesheet" type="text/css" href="weixin/res/css/sportPayFail.css"  />
    <link rel="stylesheet" type="text/css" href="weixin/res/css/style.css"  />
    <script type="text/javascript" src="../res/js/jquery-1.7.2.min.js"></script>

	
	<style type="text/css">
		ul.site-box li {
			border:1px solid #39c;
			text-align:center;
			height:20px;
			line-height:20px;
			margin:4px 0px;
			padding:2px 0px;
		}
		c{
			color:#f60;
		}
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
							<td><s:property value='order.coach.skillType.typeName'/></td>
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
	    <div class="infoBox">
	    	<div class="showInfo">T_T 订单支付失败</div>
	    </div>
	    
	    
	    
	    <div class="clear"></div>
	    <div class="confirmOrder"> 
	    	<div class="confirmBtn">
	    		<a href="javascript:window.history.back(-1);">返回支付页面</a>
	    	</div>	
	    </div>

	</div>
	
</body>
</html>
