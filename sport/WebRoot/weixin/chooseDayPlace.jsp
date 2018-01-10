<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
	<head>
		<base href="<%=basePath%>">
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0"
		/>
		<title>
			享动
		</title>
		<link rel="stylesheet" type="text/css" href="weixin/res/css/slideTool.css"  />
		
		<script type="text/javascript" src="weixin/res/js/jquery-1.7.2.min.js">
        </script>
        <script src="weixin/res/js/common.js" type="text/javascript">
        </script>
		<script type="text/javascript" src="weixin/res/js/jquery.flexslider-min.js">
		</script>
		
		<style>
			* {
	margin:0;
	padding:0;
	list-style-type:none;
}
a,img {
	border:0;
}
body {
	font:12px/180%Arial, Helvetica, sans-serif, "新宋体";
}

.mainbody {
	margin:auto;
	width:99%;
	border-left: #FFF solid 2px;
	border-right: #FFF solid 2px;
}
.maintitle {
	height:40px;
	margin:auto;
	padding:inherit;
	background-color:#3cf;
}
.maintitle_unit {
	width:20%;
	height:40px;
}
.title_p1 {
	font-size:16px;
	font-weight:bold;
	line-height:40px;
	color:#FFF;
}
.select_day_list {
	padding-left:10px;
	}
.select_day_unit {
	height:30px;
	margin-top:20px;
	color:#777;
	border-bottom: dotted #666666 1px;
}
.select_day_unit strong {
	font-size:18px;
	margin-left:10px;
}
.select_day_unit span {
	color:#39C;
	font-size:14px;
	margin-left:20px;
}
.select_day_unit a {
	font-size:16px;
	border-radius:15px;
	font-weight:800;
	height:25px;
	width:80px;
	line-height:25px;
	padding:inherit;
	text-align:center;
	background-color:#f60;
	color:#fff;
	float:right;
	margin-right:20px;
	text-decoration:none;
}
.select_day_unita:hover {
	color:#000;
	background-color:39c;
}
.sportdetil span {
	font-size:16px;
}
/* Anonymous ---------------------------*/

.slides li img {
	max-height:170px;
	min-height:170px;
}

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
#focusme {
	position:absolute;
	top:50px;
	right:0px;
	border:1px solid #fff;
	width:0px;
	color:#fff;
	opacity: 0.0; 
}

		</style>
	
	<script type="text/javascript">
		$(function() {
			document.getElementById("focusme").focus();
			
			$('.myflexslider').flexslider({
				controlNav: true,
				directionNav: false,
				animation: "slide",
				//manualControls: ".myflexslider .slidenav"
			});
			
			$(".m-bbtn").click(function(){
				window.history.back(-1);
			});
			
			$(".m-hbtn").click(function(){
				self.location='weixin/weixinandchoosePlace'; 
			});
		});
	</script> 
		
	</head>
	<body>
		
		<div class="mainbody">
		<input type="text" id="focusme"  />
			<div class="m-bbtn">
				<img alt="" src="weixin/res/images/back.png" />
			</div>
			<div class="m-hbtn">
				<img alt="" src="weixin/res/images/home.png" />
			</div>
			<div class="maintitle">
				<div class="maintitle_unit" style="width:100% !important; text-align:center; margin:0px auto;">
					<b class="title_p1">
						<s:property value="placeProduct.site.siteName" />
						(
						<s:property value="placeProduct.productName" />
						)
					</b>
					
				</div>
				
			</div>
		</div>
		<div style="clear:both;"></div>
		<div id="header">
			<div class="myflexslider" style="margin-top:1px;">
                <ul class="slides">
                <s:iterator value='placeProduct.midImages' status="status">
                    <li>
                    	<img src=".<s:property value='pathName'/>" width="100%" />
                    </li>
                </s:iterator>
                </ul>
            </div>
		</div>
		
		<div class="sportdetil">
			<p style="font-size:18px; font-weight:700; margin-left:20px; margin-top:10px; color:#39c;">
				场馆介绍
			</p>
			<hr style="width:40%" />
			<p style="margin-left:20px;font-size:14px;margin-top:10px;">
				<span>
					场馆地址：
				</span>
				<s:property value='placeProduct.site.siteAddress' />
				<a href="http://api.map.baidu.com/marker?location=113.094192,29.381201&output=html&src=weiba|weiweb">
					<span style=" color:#39f;font-size:16px;">
						看地图
					</span>
				</a>
			</p>
			<p style="margin-left:20px;font-size:14px; ">
				<span>
					联系电话：
				</span>
				<a href="tel:<s:property value='placeProduct.site.sitePhone' />">
					<s:property value='placeProduct.site.sitePhone' />
				</a>
			</p>
			<p style="margin-left:20px;font-size:14px;">
				<span>
					场馆价格：
				</span>
				<s:property value='placeProduct.normalPrice' />
				元起
			</p>
			<p style="margin-left:20px;font-size:14px;">
				<span>
					附加服务：
				</span>
				<s:property value='placeProduct.site.service' />
			</p>
			<p style="margin-left:20px;font-size:14px;">
				<span>
					公共交通：
				</span>
				<s:property value='placeProduct.site.route' />
			</p>
		</div>
		<div style="height:20px; background-color:#fff; margin-top:30px; padding:inherit;">
			<p style="font-size:18px; font-weight:700; margin-left:20px; margin-top:10px; color:#39c;">
				场馆预定
			</p>
			<hr style="width:40%" />
		</div>
		<div class="select_day_list">
			<s:iterator value="dates" var="date" begin="0" status="status">
				<div class="select_day_unit">
					<p>
						<s:if test="placeProduct.site.weekJobTimes[weekIndexArr[#status.index]]==1">
						<strong>
							<s:date name="#date" format="MM月 dd日/" timezone="ch" />
							<s:property value="weeks[#status.index]" />
						</strong>
						<a href="weixin/weixinandorderPlace?placeProduct.id=<s:property value='placeProduct.id'/>&site.id=<s:property value='placeProduct.site.id'/>&week=<s:property value='#status.index'/>">
							立即预定
						</a>
						</s:if>
						<s:else>
							<strong><s:date name="#date" format="MM月 dd日/" timezone="ch" />
							<s:property value="weeks[#status.index]" /></strong> 
							<a href="javascript:void(0);" style="background:black;">不可预订</a>
							
						</s:else>
					</p>
				</div>
			</s:iterator>
		</div>
		</div>
	</body>

</html>