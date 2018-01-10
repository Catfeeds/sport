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
        <title>
            享动
        </title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
        <link rel="stylesheet" type="text/css" href="weixin/res/css/style.css"  />
        <link rel="stylesheet" type="text/css" href="weixin/res/css/vcommunity.css"  />
        <script type="text/javascript" src="weixin/res/js/jquery-1.8.3.min.js">
        </script>
        <script type="text/javascript">
		$(function() {
	        $(".m-bbtn").click(function(){
				window.history.back(-1);
			});
		});
		</script> 
        <style>
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
			height:52px;
			line-height:26px;
			overflow : hidden;
			text-overflow: ellipsis;
			display: -webkit-box;
			-webkit-line-clamp: 2;
			-webkit-box-orient: vertical;
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
			.a-defo {
				color:#666;
			}
			.m-bbtn {
			width:32px;
			height:32px;
			position:absolute;
			left:4px;
			top:0px;
			padding:4px 4px;
		}
		</style>
    </head>
    
    <body>
        <s:url var="searchUrl" value="weixin/articleanduserArticleList" includeParams="none">
			<s:param name="page.pageSize" value="page.pageSize"></s:param>
		</s:url>
        <!--页眉开始-->
        <div id="header">
        	<div class="m-bbtn">
				<img alt="" src="weixin/res/images/back.png" />
			</div>

            <!-- top banner -->
            <div class="topbanner">
                <div class="topbannerWord" style="z-index:1;">    
                    我的帖子
                </div>
                <div class="clear"></div>
            </div>
            <!-- top banner -->   
        </div>
        <div id="content">
            <div>
                <div class="hotSportHall">
                </div>
            </div>

            <div class="discountListBox">
                <ul class="discountList">
                	<s:iterator value='articles'>
					<!-- 贴子区 -->
					 <li>
					 	<s:if test='rootArticle==null'>
                    		<a href="weixin/articleandarticleDetail?rootArticle.id=<s:property value='id'/>">
                    	</s:if>
                    	<s:else>
                    		<a href="weixin/articleandarticleDetail?rootArticle.id=<s:property value='rootArticle.id'/>">
                    	</s:else>
	        			<div class="ch-box">
	        				<s:if test='image!=null'>
	        				<div class="ch-img">
	        					<img alt="" src=".<s:property value='talker.image.pathName'/>"  />
	        				</div>
	        				</s:if>
	        				<div class="ch-info">
	        					<p><s:property value='talker.realName'/></p>
	        					<p class="ch-info-time"><s:date name='date' format='yyyy-MM-dd hh:mm:ss'/></p>
	        				</div>
	        			</div>
	        			<div style="clear:both;"></div>
	        			<div class="ch-pic">
	        				<img alt="" src=".<s:property value='image.pathName'/>" />
	        			</div>
	        			<div style="clear:both;"></div>
	        			<div class="ch-con">
	        				<s:property value='content'/>
	        			</div>
	        			<hr>
	        			<span class="a-defo"><s:property value='forum.forumName'/></span>
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
					<s:if test="page.pageNumber>=page.totalPageNumber">
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

    </body>

</html>