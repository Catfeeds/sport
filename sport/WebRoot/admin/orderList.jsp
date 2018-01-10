<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>订单的管理</title>
<!-- Bootstrap -->
<link href="../res/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="../res/js/jquery-1.8.3.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="../res/admin/css/orderListBase.css">
<link rel="stylesheet" type="text/css"
	href="../res/admin/css/orderListBox.css">
<link href="../res/commonComponents/resizeTable/css/dividePage.css"
	rel="stylesheet" type="text/css" />
<link href="../res/css/component.css"
	rel="stylesheet" type="text/css" />
<style type="text/css">
a {
	color: #39c;
}

a:hover {
	color: #c30;
}

.orderdetailPlace li {
    min-width: 200px;
    float: left;
    margin-right: 10px;
    border: 1px solid #39c;
    height: 25px;
    text-align: center;
    color: #39c;
    line-height:25px;
    font-size: 13px;
    margin-top:5px;
}

.orderdetailPrice {
    height: 40px;
    font-size: 18px;
    margin-left: 40px;
    line-height: 40px;
    margin-top: 10px;
}

.orderdetailPrice span {
    color: rgb(250,78,0);
    font-size: 22px;
    font-weight: bold;
    padding:0px 5px;
}
.orderStatusItem{
	margin:5px 10px;
}
.simpleSearchWrap{
	text-align:center;
	margin:20px;
}
</style>
</head>
<body>
	<s:if test="order.company.id!=null">
		<s:url var="searchUrl" value="orderandorderList" includeParams="none">
			<s:param name="page.pageSize" value="page.pageSize" />
			<s:param name="order.company.id" value="order.company.id" />
			<!-- 保证至少有一个参数，这样就会有一个？号 -->
		</s:url>
	</s:if>
	<s:elseif test="order.site!=null">
		<s:url var="searchUrl" value="orderandorderList" includeParams="none">
			<s:param name="page.pageSize" value="page.pageSize" />
			<s:param name="order.site.id" value="order.site.id" />
			<!-- 保证至少有一个参数，这样就会有一个？号 -->
		</s:url>
	</s:elseif>
	<s:elseif test="order.coach!=null">
		<s:url var="searchUrl" value="orderandorderList" includeParams="none">
			<s:param name="page.pageSize" value="page.pageSize" />
			<s:param name="order.coach.id" value="order.coach.id" />
			<!-- 保证至少有一个参数，这样就会有一个？号 -->
		</s:url>
	</s:elseif>
	<s:else>
		<s:url var="searchUrl" value="orderandorderList" includeParams="none">
			<s:param name="page.pageSize" value="page.pageSize" />
			<!-- 保证至少有一个参数，这样就会有一个？号 -->
		</s:url>
	</s:else>
	<h2 class="sub-header"
		style="margin-left:70px;font-size:25px;font-weight:bold;font-family:'微软雅黑';margin-top:20px;"><span id="pageName"></span>订单管理</h2>
	<div  style="margin:20px 50px;">
		<s:if test="order==null||(order.orderStatus==0)">
			<s:a style="color:red;"  class="orderStatusItem"  href="javascript:void(0);">
				所有
			</s:a>
		</s:if>
		<s:else>
			<s:a  class="orderStatusItem"  href="%{searchUrl}&order.orderStatus=0">
				所有
			</s:a>
		</s:else>
		<s:iterator begin="1" end="9" var="i">
			<s:if test="order.orderStatus==#i">
				<s:a style="color:red;" class="orderStatusItem" href="javascript:void(0);">
				</s:a>
			</s:if>
			<s:else>
				<s:a class="orderStatusItem" href="%{searchUrl}&order.orderStatus=%{#i}">
				</s:a>
			</s:else>
		</s:iterator>
	</div>
	<div class="simpleSearchWrap">
		<span><input type="text" style="width:200px;height:30px;" name="orderNumber" >&nbsp;&nbsp;
			<a href="javascript:void(0);" searchUrl="orderandorderList" id="simpleSearchBtn" style="width:100px;height:30px;"  class="blue button">搜索</a>
		</span>
	</div>
	<div class="table-responsive"
		style="margin-left:50px;margin-right:50px;">
		<table class="table table-striped">
			<thead>
				<tr>
					<th>选择</th>
					<th>订单编号</th>
					<th>金额</th>
					<th>订单提交时间</th>
					<th>订单状态</th>
					<th>确认用户已使用</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<s:if test="orders!=null">
					<s:iterator value="orders">
						<tr id="orderAllInfo<s:property value='id'/>">
							<td><input type="checkbox" name="orderId"
								value="<s:property value='id' />" />
							</td>
							<td><s:property value="orderNumber" />
							</td>
							<td>￥<s:property value='totalAcount' /></td>
							<td><s:property value="submitTime" />
							</td>
							<td class="junkedFlag">
								<s:if test="orderStatus==1">
									未提交
								</s:if> 
								<s:elseif test="orderStatus==2">
									已提交
								</s:elseif> 
								<s:elseif test="orderStatus==3">
									已付款
								</s:elseif>
								 <s:elseif test="orderStatus==4">
									已消费
								</s:elseif> 
								<s:elseif test="orderStatus==5">
									废单
								</s:elseif>
								<s:elseif test="orderStatus==6">
									正在支付
								</s:elseif>
								<s:elseif test="orderStatus==7">
									支付失败
								</s:elseif>
								<s:elseif test="orderStatus==8">
									正在申请退款
								</s:elseif>
								<s:elseif test="orderStatus==9">
									已退款
								</s:elseif>
							</td>
							<td><s:if test="hasUse">
								已确认
							</s:if> 
							<s:elseif test="order.orderStatus==3">
									<a href="javascript:void(0)" class="readOrderBtn"
										orderId="<s:property value='id'/>">确认消费</a>
							</s:elseif>
							<s:else>
								不可确认
							</s:else>
							</td>
							<td><a href="#" class="detail"
								value="<s:property value='id'/>">详情</a> &nbsp;&nbsp; <a
								href="javascript:void(0)" class="deleteItemBtn"
								orderId="<s:property value='id'/>">删除</a></td>
						</tr>

						<div class="tover" id="detailBox<s:property value='id'/>">
							<div class="tclose">
								<div class="boxTitle">
									订单详情 <a href="javascript:void(0)" class="closeBtn"> <img
										src="../res/images/closeBtn.png"> </a>
								</div>
							</div>
							<div class="orderDetailBox">

								<div style="border-bottom:1px solid #ddd;">
									<div class="orderPeople">
										<span>买家名字：</span> <span class="orderDetailOne"> <s:property
												value="buyer.userName" /> </span>
									</div>
									<div class="orderPeople">
										<span>联系方式：</span> <span class="orderDetailOne"> 
										<s:if test="phone!=null">
											<s:property	value="phone" />
										</s:if>
										<s:elseif test="buyer.phone==null">
											<s:property	value="buyer.phone" />
										</s:elseif> 
										<s:else>
											买家未留电话
										</s:else>
										</span>
									</div>
									<div class="orderPeople">
										<span>订单种类：</span> <span class="orderDetailOne"> 
											<s:if test="coach!=null">
												教练订单：<s:property value='coach.realName'/>
												<s:if test="items[0].product!=null">
												(<s:property value='items[0].product.productName'/>)
												</s:if>
												<s:else>
													(教练自行安排)
												</s:else>
											</s:if>
											<s:else>
												场地订单:<s:property value='site.siteName'/>(<s:property value='product.productName'/>)
											</s:else>
										</span>
									</div>
									<div class="orderPeople">
										<span>订单状态：</span>
										<span class="orderDetailOne">
										 <s:if	test="orderStatus==1">
											未提交
										</s:if> 
										<s:elseif test="orderStatus==2">
											已提交
										</s:elseif>
										 <s:elseif test="orderStatus==3">
											已付款
										</s:elseif> 
										<s:elseif test="orderStatus==4">
											已消费
										</s:elseif> 
										<s:elseif test="orderStatus==5">
											废单
										</s:elseif>
										<s:elseif test="orderStatus==6">
											正在支付
										</s:elseif>
										<s:elseif test="orderStatus==7">
											支付失败
										</s:elseif>
										<s:elseif test="orderStatus==8">
											正在申请退款
										</s:elseif>
										<s:elseif test="orderStatus==9">
											已退款
										</s:elseif> </span>
									</div>
								</div>
								
								<div class="orderTimeBox">
									<div>
										<dl>
											<dt>订单编号 :</dt>
											<dd>
												&nbsp;<s:property value='orderNumber' />
											</dd>
											<dt>订单交易号 :</dt>
											<dd>
												&nbsp;<s:property value='tradeNumber' />
											</dd>
										</dl>
									</div>
									<div>
										<dl>
											<dt>订单提交时间 :</dt>
											<dd>
												&nbsp;<s:property value='submitTime' />
											</dd>
											<dt>订单付款时间 :</dt>
											<dd>
												&nbsp;<s:property value='payTime' />
											</dd>
										</dl>
									</div>
									<div>
										<dl>
											<dt>确认消费时间 :</dt>
											<dd>
												&nbsp;<s:property value='deliveredTime' />
											</dd>
											<dt>订单使用时间 :</dt>
											<dd>
												&nbsp;<s:property value='useTime' />
											</dd>
										</dl>
									</div>
									
								</div>	
								
								<div class="orderTimeBox">
									<ul class="orderdetailPlace">
										<s:if test="coach==null">
											<s:iterator value="items" status="status">
												<li>
												场地：<s:date name="useDate" format="MM.dd" />/<s:property value='week'/>&nbsp;
												&nbsp;<s:property value='time'/>-<s:property value='time+1'/>时
												<s:property value='place.placeName'/>号场 
												<s:property value='place.prices[time]'/>元</li>
											</s:iterator>
										</s:if>
										<s:else>											
											<s:iterator value="items"> 
									 		<li>
									 			<s:date name="useDate" format="MM.dd" />/<s:property value='week'/>&nbsp;
									 			<s:if test="time==0">
									 				上午&emsp; 09：00--12：00
									 			</s:if>
									 			<s:elseif test="time==1">
									 				下午&emsp; 14：00--17：00
									 			</s:elseif>
									 			<s:elseif test="time==2">
									 				晚上&emsp; 18：00--21：00
									 			</s:elseif>
									 			<s:else>
									 				全天&emsp; 09：00--21：00
									 			</s:else>
									 			<s:if test="time<=2">
									 			<b><s:property value='price'/></b>
									 			</s:if>
									 			<s:else>
									 			<b><s:property value='price*3'/></b>
									 			</s:else>
									 		</li>
									 		</s:iterator>
										</s:else>
									</ul>
									
								</div>
								
							</div>
						</div>
						<div class="tback"></div>
						<!--背景淡出-->

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
			<a onclick="deleteJunked();" style="cursor:pointer;">
				<li>删除作废订单</li> </a>
		</ul>
	</div>
	<s:if test="page!=null&&page.pageSize>0">
		<div class="pagination">
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
		</div>
	</s:if>

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
			$("input[name='orderId']").attr('checked','checked');
		}else{
			$("input[name='orderId']").removeAttr('checked');
			$("#chooseAllBtn li").html("选择所有");
		}
	}
	</script>
	<script type="text/javascript">
		//删除选中
	function deleteBatch(){
		if(!confirm("删除是不可恢复的，确定要删除？"))
				return;
		var ids="-1";
		var i=0;
		$("input:checked").each(
			function(){
				ids+=","+this.value;
			}
		);				
		
		$.post("orderanddeleteSelectedOrders", {"ids":ids},
			   function(data){
			   	 var arr=new Array();
					$.each(data, function(i, item) {
						arr.push(item);					           
					});
					
					if(arr[0]){//true时表示操作成功，更改界面元素状态								
						/*$("input:checked").each(
						function(){
								$("#orderAllInfo"+this.value).empty().hide();
							}
						);*/
						document.location=document.location;	
					}
					alert(arr[1]);		
		 },'json');
	}
	$(function(){
		$(".deleteItemBtn").click(function(){
			if(!confirm("删除是不可恢复的，确定要删除？"))
				return;
			var orderId=$(this).attr("orderId");
			$.post("orderanddeleteOrder", {"order.id":orderId},
			   function(data){
			   	 var arr=new Array();
					$.each(data, function(i, item) {
						arr.push(item);					           
					});
					
					if(arr[0]){//true时表示操作成功，更改界面元素状态								
						//$("#orderAllInfo"+orderId).empty().hide();
						document.location=document.location;
					}else{
						alert(arr[1]);
					}	
			 },'json');
		});
		$(".readOrderBtn").click(function(){
			var orderId=$(this).attr("orderId");
			var thisObj=this;
			$.post("orderanduseOrder", {"order.id":orderId},
			   function(data){
			   	 var arr=new Array();
					$.each(data, function(i, item) {
						arr.push(item);					           
					});
					
					if(arr[0]){//true时表示操作成功，更改界面元素状态								
						$(thisObj).parent().html("已确认");
					}else{
						alert(arr[1]);
					}	
			 },'json');
		});
		$(".orderStatusItem").each(function(index){
			var arr=["所有","未提交","已提交","已付款","已消费","废单","正在支付","支付失败","正在申请退款","已退款",];
			$(this).html(arr[index]);
			if($(this).attr("href")=="javascript:void(0);")
				$("#pageName").html(arr[index]);
		});
		$("#simpleSearchBtn").click(function(){//按订单号简单搜索本公司的订单
			var orderNumber=$("input[name=orderNumber]").val();
			var url=$(this).attr("searchUrl")+"?order.orderNumber="+orderNumber;
			document.location=url;
		});
	});
	</script>
</body>
</html>