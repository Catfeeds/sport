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
    <link rel="stylesheet" type="text/css" href="weixin/res/css/sportBookDetail.css"  />
    <link rel="stylesheet" type="text/css" href="weixin/res/css/style.css"  />
    <script type="text/javascript" src="weixin/res/js/jquery-1.7.2.min.js"></script>
	
	<style type="text/css">
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
		
		/* Anonymous ---------------------------*/
		.confirmCode .div-phone .send1 {
			float:left;
		}
		#phone {
			width: 96%;
			margin-top:5px;
		}
		#pic-code {
			width: 60%;
		}
		#pic-code-box {
			display:-moz-inline-box; 
    		display:inline-block;
			width: 34%;
			border:1px solid #ddd;
			height: 30px;
			margin-top:3px;
			margin-left:1%;
		}
		#pic-code-box img{
			width:100%;
			height: 28px;
		}
		.div-ranks,.div-phone {
			margin:5px 0px;
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
		$(document).ready(function() {
			document.getElementById("phone").focus();
			
			$(".m-bbtn").click(function(){
				window.history.back(-1);
			});
			
			$(".m-hbtn").click(function(){
				self.location='weixin/weixinandchooseCoach'; 
			});
		});
	</script> 

</head>
<body>
	
	<div id="header">
		<div class="m-bbtn">
			<img alt="" src="weixin/res/images/back.png" />
		</div>
		<div class="m-hbtn">
			<img alt="" src="weixin/res/images/home.png" />
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
            <h2>请认真核对预定信息：</h2>
            <table class="orderdetailContentTable">
				<tr>
					<th>教　　练：</th>
					<td><s:property value='order.coach.realName'/></td>
				</tr>
				<tr>
					<th>日　　期：</th>
					<td class="orderdetailDate"><s:date name="order.preOrderTime" format="yyyy-MM-dd" /> (<s:property value='order.week'/>)</td>
				</tr>
				<tr>
					<th>运动项目：</th>
					<td>
						<s:property value='order.coach.skillType.typeName'/>
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
					 			<s:date name="useDate" format="MM.dd" />/<s:property value='week'/>&nbsp;
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
	    <div style="padding:0px 10px;font-size:12px;">免注册直接购买</div>

	    <div class="confirmCode"> 
	  		<div class="div-ranks">
				<input type="text" id="phone" class="infos" placeholder="请输入手机号码"  />
			</div>
			<div class="clear"></div>
	    	<div class="div-ranks">
	    		<input type="text" id="pic-code" class="infos" maxlength="6" name="confirmImgCodeTop" placeholder="请输入右方验证码" />
	    		<span id="pic-code-box">
	    			<img id="confirmImgTop" src="" confirmImgCode=""/>
	    		</span>
	    	</div>
	    	<div class="clear"></div>
	    	<div class="div-phone">
	    		<a href="javascript:void(0)" class="send1"  id="sendMessageBtn">获取短信验证码</a>
	    	</div>
	    	<div class="clear"></div>
	    	<div class="div-ranks">
				<input type="text" id="ranks" name="confirmCode" maxlength="4" class="infos" placeholder="请输入短信验证码"  />
			</div>
	    </div>
		<div class="clear"></div>
	    <div class="confirmOrder"> 
	    	<div class="confirmBtn">
	    		<a id="submitBtn" href="javascript:void(0);"
	    		 url="weixin/orderandtoPayOrder?order.id=<s:property value='order.id'/>">确认订单</a>
	    	</div>	
	    </div>
	    <div class="clear"></div>
	    <div class="warnInfo">
    		请认真核对场地信息，付款保证100%有场，提交订单请<span>10分钟</span>内完成付款，否则场地不予保留。
    	</div>

	</div>
	
<script type="text/javascript">
$(function(){
	var url=$("#submitBtn").attr("url");
	var codeOkFlag=false;
    var imgCodeOkFlag=false;
    var confirmCode="";
    var confirmImgCode="";
    $("input[name=confirmCode]").keyup(function(){
    	var userInputCode=$("input[name=confirmCode]").attr("value");
    	if(userInputCode.length!=4)
    		return;
    	if(userInputCode==confirmCode)
    	{	
    		codeOkFlag=true;//验证成功！
    		//alert("手机号验证成功");
    		//$("input[name=confirmCode]").css({background:"url(weixin/res/images/code-right.png) no-repeat fixed right"});
    		$("input[name=confirmCode]").css({background:"url(weixin/res/images/code-right.png) no-repeat 90% center"});
    	}else{
    		codeOkFlag=false;//验证失败！
    		//alert("手机号验证失败！请重试！");
    		//$("input[name=confirmCode]").css({border:"2px solid #f00"});
    		$("input[name=confirmCode]").css({background:"url(weixin/res/images/code-wrong.png) no-repeat 90% center"});
    	}
    });
    gainImageConfirm();//初始化验证码
    	$("#confirmImgTop").click(function(){
    		imgCodeOkFlag=false;
    		confirmImgCode="";
    		gainImageConfirm();//初始化验证码
    	});
    	//获取图像验证码
    	function gainImageConfirm(){
    		$("input[name=confirmImgCodeTop]").val("");//清空
    		var imgObj=$("#confirmImgTop");    		
    		//先获取图片
    		$(imgObj).attr("src","confirmCodeandgainImage?now="+new Date());
    		//延时1秒
    		var timer=setTimeout("getCode()",100);    		
    		window.getCode=function getCode(){    			
	    		$.post("confirmCodeandgainConfirmCode",
					function(data){
						if(data!=null){
						   confirmImgCode=new String(data).toLowerCase();//$.parseJSON(data);
						   $(imgObj).attr("confirmImgCode",confirmImgCode);
						   //alert("code:"+confirmImgCode);
						}  						
					},'json');	    		
    		}
    		
    	}
    	$("input[name=confirmImgCodeTop]").keyup(function(){
    		var val=new String($(this).val()).toLowerCase();
        	if(val.length!=6)
        		return;        	
        	if(confirmImgCode==val)
        	{	
        		imgCodeOkFlag=true;//验证成功！
        		//alert("图形验证码验证成功");
        		//$("input[name=confirmImgCodeTop]").css({border:"2px solid #0c0"});
        		$("input[name=confirmImgCodeTop]").css({background:"url(weixin/res/images/code-right.png) no-repeat 90% center"});
        	}else{
        		imgCodeOkFlag=false;//验证失败！
        		//alert("图形验证码验证失败！请重试！");
        		//$("input[name=confirmImgCodeTop]").css({border:"2px solid #f00"});
        		$("input[name=confirmImgCodeTop]").css({background:"url(weixin/res/images/code-wrong.png) no-repeat 90% center"});
        	}
        	//alert("val:"+val+"  confirmImgCode:"+confirmImgCode+" flag:"+imgCodeOkFlag);
        });
    	//发送短信验证码
    	$("#sendMessageBtn").click(function(){
    		//先判断图形验证码是否验证成功    		
    		if(!imgCodeOkFlag){
    			alert("图形验证码验证成功后才能进行短信验证！");
    			return;
    		}
    		//再进行短信验证码验证
        	sends.send();
        });
    var timer ;
    var sendingFlag=false;
    var sends = {
    	checked:1,
    	send:function(){
    			if(sendingFlag)
    				return;
    			
    			var numbers = /^1[3|4|5|7|8][0-9]\d{4,8}$/;
    			var val = $("#phone").val().replace(/\s+/g,""); //获取输入手机号码
    			if(!numbers.test(val) || val.length ==0){
    				alert("手机号码格式不对！");
    				return false;
    			}
    			if(val!=""&&(val.length==11)){
    				$.post("commonandsendMessage", { "code.phone":val,"code.templateId":"3"},
    				   function(data){
    				   		 var arr=new Array();
    						$.each(data, function(i, item) {
    							arr.push(item);					           
    						});						
    						if(arr[0]){//true时表示操作成功，更改界面元素状态	
    							confirmCode=arr[2];		
    						}else{
    							alert(arr[1]);
    						}					   
    				   },"json");
    			}else{
    				data="电话号码为11个数字!";
    				alert(data);
    				return;
    			}				
    			if(numbers.test(val)){
    				var time = 60;
    				$('.div-phone a').addClass('darkblue').removeClass('blue').DISABLED;
    				function timeCountDown(){
    					if(time==0){
    						sendingFlag=false;
    						clearInterval(timer);
    						$('.div-phone a').addClass('send1').removeClass('send0').html("获取短信验证码");
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
    				sendingFlag=true;
    				timer= setInterval(timeCountDown,1000);
    			}
    	}
    }
    $("#loginBtn").click(function (){
    	var userName=$("input[name=userName]").val();
    	var password=$("input[name=password]").val();
    	$.post("userandasynLogin", { "user.userName":userName,
    								 "user.password":password
    								},
    			   function(data){
    			   		 var arr=new Array();
    					$.each(data, function(i, item) {
    						arr.push(item);					           
    					});						
    					if(arr[0]){//true时表示操作成功，更改页面元素	
    						//这里刷新整个页面
    					   	window.top.location=window.top.location;	
    					}else{
    						alert(arr[1]);
    					}					   
    			   },"json");
    });
    
    $("#submitBtn").click(function(){
    	if(!codeOkFlag){
    		alert("您输入的验证码有误，请重新发送验证码再试！");
    		return false;
    	}
    	
    	url+="&order.phone="+$("#phone").val();
    	//alert(url);
    	///return;
    	$("#submitBtn").attr("href",url);
    });
});
</script>
</body>
</html>
