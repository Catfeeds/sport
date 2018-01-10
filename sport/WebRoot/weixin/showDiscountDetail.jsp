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
	<title>优惠详情</title>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
	
	<link rel="stylesheet" type="text/css" href="weixin/res/css/based.css">
	<link rel="stylesheet" type="text/css" href="weixin/res/css/discountDetail.css"  />

	<script type="text/javascript" src="weixin/res/js/jquery-1.7.2.min.js"></script>
	
	<style>
		.cb-box {
			width:inherit;
			margin-top:10px;
			padding-bottom:50px;
		}
		.cb-box .cb-btn {
			float:left;
			width:46%;
			border:1px solid #ddd;
			text-align:center;
			padding:5px 0px;
			height:32px;
			line-height:32px;
			margin-left:2%;
		}
		
		.cb-box .cb-btn a:hover {
			color:#111;
		}
		.cb-box .cb-btn span {
			width:32px;
			height:32px;
			vertical-align:middle;
		}
		.cb-box .cb-btn span img {
			width:32px;
			height:32px;
			margin-top:-10px;
			vertical-align:middle;
		}
		#mcover {
		    position: fixed;
		    top: 0;
		    left: 0;
		    width: 100%;
		    height: 100%;
		    background: rgba(0, 0, 0, 0.7);
		    display: none;
		    z-index: 20000;
		}
		#mcover img {
		    position: fixed;
		    right: 18px;
		    top: 5px;
		    width: 260px!important;
		    height: 180px!important;
		    z-index: 20001;
		}
		
		/* Anonymous ---------------------------*/
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
	
	<script type="text/javascript">
		$(function() {
			
			$(".m-bbtn").click(function(){
				window.history.back(-1);
			});
			
		});
	</script> 

</head>
<body>
	<!--顶部开始-->
	<div id="top">
		<div class="m-bbtn">
			<img alt="" src="weixin/res/images/back.png" />
		</div>
		<!-- top banner -->
        <div class="topbanner">
            <div class="topbannerWord" style="z-index:1;">    
                <s:property value='discount.title'/>
            </div>
            <div class="clear"></div>
        </div>
        <!-- top banner -->  
	</div>
	<!--顶部结束-->

	<div id="content">
		<div class="discountListBox">
			<ul class="discountList">
				<li>
					<h1><s:property value='discount.title'/></h1>
					<div class="InfoTime">活动时间：<s:date name="discount.beginDate" format="yyyy-MM-dd"/>-
							<s:date name="discount.endDate" format="yyyy-MM-dd"/>
					</div>
					<div class="InfoPicture">
						<img src=".<s:property value='discount.preViewImg.pathName'/>" alt="封面图" />
					</div>
					<div class="InfoContent">
						<s:property escapeHtml="false" value='discount.detail'/>
					</div>
					<div class="cb-box">
						<div class="cb-btn" onclick="document.getElementById('mcover').style.display='block';">
							<span>
								<img alt="" src="weixin/res/images/icon_msg.png" />
							</span>
							<a href="javascript:void(0)">
							发送给朋友
							</a>
						</div>
						<div class="cb-btn">
							<span>
								<img alt="" src="weixin/res/images/bow.png" />
							</span>
							<s:if test='discount.type==2'>
								<a href="weixin/weixinandchoosePlace">赶紧去预定</a>
							</s:if>
							<s:else >
								<a href="weixin/weixinandchooseCoach">赶紧去预定</a>
							</s:else>
						</div>
						<div id="mcover" onclick="document.getElementById('mcover').style.display='';" style="display:none;">
							<img src="weixin/res/images/guide.png">
						</div>
						
					</div>
				</li>
			</ul>
			<!--子频道显示 结束-->
			<div class="clear">
			</div>
		</div>
	</div>
</body>

</html>