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
<link rel="stylesheet" type="text/css" href="weixin/res/css/myOrder.css"  />
<script type="text/javascript" src="weixin/res/js/jquery-1.7.2.min.js"></script>

<style>
.h-img {
	float:left;
	width:100px;
	height:100px;
	border:1px solid #ddd;
}

.h-img img {
	width:100%;
	height:auto;
}

.h-con {
	float:left;
	width:63%;
	margin-left:1%;
}

.h-con p {
	padding:4px 0px;
	padding-left:8px; 
}

.h-con p a {
	padding:2px 20px;
	float:right;
	margin-right:1%;
	background:#3cf;
	color:#fafafa;
}
.discountList li .w-con span {
	border:1px solid #39c;
	padding:0px 4px;
	color:#39c;
}
.discountList li .w-con {
	border-bottom:1px solid #aaa;
	padding:2px 0px;
	width:100%;
	height:26px;
	-o-text-overflow: ellipsis;
	text-overflow: ellipsis;		  
	overflow: hidden;
	white-space: nowrap;
}
.discountList li .ch-box .ch-img {
	float:left;
	height:50px;
	width:50px;
	border:1px solid #ddd;
}
.discountList li .ch-box .ch-img img{
	height:50px;
	width:50px;
}
.discountList li .ch-box .ch-info {
	float:left;
}
.discountList li .ch-box .ch-info p {
	font-size:16px;
	margin:0px;
	padding:0px;
	padding-left:10px;
}
.discountList li .ch-box .ch-info .ch-info-time {
	font-size:12px;
	color:#aaa;
}
.discountList li .ch-pic {
	width:auto;
	max-height:130px;
	margin:5px 0px;
}
.discountList li .ch-pic img {
	width:auto;
	max-height:130px;
}
.discountList li .ch-con {
	height:52px;
	line-height:26px;
	overflow : hidden;
	text-overflow: ellipsis;
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
}
/* 发帖框   ********************************************/

#writeBar {
	width: 94%;
	margin: 0px auto;
	height: 46px;
	line-height:46px;
	position: fixed;
	left: 0;
	bottom: 0;
	right:0;
	background: #fff;
	border: 1px solid #ddd;
}

