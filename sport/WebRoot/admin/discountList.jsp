<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
			basePath+="admin/";
%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<base href="<%=basePath%>">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>退款订单管理</title>

<script type="text/javascript" src="../res/js/jquery-1.8.3.min.js"></script>
<link rel="stylesheet" type="text/css" href="../res/admin/css/orderListBase.css">
<link rel="stylesheet" type="text/css" href="../res/admin/css/orderListBox.css">
<link href="../res/commonComponents/resizeTable/css/dividePage.css" rel="stylesheet" type="text/css" />

<style type="text/css">
a {
	color: #39c;
}

a:hover {
	color: #c30;
}

.discountdetailPlace li {
    min-width: 200px;
    float: left;
    margin-right: 10px;
    bdiscount: 1px solid #39c;
    height: 25px;
    text-align: center;
    color: #39c;
    line-height:25px;
    font-size: 13px;
    margin-top:5px;
}

.discountdetailPrice {
    height: 40px;
    font-size: 18px;
    margin-left: 40px;
    line-height: 40px;
    margin-top: 10px;
}

.discountdetailPrice span {
    color: rgb(250,78,0);
    font-size: 22px;
    font-weight: bold;
    padding:0px 5px;
}
table.table thead tr th,table.table tbody tr td{
	text-align:center;
}
table.table thead tr th {
	font-size:14px;
	font-weight:bold;
	font-family:"微软雅黑";
}
.activity-intro {
	line-height:14px;
	max-width:300px;
	white-space:nowrap; 
	overflow : hidden;
	text-overflow: ellipsis;
}
</style>

</head>
<body>
	<s:url var="searchUrl" value="discountanddiscountList" includeParams="none">
		<s:param name="page.pageSize" value="page.pageSize" />
		<!-- 保证至少有一个参数，这样就会有一个？号 -->
	</s:url>
	<h2 class="sub-header"
		style="margin-left:70px;font-size:25px;font-weight:bold;font-family:'微软雅黑';margin-top:20px;">优惠活动管理</h2>
	<div class="table-responsive" style="margin:30px 50px ; font-weight:bold;">
		<div style="margin:15px 50px ;font-size:16px;">
		<s:a href="%{searchUrl}&discount.discountStatus=0">正在进行的活动</s:a>&nbsp;&nbsp;
		<s:a href="%{searchUrl}&discount.discountStatus=1">还未开始的活动</s:a>&nbsp;&nbsp;
		<s:a href="%{searchUrl}&discount.discountStatus=2">已经结束的活动</s:a>&nbsp;&nbsp;
		</div>
		<table class="table table-striped">
			<thead>
				<tr>
					<th>选择</th>
					<th>活动标题</th>
					<th>活动时间</th>
					<th>活动状态</th>
					<th>活动简介</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<s:if test="discounts!=null">
					<s:iterator value="discounts"> 
						<tr id="discountAllInfo<s:property value='id'/>">
							<td><input type="checkbox" name="discountId"
								value="<s:property value='id' />" />
							</td>
							<td><s:property value="title" />
							</td>
							<td><s:date name="beginDate" format="yyyy-MM-dd"/>							
							</td>
							<td>
								<s:if test="discountStatus==0">
									正在进行中
								</s:if>
								<s:elseif test="discountStatus=1">
									还未开始
								</s:elseif>
								<s:else>
									已经结束
								</s:else>
							</td>
							<td class="activity-intro">
								<s:property value='introduction'/>
							</td>
							<td><a href="discountanddiscountDetail?discount.id=<s:property value='id'/>" class="detail"
								value="<s:property value='id'/>">详情</a> &nbsp;&nbsp; 
							
								<a	href="javascript:void(0)" class="deleteItemBtn"
								discountId="<s:property value='id'/>">删除</a></td>
						</tr>
					 </s:iterator>
				</s:if> 
			</tbody>

		</table>
	</div>


	<div class="operation">
		<ul>
			<a id="chooseAllBtn" onclick="checkedAll();" style="cursor:pointer;">
				<li>选择所有</li> </a>
			<a onclick="deleteBatch();" style="cursor:pointer;">
				<li>删除选中</li> </a>
		</ul>
	</div>
	<s:if test="page!=null&&(page.totalPageNumber>0)">
		<div class="pagination">
			<ul>
				<!-- 如果当前页是第一页 -->
				<s:if test="page.pageNumber<=1">
					<li class="disablepage">首页</li>
					<li class="disablepage">上一页</li>
				</s:if>
				<!-- 否则 -->
				<s:else>
					<li><s:a href="%{searchUrl}&discount.discountStatus=%{discount.discountStatus}&page.pageNumber=1">首页</s:a></li>
					<li><s:a
							href="%{searchUrl}&discount.discountStatus=%{discount.discountStatus}&page.pageNumber=%{page.pageNumber-1}">上一页</s:a>
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
							<li><s:a href="%{searchUrl}&discount.discountStatus=%{discount.discountStatus}&page.pageNumber=%{i}">
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
								<li><s:a href="%{searchUrl}&discount.discountStatus=%{discount.discountStatus}&page.pageNumber=%{i}">
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
								<li><s:a href="%{searchUrl}&discount.discountStatus=%{discount.discountStatus}&page.pageNumber=%{i}">
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
								<li><s:a href="%{searchUrl}&discount.discountStatus=%{discount.discountStatus}&page.pageNumber=%{i}">
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
							href="%{searchUrl}&discount.discountStatus=%{discount.discountStatus}&page.pageNumber=%{page.pageNumber+1}">下一页</s:a>
					</li>
					<li class="nextpage"><s:a
							href="%{searchUrl}&discount.discountStatus=%{discount.discountStatus}&page.pageNumber=%{page.totalPageNumber}">尾页</s:a>
					</li>
				</s:else>
			</ul>
		</div>
	</s:if>

	<script type="text/javascript">
		//选择所有进行操作
	function checkedAll() {
					
		if($("#chooseAllBtn li").html()=="选择所有"){
			$("#chooseAllBtn li").html("取消选择");
			$("input[name='discountId']").attr('checked','checked');
		}else{
			$("input[name='discountId']").removeAttr('checked');
			$("#chooseAllBtn li").html("选择所有");
		}
	}
	
		//删除选中
	function deleteBatch(){
		var ids="-1";
		var i=0;
		$("input:checked").each(
			function(){
				ids+=","+this.value;
			}
		);				
		
		$.post("discountanddeleteSelectedDiscounts", {"ids":ids},
			   function(data){
			   	 var arr=new Array();
					$.each(data, function(i, item) {
						arr.push(item);					           
					});
					
					if(arr[0]){//true时表示操作成功，更改界面元素状态								
						/*$("input:checked").each(
						function(){
								$("#discountAllInfo"+this.value).remove();
							}
						);*/
						document.location=document.location;	
					}else{
						alert(arr[1]);	
					}	
		 },'json');
	}
	$(function(){
		$(".deleteItemBtn").click(function(){
			var discountId=$(this).attr("discountId");
			$.post("discountanddeleteDiscount", {"discount.id":discountId},
			   function(data){
			   	 var arr=new Array();
					$.each(data, function(i, item) {
						arr.push(item);					           
					});
					
					if(arr[0]){//true时表示操作成功，更改界面元素状态								
						//$("#discountAllInfo"+discountId).remove();
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