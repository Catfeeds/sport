<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>运动场馆预定</title>
</head>
<link href="res/css/zsport.css" rel="stylesheet" type="text/css">
<link href="res/css/zcoach.css" rel="stylesheet" type="text/css">
<link href="res/css/base.css" rel="stylesheet" type="text/css">
<link href="res/css/index.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="res/commonComponents/loginPopDialog/css/loginbox.css" />
<link href="res/commonComponents/resizeTable/css/dividePage.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript" src="res/js/slider.js"></script>
<script type="text/javascript" src="res/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="res/js/orderPlace.js"></script>
<!-- 弹出登录注册对话框 -->
	<link rel="stylesheet" href="res/commonComponents/loginPopDialog/css/loginbox.css"  type="text/css"/>
	<script type="text/javascript" src="res/js/header.js"></script>
	<!-- 弹出框结束 -->
<style>
.tagContent {
	HEIGHT: auto !important;
}

</style>

<!-- Anonymous 2015-10-24 18:01:52 轮播图   -->
<style>

img {
	border: 0;
}
.ck-slide ul {
	margin: 0;
	padding: 0;
	list-style-type: none;
}
.ck-slide {
	position: relative;
	overflow: hidden;
	border:5px solid #ddd;
}
.ck-slide ul.ck-slide-wrapper {
	position: absolute;
	top: 0;
	left: 0;
	z-index: 1;
	margin: 0;
	padding: 0;
}
.ck-slide ul.ck-slide-wrapper li {
	position: absolute;
}
.ck-slide .ck-prev, .ck-slide .ck-next {
	position: absolute;
	top: 50%;
	z-index: 2;
	width: 35px;
	height: 70px;
	margin-top: -35px;
	border-radius: 3px;
	opacity: .15;
	background: red;
	text-indent: -9999px;
	background-repeat: no-repeat;
	transition: opacity .2s linear 0s;
}
.ck-slide .ck-prev {
	left: 5px;
	background: url(res/images/arrow-left.png) #000 50% no-repeat;
}
.ck-slide .ck-next {
	right: 5px;
	background: url(res/images/arrow-right.png) #000 50% no-repeat;
}
.ck-slidebox {
	position: absolute;
	left: 50%;
	bottom: 12px;
	z-index: 30;
}
.ck-slidebox ul {
	height: 20px;
	padding: 0 4px;
	border-radius: 8px;
	background: rgba(0,0,0,0.5);
}
.ck-slidebox ul li {
	float: left;
	height: 12px;
	margin: 4px 4px;
}
.ck-slidebox ul li em {
	display: block;
	width: 12px;
	height: 12px;
	border-radius: 100%;
	background-color: #fff;
	text-indent: -9999px;
	cursor: pointer;
}
.ck-slidebox ul li.current em {
	background-color: #3cf;
}
.ck-slidebox ul li em:hover {
	background-color: #3cf;
}

.ck-slide { 
	width: 410px; 
	height: 250px; 
	margin: 0 auto;
	margin-top:20px;
}
.ck-slide ul.ck-slide-wrapper { 
	height: 240px;
	padding:5px;
}
.ck-slide ul.ck-slide-wrapper li a img {
	width: 400px; 
	height: 240px;
}

.sportselect_banner {
	height:280px;
}
.sportselect_detail {
	height:250px;
	
}
.sportselect_info {
	height:300px;
}


/* input type=number 去掉默认样式*/
input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button{
    -webkit-appearance: none !important;
    margin: 0; 
}
input[type="number"]{-moz-appearance:textfield;}
/* input type=number 去掉默认样式*/
</style>

<script src="res/js/slide.js"></script>
<script>
	$(document).ready(function(){
		$('.ck-slide').ckSlide({
				autoPlay: true
			});

	});
</script>
<!-- Anonymous 2015-10-24 18:01:52 轮播图   -->

