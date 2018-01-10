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
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"
	/>
	
	<link rel="stylesheet" type="text/css" href="weixin/res/css/based.css">
	<link rel="stylesheet" type="text/css" href="weixin/res/css/discountDetail.css"  />
	<script type="text/javascript" src="weixin/res/js/jquery-1.7.2.min.js"></script>

	
	<style type="text/css">
		/* Anonymous ---------------------------*/
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
		
   		#content {
   			padding-bottom:60px;
   		}
   		
   		#replyBar {
   			float:left;
   			width:94%;
   			margin:0px auto;
   			background:#fff;
   			border:1px solid #ddd;
   			position:fixed;
   			bottom:0px;
   			left:0px;
   			right:0px;
   			height:58px;
   		}
   		
   		#replyBar .rec-box {
   			float:left;
   			font-size:14px;
   			line-height:20px;
   			width:76%;
   			margin:6px auto;
   		}
   		#replyBar .rec-box textarea {
   			width:94%;
   			margin-left:2%;
   		}
   		#replyBar .rec-btn {
   			float:left;
   			font-size:14px;
   			line-height:20px;
   			margin:10px auto;
   			width:20%;
   		}
   		#replyBar .rec-btn input {
   			font-size:14px;
   			line-height:20px;
   			width:94%;
   			border:1px solid #ddd;
   			margin-left:5%;
   		}
   		
   		.po-box {
   			padding:0px 4px;
   			float:right;
   			height:24px;
   			border:1px solid #999;
   			border-radius:6px;
   		}
   		
   		.po-box .po-num {
   			float:right;
   			padding:3px 2px;
   			height:24px;
   			font-size:14px;
   			line-height:24px;
   			margin:0px auto;
   		}
   		
   		.po-box .po-zan {
   			float:left;
   			width:24px;
   			height:24px;
   			margin:0px auto;
   		}
   		
   		.po-box .po-zan img{
   			width:24px;
   			height:24px;
   		}
   		
   		.InfoContent img {
			margin-top: 6px;
		}
		
		/* 后增样式 贴子格式 **************************/
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
			height:auto;
			line-height:26px;
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
.ch-con-re {
	padding-left:60px;
}
.re2so {
	padding:0px 8px;
	border:1px solid #3cf;
	border-radius:3px;
	float:right;
}
</style>   	
	<script type="text/javascript">
		$(function() {
			
			$(".m-bbtn").click(function(){
				window.history.back(-1);
			});
			$(".m-hbtn").click(function(){
				self.location='weixin/articleandforumIndex'; 
			});
		});
	</script> 
	

</head>
<body>
<s:url var="searchUrl" value="weixin/articleandreplyArticleList" includeParams="none">
	<s:param name="page.pageSize" value="page.pageSize"></s:param>
	<s:param name="rootArticle.id" value="rootArticle.id"></s:param>
	<s:param name="rootArticle.parentArticle.id" value="rootArticle.id"></s:param>
</s:url>
	<!--顶部开始-->
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
                	回复 <s:property value='rootArticle.talker.realName'/>
            </div>
            <div class="clear"></div>
        </div>
        <!-- top banner -->  
	</div>
	<!--顶部结束-->

	<div id="content">
		<div class="discountListBox">
			<!--子频道显示 结束-->
			<div class="clear">
			</div>	

			<div class="comment">
				<ul class="discountList">
					<!-- 贴子区 -->
					 <li>
	        			<div class="ch-box">
	        				<div class="ch-img">
	        					<img alt="" src=".<s:property value='rootArticle.talker.image.pathName'/>"  />
	        				</div>
	        				<div class="ch-info">
	        					<p><s:property value='rootArticle.talker.realName'/></p>
	        					<p class="ch-info-time"><s:date name="rootArticle.date" format="yyyy-MM-dd hh:mm:ss"/></p>
	        				</div>
	        			</div>
	        			<div style="clear:both;"></div>
	        			<div class="ch-con-re">
	        				<s:if test="rootArticle.image!=null">
	        					<img alt="" src=".<s:property value='rootArticle.image.pathName'/>" />
	        				</s:if>
	        				<s:property value='rootArticle.content'/>
	        			</div>
	        			<div class="comment">
							<ul class="discountList" style="padding-left:60px; ">
								<s:iterator value='articles'  status="st">
								<!-- 贴子区 -->
								 <li> 
				        			<div class="ch-box">
				        				<div class="ch-img">
				        					<img alt="" src=".<s:property value='talker.image.pathName'/>"  />
				        				</div>
				        				<div class="ch-info">
				        					<p><s:property value='talker.realName'/></p>
				        					<p class="ch-info-time"><s:date name="date" format="yyyy-MM-dd hh:mm:ss"/></p>
				        				</div>
				        			</div>
				        			<div style="clear:both;"></div>
				        			<div class="ch-con-re">
					        				<s:property value='content'/>
				        			</div>
				        		</li>				   
					        	<!-- 贴子区 -->
					        	</s:iterator>
							</ul>
						</div>
	        		</li>
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
			<div style="clear:both;"></div>
			<div style="margin-bottom:20px;"></div>
		</div>
	</div>
	<form action="weixin/articleandaddArticle" method="post" enctype="multipart/form-data">	
		<input type="hidden" name="article.parentArticle.id" value="<s:property value='rootArticle.id'/>"/>	
		<input type="hidden" name="rootArticle.id" value="<s:property value='rootArticle.id'/>"/>	
		<input type="hidden" name="rootArticle.parentArticle.id" value="<s:property value='rootArticle.id'/>"/>			
		<input type="hidden"  name="article.articleType" value="1">
		<div id="replyBar">
			<div class="rec-box">
				<textarea rows="" cols="" name="article.content" placeholder="我也说一句.."></textarea>
			</div>
			<div class="rec-btn">
				<input type="submit" value="回复" />
			</div>
	   	</div>
   	</form>
   	<script>
   		$(document).ready(function(){
   			if($(".rec-box textarea").val()== "")
   			{
   				$(".rec-btn input").prop("disabled","true");
   			}
   			$(".rec-box textarea").focus(function(){
	   			$(".rec-btn input").removeAttr("disabled");
	   			$(".rec-btn input").css("border","1px solid #3cf");
	   			$(".rec-btn input").css("color","#3cf");
   			});
   			$(".rec-box textarea").focusout(function(){
   				if($(".rec-box textarea").val()== "")
   				{
   					$(".rec-btn input").prop("disabled","true");
	   				$(".rec-btn input").css("border","1px solid #ddd");
	   				$(".rec-btn input").css("color","#ddd");
   				}
   			});
   		});
   	</script>
</body>

</html>