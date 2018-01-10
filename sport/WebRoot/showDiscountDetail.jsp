<%@ page language="java"  contentType="text/html; charset=UTF-8" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<title>热门活动</title>
		<!-- 弹出登录注册对话框 -->
	<link rel="stylesheet" href="res/commonComponents/loginPopDialog/css/loginbox.css"  type="text/css"/>
	<script type="text/javascript" src="res/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="res/js/header.js"></script>
	<!-- 弹出框结束 -->
		<style type="text/css">
		*{
	margin: 0;
	padding: 0;
	list-style: none;
	font-family: "微软雅黑";
}
		a{
	text-decoration: none;
}
.clearfix{
	clear: both;
}
.displaycss{
	display: none;
}
.hiddencss{
	display: ;
}
.activity-mainbody{
	width: 1000px;
	margin: 5px auto;
	font-size: 16px;
}
.activity-detail-title h1{
	margin: 0 150px;
	text-align: center;
	border-bottom: 1px solid #333333;
}
.activity-detail-title h5{
	text-align: left;
	margin-left: 150px;
	color: #AAA;
	float: left;
}
.activity-detail-title a{
	text-align: left;
	margin-right: 160px;
	float:right;
	font-size: 14px;
	color:blue;
}

.activity-detail-img{
	height: 300px;
}
.activity-detail-img img{
	width: 600px;
	height: 280px;
	margin: 10px 200px;
} 
.activity-detail-detail{
	margin: 0 150px;
	height: auto;
	overflow: hidden;
}
		</style>
	</head>

	<body>
		<div><iframe src="header" width="100%" height="190px" frameborder="0" scrolling="no"></iframe></div>
		<div class="activity-mainbody">
			<div class="activity-detail-title">
				<h1 ><s:property value='discount.title'/></h1>
				<h5>活动时间段：<s:date name='discount.beginDate' format="yyyy-MM-dd"/>
					至 <s:date name="discount.endDate" format="yyyy-MM-dd"/>
				</h5>
			</div>
			<div class="clearfix"></div>
			<div class="activity-detail-img">
				<img src=".<s:property value='discount.preViewImg.pathName'/>" />
			</div>
			<div class="activity-detail-detail">
				<p>活动名称：“<s:property value='discount.title'/>”</p>
				<p>活动时间： <s:date name='discount.beginDate' format="yyyy-MM-dd"/>
					至 <s:date name="discount.endDate" format="yyyy-MM-dd"/> </p>
				<p>
					<s:property value='discount.introduction'/>
				</p>
				<p>
					<s:property escapeHtml="false" value='discount.detail'/>
				</p>
			</div>
		</div>
		<div class="mainbody"><iframe src="footer.jsp" width="100%" height="200px" frameborder="0" scrolling="no"></iframe></div>
	</body>

</html>