#writeBar a {
	background: #fff;
	min-height: 46px;
	text-align: center;
	font-size: 16px;
	font-weight:bold;
	display: block;
	margin: 0px 70px 0;
	padding: 0;
	text-overflow: ellipsis;
	overflow: hidden;
	outline: 0 !important;
	border: 1px solid red;
	color:#3cf;
	z-index: 3;
	border: 1px solid #ddd;
	border-top: none;

	border-radius:10px;
	-webkit-border-radius:10px;
	-moz-border-radius:10px;
	-o-border-radius:10px;
}
</style>
 <style>
			hr {margin:2px 0px;color:#d0d1d4;}
			
			/* Anonymous 2015-10-25 19:26:09 分页样式 */
			a {
				color:#3cf;
			}
			
			.pageOp .disablepage{
				color:#ddd;
				border:1px solid #ddd;
			}
			
			.pageOp .currentpage{
				color:#3cf;
				border:1px solid #3cf;
			}
			
			.pageOp ul li {
				float:left;
				border:1px solid #3cf;
				width:17%;
				margin:0px 1%;
				text-align:center;
				border-radius:3px;
				height:26px;
				line-height:26px;
				font-size:16px;
				color:#ddd;
				margin-bottom:50px;
			}
			.ap-p {
				margin-left:4%;
				margin-bottom:6px;
			}
			.ap-p span {
				color:f60;
				font-size:20px;
			}
			.discountListBox  {
				margin-bottom: 6px;
			}
		</style>
</head>

<body>
<s:url var="searchUrl" value="weixin/articleandtypeForum" includeParams="none">
	<s:param name="page.pageSize" value="page.pageSize"></s:param>
	<s:param name="forum.id" value="forum.id"></s:param>
</s:url>
	<div id="header">
	    <!-- top banner -->
		<div class="topbanner">
	        <s:property value='forum.forumName'/>圈子动态
	    </div>
	    <!-- top banner -->   
	</div>
	
	<div id="content">
		<div class="discountListBox">
			<ul class="discountList">
			
				<!-- 贴子信息区 -->
        		<li>
        			<div class="h-img">
        				<img alt="" src="weixin/res/images/1.png" />
        			</div>
        			<div class="h-con">
        				<p><s:property value='forum.forumName'/>圈子</p>
        				<p>贴子&nbsp;<s:property value='forum.articleNumber'/></p>
        				<p>经验&nbsp;
        				<s:if test="#session.currentUser!=null">
        					<s:if test="#session.currentUser.experience<100">
								<s:property value='#session.currentUser.experience'/>/100
							</s:if>
							<s:elseif test="#session.currentUser.experience>=100&&(#session.currentUser.experience<1000)">
								<s:property value='#session.currentUser.experience'/>/1000
							</s:elseif>
							<s:elseif test="#session.currentUser.experience>=1000&&(#session.currentUser.experience<10000)">
								<s:property value='#session.currentUser.experience'/>/10000
							</s:elseif>
							<s:else>
								老熟人了
							</s:else>
						</s:if>
        				 
							<s:if test="#session.currentUser.hasSign">
								<a style="background:#ddd;" href="javascript:void(0);">
									已签
								</a>
							</s:if>
							<s:else>
								<a class="signUp" href="javascript:void(0);">
									签到
								</a>
							</s:else>
							<a href="javascript:void(0);"
									forumId="<s:property value='forum.id'/>"
								 	class="careForum">关&nbsp;注</a>
						</p>
        			</div>
        		</li>
        		<!-- 贴子信息区 -->
        		
        		<!-- 公告区 -->
        		<li>
        			<h4>公告区</h4>   
        			<s:iterator value='noticeArticles'>     			
        			<div class="w-con">        				
        				<a href="weixin/articleandarticleDetail?rootArticle.id=<s:property value='id'/>">
        				<span>最新</span>&nbsp;<s:property value='title'/>&nbsp;
        				</a>
        			</div> 
        			</s:iterator>       			
        		</li>
        		<!-- 公告区 -->
        		
        		<!-- 贴子区 -->
        		<s:iterator value="articles">
        		<li>
        			<a href="weixin/articleandarticleDetail?rootArticle.id=<s:property value='id'/>">
        			<div class="ch-box">
        				<div class="ch-img">
        					<img alt="" src=".<s:property value='talker.image.pathName'/>"  />
        				</div>
        				<div class="ch-info">
        					<p><s:property value='talker.realName'/></p>
        					<p class="ch-info-time"><s:date name="date" format="yyyy-MM-dd hh:mm"/></p>
        				</div>
        			</div>
        			<div style="clear:both;"></div>
        			<div class="ch-pic">
        				<img alt="" src=".<s:property value='image.pathName'/>" />
        			</div>
        			<div style="clear:both;"></div>
        			<div class="ch-con">
        				标题：<s:property value='title'/><br/>
        				内容：<s:property value='content'/><br/>
        			</div>
        			</a>
        		</li>
        		</s:iterator>
        		<!-- 贴子区 -->
        		
       		</ul>
		</div>
		 <p class="ap-p">共 <span><s:property value="page.totalPageNumber"/></span> 页</p>
			<div class="pageOp">
				<ul>
					<!-- 如果当前页是第一页 -->
					<s:if test="page.pageNumber<=1">
						<li class="disablepage">首页</li>
						<li class="disablepage">上一页</li>
					</s:if>
					<!-- 否则 -->
					<s:else>
						<li><s:a href="%{searchUrl}&page.pageNumber=1">首页</s:a></li>
						<li><s:a
								href="%{searchUrl}&page.pageNumber=%{page.pageNumber-1}">上一页</s:a>
						</li>
					</s:else>
					<li class="currentpage">第<s:property value='page.pageNumber' />页</li>
					<!-- 如果当前页是最后一页 -->
					<s:if test="page.pageNumber==page.totalPageNumber">
						<li class="disablepage">下一页</li>
						<li class="disablepage">尾页</li>
					</s:if>
	
					<s:else>
						<li class="nextpage"><s:a
								href="%{searchUrl}&page.pageNumber=%{page.pageNumber+1}">下一页</s:a>
						</li>
						<li class="nextpage"><s:a
								href="%{searchUrl}&page.pageNumber=%{page.totalPageNumber}">尾页</s:a>
						</li>
					</s:else>
				</ul>
			</div>
	</div>
	
	<div id="writeBar">
   		 <a href="weixin/articleandtoAddArticle?forum.id=<s:property value='forum.id'/>">
   			发布帖子
   		</a>
   	</div>
<script type="text/javascript">
	$(function(){		
		//签到
		$(".signUp").click(function(){
			var html=$(this).html();
			var thisObj=this;
			if(html=="已签")
				return;
			$.post("weixin/articleanduserSignIn",null,function(data){
			   		var arr=new Array();
					$.each(data, function(i, item) {
						arr.push(item);					           
					});					
					if(arr[0]){//true时表示操作成功，更改界面元素状态
					//	$(thisObj).html("已签");
						document.location=document.location;
					}else{
						alert(arr[1]);	
					}	
		 	},'json'); 
		});
		//关注圈子
		$(".careForum").click(function(){
			
			var forumId=$(this).attr("forumId");
			var html=$(this).html();
			var thisObj=this;
			if(html=="已关注")
				return;
			$.post("weixin/forumandcareForum",{"forum.id":forumId},function(data){
			   		var arr=new Array();
					$.each(data, function(i, item) {
						arr.push(item);					           
					});					
					if(arr[0]){//true时表示操作成功，更改界面元素状态
						$(thisObj).html("已关注");
					}else{
						alert(arr[1]);	
					}	
		 	},'json'); 
		});
	});
</script>	
</body>
</html>
