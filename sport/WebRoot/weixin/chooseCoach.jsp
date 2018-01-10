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
        <link rel="stylesheet" type="text/css" href="weixin/res/css/sportBook.css"  />
        <link rel="stylesheet" type="text/css" href="weixin/res/css/address.css" />
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
.slides li img {
	max-height:170px;
	min-height:170px;
}

</style>

		<script type="text/javascript" src="weixin/res/js/jquery.flexslider-min.js">
		</script>
		<script type="text/javascript">
			$(document).ready(function() {

				$('.myflexslider').flexslider({
					controlNav: true,
					directionNav: false,
					animation: "slide",
					//manualControls: ".myflexslider .slidenav"
				});

			});
		</script>  

<script>
	$(document).ready(function(){
		$(".areaSelect").bind("click",function(){
			$(".overlayer").fadeIn(300);
			$(".overback").fadeIn(300);
		});
		
		$(".firstaddress li").bind("click",function(){
			if($(this).find("span").html() == "↓")
			{	
				$(this).find("span").html("↑");
				$(this).find("ul").slideDown(300);
			}
			else if($(this).find("span").html() == "↑")
			{	
				$(this).find("span").html("↓");
				$(this).find("ul").slideUp(300);
			}
		});
		
		$(".secondaddress li").click(function(){
			$(".overlayer").fadeOut(300);
			$(".overback").fadeOut(300);
		});
		
		$(".overback").click(function(){
			$(".overlayer").fadeOut(300);
			$(".overback").fadeOut(300);
		});
	});	
</script>
<style>
.areaSelect {
	position:absolute;
	left:10px;
	top:0px;
	height:40px;
	overflow: hidden;
	text-align:center;
	background:#3cf;
	line-height:40px;
	color:#fff;
	font-size:14px;
}
.overlayer {
	position:absolute;
	width:90%;
	margin-left:5%;
	z-index:9;
	display:none;
}
.overback {
	z-index: 8;
	position:fixed;
	top:0;
	left:0;
	width:100%;
	height:100%;
	background:#000;
	opacity:0.4;
	filter:alpha(opacity=40);   
	display:none;
}
</style>
    
    </head>
    
    <body>
        <s:url var="searchUrl" value="weixin/weixinandchooseCoach?condition.searchType=place" includeParams="none">
	
		</s:url>
       <div class="overback">
		</div> 
        <!--页眉开始-->
        <div id="header">
			
             <!-- top banner -->
            <div class="topbanner" style="position:relative;">
	            <div  class="areaSelect">
		               <s:property value='#session.currentCondition.cityAddress.addressName'/>&nbsp;&nbsp;
		               <s:property value='#session.currentCondition.address.addressName'  default="选择地区"/>
		        </div>
                <div class="topbannerWord" style="z-index:1;">    
                   	<b>我要预订</b> 
                </div>
                <div class="clear"></div>
            </div>
            <!-- top banner -->   

			<div class="overlayer">
				<div class="topbannerWord">    
                   	 选择地点&nbsp;
                   	 
                </div>
				<ul class="firstaddress">
					<li>
						 <s:a class="selected" href="%{searchUrl}&condition.searchFlag=complex&condition.address.id=0" 
		                            	 	addrId="<s:property value='id'/>">
		                            	 	整个"<s:property value='#session.currentCondition.cityAddress.addressName'/>"内
		                            	 	</s:a>
					</li>
					<s:iterator value="cityAddrs">
						<li>
							<s:property value='addressName'/>
							<span style="display:none">↓</span>
							<ul class="secondaddress">
								<s:iterator value='childrenAddress'>
									<s:a class="selected" href="%{searchUrl}&condition.searchFlag=complex&condition.address.id=%{id}" 
		                            	 	addrId="<s:property value='id'/>">
										<li  addressId="<s:property value='id'/>"><s:property value='addressName'/></li>
									</s:a>								
								</s:iterator>
								<div class="clearfix"></div>
							</ul>
						</li>
					</s:iterator>					
				</ul>
			</div>
			
            <!--幻灯片 开始-->
                   

            <div class="myflexslider" style="margin-top:1px;">
                <ul class="slides">
                   <s:iterator value="discounts" status="st">
                		<s:if test="#st.index<5">
	                		<li>
		                       <a href="weixin/discountanddiscountDetail?discount.id=<s:property value='id'/>">
		                     		<img src=".<s:property value='preViewImg.pathName'/>" width="100%" />
		                    	</a>
		                    </li>
	                    </s:if>
                	</s:iterator>  
                </ul>
            </div>
            <!--幻灯片 结束-->
        </div>
        <div id="content">
             <!--导航开始-->
            <ul class="channellist">
            	<s:iterator value="types">
            			<li>
                            <s:if test="#session.currentCondition.type.id==id">
	                            <s:a class="selected" href="%{searchUrl}&condition.searchFlag=complex&condition.type.id=%{id}"
	                            	 typeId="<s:property value='id'/>">
	                          	<div class="ChannelIcon">
					                    <img src=".<s:property value='image.pathName'/>" />
					                 </div>
					                 <div class="ChannelName">
					               		      <s:property value="typeName"/>
					                 </div>
	                            </s:a> 
                            </s:if>
                            <s:else>
                            	<s:a href="%{searchUrl}&condition.searchFlag=complex&condition.type.id=%{id}"
	                            		  typeId="<s:property value='id'/>">
	                            	<div class="ChannelIcon">
						                 <img src=".<s:property value='image.pathName'/>" />
						            </div>
						            <div class="ChannelName">
						                 <s:property value="typeName"/>
						            </div>
	                           </s:a> 
                           </s:else>
                  </s:iterator>
                </li>
                   
              
            </ul>
            <!--导航结束-->
            <div class="clear">
            </div>

            <div>
                <div class="hotPic">
                </div>
                <div class="hotSportHall">
                  热门教练
                </div>
            </div>

            <div>
            	
                <ul class="productList">
                <s:iterator value="coachs">
                    <li>
                        <a href="weixin/weixinandchooseDayCoach?coach.id=<s:property value='id'/>">
                            <img src=".<s:property value='photoes[0].pathName'/>" />
                            <p class="productTitle"><s:property value='realName'/></p>
                            <p class="productTitle">擅长项目：<s:property value="skillType.typeName"/></p>
                            <p class="productPrice">&yen;<s:property value='basePrice'/></p>
                            <span class="book">预定</span>
                        </a>
                    </li>
                </s:iterator>
                </ul>
            </div>
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

    </body>

</html>