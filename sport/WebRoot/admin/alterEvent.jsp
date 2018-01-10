<%@ page language="java"  contentType="text/html; charset=UTF-8" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	basePath+="admin/";
%>
<!DOCTYPE html >
<html>
<head>
<base href="<%=basePath%>">
	<meta http-equiv="content-type" content="text/html;charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="../res/admin/css/default.css" />
	<style type="text/css">
* {
	background: none repeat scroll 0 0 transparent;
	border: 1 none;
	margin: 0;
	padding: 0;
	vertical-align: baseline;
	font-family: 微软雅黑;
	overflow: auto;
}

#navi {
	width: 100%;
	position: relative;
	word-wrap: break-word;
	border-bottom: 1px solid #065FB9;
	margin: 0;
	padding: 0;
	height: 40px;
	line-height: 40px;
	vertical-align: middle;
	background-image: -moz-linear-gradient(top, #EBEBEB, #BFBFBF);
	background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0, #EBEBEB),
		color-stop(1, #BFBFBF) );
}

#naviDiv {
	font-size: 14px;
	color: #333;
	padding-left: 10px;
}

#tips {
	margin-top: 10px;
	width: 100%;
	height: 40px;
}

#buttonGroup {
	padding-left: 10px;
	float: left;
	height: 35px;
}

.button {
	margin-top: 20px;
	padding-left: 10px;
	padding-right: 10px;
	font-size: 14px;
	width: 70px;
	height: 30px;
	line-height: 30px;
	vertical-align: middle;
	text-align: center;
	cursor: pointer;
	border-color: #77D1F6;
	border-width: 1px;
	border-style: solid;
	border-radius: 6px 6px;
	-moz-box-shadow: 2px 2px 4px #282828;
	-webkit-box-shadow: 2px 2px 4px #282828;
	background-image: -moz-linear-gradient(top, #EBEBEB, #BFBFBF);
	background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0, #EBEBEB),
		color-stop(1, #BFBFBF) );
}

#mainContainer {
	padding-left: 10px;
	padding-right: 10px;
	text-align: left;
	width: 98%;
	font-size: 16px;
}

.wrong{
	color:#f00;
	}
</style>
	<body>
		<script type="text/javascript" src="../res/admin/js/Calendar3.js"></script>
		<script type="text/javascript" src="../res/admin/js/jquery-1.8.3.min.js"></script>
		
		<div id="navi">
			<div id='naviDiv'>
				<span><img src="../images/arror.gif" width="7" height="11"
						border="0" alt="">
				</span>&nbsp;赛事管理
				<span>&nbsp; <span><img src="../images/arror.gif"
							width="7" height="11" border="0" alt="">
				</span>&nbsp;<a href="eventandeventList">赛事列表</a><span>&nbsp;
				
			</div>
		</div>
		<div id="tips">
		</div>
		<div id="mainContainer" style="width:100%;height:auto;overflow:auto;">
			<!-- 从session中获取学生集合 -->
			<strong>修改赛事</strong>
			<br>
			<br>

			<form name="modifyForm" id="modifyForm"
				action="eventandalterEvent" method="post" enctype="multipart/form-data">
				<input type="hidden" name="event.id" value="<s:property value='event.id'/>"/>
				<table width="900px" style="overflow:auto;">
					<tr>
						<td width="100px">
							赛事标题：
						</td>
						<td width="800px">
							<input type="text" name="event.title"
								value='<s:property value="event.title"/>' />
						</td>
					</tr>
					<tr>
						<td>
							赛事作者：
						</td>
						<td>
							<input type="text" name="event.author"
								value="<s:property value="event.author"/>" />
						</td>
					</tr>
					<tr>
						<td>
							发布日期：
						</td>
						<td>
							<input name="event.time" type="text" id="control_date" size="20"
								maxlength="10" onclick="new Calendar().show(this);"
								readonly="readonly"
								value="<s:date name="event.time" format="yyyy-MM-dd"/>" />
						</td>
					</tr>
					<tr height="20px;">
						<td>封面图：</td><td></td>
					</tr>
					<tr>
						<td>							
						</td>
						<td style="height:200px;">
							<img style="width:200px;height:200px;" src="..<s:property value='event.image.pathName'/>"/>
						</td>
					</tr>
					<tr>
						<td>
							上传图片：
						</td>
						<td>
							<input type="file" name="file" value="">
							
						</td>
					</tr>
					<tr>
						<td>赛事详情：</td>
						<td><span id="messageBox" class="wrong"></span></td>
					</tr>
					<tr>
						<td>
						</td>
						<td>
							<textarea style="width: 600px !important; height: 200px;"
								type="text" name="event.content" 
								><s:property value="event.content"/></textarea>
						</td>
					</tr>
					<tr>
						<td colspan="2" align="center">
							<input class="button" type="submit" value="修改">
						</td>
					</tr>
				</table>
			</form>

		</div>
	</body>
</html>