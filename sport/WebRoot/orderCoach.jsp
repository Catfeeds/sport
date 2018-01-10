<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>私人教练预定</title>
</head>
<link href="res/css/zsport.css" rel="stylesheet" type="text/css">
<link href="res/css/zcoach.css" rel="stylesheet" type="text/css">
<link href="res/css/base.css" rel="stylesheet" type="text/css">
<link href="res/css/index.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="res/commonComponents/loginPopDialog/css/loginbox.css"  type="text/css"/>
<script type="text/javascript" src="res/js/slider.js"></script> 
<script type="text/javascript" src="res/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="res/js/main.js"></script>
<script type="text/javascript" src="res/js/coachbook.js"></script>
<!-- 弹出登录注册对话框 -->
	<link rel="stylesheet" href="res/commonComponents/loginPopDialog/css/loginbox.css"  type="text/css"/>
	<script type="text/javascript" src="res/js/header.js"></script>
	<!-- 弹出框结束 -->
<style>
	*{
	padding: 0;
	margin: 0;}
		.clearfix{
			clear: both;
		}
		.displaycss{
			display: none;
		}
	
		.coach-week-optional {
			height: auto;
			
		}
		.coach-week-optional ul{
			list-style: none;
			background-color: #FFFFFF;
		}
		.coach-week-optional li{
			width: auto;
			margin: 0 5px 0 0;
			padding: 5px;
			border-radius: 10px 10px 0 0;
			float: left;
			text-align: center;
			cursor: pointer;
			background-color: rgb(168,180,200);
		}
		.coach-week-optional li:hover{
			background-color: rgb(71,161,206);
		}
		.coach-week-selected{
			background-color:  rgb(71,161,206) !important;
		}
		
		
		.coach-time-optional{
			height: auto;
		}
		.coach-time-optional ul{
			list-style: none;
		}
		.coach-time-optional li{
			background-color:  rgb(71,161,206);
			cursor: pointer;
			line-height: 20px;
			text-align:left;
			width:95%;
			padding: 5px 0px 5px 20px;
			margin: 5px 0px 5px 0;
		}
		.coach-time-optional li span{
			font-size:16px;
			width:200px;
		}
		.coach-time-optional li b{
			font-size:16px;
			color:#f00;
			width:100px;
		}
		.coach-time-optional li:hover{
			background-color: rgb(79,202,101);
		}
		.coach-time-selected{
			background-color:rgb(79,202,101)  !important;
		}
		.coach-time-noselecet{
			background-color: rgb(200,200,200) !important;
		}
		.coach-list{
			float: left; width: 250px; 
			padding: 5px 20px;
			margin: 5px; 
			border: 1px solid #6495ED;
		}
		.coach-list{
		float:left;
		}
		.coach-list b{
			color:#f00;
			padding-left:20px;
		}
		service{
		}
		.contpric{color:#F00; font-size:18px; font-weight:600}
		.divcoachplace{
			font-size:12px;
			padding:5px 10px;
			margin-top:5px;
			margin-left:100px;
			border-radius:10px;
			color:#000;
			height:18px;
			background-color:rgb(135,206,255);
		}
		.activityaddress ul{
			list-style:none;
		}
		
		.activityaddress li{
			float:left;
		}
		.select-producttype{
		width:100%;
		margin:5px 20px ;
		}
		.select-producttype span{
			float:left;
			margin:5px;
			padding:5px;
			border-radius:5px;
			border:1px solid rgb(71,161,206);
			cursor:pointer;
		}
		.select-producttype input[type="radio"]{
			vertical-align: middle;
			height:auto;
			margin-right:5px;
		}
		.prodcut-type-p{
		text-align:left;
		font-size:16px;
		line-height:20px;
		padding:5px;
		}
		.coach-time-unable{
			background-color:rgb(180,180,180)  !important;
		}
	</style>
	<style>
.tagContent {
	HEIGHT: auto !important;
}
/* Anonymous ------------------------- */
.fieldset .pic-box-span {
	display:-moz-inline-box; 
    display:inline-block;
    width:140px;
    height:38px;
    margin-left:2px;
}
.fieldset .pic-box-span img{
    width:140px;
    height:38px;
    vertical-align:center;
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
	width: 400px;
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
	height:280px;
}
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
<div><iframe src="header" width="100%" height="190px" frameborder="0" scrolling="no"></iframe></div>
<div class="mainbody">

<div class="sport_body">
	<div class="sportselect_info">
    	<div class="sportselect_banner">
	    	<!-- Anonymous  轮播图   -->
			<div class="ck-slide">
				<ul class="ck-slide-wrapper">
					<s:iterator value='coach.photoes' status="status">
						<li>
							<a href="javascript:void(0)"><img src=".<s:property value='pathName'/>" alt=""></a>
						</li>
					</s:iterator>
				</ul>
				<a href="javascript:" class="ctrl-slide ck-prev">上一张</a> <a href="javascript:" class="ctrl-slide ck-next">下一张</a>
			</div>
		    <!-- Anonymous  轮播图   --> 
       <%-- <DIV id=focus_img style="background-color:#F1F1F1">
        <TABLE id=focus_warp cellSpacing=0 cellPadding=0 width=400 border=0>
          <TBODY>
          <TR>
            <TD>
              <div id=au style="WIDTH: 400px">
					<div class=dis name="f">
						<img height=225 alt=01 width=400
									src=".<s:property value='coach.photoes[0].pathName'/>"
													>
					</div>
					<s:iterator value='coach.photoes' begin='1'
												status="status">
						<s:if test="#status.index<3">
							<div class=undis name="f">
								<img height=225 alt=01	src=".<s:property value='pathName'/>" width=400>
							</div>
						</s:if>
					</s:iterator>
			</div>
             </TD>
          </TR>
          <TR>
            <TD height=75>
              <TABLE id=simg cellSpacing=0 cellPadding=0 width=326 border=0>
                <TBODY><TR>
                 <s:iterator value='coach.photoes' status="status">
					<s:if test="#status.index<3">
						<td style="width:110px;padding:0 5px" class=s onmouseover="play(this,'au','');" align=right>
								<img height=56 src=".<s:property value='pathName'/>" width=120 ></td>
					</s:if>
				</s:iterator>
                    <td width="77"></td>
                </TR></TBODY>
                </TABLE>
              </TD>
          </TR>
         </TBODY></TABLE>
        </DIV>  --%>
        </div>
        <div class="sportselect_detail">
        	<strong><s:property value='coach.realName'/></strong>
        	<div style="width:450px; background-color:#87CEFF; height:5px;" align="left"> 
            </div>
              <br />     
            <p><span>联系电话：</span><s:property value='coach.phone'/></p>
            <p><span>预定价格：</span><s:property value='coach.basePrice'/>元起</p>
            <p><span>项目类型：</span><s:property value='coach.skillType.typeName'/></p>
            <p><span>活动地点：</span></p>
            <div class="activityaddress"><ul><li >            
	            	<s:iterator value="coach.addrs"> 
	            		<div class="divcoachplace">
	            			<s:property value='parentAddress.addressName'/>><s:property value='addressName'/>452
	            		</div>
	            	</s:iterator>            
           	</li></ul></div>
        </div>
	</div>
    <div class="select-producttype">
    	<a href="orderCoach?coach.id=<s:property value='coach.id'/>">
    		<label for="ids<s:property value='id'/>">
    			<span>
    			<s:if test="coachProduct==null">
    				<input type="radio" name="producttype" checked="checked" id="ids1" />
    			</s:if>
    			<s:else>
    				<input type="radio" name="producttype" id="ids1" />
    			</s:else>
    				教练自行安排
    			</span>
    		</label>
    	</a>
    	<s:iterator value='coach.coachProducts'>
    		<a href="orderCoach?coach.id=<s:property value='coach.id'/>&coachProduct.id=<s:property value='id'/>">
    		<label for="ids<s:property value='id'/>">
    			<span>
    			<s:if test="coachProduct.id==id">
    				<input type="radio" name="producttype" checked="checked" id="ids1" />
    			</s:if>
    			<s:else>
    				<input type="radio" name="producttype" id="ids1" />
    			</s:else>
    				<s:property value="productName"/>
    			</span>
    		</label>
    		</a>
    	</s:iterator>
   		<!-- <label for="ids1"><span><input type="radio" name="producttype" id="ids1" />羽毛球陪练</span></label> -->
   		
    </div>
    <div style="clear:both"></div>
    <div class="select_day">   
      		<div style="width:600px; margin:5px  auto;margin-right:5px;float:left;">
			<div  class="coach-week-optional">
				<ul>
					<!-- <li class="week1  coach-week-selected">周一</li> -->
					<s:iterator value="dates" var="date" begin="0" status="status">
						<s:if test="coach.weekJobTimes[weekIndexArr[#status.index]]==1">
							<s:if test="#status.index==0">
								<li class="week<s:property value='#status.index+1'/>  coach-week-selected"> 
									<s:date name="#date" format="MM.dd/" /> <s:property value="weeks[#status.index]" /> 
								</li>
							</s:if>
							<s:else>
								<li class="week<s:property value='#status.index+1'/>"> 
									<s:date name="#date" format="MM.dd/" /> <s:property value="weeks[#status.index]" /> 
								</li>
							</s:else>
						</s:if>	
						<s:else>
							<li class="week<s:property value='#status.index+1'/>" style="background:rgb(53,53,53);"> 
									<s:date name="#date" format="MM.dd/" /> <s:property value="weeks[#status.index]" /> 
							</li>
						</s:else>					
					</s:iterator>
				</ul>
			</div>
			<div class="clearfix"></div>
			<s:iterator value="coachPreOrderInfos" status="status">
				<s:if test="coach.weekJobTimes[weekIndexArr[#status.index]]==1">
					<s:if test="#status.index==0">
						<div class="coach-time-optional" 
							pOrderId="<s:property value='order.id'/>"
							coachId="<s:property value='coach.id'/>"
							productId="<s:property value='coachProduct.id'/>"						
							id="week<s:property value='#status.index+1'/>">
					</s:if>
					<s:else>
						<div class="coach-time-optional displaycss" 
							pOrderId="<s:property value='order.id'/>"
							productId="<s:property value='coachProduct.id'/>"
							coachId="<s:property value='coach.id'/>"
							id="week<s:property value='#status.index+1'/>">
					</s:else>				
					<ul>
						<s:if test="order.orderInfos[0]>0&&(coach.dayJobTimeArr[0]==1)">
							<li timeId="0" >
						</s:if>
						<s:else>
							<li class="coach-time-unable">
						</s:else>					
							<span>上午&emsp; 09：00--12：00</span>&emsp;&emsp;					
							
							<s:if test="coachProduct!=null">
								<service><s:property value='coachProduct.productName'/></service>&emsp;&emsp;
								<b><s:property value="costInfo.prices[0]"/></b>元
							</s:if>
							<s:else>
								<service>教练自行安排</service>&emsp;&emsp;
								<b><s:property value="coach.baseCostPrices[0]"/></b>元
							</s:else>						
						</li>
						
						<s:if test="order.orderInfos[1]>0&&(coach.dayJobTimeArr[1]==1)">
							<li timeId="1">
						</s:if>
						<s:else>
							<li class="coach-time-unable">
						</s:else>
							<span>下午&emsp; 14：00--17：00</span>&emsp;&emsp;
							
							<s:if test="coachProduct!=null">
								<service><s:property value='coachProduct.productName'/></service>&emsp;&emsp;
								<b><s:property value="costInfo.prices[1]"/></b>元
							</s:if>
							<s:else>
								<service>教练自行安排</service>&emsp;&emsp;
								<b><s:property value="coach.baseCostPrices[1]"/></b>元
							</s:else>
						</li>
						
						<s:if test="order.orderInfos[2]>0&&(coach.dayJobTimeArr[2]==1)">
							<li timeId="2">
						</s:if>
						<s:else>
							<li class="coach-time-unable">
						</s:else>
							<span>晚上&emsp; 18：00--21：00</span>&emsp;&emsp;
						
							<s:if test="coachProduct!=null">
								<service><s:property value='coachProduct.productName'/></service>&emsp;&emsp;
								<b><s:property value="costInfo.prices[0]"/></b>元
							</s:if>
							<s:else>
								<service>教练自行安排</service>&emsp;&emsp;
								<b><s:property value="coach.baseCostPrices[2]"/></b>元
							</s:else>
						</li>
						
						<s:if test="order.orderInfos[0]>0&&(order.orderInfos[1]>0)&&(order.orderInfos[2]>0)&&(coach.dayJobTimeArr[0]==1)&&(coach.dayJobTimeArr[1]==1)&&(coach.dayJobTimeArr[2]==1)">
							<li class="allday" timeId="3">
						</s:if>
						<s:else>
							<li class="coach-time-unable">
						</s:else>
						
							<span>全天&emsp; 09：00--21：00</span>&emsp;&emsp;
							
							<s:if test="coachProduct!=null">
								<service><s:property value='coachProduct.productName'/></service>&emsp;&emsp;
								<b><s:property value="costInfo.prices[3]"/></b>元
							</s:if>
							<s:else>
								<service>教练自行安排</service>&emsp;&emsp;
								<b><s:property value="coach.baseCostPrices[3]"/></b>元
							</s:else>
						</li>
					</ul>
				</div>
			</s:if>
			<s:else>
					<s:if test="#status.index==0">
						<div  style="margin:30px;"  class="coach-time-optional" 
							pOrderId="<s:property value='order.id'/>"
							coachId="<s:property value='coach.id'/>"
							productId="<s:property value='coachProduct.id'/>"						
							id="week<s:property value='#status.index+1'/>">
					</s:if>
					<s:else>
						<div style="margin:30px;" class="coach-time-optional displaycss" 
							pOrderId="<s:property value='order.id'/>"
							productId="<s:property value='coachProduct.id'/>"
							coachId="<s:property value='coach.id'/>"
							id="week<s:property value='#status.index+1'/>">
					</s:else>
						该教练今天不营业哦！
				</div>
			</s:else>
			</s:iterator>
			<!-- <div class="coach-time-optional displaycss" id="week1">
				<ul>
					<li class="coach-time-unable">
						<span>上午&emsp; 08：00--12：00</span>&emsp;&emsp;
						<service>羽毛球陪练</service>&emsp;&emsp;
						<b>25.00</b>元
					</li>
					<li>
						<span>下午&emsp; 08：00--12：00</span>&emsp;&emsp;
						<service>羽毛球陪练</service>&emsp;&emsp;
						<b>25.00</b>元
					</li>
					<li>
						<span>晚上&emsp; 08：00--12：00</span>&emsp;&emsp;
						<service>羽毛球陪练</service>&emsp;&emsp;
						<b>25.00</b>元
					</li>
					<li class="allday">
						<span>全天&emsp; 08：00--12：00</span>&emsp;&emsp;
						<service>羽毛球陪练</service>&emsp;&emsp;
						<b>70.00</b>元
					</li>
				</ul>
			</div> -->
			<!--
 *****************
            -->          
			</div>
		<div style="float:left;width:300px; margin-top:10px;">
		 <div class="coach-time">
		 	<s:iterator value="currentOrder.items"> 
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
		 </div> 
		
		<p class="prodcut-type-p" id="hermite"> </p>
		<hr />
		<div class="clearfix"></div>
		
		<center>
		<strong style="margin:auto;">共<b class="contpric"> 0 </b>元&emsp;&emsp;
			<a href="orderandsubmitOrder" class="abutton"> 立即预定 </a>&emsp;&emsp;
			<a href="javascript:void(0);" id="deletecurrentOrder"  class="abutton"> 重置 </a></strong>
		</center>
		   </div>
    </div>
   				<div style="clear:both;"></div>
				<div style="width:900px; margin-right:10px; border: #Fff 2px solid;">
					<div class="uldiv">
						<ul class="titul">
							<li class="tipsli" id="details">教练详情</li>
							<li class="hiddenli">
								<div>
									<p>
										<s:property escapeHtml="false" value='coach.detail' />
									</p>
								</div>
							</li>
							<li class="tipsli" id="comments">教练评论</li>
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
										</span> <span class="commentright">
											<ul class="star">												
												<s:iterator begin="1" end="score" var="i">
													<li class="light"><a href="javascript:;"><s:property value='i'/></a></li>
												</s:iterator>
												<s:iterator begin="score" end="4" var="i">
													<li><a href="javascript:;"><s:property value='i'/></a></li>
												</s:iterator>
											</ul>
											<hr />
											<p style="margin-left:30px;"><s:property value='detail'/></p>
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
<div style="clear:both; height:20px;"></div>
<div class="mainbody"><iframe src="footer.jsp" width="100%" height="200px" frameborder="0" scrolling="no"></iframe>
</div>
<!-- 弹出登录开始  -->
<!-- 	<div class="cd-user-modal" > 
		<div class="cd-user-modal-container">
			<ul class="cd-switcher">
				<li><a style="color:red;background:rgb(222,222,222);" href="#0">用户登录</a></li>
				<li><a href="#0">快速注册</a></li>
			</ul>

			<div id="cd-login" style="border:1px solid #ddd;"> 
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

			<div id="cd-signup" style="border:1px solid #ddd;"> 
				<div class="div-phone">
					<form class="cd-form">
					<p class="fieldset">
						<span class="lb-show">　手机号码：</span>
						<input class="full-width has-padding has-border phonenumber" name="userName1" id="signup-username" type="text" placeholder="请输入手机号码">
					</p>
					<p class="fieldset">
						<span class="lb-show">　　密　码：</span>
						<input class="full-width has-padding has-border" name="password1" id="signin-password" type="password"  placeholder="请输入密码">
					</p>
				 <p class="fieldset">
						<span class="lb-show">图形验证码：</span>
						<input class="full-width3 has-padding has-border" name="confirmImgCode" id="signin-password" type="text"  placeholder="请输入右方验证码">
						<span class="pic-box-span"><img alt="" id="confirmImg" src="res/images/banner1.png"  confirmImgCode=""  align="absmiddle" /> </span>
					
					</p>
					 
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
	</div> -->
	<!-- 弹出登录结束  --> 
</body>
</html>
