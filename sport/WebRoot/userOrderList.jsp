<%@ page language="java"  contentType="text/html; charset=UTF-8" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html>
<html lang="en">

	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>用户订单管理</title>
		<meta name="description" content="">
		<meta name="author" content="templatemo">
		<link href='http://fonts.useso.com/css?family=Open+Sans:400,300,400italic,700' rel='stylesheet' type='text/css'>
		<link href="res/css/font-awesome.min.css" rel="stylesheet">
		<link href="res/css/bootstrap.min.css" rel="stylesheet">
		<link href="res/css/templatemo-style.css" rel="stylesheet">

<!-- 引入分页下标 -->
<link href="./res/commonComponents/resizeTable/css/dividePage.css"
	rel="stylesheet" type="text/css" />
<!--end -->
		<link href="res/css/component.css" type="text/css" rel="stylesheet" />
		<link href="res/css/userHome.css" type="text/css" rel="stylesheet" /> 
<!-- 弹出登录注册对话框 -->
	<link rel="stylesheet" href="res/commonComponents/loginPopDialog/css/loginbox.css"  type="text/css"/>
	<script type="text/javascript" src="res/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="res/js/header.js"></script>
	<!-- 弹出框结束 -->
  <Style>
.coach-list{
			float: left;
			font-size:12px;
			 width: 250px; 
			padding:0 10px;
			margin: 5px; 
			border: 1px solid #6495ED;
		}
		.coach-list b{
			color:#f00;
			padding-left:20px;
		}
</Style>
		<style>
			.orderhead li {
				float: left;
				text-align: center;
				margin: 2px 15px;
			}
			.orderhead h4 {
				margin:2px auto;
			}
			.orderhead span {
				color: #A6A6A6;
				text-align: left;
				width: 150px;
			}
			.orderfoot {
				margin-right: 100px;
				margin-bottom: 40px;
			}
			.orderfoot li {
				float: right;
			}
			.orderfoot span {
				font-size: 16px;
				font-weight: 700;
			}
			r {
				color: red;
			}
			.orderfoot input[type=button] {
				font-size: 16px;
				padding: 0 20px;
				margin: auto 20px;
				color: white;
				border-radius: 10px;
				background: rgb(57, 173, 180);
			}
			.ordertitle li {
				float: left;
				margin: auto 15px;
			}
			.orderdetail li {
				float: left;
				line-height: 20px;
				cursor: pointer;
				margin: 2px 15px;
				border: #39c 1px solid;
			}
			.orderdetailtitle {
				font-size: 15px;
				color: #1F2124;
				float: left;
				width: 80px;
				font-weight: 500;
				margin: 0px 10px;
				cursor: pointer;
			}
			.titleli {
				line-height: 25px !important;
				cursor: none !important;
				border: none !important;
			}
			.displaycss {
				display: none;
			}
			.comments {
				text-align: left;
				border: 1px #A6A6A6 solid;
				border-top: none !important;
				border-radius: 10px;
				padding: 0 20px;
			}
			.star li {
				float: left;
				width: 24px;
				cursor: pointer;
				text-indent: -9999px;
				background: url(res/images/star.png)0 0 no-repeat;
			}
			.stars li {
				float: left;
				width: 24px;
				cursor: pointer;
				text-indent: -9999px;
				background: url(res/images/star.png)0 0 no-repeat;
			}
			.light {
				background: url(res/images/star.png)0 -28px no-repeat !important;
			}
			.ahalflight {
				background: url(res/images/star.png)0 -50px no-repeat !important;
			}
			.commentdetilep{
			 line-height: 20px;width:600;word-break:break-all; 　word-wrap:break-word; border-bottom: solid 1px #101010;
			}
		</style>

	</head>
<s:url var="searchUrl" value="orderanduserOrderList" includeParams="none">
	<s:param name="page.pageSize" value="page.pageSize"></s:param>
</s:url>
	<body>
	  <!-- header -->
