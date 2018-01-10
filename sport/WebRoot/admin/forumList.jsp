<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	basePath += "admin/";
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<base href="<%=basePath%>">
<meta charset="utf-8">

<title>xx</title>
<script type="text/javascript" src="../res/js/jquery-1.8.3.min.js"></script>
	<link rel="stylesheet" type="text/css" href="../res/admin/css/orderListBase.css">
	<link rel="stylesheet" type="text/css" href="../res/admin/css/orderListBox.css">
	<link href="../res/commonComponents/resizeTable/css/dividePage.css"
	rel="stylesheet" type="text/css" />
	<style>
	.forumLogoBox img {
		width:100px;
		height:100px;
	}
	.chooseCondition{
		margin:0 10px;
		font-size:16px;
		font-weight:bold;
	}
	</style>
</head>
<body>
		<s:url var="searchUrl" value="forumandforumList" includeParams="none">
			<s:param name="page.pageSize" value="page.pageSize" />
			<!-- 保证至少有一个参数，这样就会有一个？号 -->
		</s:url>
	<h2 class="sub-header" style="margin-left:70px;font-size:25px;font-weight:bold;font-family:'微软雅黑';margin-top:20px;">社交圈管理</h2>
	<div style="margin:30px 50px;">
		<s:a class="chooseCondition" href="%{searchUrl}">所有</s:a>&nbsp;&nbsp;&nbsp;
		<s:a class="chooseCondition" href="%{searchUrl}&forum.classType=1">个人</s:a>&nbsp;&nbsp;&nbsp;
		<s:a  class="chooseCondition" href="%{searchUrl}&forum.classType=2">入驻商家</s:a>&nbsp;&nbsp;&nbsp;
		<s:a  class="chooseCondition" href="%{searchUrl}&forum.classType=3">平台拥有者</s:a>&nbsp;&nbsp;&nbsp;
		<s:a  class="chooseCondition" href="%{searchUrl}&forum.classType=4">其它</s:a>&nbsp;&nbsp;&nbsp;
	</div>
	<div class="table-responsive" style="margin-left:50px;margin-right:50px;">
		<table class="table table-striped" >
			<thead>
				<tr>
					<th>选择</th>
					<th>论坛名</th>
					<th>论坛主</th>
					<th>论坛类别</th>
					<th>论坛分类</th>
					<th>创建时间</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
			<s:if test="forums!=null">
				<s:iterator value="forums">			
					<tr id="forumAllInfo<s:property value='id'/>">
						<td><input type="checkbox" name="forumId" value="<s:property value='id' />"/></td>
						<td><s:property value="forumName" /></td>
						<td><s:property value="owner.userName" /></td>
						<td><s:property value="classType" /></td>
						<td><s:property value="type.typeName" /></td>
						<td><s:property value="createDate" /></td>
						<td>
							<a href="javascript:void(0);" class="detail" value="<s:property value='id'/>" >详情</a>
							| <a href="forumandforumDetail?forum.id=<s:property value='id'/>"> 修改</a>
							| <a href="../forum/articleandtypeForum?forum.id=<s:property value='id'/>" target="_top"> 去看看</a>
						</td>			
					</tr>
					
					<div class="tover" id="detailBox<s:property value='id'/>">
						<div class="tclose">
							<div class="boxTitle">
								社交圈详情
								<a href="javascript:void(0);" class="closeBtn">
									<img src="../res/images/closeBtn.png">
								</a>
							</div>
						</div>
						<div class="orderDetailBox" style="border-bottom:1px solid #ddd;">
							<div>
								<div class="forumLogoBox" style="width:100px;height:100px;border:1px solid #ddd;float:left;margin:10px 60px 10px 80px;">
									<img alt="" src="..<s:property value='logoImage.pathName'/>" />
								</div>
								<div style="width:400px;float:left;padding-top:5px;">
									<div class="orderPeople">
										<span>论坛名：</span>
										<span class="orderDetailOne">
											<s:property value="forumName" /> 
										</span>
									</div>
									<div class="orderPeople">
										<span>论坛主：</span>
										<span class="orderDetailOne">
											<s:property value="owner.userName" /> 
										</span>
									</div>
									<div class="orderPeople">
										<span>论坛类别：</span>
										<span class="orderDetailOne">
											<s:property value="classTypeStr" /> 
										</span>
									</div>
									<div class="orderPeople" >
										<span>论坛分类：</span>
										<span class="orderDetailOne" >
											<s:property value="type.typeName" /> 
										</span>
									</div>
									<div class="orderPeople">
										<span>创建时间：</span>
										<span class="orderDetailOne">
											<s:date name='createDate' format="yyyy-MM-dd hh:mm"/>
										</span>
									</div>	
								</div>
								<div style="clear:both;"></div>
							</div>
							
							<div class="orderTimeBox">
								<div>社交圈描述：</div>
								<div style="margin-top:8px;line-height:20px;">
									<s:property value='introduction'/>
								</div>
							</div>			
						</div>
					</div>
					<div class="tback"></div><!--背景淡出-->
					
				</s:iterator>
			</s:if>	
			</tbody>
			
		</table>
	</div>
	
 
	<div class="operation">
		<ul>
			<a id="chooseAllBtn" onclick="checkedAll();" style="cursor:pointer;">
				<li>选择所有</li>
			</a>
			<a onclick="deleteBatch();" style="cursor:pointer;"	>
				<li>删除选中</li>
			</a>
		</ul>
	</div>
	
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
	

	<script type="text/javascript">
	//详情展示
jQuery(document).ready(function($) {
	$('.detail').click(function(){
		var temp = $(this).attr("value");
		$('.tback').fadeIn(100);
		$('#detailBox'+temp).slideDown(200);
	})
	$('.tclose .closeBtn').click(function(){
		$('.tback').fadeOut(100);
		$('.tover').slideUp(200);
	});
});
	</script>
	<script type="text/javascript">
	//选择所有进行操作
	function checkedAll() {
					
		if($("#chooseAllBtn li").html()=="选择所有"){
			$("#chooseAllBtn li").html("取消选择");
			$("input[name='forumId']").attr('checked','checked');
		}else{
			$("input[name='forumId']").removeAttr('checked');
			$("#chooseAllBtn li").html("选择所有");
		}
	}
	</script>
	<script type="text/javascript">
	//删除选中
	function deleteBatch(){
		if(!confirm("删除是不可恢复的,确定要删除?"))
		return;
		var ids="-1";
		var i=0;
		$("input:checked").each(
			function(){
				ids+=","+this.value;
			}
		);				
		
		$.post("forumanddeleteSelectedForum", {"ids":ids},
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
	}
	</script>
</body>
</html>