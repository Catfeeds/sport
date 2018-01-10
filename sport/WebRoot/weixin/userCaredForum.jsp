<%@ page language="java"  contentType="text/html; charset=UTF-8" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>享动</title>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<link rel="stylesheet" type="text/css" href="weixin/res/css/based.css"  />
<script type="text/javascript" src="res/js/jquery-1.8.3.min.js"></script>
<style type="text/css">
#header, #content , #footer {
	width: 99%;
	margin: 0px auto;
	border:0px solid green;
}

.topbanner {
	background:#3cf;
	color:#fff;
	text-align:center;
	height:40px;
	line-height:40px;
}
.fdm ul li {
	float:left;
	width:47%;
	margin:5px 1%;
	padding:8px 0px;
	border:1px solid #3cf;
	border-radius:4px;
	text-align:center;
	-o-text-overflow: ellipsis;
	text-overflow: ellipsis;		  
	overflow: hidden;
	white-space: nowrap;
	color:#333;
}
.myArticle {
	border:1px solid #3cf;
	width: 96%;
	margin: 0px 1%;
	padding:8px 0px;
	text-align:center;
	position:fixed;
	bottom:0px;
	background:#fff;
	
}
</style>
</head>

<body>
	<div id="header">
	    <!-- top banner -->
		<div class="topbanner">
	        我关注的圈子
	    </div>
	    <!-- top banner -->   
	</div>
	
	<div id="content">
		<div class="fdm">
			<ul>
				<s:iterator value="forums">
				<a id="forumItem<s:property value='id'/>" href="weixin/articleandtypeForum?forum.id=<s:property value='id'/>">
					<li><s:property value='forumName'/></li>
				</a>
				<a class="disCareForumBtn"  forumId="<s:property value='id'/>" href="javascript:void(0);">
					<li>取消关注</li>
				</a>				
				</s:iterator>
			</ul>
		</div>
		<div style="clear:both;margin-bottom:50px;"></div>
		<a href="weixin/articleanduserArticleList">
		<div class="myArticle">
			查看我的帖子
		</div>
		</a>
	</div>
	 <script>
      $(function(){ 
        // Content widget with background image
				$(".disCareForumBtn").click(function(){//disCareForum
					if(!confirm("取消关注？"))
						return;
					var forumId=$(this).attr("forumId");
					var thisObj=this;
					$.post("forumanddisCareForum",
					 	{"forum.id":forumId},
						function(data){
							var arr=new Array();
							$.each(data, function(i, item) {
								arr.push(item);					           
							});
							if(arr[0]){//true时表示操作成功，更改界面元素状态								
								$("#forumItem"+forumId).remove();
								$(thisObj).remove();
							}else{
								alert(arr[1]);
							}												
					},'json'); 					
				});
      });
    </script>	
</body>
</html>