<iframe src="header" scrolling="no" frameborder="0" width="100%" height="190px"></iframe>
<!-- /header -->
		<!-- Left column -->
<div style="width:1000px; margin: auto auto 20px auto;">
		<div class="templatemo-flex-row">
			<div class="templatemo-sidebar" style="float: left;">
				<div class="profile-photo-container">
					<img src=".<s:property value='#session.currentUser.image.pathName'/>" alt="个人头像" class="img-responsive">
						<h3 style="text-align: center; padding: 5px;"><s:property value='#session.currentUser.realName'/></h3>
				</div>
				
				<nav class="templatemo-left-nav">
										<ul>
						<li><a href="userHome"><i class="fa fa-home fa-fw"></i>个人首页</a></li>
			            <li><a href="useranduserDetail" >个人资料管理</a></li>
			            <li><a href="orderanduserOrderList"   class="active">订单管理</a></li>
			            <li><a href="forumanduserCaredForum">关注的圈子</a></li>
			            <li><a href="articleanduserArticleList">我的帖子</a></li>
					</ul>
				</nav>
			</div>
			<!-- Main content -->
			
			<div class="templatemo-content col-1 light-gray-bg templatemo-content-container" 
				style=" width:80%;float:right;">
				<s:iterator value="orders">
					<div class="templatemo-content-widget white-bg">
					<div class="panel panel-default no-border">
						<div class="panel-heading border-radius-10" style="float: left;">
							<s:if test="orderStatus<3">
								<h2>订单状态：未支付</h2>									
							</s:if>
							<s:elseif test="orderStatus==3">
								<h2>订单状态：已支付（未确认消费）</h2>
							</s:elseif>
							<s:elseif test="orderStatus==4">
								<h2>订单状态：已经消费</h2>
							</s:elseif>
							<s:elseif test="orderStatus==5">
								<h2>订单状态：已失效（建议删除）</h2>
							</s:elseif>
							<s:elseif test="orderStatus==6">
								<h2>订单状态：订单正在支付中</h2>
							</s:elseif>
							<s:elseif test="orderStatus==7">
								<h2>订单状态：支付失败（建议删除）</h2>
							</s:elseif>
							<s:elseif test="orderStatus==8">
								<h2>订单状态：正在申请退款</h2>
							</s:elseif>
							<s:elseif test="orderStatus==9">
								<h2>订单状态：已经退款成功</h2>
							</s:elseif>
							<s:elseif test="orderStatus==10">
								<h2>订单状态：已经短信验证成功</h2>
							</s:elseif>
						</div>
						<div style="float: left; margin-left: 20px;">
							<h2>订单编号 :<b><s:property value="orderNumber"/></b></h2>
						</div>
						<div class="clearfix"></div>
						<ul class="orderhead">
							<s:if test="items[0].place!=null">
								<li>
								<h4><b>场馆:</b>
									<s:property value="items[0].place.site.siteName"/>/
									<s:property value="items[0].product.productName"/>								
								</h4></li>
							</s:if>
							<s:else>
								<li>
								<h4><b>教练:</b><s:property value="items[0].coach.realName"/>/
									<s:if test="items[0].product!=null">
										<s:property value="items[0].product.productName"/>
									</s:if>
									<s:else>
										教练自行安排
									</s:else>
								</h4></li>
							</s:else>							
							<li>
								<h4><b>消费时间：</b><s:date name='preOrderTime' format="yyyy-MM-dd"/> (<s:property value='week'/>)</h4></li>
							<li>
								<h4><b>地址：</b>
								<s:if test="items[0].place!=null">
									<s:property value='items[0].product.site.address.parentAddress.parentAddress.addressName'/>>
									<s:property value='items[0].product.site.address.parentAddress.addressName'/>>
									<s:property value='items[0].product.site.address.addressName'/>&nbsp;&nbsp;
									<s:property value='items[0].product.site.siteAddress'/>
								</s:if>
								<s:else>
									教练另行通知
								</s:else>
								</h4></li>
						</ul>
						<div class="clearfix"></div>
						<ul class="orderhead">
							<li><span>提交时间：<s:date name="submitTime" format="yyyy-MM-dd"/> </span></li>
							<li><span>支付时间：<s:date name="payTime" format="yyyy-MM-dd"/> </span></li>
							<li><span>消费时间：<s:date name="preOrderTime" format="yyyy-MM-dd"/> </span></li>
						</ul>
						<div class="clearfix"></div>
							<div class="panel-body templatemo-flex-row flex-content-row margin-bottom-30">
							<div class="col-1">
								<div class="orderdetailtitle"/>订单详细</div>
								<div style="float: left;">
									<s:if test="items[0].place!=null">
										<ul class="orderdetail ">
											<s:iterator value="items">
												<li>场地<s:property value='place.placeName'/>&emsp;
												<s:property value='time'/>：00-<s:property value='time+1'/>：00</li>
											</s:iterator>
										</ul>
									</s:if>
									<s:else>
										<s:iterator value="items"> 
									 		<span class='coach-list' id="<s:property value='coach.id'/><s:property value='coachPreOrder.id'/><s:property value='time'/>"
									 			orderItemId="<s:property value='id'/>">
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
									 			<b><s:property value='price'/></b>
									 		</span>
									 	</s:iterator>
									</s:else>
								</div>
								<div class="clearfix"></div>
								<br />
								<ul class="orderfoot">
									<s:if test="orderStatus<3||(orderStatus==6)">
										<li><a href="orderandtoPayOrder?order.id=<s:property value='id'/>">
											<input class="payBtn"  orderId="<s:property value='id'/>" type="button" value="支付"/>
										</a></li>	
										<li>
											<input class="deleteBtn" orderId="<s:property value='id'/>" type="button" value="删除">
										</li>								
									</s:if>
									<s:elseif test="orderStatus==3">
										<li>
											<input class="confirmUseBtn" orderId="<s:property value='id'/>" type="button" value="确认已消费">
										</li>
										<li>
											<input class="refoundBtn" 
												refoundUrl="orderandrefound?order.id=<s:property value='id'/>"
												orderId="<s:property value='id'/>" type="button" value="申请退款"/>
										</li>						
									</s:elseif>
									<s:elseif test="orderStatus==4">
										<s:if test="items[0].comment==null">
										<li>
											<input class="commentBtn"  orderId="<s:property value='id'/>" type="button" value="评论">
										</li>
										<li>
											<input class="submitbutton displaycss"  orderId="<s:property value='id'/>"  id="<s:property value='id'/>btnsub" type="button" value="提交评论">
										</li>
										</s:if>
										<li>
											<input class="deleteBtn" orderId="<s:property value='id'/>" type="button" value="删除">
										</li>
										
									</s:elseif>
									<s:elseif test="orderStatus==5||(orderStatus==7)||(orderStatus==9)">
										<li>
											<input class="deleteBtn" orderId="<s:property value='id'/>" type="button" value="删除">
										</li>
									</s:elseif>		
									<s:elseif test="orderStatus==8">
										<li>
											<a href="refoundandrefoundDetail?refound.order.id=<s:property value='id'/>">
											<input  onclick="javascript:void(0);" 
												type="button" value="申请详情">
											</a>
										</li>
									</s:elseif>	
									<li><span>共计<r><s:property value='totalAcount'/></r>元</span></li>
								</ul>
								<div class="clearfix"></div>
								<s:if test="orderStatus==4">
									<s:if test="items[0].comment==null">
									<div class="comments displaycss" id="<s:property value='id'/>div">
										<ul class="star" orderId="<s:property value='id'/>" id="<s:property value='id'/>btnstar">
			                                <li class="light" starId="1" ><a href="javascript:void(0);">1</a></li>
			                                <li class="light" starId="2" ><a href="javascript:void(0);">2</a></li>
			                                <li class="light" starId="3" ><a href="javascript:void(0);">3</a></li>
			                                <li class="light" starId="4" > <a href="javascript:void(0);">4</a></li>
			                                <li class="light" starId="5" ><a href="javascript:void(0);">5</a></li>
		                                	<input type="hidden" name="star" value="5"/>
		                            	</ul>
		                       			<p class="starcomment" id="starIntro<s:property value='id'/>">很好</p>
		                        		<div class="clearfix"></div>
		                        		<br />
		                            	<p contenteditable="true" style=" line-height: 20px; border-bottom: solid 1px #101010;">
		                            	<textarea style="width:100%" maxlength="100" id="commentEditor<s:property value='id'/>" rows="3" cols="100%" placeholder="请评论（100字内）"></textarea>
		                            	</p>							
									</div>
									</s:if>
									<s:else>
										<div class="comments" id="<s:property value='id'/>div">
										<ul class="stars" orderId="<s:property value='id'/>" id="<s:property value='id'/>btnstar">
			                               
			                                <s:iterator begin="1" end="items[0].comment.score" var="i">
			                                	 <li class="light" starId="<s:property value='i'/>" ><a href="javascript:void(0);"><s:property value='i'/></a></li>
			                                </s:iterator>
			                                 <s:iterator begin="items[0].comment.score" end="4" var="i">
			                                	 <li starId="<s:property value='i'/>" ><a href="javascript:void(0);"><s:property value='i'/></a></li>
			                                </s:iterator>
		                                	<input type="hidden" name="star" value="5"/>
		                            	</ul>
		                       			<p class="starcomment" id="starIntro<s:property value='id'/>"></p>
		                        		<div class="clearfix"></div>
		                        		<br />
		                            	<p contenteditable="false" class="commentdetilep" style="">
		                            	<s:property value='items[0].comment.detail'/>
		                            	</p>							
									</div>
									</s:else>
								</s:if>
							</div>	
						</div>
					</div>
					</div>
				</s:iterator>	
				<!-- 分页选择部分 -->
			<div class="left_result_info">
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
							<li><s:a href="%{searchUrl}&page.pageNumber=1">首页</s:a>
		
							</li>
							<li><s:a
								href="%{searchUrl}&page.pageNumber=%{page.pageNumber-1}">上一页</s:a>
							</li>
						</s:else>
						<!-- 如果总页码小于7页，就显示全部页码 -->
						<s:if test="page.totalPageNumber<=7">
							<s:iterator begin="1" var="i" end="page.totalPageNumber">
								<s:if test="#i==page.pageNumber">
									<li class="currentpage"><s:property /></li>
								</s:if>
								<s:else>
									<li><s:a
										href="%{searchUrl}&page.pageNumber=%{i}">
											<s:property /> </s:a>
									</li>
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
										<li class="currentpage"><s:property /></li>
									</s:if>
									<s:else>
										<li><s:a
											href="%{searchUrl}&page.pageNumber=%{i}">
												<s:property /> </s:a>
										</li>
									</s:else>
								</s:iterator>
								<li>...</li>
							</s:if>
							<s:elseif test="page.pageNumber<=4">
								<s:iterator begin="1" var="i" end="7">
									<s:if test="page.pageNumber==#i">
										<li class="currentpage"><s:property /></li>
									</s:if>
									<s:else>
										<li><s:a
											href="%{searchUrl}&page.pageNumber=%{i}">
												<s:property /> </s:a>
										</li>
									</s:else>
								</s:iterator>
								<li>...</li>
							</s:elseif>
							<s:elseif test="page.pageNumber+4>=page.totalPageNumber">
								<li>...</li>
								<s:iterator begin="page.pageNumber-3" var="i"
									end="page.totalPageNumber">
									<s:if test="page.pageNumber==#i">
										<li class="currentpage"><s:property /></li>
									</s:if>
									<s:else>
										<li><s:a
											href="%{searchUrl}&page.pageNumber=%{i}">
												<s:property /> </s:a>
										</li>
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
			<!-- 分页部分结束 -->		
			</div>
			</div>
		</div>


