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
<s:url var="searchUrl" value="weixin/orderanduserOrderList" includeParams="none">
	<s:param name="page.pageSize" value="page.pageSize"></s:param>
</s:url>
<body>
	<div id="header">
	    <!-- top banner -->
		<div class="topbanner">
	        我的订单
	    </div>
	    <!-- top banner -->   
	</div>
	
	<div id="content">
		<div class="discountListBox">
			<ul class="discountList"> 
			<s:iterator value="orders">
				<s:if test="coach==null">
	        		<li>
	        			<a href="weixin/orderandorderDetail?order.id=<s:property value='id'/>">
	        			<div>
	        				<p>类型：<span>场馆预定</span></p>
	        				<p>项目：<span>
									<s:property value="items[0].product.productName"/>	
							</span></p>
	        				<p>场馆：<span><s:property value="items[0].place.site.siteName"/></span></p>
	        				<p>预定时间：<span class="timec"><s:date name='preOrderTime' format="yyyy-MM-dd"/>(<s:property value="week"/>)</span></p>
	        				<hr size="1" />
	        				<p><span>详情 &gt;&gt;</span></p>
	        			</div>
	        			</a>
	        		</li>
        		</s:if>
        		<s:else>
	        		<li>
	        			<a href="weixin/orderandorderDetail?order.id=<s:property value='id'/>">
	        			<div>
	        				<p>类型：<span>教练预定</span></p> 
	        				<p>教练名：<span><s:property value="coach.realName"/></span></p>
	        				<p>项目：<span><s:property value="coach.skillType.typeName"/></span></p>
	        				<p>服务：<span>
	        					<s:if test="items[0].product!=null">
									<s:property value="items[0].product.productName"/>
								</s:if>
								<s:else>
									教练自行安排
								</s:else>
							</span></p>
	        				<p>预定时间：<span class="timec"><s:date name='preOrderTime' format="yyyy-MM-dd"/>(<s:property value="week"/>)</span></p>
	        				<hr size="1" />
	        				<p><span>详情 &gt;&gt;</span></p>
	        			</div>
	        			</a>
	        		</li>
        		</s:else>
        	</s:iterator>
       		</ul>
		</div>
		<p class="ap-p">共 <span><s:property value="page.totalPageNumber"/></span> 页</p>
		<div class="pageOp">
			<s:if test="page!=null&&(page.totalPageNumber>0)">
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
			</s:if>
		</div>
	</div>

</body>
</html>