</head>
<body>
<s:url var="searchUrl" value="orderPlace" includeParams="none">
	<s:param name="placeProduct.id" value="placeProduct.id"/>
	<s:param name="site.id" value="site.id"/>
	<s:param name="page.pageSize" value="page.pageSize"/><!-- 保证至少有一个参数，这样就会有一个？号 -->
</s:url>
	<div>
		<iframe src="header" width="100%" height="190px" frameborder="0"
			scrolling="no"></iframe>
	</div>
	<div class="mainbody">

		<div class="sport_body">
			<div class="sportselect_info">
				<div class="sportselect_banner">
					<!-- Anonymous  轮播图   -->
					<div class="ck-slide">
						<ul class="ck-slide-wrapper">
							<s:iterator value='placeProduct.midImages'>
								<li>
									<a href="javascript:void(0)"><img src=".<s:property value='pathName'/>" alt=""></a>
								</li>
							</s:iterator>
						</ul>
						<a href="javascript:" class="ctrl-slide ck-prev">上一张</a> <a href="javascript:" class="ctrl-slide ck-next">下一张</a>
					</div>
				    <!-- Anonymous  轮播图   -->
				    <%-- 
					<div id=focus_img style="background-color:#F1F1F1">
						<table id=focus_warp cellSpacing=0 cellPadding=0 width=400
							border=0 >
							<tbody>
								<tr>
									<td>
										<div id=au style="WIDTH: 400px">
											<div class=dis name="f">
												<img height=225 alt=01 width=400
													src=".<s:property value='placeProduct.midImages[0].pathName'/>"
													>
											</div>
											<s:iterator value='placeProduct.midImages' begin='1'
												status="status">
												<s:if test="#status.index<3">
													<div class=undis name="f">
														<img height=225 alt=01
															src=".<s:property value='pathName'/>" width=400>
													</div>
												</s:if>
											</s:iterator>
										</div></td>
								</tr>
								<tr>
									<td height=75>
										<table id=simg cellSpacing=0 cellPadding=0 width=326 border=0>
											<tbody>
												<tr>
													<s:iterator value='placeProduct.midImages' status="status">
														<s:if test="#status.index<3">
															<td style="width:110px;padding:0 5px" class=s onmouseover="play(this,'au','');" align=right>
																<img height=56 src=".<s:property value='pathName'/>" width=120 ></td>
														</s:if>
													</s:iterator>
													<td width="77"></td>
												</tr>
											</tbody>
										</table></td>
								</tr>
							</tbody>
						</table>
					</div> --%>
				</div>
				<div class="sportselect_detail">
					<strong><s:property value="placeProduct.site.siteName" />
					</strong>
					<div style="width:450px; background-color:#87CEFF; height:5px;"
						align="left"></div>
					<br />
					<p>
						<span>场馆地址：</span>
						<s:property value='placeProduct.site.siteAddress' />
					</p>
					<p>
						<span>联系电话：</span>
						<s:property value='placeProduct.site.sitePhone' />
					</p>
					<p>
						<span>场馆价格：</span>
						<s:property value='placeProduct.normalPrice' />
						元起
					</p>
					<p>
						<span>附加服务：</span>
						<s:property value='placeProduct.site.service' />
					</p>
					<p>
						<span>公共交通：</span>
						<s:property value='placeProduct.site.route' />
					</p>
				</div>
			</div>

			<div class="select_day">
				<div id=con>
					<ul id="tags">
						<s:iterator value="dates" var="date" begin="0" status="status">
							<s:if test="placeProduct.site.weekJobTimes[weekIndexArr[#status.index]]==1">
								<li ><a class="tabItem" tabId="<s:property value='#status.index'/>" href="javascript:void(0);"> 
								<s:date name="#date" format="MM.dd/" timezone="ch" /> <s:property value="weeks[#status.index]" /> 
								</a></li>
							</s:if>
							<s:else>
								<li ><a class="tabItem" style="background:rgb(53,53,53);" tabId="<s:property value='#status.index'/>" href="javascript:void(0);"> 
								<s:date name="#date" format="MM.dd/" timezone="ch" /> <s:property value="weeks[#status.index]" /> 
								</a></li>
							</s:else>
						</s:iterator>
					</ul>
					<div style="clear:both;"></div>
					<div id=tagContent>
						<s:iterator value="sitePreOrderInfos" status="status">
							<s:if test="placeProduct.site.weekJobTimes[weekIndexArr[#status.index]]==1">
							<div class="tagContent"
								id="tagContent<s:property value='#status.index'/>">
								<table class="selecthail">
									<tr id=r0>
										<td width="23px" id=d0> 场 地 </td>
										<s:iterator begin="9" end="22" var="i" status="status">
											<td width="10" style="font-size:10px;"><s:property
													value="#status.index+8" />-<s:property value='i' /></td>
										</s:iterator>
										<td style="width:23px"></td>
									</tr>
								</table>
								<div style="width:680px; height:500px; overflow-y:scroll;">
									<table class="selecthail">
									<s:iterator value="placesDayInfo" status="middleStatus">
										<tr id="r<s:property value='#middleStatus.index+1'/>" placeId="<s:property value='place.id'/>"
											orderId="<s:property value='order.id'/>">
											<td id="d<s:property value='place.id'/>" class="placetitle">
												<p style="width:23px;overflow:hidden;text-overflow: ellipsis;white-space:nowrap;">	
												<s:property value="place.placeName" /> <!-- 时间：<s:property value='order.date'/> -->
												</p>
											</td>
											<s:iterator value="order.orderInfos" var="count"
												status="innerStatus">
												<s:if test="#innerStatus.index>7&&(#innerStatus.index<22)">
													<s:if
														test="#count>0&&(sitePreOrderInfos[#status.index].placesDayInfo[#middleStatus.index].place.prices[#innerStatus.index]>0)">
														<td id="d<s:property value='#innerStatus.index+1'/>"
															class="able_td"
															timeId="<s:property value='#innerStatus.index'/>"
															style="font-size:12px;" selectTime="false"
															price="<s:property value='sitePreOrderInfos[#status.index].placesDayInfo[#middleStatus.index].place.prices[#innerStatus.index]'/>">
															<div style="width:40px;overflow:hidden;text-overflow:clip;white-space:nowrap;">
															￥<s:property
																value="sitePreOrderInfos[#status.index].placesDayInfo[#middleStatus.index].place.prices[#innerStatus.index]" />
															</div>
														</td>
													</s:if>
													<s:else>
														<td id="d<s:property value='#innerStatus.index+1'/>"
															class="occupy_td"
															timeId="<s:property value='#innerStatus.index'/>">
															<div style="width:40px;overflow:hidden;text-overflow:clip;white-space:nowrap;">
																		无
															</div>
														</td>
													</s:else>
												</s:if>
											</s:iterator>
											<!-- td两种状态：able_td、occupy_td -->
										</tr>
									</s:iterator>
								</table>
								</div>
							</div>
							</s:if>
							<s:else>
							<div  class="tagContent"
								id="tagContent<s:property value='#status.index'/>">
								该场馆今天不营业！
							</div>
							</s:else>
						</s:iterator>
					</div>
				</div>

				<div class="select_order">
					<img src="res/images/other/tishi.png" width="200" height="20" /> <br />
					<hr />
					<br />
					<ti> <strong style="font-size:18px; color:#333;">预定项目：</strong>
					<s:property value='placeProduct.type.typeName' /></ti>
					<br />
					<da> <strong style="font-size:18px; color:#333;">预定日期：</strong>
					<span id="orderedDay"></span></da>
					<br />
					<ti> <strong style="color:#333;">场次：</strong></ti>
					<div id="ordersBox"></div>
					<span>已选择<b
						style="color:#F00; font-size:18px; font-weight:600"
						id="orderedNumber"> </b>个场次,单击取消</span>
					<hr />
					<strong style="margin-left:2em;">共<b
						style="color:#F00; font-size:18px; font-weight:600"
						id="totalPrice"> 0 </b>元</strong> <br /> <br />
					<p style="border:#FFF; float:right;">
						<a href="orderandsubmitOrder" class="abutton"> 立即预定 </a>
					</p>
				</div>
				<br />
				<div style="clear:both;"></div>
				<div style="width:900px; margin-right:10px; border: #Fff 2px solid;">
					<div class="uldiv">
						<ul class="titul">
							<li class="tipsli" id="details">场馆详情</li>
							<li class="hiddenli">
								<div>
									<p>
										<s:property escapeHtml="false" value='placeProduct.site.detail' />
									</p>
								</div>
							</li>
							<li class="tipsli" id="comments">场馆评论</li>
							<li class="hiddenli detailli" >
								<UL class="commentsummary">
									<LI>综合评价</LI>
									<LI><ul class="star">
											
											<s:iterator begin="1" end="avgComment.score" var="i">
												<li class="light"><a href="javascript:;"><s:property value='i'/></a></li>
											</s:iterator>
											<s:if test="avgComment.score<5">
												<s:if test="avgComment.half">
													<li class="ahalflight"><a href="javascript:;"><s:property value='i'/></a></li>
												</s:if>
												<s:else>
													<li><a href="javascript:;"><s:property value='i'/></a></li>
												</s:else>
												<s:iterator begin="avgComment.score+1" end="4" var="i">
													<li><a href="javascript:;"><s:property value='i'/></a></li>
												</s:iterator>
											</s:if>
										</ul>
									</LI>
									<li style="float:right;"><SPAN><I><s:property
													value='page.pageNumber' />
										</I>/<s:property value='page.totalPageNumber' />
									</SPAN> <A class="fany" href="javascript:void(0);">&gt;</A>
									</LI>
									<li style="float:right;">共<s:property
											value='page.totalItemNumber' />条 &emsp;</li>
								</ul>
								<s:iterator value="comments">
									<div class="commentcell">
										<span class="commentleft"> <img
											src="res/images/person.jpg" width="60" height="60" /> <b><s:property value='user.userName' default="用户名"/></b>
										</span>
										 <span class="commentright">
											<ul class="star">												
												<s:iterator begin="1" end="score" var="i">
													<li class="light"><a href="javascript:;"><s:property value='i'/></a></li>
												</s:iterator>
												<s:iterator begin="score" end="4" var="i">
													<li><a href="javascript:;"><s:property value='i'/></a></li>
												</s:iterator>
											</ul>
											<hr />
											
											<p style="margin-left:30px;word-break:break-all;word-wrap:break-word;"><s:property value='detail'/></p>
											<s:if test="replyContent!=null">
											<div style="margin-left:40px;border:1px solid #333;border-top:none; width:680px;height:auto;border-radius:none !important;padding:0">
												<P>&emsp;商家回复：</P>
												<p style="margin-left:50px;word-break:break-all;word-wrap:break-word;"><s:property value='replyContent' /></p>
											</div>
											</s:if>
					
										</span>
									</div>
								</s:iterator>	

								<div style="text-align:center; padding:0;">
									<s:if test="page.totalPageNumber>1">
										<div class="pagination">
											<ul>
												<!-- 如果当前页是第一页 -->
												<s:if test="page.pageNumber<=1">
													<li ><a style="background-color:#aaa">首页</a></li>
													<li ><a style="background-color:#aaa">上一页</a></li>
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
															<li class="currentpage"><s:property />
															</li>
														</s:if>
														<s:else>
															<li><s:a href="%{searchUrl}&page.pageNumber=%{i}">
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
																<li><s:a href="%{searchUrl}&page.pageNumber=%{i}">
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
																<li><s:a href="%{searchUrl}&page.pageNumber=%{i}">
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
																<li><s:a href="%{searchUrl}&page.pageNumber=%{i}">
																		<s:property />
																	</s:a></li>
															</s:else>
														</s:iterator>
													</s:elseif>
												</s:else>
												<!-- 如果当前页是最后一页 -->
												<s:if test="page.pageNumber==page.totalPageNumber">
													<li><a style="background-color:#aaa">下一页</a></li>
													<li><a style="background-color:#aaa">尾页</a></li>
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
									</s:if>
								</div>
							</li>
						</ul>
					</div>

				</div>
			</div>

		</div>

		<div style="clear:both;"></div>
	</div>
	<div class="mainbody">
		<iframe src="footer.jsp" width="100%" height="200px" frameborder="0"
			scrolling="no"></iframe>
	</div>
	<script>
