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
	<title>优惠信息</title>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"
	/>
	
	<link rel="stylesheet" type="text/css" href="weixin/res/css/based.css">
	<link rel="stylesheet" type="text/css" href="weixin/res/css/discountList.css"  />
	<link rel="stylesheet" type="text/css" href="weixin/res/css/myOrder.css"  />
	<script type="text/javascript" src="weixin/res/js/jquery-1.7.2.min.js">
	</script>
	<script src="weixin/res/js/common.js" type="text/javascript">
	</script>
	
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
<s:url var="searchUrl" value="weixin/discountanddiscountList" includeParams="none">
		<s:param name="page.pageSize" value="page.pageSize" />
		<!-- 保证至少有一个参数，这样就会有一个？号 -->
	</s:url>
	<!--顶部开始-->
	<div id="top">
		<!-- top banner -->
        <div class="topbanner">
            <div class="topbannerWord" style="z-index:1;">    
                优惠信息
            </div>
            <div class="clear"></div>
        </div>
        <!-- top banner -->  
	</div>
	<!--顶部结束-->

	<div id="content" >
		<div class="discountListBox">
			<ul class="discountList">
				<s:iterator value="discounts">
				<a href="weixin/discountanddiscountDetail?discount.id=<s:property value='id'/>">
					<li>						
						<div class="ChannelName">
							<s:property value='title'/>
						</div>							
						<div class="ChannelPicture">
							<img src=".<s:property value='preViewImg.pathName'/>" />
						</div>
						<div class="ChannelIntroduction">
							<s:property value='introduction'/>
						</div>
						<div class="ShowInfo">
							点击查看详情&gt;&gt;
						</div>
					</li>
				</a>
		 	</s:iterator> 
				
			</ul>
			<!--子频道显示 结束-->
			<div class="clear">
			</div>
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
</body>

</html>