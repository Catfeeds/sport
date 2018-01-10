<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>">

<title>提示</title>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<link rel="stylesheet" type="text/css" href="weixin/res/css/based.css">
<link rel="stylesheet" type="text/css" href="weixin/res/css/discountDetail.css"  />
<script type="text/javascript" src="weixin/res/js/jquery-1.7.2.min.js"></script>
<style type="text/css">
.msgBox {
	font: 13px 'Lucida Sans', 'trebuchet MS', Arial, Helvetica;
	background: #fff;
	border: 1px solid #ddd;
	color: #333;
	padding: 20px;
	_display: inline; /* IE6 double margin fix */
	position: relative;
	margin: 0px auto;
	-moz-box-shadow: 0 2px 2px -1px rgba(0, 0, 0, .3);
	-webkit-box-shadow: 0 2px 2px -1px rgba(0, 0, 0, .3);
	box-shadow: 0 2px 2px -1px rgba(0, 0, 0, .3);
	margin-top:10px;
}

.msgBox:after {
	z-index: -1;
	position: absolute;
	content: "";
	bottom: 10px;
	right: 4px;
	width: 80%;
	top: 80%;
	-webkit-box-shadow: 0 12px 5px rgba(0, 0, 0, .3);
	-moz-box-shadow: 0 12px 5px rgba(0, 0, 0, .3);
	box-shadow: 0 12px 5px rgba(0, 0, 0, .3);
	-webkit-transform: rotate(3deg);
	-moz-transform: rotate(3deg);
	-o-transform: rotate(3deg);
	-ms-transform: rotate(3deg);
	transform: rotate(3deg);
}

.BD .header {
	border-bottom-color: #45D0DA;
}

.header:after {
	position: absolute;
	bottom: -8px;
	left: 0;
	height: 3px;
	width: 100%;
	content: '';
}

.header {
	position: relative;
	font-size: 14px;
	font-weight: normal;
	text-transform: uppercase;
	padding: 40px;
	margin: -20px -20px 20px -20px;
	border-bottom: 8px solid;
	background-color: #eee;
	background-image: -moz-linear-gradient(#fff, #eee);
	background-image: -webkit-gradient(linear, left top, left bottom, from(#fff),
		to(#eee) );
	background-image: -webkit-linear-gradient(#fff, #eee);
	background-image: -o-linear-gradient(#fff, #eee);
	background-image: -ms-linear-gradient(#fff, #eee);
	background-image: linear-gradient(#fff, #eee);
}

.m-bbtn {
	width:32px;
	height:32px;
	position:absolute;
	left:4px;
	top:0px;
	padding:4px 4px;
}
.m-bbtn img, .m-hbtn img {
	width:32px;
	height:32px;
}

</style>
</head>
<script type="text/javascript">
	$(function() {
		
		$(".m-bbtn").click(function(){
			window.history.back(-1);
		});
	});
</script> 
<body>
	<div id="header">
		<div class="m-bbtn">
			<img alt="" src="weixin/res/images/back.png" />
		</div>
		
		<!-- top banner -->
        <div class="topbanner">
	        
            <div class="topbannerWord" style="z-index:1;">    
                	提示消息          
            </div>
            <div class="clear"></div>
        </div>
        <!-- top banner -->  
	</div>
	<div id="content">
		<div class="msgBox BD">
			<div class="header">
				享动提醒您：
				<s:property value="errorMsg" />
			</div>
		</div>
	</div>
</body>
</html>
