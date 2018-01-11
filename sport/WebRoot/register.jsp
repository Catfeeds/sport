<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
<!--这里是title icon-->
<link rel="icon" href="res/images/headPic.ico" type="image/x-icon" />
<link rel="shortcut icon" href="res/images/headPic.ico" type="image/x-icon" />

<title>动起来注册</title>
<meta http-equiv="content-Type" content="text/html" charset="utf-8">
<link rel="stylesheet" type="text/css" href="res/css/indexUserLoad.css">

<script type="text/javascript" src="res/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="res/js/indexRegister.js"></script>

</head>
<body>
	<div class="content">
		<div class="ucSimpleHeader">
			<a href="index.jsp" class="meizuLogo"></a>
			<div class="trigger">
				<a href="login.jsp">登录</a>
				<span>&nbsp;|&nbsp;</span>
				<a href="javascript:void(0)">注册</a>
			</div>
		</div>
		<form method="post" action="userandregister" id="#mainForm1" class="mainForm mainForm1">
			<div class="number" style="text-align:center;">
				<div style="width:100px;margin:0 auto;"><a href="##" class="linkABlue" style="float:left;margin-left:5px;">用户注册</a></div>
			</div>			
			<div class="normalInput">
				<input type="text" class="username" name="user.userName" id="userName" maxlength="32" placeholder="用户名">	
			</div>			
			<span class="error error1" id="userNameInfo">*</span>
			<div class="normalInput">
				<input type="text" class="phone" id="phone" name="user.phone" maxlength="11" placeholder="手机号码">	
			</div>
			<span class="error error2"></span>
			<div class="normalInput">
				<input type="text" class="kapkey" name="confirmCode" maxlength="4" placeholder="验证码">
				<span class="formLine"></span>
				<a href="javascript:void(0);" id="getKey" class="linkABlue">获取验证码</a>
			</div>
			<span class="error error3"></span>
			<div class="normalInput">
				<input type="text" class="password" name="user.password" maxlength="16" autocomplete="off" placeholder="密码">
				<input type="password" class="password1" name="user.passwordConfirm" maxlength="16" autocomplete="off" placeholder="密码">
				<a id="pwdBtn" href="javascript:void(0);" class="pwdBtnShow" isshow="false">
					<i class="i_icon"></i>
				</a>
			</div>
			<span class="error error4"></span>
			<div class="rememberField">
				<span class="checkboxPic check_chk" tabindex="-1" isshow="false">
					<i class="i_icon"></i>
				</span>
				<label class="pointer">我已阅读并接受</label>
				<a href="javascript:void(0);" target="_blank" class="linkABlue">《xxxx服务协议条款》</a>
			</div>
			<span class="otherError">请确认已阅读并同意xxxx服务协议条款</span>
			<input type="submit" onclick="OnSubmit();return false;" class="fullBtnBlue" value="注册"/>			
		</form>
	</div>
	
	</div>
	<div id="mz_Float">
		<div class="mz_FloatBox">
			<div class="mz3AngleL">
				<i class="i_icon"></i>
			</div>
			<div class="mzFloatTip bRadius2">长度为8-16个字符，区分大小写，至少包含两种类型</div>
		</div>
	</div>
	<div style="text-align:center;">
</div>
<script type="text/javascript">
	var codeOkFlag=false;
	var confirmCode="";
	$("input[name=confirmCode]").keyup(function(){
		var userInputCode=$("input[name=confirmCode]").attr("value");
		if(userInputCode.length!=4)
			return;
		if(userInputCode==confirmCode)
		{	
			codeOkFlag=true;//验证成功！
			alert("手机号验证成功");
		}else{
			codeOkFlag=false;//验证失败！
			alert("手机号验证失败！请重试！");
		}
	});
	$("#getKey").click(
			function(){							
				var phone=$.trim($("#phone").attr('value'));
				if(phone!=""&&(phone.length==11)){
					$.post("commonandsendMessage", { "code.phone":phone},
					   function(data){
					   		 var arr=new Array();
							$.each(data, function(i, item) {
								arr.push(item);					           
							});
							$("#mz_Float").css("top","232px");
							if(arr[0]){//true时表示操作成功，更改界面元素状态												    
								$(".error2").html(arr[1]).css('color','blue');								
								confirmCode=arr[2];								
								
							}else{
								$(".error2").html(arr[1]).css('color','red');
							}					   
					   },"json");
				}else{
					data="电话号码为11个数字!";
					//$("#userNameInfo").html(data).css('color','red');
					 $("#mz_Float").css("top","232px");
						$(".error2").html(data);
				}				
			}
	);
	$("#userName").blur(
			function(){
				var username=$.trim($("#userName").attr('value'));
				if(username!=""&&(username.length>6)){
					$.post("userandisExistsUserName", { "user.userName":$("#userName").attr('value')},
					   function(data){
					   		 var arr=new Array();
							$.each(data, function(i, item) {
								arr.push(item);					           
							});
							$("#mz_Float").css("top","232px");
							if(arr[0]){//true时表示操作成功，更改界面元素状态												    
								$("#mz_Float").find(".bRadius2").html(arr[1]).css('color','blue');
							}else{
								$("#mz_Float").find(".bRadius2").html(arr[1]).css('color','red');
							}					   
					   },"json");
				}else{
					data="用户名为6个字符以上!";
					//$("#userNameInfo").html(data).css('color','red');
					 $("#mz_Float").css("top","232px");
						$("#mz_Float").find(".bRadius2").html(data).css('color','red');
				}				
			}
	);
	function OnSubmit(){
		if(!codeOkFlag){
			alert("您输入的验证码有误，请重新发送验证码再试！");
			return false;
		}
		form[0].submit();
	}
</script>
</body>
</html>