<script type="text/javascript">
	$(function(e) {
				$(".confirmUseBtn").click(function(){//确认该订单已经消费了
					$.post("orderanduseOrder",
					 	{   "order.id":$(this).attr("orderId")
					 	 },
						function(data){
							var arr=new Array();
							$.each(data, function(i, item) {
								arr.push(item);					           
							});
							if(arr[0]){//true时表示操作成功，更改界面元素状态								
								//这里刷新整个页面
					   			window.top.location=window.top.location;
							}else{
								alert(arr[1]);
							}												
					},'json'); 
				});
				$(".refoundBtn").click(function(){//确认该订单已经消费了
					var refoundUrl=$(this).attr("refoundUrl");
					$.post("orderandaplyRefound",
					 	{   "order.id":$(this).attr("orderId")
					 	 },
						function(data){
							var arr=new Array();
							$.each(data, function(i, item) {
								arr.push(item);					           
							});
							if(arr[0]){//true时表示操作成功，更改界面元素状态								
								//这里刷新整个页面
					   			window.top.location=refoundUrl;
							}else{
								alert(arr[1]);
							}												
					},'json'); 
				});
				$(".deleteBtn").click(function(){//确认该订单已经消费了
					$.post("orderanddeleteOrder",
					 	{   "order.id":$(this).attr("orderId")
					 	 },
						function(data){
							var arr=new Array();
							$.each(data, function(i, item) {
								arr.push(item);					           
							});
							if(arr[0]){//true时表示操作成功，更改界面元素状态								
								//这里刷新整个页面
					   			window.top.location=window.top.location;
							}else{
								alert(arr[1]);
							}												
					},'json'); 
				});
				/*
				$(".orderdetailtitle").click(function() {
					var orderlength = $(".orderdetailtitle").length;
					for (var i = 0; i < orderlength; i++) {
						if ($(this).attr("id") == $(".orderdetailtitle").eq(i).attr("id")) {
							$(".orderdetail").eq(i).toggleClass("displaycss");
						}
					}
				});//场地
				*/
				$(".star li").click(function(){
					var starlength=$(".star").length;
					var stararry=["很差","差","一般","还行","很好","非常好"];
					var thisid=$(this).attr("id");
					var i=0;
					var starId=$(this).attr("starId");
					var orderId=$(this).parent().attr("orderId");
					$("input[name=star]").val(starId);
					$("#starIntro"+orderId).html(stararry[starId-1]);
					$(this).parent().children().removeClass("light");
					$(".star#"+orderId+"btnstar li").each(function(){
						var tempId=$(this).attr("starId");
						if(tempId<=starId){
							$(this).addClass("light");
						}
					});					
				});
				
				
				$(".commentBtn").click(function(){
					var idstr=$(this).attr("orderId");
					var iddiv="#"+idstr+"div";
					var idsub="#"+idstr+"btnsub";
					idstr="#"+idstr;					
					$(iddiv).removeClass("displaycss");
					$(this).addClass("displaycss");
					$(idsub).removeClass("displaycss");
				});
				$(".submitbutton").click(function(){
					$(".star").attr("class","stars");
					$(".startcomment").attr("class","startcomments");
					var orderId=$(this).attr("orderId");
					var content=$("#commentEditor"+$(this).attr("orderId")).val();
					$(".submitbutton").addClass("displaycss");
					$.post("commentandaddComment",
					 	{   "order.id":orderId,
					 		"comment.detail":content,
					 		"comment.score":$("input[name=star]").val()
					 	 },
						function(data){
							var arr=new Array();
							$.each(data, function(i, item) {
								arr.push(item);					           
							});
							if(arr[0]){//true时表示操作成功，更改界面元素状态								
								//这里刷新整个页面
					   			window.top.location=window.top.location;
							}else{
								alert(arr[1]);
							}														
					},'json'); 
				});
				
	});
</script>
<iframe src="footer.jsp" scrolling="no" frameborder="0" width="100%" height="165px"></iframe>
	</body>

</html>