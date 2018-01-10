<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>运动场馆</title>
  <script src="js/jquery.min.js"></script>
  <script type="text/javascript" src="res/js/slider.js"></script> 
  <link href="res/commonComponents/resizeTable/css/table.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript" src="res/js/jquery-1.8.3.min.js"></script>
  <link href="res/css/zsport.css" rel="stylesheet" type="text/css" >
	<link href="res/css/base.css" rel="stylesheet" type="text/css">
	<link href="res/css/index.css" rel="stylesheet" type="text/css">
<!--end -->

  <style>

</style>
</head>

<body>
<div class="mainbody" >
	<div class="sport_body" style="width:700px !important;">
    <div class="uldiv">
    	<ul class="titul" >
            <li class="tipsli" id="details">场馆详情</li>
				<li class="hiddenli">
					<div>
                   <p>描述描述描述描述描述描述描述描述描述 
                   <img src="res/images/img1.jpg" width="900" height="424" />
                   <br />述描述描述描<br />述 
                   <img src="res/images/img3.jpg" width="900" height="424" />
                   </p>
                    </div>
                </li>
            <li class="tipsli" id="comments">场馆评论</li>
            	<li class="hiddenli">
                    <UL class="commentsummary">
                        <LI>综合评价</LI>
                        <LI><ul class="star">
                                <li class="light"><a href="javascript:;">1</a></li>
                                <li class="light"><a href="javascript:;">2</a></li>
                                <li class="light"><a href="javascript:;">3</a></li>
                                <li class="ahalflight"><a href="javascript:;">4</a></li>
                                <li><a href="javascript:;">5</a></li>
                            </ul>
                        </LI>
                        <li style="float:right;">
                        <SPAN><I>1</I>/8</SPAN> 
                        <A class="fany" href="#">&gt;</A> 
                        </LI>
                        <li style="float:right;">
                        	共123条 &emsp;
                        </li>
                    </ul>
   
					<div class="commentcell" >
                    	<span class="commentleft">
                        	<img src="res/images/person.jpg" width="60" height="60"/>
                            <b>用户名</b>
                        </span>
                        <span class="commentright">
                            <ul class="star">
                                <li class="light"><a href="javascript:;">1</a></li>
                                <li class="light"><a href="javascript:;">2</a></li>
                                <li class="light"><a href="javascript:;">3</a></li>
                                <li><a href="javascript:;">4</a></li>
                                <li><a href="javascript:;">5</a></li>
                            </ul>
                        	<hr />
                            <p>有点露胶，不过可以接受，鞋面上有一点白点扣不掉，在侧面可以接受，唯一就是…鞋子太臭了，味道很大，橡胶鞋底摸起来怪怪的，送来后跟贴，不过没什么卵用，毕竟硬，会打脚，看看回家穿袜子怎么样
                            有点露胶，不过可以接受，鞋面上有一点白点扣不掉，在侧面可以接受，唯一就是…鞋子太臭了，味道很大，橡胶鞋底摸起来怪怪的，送来后跟贴，不过没什么卵用，毕竟硬，会打脚，看看回家穿袜子怎么样</p>
                            <p style="text-align:right !important;"><a href="#">举报</a></p>
                        </span>
                    </div>
                    <div class="commentcell" >
                    	<span class="commentleft">
                        	<img src="res/images/person.jpg" width="60" height="60"/>
                            <b> yonghuming</b>
                        </span>
                        <span class="commentright">
                            <ul class="star">
                                <li class="light"><a href="javascript:;">1</a></li>
                                <li class="light"><a href="javascript:;">2</a></li>
                                <li class="light"><a href="javascript:;">3</a></li>
                                <li><a href="javascript:;">4</a></li>
                                <li><a href="javascript:;">5</a></li>
                            </ul>
                        	<hr />
                            <p>有点露胶，不过可以接受，鞋面上有一点白点扣不掉，在侧面可以接受，唯一就是…鞋子太臭了，味道很大，橡胶鞋底摸起来怪怪的，送来后跟贴，不过没什么卵用，毕竟硬，会打脚，看看回家穿袜子怎么样
                            有点露胶，不过可以接受，鞋面上有一点白点扣不掉，在侧面可以接受，唯一就是…鞋子太臭了，味道很大，橡胶鞋底摸起来怪怪的，送来后跟贴，不过没什么卵用，毕竟硬，会打脚，看看回家穿袜子怎么样</p>
                            <p style="text-align:right !important;"><a href="#">举报</a></p>
                        </span>
                    </div>
                    <div class="commentcell" >
                    	<span class="commentleft">
                        	<img src="res/images/person.jpg" width="60" height="60"/>
                            <b>userName</b>
                        </span>
                        <span class="commentright">
                            <ul class="star">
                                <li class="light"><a href="javascript:;">1</a></li>
                                <li class="light"><a href="javascript:;">2</a></li>
                                <li class="light"><a href="javascript:;">3</a></li>
                                <li><a href="javascript:;">4</a></li>
                                <li><a href="javascript:;">5</a></li>
                            </ul>
                        	<hr />
                            <p>有点露胶，不过可以接受，鞋面上有一点白点扣不掉，在侧面可以接受，唯一就是…鞋子太臭了，味道很大，橡胶鞋底摸起来怪怪的，送来后跟贴，不过没什么卵用，毕竟硬，会打脚，看看回家穿袜子怎么样
                            有点露胶，不过可以接受，鞋面上有一点白点扣不掉，在侧面可以接受，唯一就是…鞋子太臭了，味道很大，橡胶鞋底摸起来怪怪的，送来后跟贴，不过没什么卵用，毕竟硬，会打脚，看看回家穿袜子怎么样</p>
                            <p style="text-align:right !important;"><a href="#">举报</a></p>
                        </span>
                    </div>
                    <div style="text-align:center; padding:0;">
                   <div class="pagination">
			<ul>
				<li><input id="chooseAllBtn" type="button" value="选择所有"
					onclick="checkedAll();"></li>
				<li><input type="button" onclick="deleteBatch();" value="删除选中"></li>
				<!-- 如果当前页是第一页 -->
				<s:if test="page.pageNumber<=1">
					<li class="disablepage">首页</li>
					<li class="disablepage">上一页</li>
				</s:if>
				<!-- 否则 -->
				<s:else>
					<li><a href="useranduserList?page.pageNumber=1">首页</a>
					</li>
					<li><a
						href="useranduserList?page.pageNumber=<s:property value='page.pageNumber-1'/>">上一页</a>
					</li>
				</s:else>
				<!-- 如果总页码小于7页，就显示全部页码 -->
				<s:if test="page.totalPageNumber<=7">
					<s:iterator begin="1" var="i" end="page.totalPageNumber">
						<s:if test="#i==page.pageNumber">
							<li class="currentpage">
										<s:property /> 
								</li>
						</s:if>
						<s:else>
							<li><a
								href="useranduserList?page.pageNumber=<s:property/>">
									<s:property /> </a></li>
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
								<li class="currentpage">
										<s:property /> 
								</li>
							</s:if>
							<s:else>
								<li><a
									href="useranduserList?page.pageNumber=<s:property/>">
										<s:property /> </a></li>
							</s:else>
						</s:iterator>
						<li>...</li>
					</s:if>
					<s:elseif test="page.pageNumber<=4">
						<s:iterator begin="1" var="i" end="7">
							<s:if test="page.pageNumber==#i">
								<li class="currentpage">
										<s:property /> 
								</li>
							</s:if>
							<s:else>
								<li><a
									href="useranduserList?page.pageNumber=<s:property/>">
										<s:property /> </a></li>
							</s:else>
						</s:iterator>
						<li>...</li>
					</s:elseif>
					<s:elseif test="page.pageNumber+4>=page.totalPageNumber">
						<li>...</li>
						<s:iterator begin="page.pageNumber-3" var="i"
							end="page.totalPageNumber">
							<s:if test="page.pageNumber==#i">
								<li class="currentpage">
										<s:property /> 
								</li>
							</s:if>
							<s:else>
								<li><a
									href="useranduserList?page.pageNumber=<s:property/>">
										<s:property /> </a></li>
							</s:else>
						</s:iterator>
					</s:elseif>
				</s:else>
				<!-- 如果当前页是最后一页 -->
				<s:if test="page.pageNumber==page.totalPageNumber">
					<li class="disablepage">下一页</li>
					<li class="disablepage">尾页</li>
				</s:if>
				<!-- 否则 -->
				<s:else>
					<li class="nextpage"><a
						href="useranduserList?page.pageNumber=<s:property value='page.pageNumber+1'/>">下一页</a>
					</li>
					<li class="nextpage"><a
						href="useranduserList?page.pageNumber=<s:property value='page.totalPageNumber'/>">尾页</a>
					</li>
				</s:else>
			</ul>
		</div>
		</div>
                </li>
   		</ul>
    </div>
    
    </div>
</div>
</body>
<script>
$(document).ready(function(e) {
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
</html>


