<%@ page language="java"  contentType="text/html; charset=UTF-8" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<title></title>
		<link href="res/css/refund.css"rel="stylesheet" type="text/css" charset="UTF-8" />
	</head>
	<style>
		.finance-settlement{
			border: 1px solid #DDDDDD;
			border-radius: 10px;
			padding:20px  10px;
			padding-bottom: 100px;
			width:600px;
			height: auto;
			margin: auto;
			font-size: 16px;
			font-family: "微软雅黑";
			background:#F0F0EE;
		}
		.finance-settlement-div div{
			width:140px;
			float:left;
		}
	</style>
	<body>
		<div class="finance-mainbody">
			<form action="refoundandsubmitRefound" method="post">
				<input type="hidden" name="refound.order.id" value="<s:property value='order.id'/>" />
			<div class="finance-settlement">
				<h2>享动平台退款申请单</h2>
			<h4>订单信息</h4>
			<p>订单编号：<s:property value='order.orderNumber'/></p>
			<p>订单状态：已付款</p>
			<p>下单时间：<s:date name="order.createTime" format="yyyy-MM-dd"/></p>
			<h4>退款信息</h4>
			<p>可退金额:&emsp;<b>&yen;<s:property value="order.totalAcount"/></b></p>
			<div class="finance-settlement-div">
				<div>联&nbsp;系&nbsp;电&nbsp;话&emsp;：&emsp;</div>
				<input type="text" name="refound.phone" /> *
			</div>
			<div class="finance-settlement-div">
				<div>姓&emsp;&emsp;&emsp;名&emsp;：&emsp;</div>
				<input type="text" name="refound.realName"/> 
			</div>
			<div class="finance-settlement-div">
				<div>支付宝帐号&emsp;：&emsp;</div><input type="text" name="refound.zifubaoAcount"/> 
			</div>
			<div class="finance-settlement-div">
				<div>微信支付帐号：</div><input type="text" name="refound.weixinAcount"/> *
			</div>
			<div class="finance-settlement-div">
				<div style="text-align: left;top: 0;">退款原因&emsp;&emsp;:&nbsp;&nbsp;&nbsp;&nbsp;</div>
				<textarea name="refound.reason" style="width: 200px;margin: 0;resize:none;"></textarea> *
			</div>
			<div class="refundtip">
				<h4>退款声明:</h4>
				 <p>1. 若您的订单需要进行退款，那么请您向客服告知订单编号及退款原因，申请退款，我们会及时为您办理退款。</p>
				 <p>2. 申请成功后将有工作人员向您联系，以确认相关事项，给您带来的不便请见谅！</p>
				 <p>3. 请在订单生效2小时前进行退款申请，若距离订单生效不足2小时的，平台不予受理。</p>
				 <p>4. 退款申请提交后，我们会尽快为您办理退款，请您在1-5个工作日内查询您提供的账户交易情况，如有异常情况，请咨询在线客服。</p>
				 <p>5. 支付宝账号：请确保您提供的支付宝账号经过实名验证，以免退错或余额不能提取。</p>
			</div>

		
			
				<input type="submit" value="申请退款" class="finance-settlement-input"/>
			<div class="finance-settlement-button">
				<a href="javascript:history.back(-1);" >取消</a>
			</div>
			</form>
		</div>
			
		</div>
		
	</body>
</html>
