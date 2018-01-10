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
	<title>赛事管理</title>
	<meta http-equiv="content-type" content="text/html;charset=UTF-8">
	<script type="text/javascript" src="../res/js/jquery-1.8.3.min.js"></script>
	<link href="../res/commonComponents/resizeTable/css/dividePage.css" rel="stylesheet" type="text/css" ></link>
	<style type="text/css"> 
* {
	background: none repeat scroll 0 0 transparent;
	border: 0 none;
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
	float: left;
	margin-right: 10px;
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
	text-align: center;
	width: 98%;
	font-size: 12px;
}
</style>
</head>
		<s:url var="searchUrl" value="eventandeventList" includeParams="none">
			<s:param name="page.pageSize" value="page.pageSize" />
			<!-- 保证至少有一个参数，这样就会有一个？号 -->
		</s:url>
	<body>
		<div id="navi">
			<div id='naviDiv'>
				<span><img src="../images/arror.gif" width="7" height="11"
						border="0" alt=""> </span>&nbsp;赛事管理
				<span>&nbsp; <span><img src="../images/arror.gif"
							width="7" height="11" border="0" alt=""> </span>&nbsp;<a
					href="eventandeventList">赛事列表</a><span>&nbsp;

				
			</div>
		</div>
		<div id="tips">
			<div id="buttonGroup">
				<div class="button" onmouseout=this.style.backgroundColor;
					ontWeight='normal' ;onmouseover=this.style.backgroundColor;
					style.fontWeight='bold';>
					<a href="addEvent.jsp">添加赛事</a>
				</div>
			</div>
		</div>
		<div id="mainContainer">

			<!-- 从session中获取学生集合 -->

			<table class="default" width="100%">
				<col width="10%">
				<col width="15%">
				<col width="10%">
				<col width="20%">
				<col width="30%">
				<col width="15%">
				<tr class="title">
					<td>
						序号
					</td>
					<td>
						赛事标题
					</td>
					<td>
						作者
					</td>
					<td>
						发布日期
					</td>
					<td>
						赛事详情
					</td>
					<td>
						操作
					</td>
				</tr>
				<s:iterator value='events' status="st">
				<tr class="list">
					<td><s:property value='#st.index+(page.pageSize*(page.pageNumber-1))'/>
					</td>
					<td><s:property value='title'/></td>
					<td><s:property value='author'/></td>
					<td><s:date name="time" format="yyyy-MM-dd"/></td>
					<td><s:property value='content.substring(0,20)'/>...</td>
					<td>
						<a
							href="eventandeventDetail?event.id=<s:property value='id'/>">修改
						</a>
						<a
							href="javascript:void(0);" class="deleteBtn" eventId="<s:property value='id'/>"
							> 删除</a>
					</td>

				</tr>
				</s:iterator>
				<!-- 遍历开始-->
				<!-- 遍历结束 -->
			</table>
			<div class="pagination">
		<s:if test="page!=null&&(page.totalPageNumber>0)">
	<ul>
				<!-- 如果当前页是第一页 -->
				<s:if test="page.pageNumber<=1">
					<li class="disablepage">首页</li>
					<li class="disablepage">上一页</li>
				</s:if>
				<!-- 否则 -->
				<s:else>
					<li><s:a href="%{searchUrl}&order.orderStatus=%{order.orderStatus}&page.pageNumber=1">首页</s:a></li>
					<li><s:a
							href="%{searchUrl}&order.orderStatus=%{order.orderStatus}&page.pageNumber=%{page.pageNumber-1}">上一页</s:a>
					</li>
				</s:else>
				<!-- 如果总页码小于7页，就显示全部页码 -->
				<s:if test="page.totalPageNumber<=7">
					<s:iterator begin="1" var="i" end="page.totalPageNumber">
						<s:if test="#i==page.pageNumber">
							<li class="currentpage"><s:property />
							</li>
						</s:if>
						<s:else>
							<li><s:a href="%{searchUrl}&order.orderStatus=%{order.orderStatus}&page.pageNumber=%{i}">
									<s:property />
								</s:a></li>
						</s:else>
					</s:iterator>
				</s:if>
				<!-- 否则中间的隐藏，值显示离当前页最近的7页 -->
				<s:else>
					<s:if
						test="page.pageNumber>4&&page.pageNumber<(page.totalPageNumber-4)">
						<li>...</li>
						<s:iterator begin="page.pageNumber-3" var="i"
							end="page.pageNumber+3">
							<s:if test="page.pageNumber==#i">
								<li class="currentpage"><s:property />
								</li>
							</s:if>
							<s:else>
								<li><s:a href="%{searchUrl}&order.orderStatus=%{order.orderStatus}&page.pageNumber=%{i}">
										<s:property />
									</s:a></li>
							</s:else>
						</s:iterator>
						<li>...</li>
					</s:if>
					<s:elseif test="page.pageNumber<=4">
						<s:iterator begin="1" var="i" end="7">
							<s:if test="page.pageNumber==#i">
								<li class="currentpage"><s:property />
								</li>
							</s:if>
							<s:else>
								<li><s:a href="%{searchUrl}&order.orderStatus=%{order.orderStatus}&page.pageNumber=%{i}">
										<s:property />
									</s:a></li>
							</s:else>
						</s:iterator>
						<li>...</li>
					</s:elseif>
					<s:elseif test="page.pageNumber+4>=page.totalPageNumber">
						<li>...</li>
						<s:iterator begin="page.pageNumber-3" var="i"
							end="page.totalPageNumber">
							<s:if test="page.pageNumber==#i">
								<li class="currentpage"><s:property />
								</li>
							</s:if>
							<s:else>
								<li><s:a href="%{searchUrl}&order.orderStatus=%{order.orderStatus}&page.pageNumber=%{i}">
										<s:property />
									</s:a></li>
							</s:else>
						</s:iterator>
					</s:elseif>
				</s:else>
				<!-- 如果当前页是最后一页 -->
				<s:if test="page.pageNumber==page.totalPageNumber">
					<li class="disablepage">下一页</li>
					<li class="disablepage">尾页</li>
				</s:if>

				<s:else>
					<li class="nextpage"><s:a
							href="%{searchUrl}&order.orderStatus=%{order.orderStatus}&page.pageNumber=%{page.pageNumber+1}">下一页</s:a>
					</li>
					<li class="nextpage"><s:a
							href="%{searchUrl}&order.orderStatus=%{order.orderStatus}&page.pageNumber=%{page.totalPageNumber}">尾页</s:a>
					</li>
				</s:else>
			</ul>
		</s:if>
	</div>
		</div>
		
	<script type="text/javascript">
	$(function(){
		$(".deleteBtn").click(function(){
			var eventId=$(this).attr("eventId");
			$.post("eventanddeleteEvent", {"event.id":eventId},
				   function(data){
				   	 var arr=new Array();
						$.each(data, function(i, item) {
							arr.push(item);					           
						});					
						if(arr[0]){//true时表示操作成功，更改界面元素状态								
							document.location=document.location;
						}else{
						alert(arr[1]);	
						}	
			 },'json');
		});
	});
	
	</script>
	</body>
</html>