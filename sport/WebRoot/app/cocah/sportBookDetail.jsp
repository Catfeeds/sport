<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
basePath += "cocah/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    	
	<title>享动</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<!--    <link rel="stylesheet" type="text/css" href="../res/css/base.css"  /> -->
    <link rel="stylesheet" type="text/css" href="../res/css/sportBookDetail.css"  />
    <link rel="stylesheet" type="text/css" href="../res/css/style.css"  />
    <script type="text/javascript" src="../res/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="../res/js/common.js" ></script>
	
	<style type="text/css">

	</style>

</head>
<body>
	
	<div id="header">
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
            <h2>请认真核对预定信息：</h2>
            <table class="orderdetailContentTable">
				<tr>
					<th>教　　练：</th>
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
	    <div style="padding:0px 10px;font-size:12px;">免注册直接购买</div>

	    <div class="confirmCode"> 
	    	<div class="div-phone">
	    		<input type="text" id="phone" class="infos" placeholder="请输入手机号码" />
	    		<a href="javascript:;" class="send1" onclick="sends.send();">发送验证码</a>
	    	</div>
	    	<div class="div-ranks">
				<input type="text" id="ranks" class="infos" placeholder="请输入验证码"  />
			</div>
	    </div>
		<div class="clear"></div>
	    <div class="confirmOrder"> 
	    	<div class="confirmBtn">
	    		<a href="sportSelectPay.jsp">确认订单</a>
	    	</div>	
	    </div>
	    <div class="clear"></div>
	    <div class="warnInfo">
    		请认真核对场地信息，付款保证100%有场，提交订单请<span>10分钟</span>内完成付款，否则场地不予保留。
    	</div>

	</div>
	
	<script>
		var sends = {
			checked:1,
			send:function(){
					var numbers = /^1\d{10}$/;
					var val = $('#phone').val().replace(/\s+/g,""); //获取输入手机号码
					if($('.div-phone').find('span').length == 0 && $('.div-phone a').attr('class') == 'send1'){
						if(!numbers.test(val) || val.length ==0){
							$('.div-phone').append('<span class="error">手机号码格式错误</span>');
							return false;
						}
					}
					if(numbers.test(val)){
						var time = 60;
						$('.div-phone span').remove();
						function timeCountDown(){
							if(time==0){
								clearInterval(timer);
								$('.div-phone a').addClass('send1').removeClass('send0').html("发送验证码");
								sends.checked = 1;
								return true;
							}
							$('.div-phone a').html(time+"S后再次发送");
							time--;
							return false;
							sends.checked = 0;
						}
						$('.div-phone a').addClass('send0').removeClass('send1');
						timeCountDown();
						var timer = setInterval(timeCountDown,1000);
					}
			}
		}
		</script>
</body>
</html>
