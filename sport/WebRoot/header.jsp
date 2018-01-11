<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">

	<meta charset="UTF-8">
	<title>动起来</title>
	<link href="res/css/base.css" rel="stylesheet" type="text/css">
	<link href="res/css/header.css" rel="stylesheet" type="text/css">
	<!-- 弹出登录注册对话框 -->
	<link rel="stylesheet" href="res/commonComponents/loginPopDialog/css/loginbox.css"  type="text/css"/>
	<script type="text/javascript" src="res/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="res/js/header.js"></script>
	<script type="text/javascript" src="res/js/main.js"></script>
	<!-- 弹出框结束 -->
	
	<style>
	/* input type=number 去掉默认样式*/	
	input::-webkit-outer-spin-button,
	input::-webkit-inner-spin-button{
	    -webkit-appearance: none !important;
	    margin: 0;
	}  /* chrome*/
	input[type="number"]{
	     -moz-appearance:textfield
	;}  /* firefox*/ 
	/* input type=number 去掉默认样式*/
	
	.fieldset .pic-box-span img{
	    width:140px;
	    height:38px;
	    vertical-align:center;
	    border:1px dashed black;
	    padding:1px;
	}
	</style> 
	
</head>
<body>
	
	<!-- top start -->
	<div class="topbanner">
		<div class="topbannerBox">
			<div class="topbannerBoxLeft">
				<div class="topbannerBoxLogo">
					<img  src="res/images/toplogo.png" />
				</div>	
				<div class="topbannerBoxWord">
					&nbsp;&nbsp;欢迎来到享动网
				</div>
			</div>
			<div class="topbannerBoxRight">
				<s:if test="#session.currentUser!=null">
					<a href="javascript:void(0)" target="_parent">欢迎您(<s:property value='#session.currentUser.userName'/>)</a>|
					<a href="useranduserDetail" target="_parent">个人中心</a>|
					<a href="orderanduserOrderList" target="_parent">我的订单</a>|					
					<a href="userandlogout" target="_parent">退出登录</a>|
				</s:if>				
				<a href="AboutUs.jsp" target="_parent">关于我们</a>|
				<a href="JoinUs.jsp" target="_parent">加入我们</a>	
			</div>
		</div>
	</div>
	<!-- top end -->

	<!-- searchBox start -->
	<div class="searchAndLogoBox"> 
		<div class="logoBox"> 
			<a href="javascript:void(0)"><img  src="res/images/logo.png" /></a> 
		</div> 
		<div class="addressListWrap">
			<select id="parentAddressId">
				<s:iterator value="cityAddrs">
					<s:if test="#session.currentAddr.id==id">
						<option selected="selected" value="<s:property value='id'/>"><s:property value="addressName"/></option>
					</s:if>
					<s:else>
						<option value="<s:property value='id'/>"><s:property value="addressName"/></option>
					</s:else>
				</s:iterator>
			</select>
		</div>
		<div class="searchBox">
			<form name="searchform" method="post" action="simpleSearch" target="_top"> 
				<input type="hidden" name="condition.searchFlag" value="simple"/>
				<select name="condition.searchType" id="choose">
					<option value="place">搜场地</option>
					<option value="coach">搜教练</option>
				</select> 
				<input class="inp_srh" name="condition.simpleKeyWord"  placeholder="请输入您要搜索的内容" >
				<input class="btn_srh" type="submit" name="submit" value="搜索">
			</form>
		</div>
	</div> 
	<!-- searchBox end -->
	
	<!-- mainbanner start -->
	<div class="mainbanner">
		<div  class="mainbannerBox">
			<div class="mainbannerNav">
				<ul class="mainbannerNavBox">
					<li class="mainbannerSelected">
						<a href="index" target="_parent">首页</a>
					</li>
					<li><a href="simpleSearch?condition.searchType=place&condition.searchFlag=complex&condition.address.id=0" target="_parent">场馆预定</a></li>
					<li><a href="simpleSearch?condition.searchType=coach&condition.searchFlag=complex&condition.address.id=0" target="_parent">私人教练</a></li>
					<li><a href="forum/articleandforumIndex" target="_parent">社交圈</a></li>
					
				</ul>
			</div>

			<div class="mainbannerLoginAndRegister">
				<a href="javascript:void(0);" class="mainbannerLogin" >登录</a>
				<a  href="javascript:void(0);" class="mainbannerRegister">注册</a>
			</div>
		</div>

  	</div>
	<!-- mainbanner end -->

	<script type="text/javascript" src="res/js/jquery.select.js"></script>
	<!-- mainbanner select start -->
	<script type="text/javascript">
		$(".mainbannerNav ul li").hover(function(){
		$(this).addClass("mainbannerSelected").siblings().removeClass("mainbannerSelected");
		});
		$(function(){
			//切换所在城市
			$("#parentAddressId").change(function(){
				//alert(this.value);
				$.post("setCurrentCity", {"addr.id":this.value},
					   function(data){
					   	//这里刷新整个页面
					   	window.top.location=window.top.location;
				 },'json');
			});
		});
		
	</script>
	<!-- mainbanner select end -->
	<!-- 弹出登录开始  -->
	<div id="popDialog">
	<div class="cd-user-modal" > 
		<div class="cd-user-modal-container">
			<ul class="cd-switcher">
				<li id="loginTab"><a  style="color:red;background:rgb(222,222,222);" href="javascript:void(0);">用户登录</a></li>
				<li id="registerTab"><a  href="javascript:void(0);">快速注册</a></li>
			</ul>

			<div id="cd-login" style="border:1px solid #ddd;"> <!-- 登录表单 -->
				<div>
					<form class="cd-form" >
					<p class="fieldset">
						<span class="lb-show">　　用户名：</span>
						<input class="full-width has-padding has-border" name="userNameTop" id="signin-username" type="text" placeholder="请输入登陆账号、手机号码或者微信号">
					</p>

					<p class="fieldset">
						<span class="lb-show">　　密　码：</span>
						<input class="full-width has-padding has-border" name="passwordTop" id="signin-password" type="password"  placeholder="请输入密码">
					</p>
					
					<p class="fieldset">
						<input class="full-width2" id="loginBtnTop" type="button"  value="登 录">
					</p>
					</form>
				</div>
			</div>

			<div id="cd-signup" style="border:1px solid #ddd;"> <!-- 注册表单 -->
				<div class="div-phone">
					<form class="cd-form">
					<p class="fieldset">
						<span class="lb-show">　手机号码：</span>
						<input class="full-width has-padding has-border phonenumber" name="userNameTop1" id="signup-username" type="text" placeholder="请输入手机号码" />
					</p>
					<p class="fieldset">
						<span class="lb-show">　　密　码：</span> <input class="full-width has-padding has-border"
									name="passwordTop1" id="signin-password1" type="password"
									placeholder="请输入4-16位密码"
									<%-- onblur="if((this.value.length) < 4 || (this.value.length) > 16){alert('密码长度错误，请输入4-16位的密码。');(this.value) = ''; }"--%> />
							</p>
					<p class="fieldset">
						<span class="lb-show">图形验证码：</span>
						<input class="full-width3 has-padding has-border" maxlength="6" name="confirmImgCodeTop" id="signin-password" type="text"  placeholder="请输入右方验证码">
						<span class="pic-box-span"><img alt="" id="confirmImgTop" src="" confirmImgCode="" align="absmiddle" /> </span>
					
					</p>					
					<p class="fieldset">
						<span class="lb-show">短信验证码：</span>
						<input class="full-width3 has-padding has-border" maxlength="4" name="confirmCodeTop" id="signup-password" type="text"  placeholder="请输入短信验证码">
						<a class="button blue msgcode" id="sendMessageBtnTop"  >获取短信验证码</a>
					</p>
										
					<p class="fieldset">
						<input class="full-width2" id="registerBtnTop" type="button"  value="注册新用户">
					</p>
					</form>
				</div>
			</div>

			<a href="javascript:void(0);" class="cd-close-form">关闭</a>
		</div>
	</div>
	</div>
	<!-- 弹出登录结束  --> 
</body>
</html>