$(function(e) {
    $(".tipsli").click(function(){
		var thisdom=$(this).attr('id');
		var uldom=$(".titul > li");
		uldom.each(function(index, element) {
			$(this).remove("detailli");
        });
		for(i=0;i<uldom.length;i++){
			if(thisdom==uldom.eq(i).attr('id')){
				j=i+1;
				uldom.eq(j).toggleClass("detailli");
				return;}
			i++;}
	});
});
	</script>
	<!-- 弹出登录开始  -->
	<div class="cd-user-modal" > 
		<div class="cd-user-modal-container">
			<ul class="cd-switcher">
				<li><a style="color:red;background:rgb(222,222,222);" href="#0">用户登录</a></li>
				<li><a href="#0">快速注册</a></li>
			</ul>

			<div id="cd-login" style="border:1px solid #ddd;"> <!-- 登录表单 -->
				<div>
					<form class="cd-form" >
					<p class="fieldset">
						<span class="lb-show">　　用户名：</span>
						<input class="full-width has-padding has-border" name="userName" id="signin-username" type="text" placeholder="请输入登陆账号、手机号码或者微信号">
					</p>

					<p class="fieldset">
						<span class="lb-show">　　密　码：</span>
						<input class="full-width has-padding has-border" name="password" id="signin-password" type="password"  placeholder="请输入密码">
					</p>
					
					<p class="fieldset">
						<input class="full-width2" id="loginBtn" type="button"  value="登 录">
					</p>
					</form>
				</div>
			</div>

			<div id="cd-signup" style="border:1px solid #ddd;"> <!-- 注册表单 -->
				<div class="div-phone">
					<form class="cd-form">
					<p class="fieldset">
						<span class="lb-show">　手机号码：</span>
						<input class="full-width has-padding has-border phonenumber" name="userName1" id="signup-username" type="number" placeholder="请输入手机号码">
					</p>
					<p class="fieldset">
						<span class="lb-show">　　密　码：</span>
						<input class="full-width has-padding has-border" name="password1" id="signin-password" type="password"  placeholder="请输入密码">
					</p>
					<!--  
					<p class="fieldset">
						<span class="lb-show">图形验证码：</span>
						<input class="full-width3 has-padding has-border" name="confirmImgCode" id="signin-password" type="text"  placeholder="请输入右方验证码">
						<span class="pic-box-span"><img alt="" id="confirmImg" src="res/images/banner1.png" confirmImgCode="" align="absmiddle" /> </span>
					
					</p>
					-->
					<p class="fieldset">
						<span class="lb-show">短信验证码：</span>
						<input class="full-width3 has-padding has-border" name="confirmCode" id="signup-password" type="text"  placeholder="请输入短信验证码">
						<a class="button blue msgcode" id="sendMessageBtn"  >获取短信验证码</a>
					</p>
					
					
					
					<p class="fieldset">
						<input class="full-width2" id="registerBtn" type="button"  value="注册新用户">
					</p>
					</form>
				</div>
			</div>

			<a href="javascript:void(0);" class="cd-close-form">关闭</a>
		</div>
	</div>
	<!-- 弹出登录结束  --> 
</body>
</html>
