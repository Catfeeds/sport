<%@ page language="java"  contentType="text/html; charset=UTF-8" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
basePath+="forum/";
%>

<!DOCTYPE html>
<!-- made by danyuan -->
<html >
<head>
	<base href="<%=basePath%>">
	<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
	<title>享动社区论坛</title>
	<link rel="stylesheet" href="res/css/forum.css" type="text/css" media="all" />
	<link rel="stylesheet" href="res/commonComponents/imgChange/css/owl.carousel.css" />
	<link href="res/commonComponents/toTop/css/zzsc.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="res/commonComponents/progressBar/css/css.css" />
	<script type="text/javascript" src="res/commonComponents/imgChange/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="res/commonComponents/imgChange/js/owl.carousel.js"></script>
	<!-- 引入图片预览 -->
	<script type="text/javascript" src="res/js/upload.js"></script>
	<script type="text/javascript">
	$(function(){
		$('#owl-demo').owlCarousel({
			items: 1,
			navigation: true,
			navigationText: ["上一个","下一个"],
			autoPlay: true,
			stopOnHover: true
		}).hover(function(){
			$('.owl-buttons').show();
		}, function(){
			$('.owl-buttons').hide();
		});
		//进度条
		$(".experience").each(function(i,item){
			var a=parseInt($(item).attr("w"));
			$(item).animate({
				width: a+"%"
			},1000);
		});
		//返回顶部
		$(window).on('scroll',function(){
			var st = $(document).scrollTop();
			if( st>0 ){
				if( $('#main-container').length != 0  ){
					var w = $(window).width(),mw = $('#main-container').width();
					if( (w-mw)/2 > 70 )
						$('#go-top').css({'left':(w-mw)/2+mw+20});
					else{
						$('#go-top').css({'left':'auto'});
					}
				}
				$('#go-top').fadeIn(function(){
					$(this).removeClass('dn');
				});
			}else{
				$('#go-top').fadeOut(function(){
					$(this).addClass('dn');
				});
			}	
		});
		$('#go-top .go').on('click',function(){
			$('html,body').animate({'scrollTop':0},500);
		});

		$('#go-top .uc-2vm').hover(function(){
			$('#go-top .uc-2vm-pop').removeClass('dn');
		},function(){
			$('#go-top .uc-2vm-pop').addClass('dn');
		});
	});
	</script>

</head>
<body>
<s:url var="searchUrl" value="articleandtypeForum" includeParams="none">
	<s:param name="page.pageSize" value="page.pageSize"></s:param>
	<s:param name="forum.id" value="forum.id"></s:param>
</s:url>
<!-- Header -->
<div id="header">
	<div class="shell">
		<!-- Logo + Top Nav -->
		<div id="top">
			<h1><a href="../index">享动</a></h1>
			<div id="top-navigation">
				<s:if test="person!=null">
					<s:if test="#session.currentUser!=null">
					欢迎您：<a href="../useranduserHome"><s:property value='person.realName'/></a>
					</s:if>
					<s:elseif test="#session.currentManager!=null">
						欢迎管理员：<a href="../admin/index.jsp"><s:property value='person.realName'/></a>
					</s:elseif>
					<s:elseif test="#session.currentCoach!=null">
						欢迎教练：<a href="../admin/index.jsp"><s:property value='person.realName'/></a>
					</s:elseif>					
					<span>&nbsp;&nbsp;|</span>
				</s:if>
				<s:else>
						欢迎您，游客<span>&nbsp;&nbsp;|</span>
				</s:else>
				<a href="articleandforumIndex">社区首页</a>
				<span>|</span>
				<a href="../index">享动</a>
			</div>
		</div>
		<!-- End Logo + Top Nav -->
		
		<!-- Main Nav -->
		<div id="navigation">
			<ul>
			    <li><a href="javascript:void(0);" class="active"><span>
			  		<s:property value='forum.forumName'/>社区
			  	</span></a></li>			    
			</ul>
		</div>
		<!-- End Main Nav -->
	</div>
</div>
<!-- End Header -->
<!--返回顶部-->
<div class="go-top dn" id="go-top">
    <a href="javascript:void(0);" class="uc-2vm"></a>
	<div class="uc-2vm-pop dn">
		<h2 class="title-2wm">用微信扫一扫</h2>
		<div class="logo-2wm-box">
			<img src="res/images/weixin.jpg" alt="享动" width="240" height="240">
		</div>
	</div>
	<!-- 
    <a href="javascript:void(0);" target="_blank" class="feedback"></a>
     -->
    <a href="javascript:void(0);" class="go"></a>
</div>

<!-- Container -->
<div id="container">
	<div class="shell">
		
		<!-- Small Nav -->
		<div class="small-nav">
			<a href="articleandforumIndex">享动论坛</a>
			<span>&gt;</span>
			<s:property value='forum.forumName'/>社区动态
			<a href="javascript:void(0);"
				forumId="<s:property value='forum.id'/>"
			 class="careForum">关&nbsp;注</a>
		</div>
		<!-- End Small Nav -->
		<div class="picChange">
			<!-- Demo -->
			<div id="owl-demo" class="owl-carousel">
				<s:iterator value='events'>
				<s:if test="image!=null">
				<a class="item" href="javascript:void(0);">
					<img src="..<s:property value='image.pathName'/>" alt="">
					<b></b><span><s:property value='title'/></span>
				</a>
				</s:if>				
				</s:iterator>
			</div>
		</div>
		<!-- Main -->
		<div id="main">
			<div class="cl">&nbsp;</div>
			
			<!-- Content -->
			<div id="content">
				
				<!-- Box -->
				<div class="box">
					<!-- Box Head -->
					<div class="box-head">
						<h2 class="left">所有动态</h2>
						<form action="articleandsearchTypeForum" method="post">
						<div class="right">
							<label>搜索帖子</label>
							<input type="hidden" name="article.articleType" value="1"/>
							<input type="text" name="article.title" class="field small-field" />
							<input type="submit" class="button" value="搜索" />
						</div>
						</form>
					</div>
					<!-- End Box Head -->	

					<!-- Table -->
					<div class="table">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<th width="10%">回帖数</th>
								<th width="55%">标题</th>
								<th width="15%">发表时间</th>
								<th width="10%">发表用户</th>
								<th width="10%">操作</th>
							</tr>
							<s:iterator value="articles">
								<tr>
									<td><s:property value='childArticleNumber'/></td>
									<td><h3><a href="articleandarticleDetail?rootArticle.id=<s:property value='id'/>">
										<s:property value='title'/>
									</a></h3></td>
									<td><s:date name="date" format="yyyy-MM-dd hh:mm"/></td>
									<td><a href="javascript:void(0);"><s:property value='talker.realName'/></a></td>
									<td><a href="javascript:void(0);" class="supportBtn" 
											articleId="<s:property value='id'/>"
										>
										<img src="res/images/support.png"/>
										<span id="supportNumber<s:property value='id'/>"
											flag="true">
											<s:property value='supportNumber'/>
										</span>
										</a><br/>
										<shiro:hasPermission name="forum:*">
										<br/>
										<a href="javascript:void(0);"
											articleId="<s:property value='id'/>"
											baseUrl="articleandtypeForum?article.forum.id=<s:property value='forum.id'/>"
										 class="deleteBtn" >
											删贴
										</a>
										</shiro:hasPermission>
									</td>
									
								</tr>
								<s:if test="image!=null">
								<tr>
									<td></td>
									<td><h3><a href="articleandarticleDetail?rootArticle.id=<s:property value='id'/>">									
									<img src="..<s:property value='image.pathName'/>" class="previewImg"/>									
									</a></h3></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								</s:if>
							</s:iterator>
						</table>
						
						
						<!-- 公告贴分页开始 -->
						<s:if test="page.totalPageNumber>0">
							<div class="pagging">
							<div class="left">共<s:property value='page.totalPageNumber'/>页</div>
							<div class="right">
							<!-- 如果当前页是第一页 -->
							<s:if test="page.pageNumber<=1">
								<a href="javascript:void(0);" class="disablepage">首页</a>
								<a href="javascript:void(0);" class="disablepage">上一页</a>
							</s:if>
							<!-- 否则 -->
							<s:else>
								<s:a href="%{searchUrl}&page.pageNumber=1">首页</s:a>			
								<s:a
									href="%{searchUrl}&page.pageNumber=%{page.pageNumber-1}">上一页</s:a>
								
							</s:else>
							<!-- 如果总页码小于7页，就显示全部页码 -->
							<s:if test="page.totalPageNumber<=7">
								<s:iterator begin="1" var="i" end="page.totalPageNumber">
									<s:if test="#i==page.pageNumber">
										<a href="javascript:void(0);" class="currentpage"><s:property /></a>
									</s:if>
									<s:else>
										<s:a
											href="%{searchUrl}&page.pageNumber=%{i}">
												<s:property /> </s:a>
										
									</s:else>
								</s:iterator>
							</s:if>
							<!-- 否则中间的隐藏，值显示离当前页最近的7页 -->
							<s:else>
								<s:if
									test="page.pageNumber>4&&page.pageNumber<(page.totalPageNumber-4)">
									<a href="javascript:void(0);">...</a>
									<s:iterator begin="page.pageNumber-3" var="i"
										end="page.pageNumber+3">
										<s:if test="page.pageNumber==#i">
											<a  href="javascript:void(0);" class="currentpage"><s:property /></a>
										</s:if>
										<s:else>
											<s:a
												href="%{searchUrl}&page.pageNumber=%{i}">
													<s:property /> </s:a>
										</s:else>
									</s:iterator>
									<a href="javascript:void(0);">...</a>
								</s:if>
								<s:elseif test="page.pageNumber<=4">
									<s:iterator begin="1" var="i" end="7">
										<s:if test="page.pageNumber==#i">
											<a href="javascript:void(0);" class="currentpage"><s:property /></a>
										</s:if>
										<s:else>
											<s:a href="%{searchUrl}&page.pageNumber=%{i}">
													<s:property /> </s:a>											
										</s:else>
									</s:iterator>
									<a href="javascript:void(0);">...</a>
								</s:elseif>
								<s:elseif test="page.pageNumber+4>=page.totalPageNumber">
									<a href="javascript:void(0);">...</a>
									<s:iterator begin="page.pageNumber-3" var="i"
										end="page.totalPageNumber">
										<s:if test="page.pageNumber==#i">
											<a href="javascript:void(0);" class="currentpage"><s:property /></a>
										</s:if>
										<s:else>
											<s:a
												href="%{searchUrl}&page.pageNumber=%{i}">
													<s:property /> </s:a>											
										</s:else>
									</s:iterator>
								</s:elseif>
							</s:else>
							<!-- 如果当前页是最后一页 -->
							<s:if test="page.pageNumber==page.totalPageNumber">
								<a href="javascript:void(0);" class="disablepage">下一页</a>
								<a href="javascript:void(0);" class="disablepage">尾页</a>
							</s:if>			
							<s:else>
								<s:a
									href="%{searchUrl}&page.pageNumber=%{page.pageNumber+1}">下一页</s:a>
								<s:a
									href="%{searchUrl}&page.pageNumber=%{page.totalPageNumber}">尾页</s:a>								
							</s:else>
							</div>
						</div>
					</s:if>
					<!-- 公告贴分页结束 -->
						
					</div>
					<!-- Table -->
					
				</div>
				<!-- End Box -->
				
				<!-- Box -->
				<div class="box">
					<!-- Box Head -->
					<div class="box-head">
						<h2>我要发帖</h2>
					</div>
					<!-- End Box Head -->
					
					<form action="articleandaddArticle" method="post" enctype="multipart/form-data">
						<input type="hidden" name="article.forum.id"  value="<s:property value='forum.id'/>"/>
						<input type="hidden" name="forum.id"  value="<s:property value='forum.id'/>"/>
						<!-- Form -->
						<div class="form">
								<p>
									<span class="req">不超过30字</span>
									<label style="margin-bottom:10px;">帖子标题 <span>(必填项)</span>
										<s:if test="#session.currentManager!=null&&(#session.currentManager.company.host)">
										<span style="margin-left:10px;">帖子类型：
											<input type="radio" id="typeCommon" checked="checked" name="article.articleType" value="1">
											<label for="typeCommon" style="display:inline;">普通贴</label>
											&nbsp;&nbsp;
											<input type="radio" id="typeNotice" name="article.articleType" value="2">
											<label style="display:inline;" for="typeNotice">公告贴</label>
										</span>
										</s:if>
										<s:else>
											<input type="hidden"  name="article.articleType" value="1">
										</s:else>
									</label>
									<input type="text" name="article.title" class="field size1" />
								</p>	
															
								<p>
									<span class="req">不超过1000字</span>
									<label>详情 <span>(必填项)</span></label>
									<textarea class="field size1" name="article.content" rows="10" cols="30"></textarea>
								</p>	
							
						</div>
						<!-- End Form -->
						<!-- 上传图片 -->
						<span class="uploadTitle">上传图片：</span>
						<div class="chooseFileBtn">						
						<div id="preview">
							<img id="imghead" src="../res/images/banner1.png" />
						</div>
						<input type="file" accept="image/*" name="file" onchange="previewImage(this)" class="upload" id="file">
						<label for="file">
							 <svg xmlns="http://www.w3.org/2000/svg" width="15" height="12" viewBox="0 0 20 17">
								   <path d="M10 0l-5.2 4.9h3.3v5.1h3.8v-5.1h3.3l-5.2-4.9zm9.3 11.5l-3.2-2.1h-2l3.4 2.6h-3.5c-.1 0-.2.1-.2.1l-.8 2.3h-6l-.8-2.2c-.1-.1-.1-.2-.2-.2h-3.6l3.4-2.6h-2l-3.2 2.1c-.4.3-.7 1-.6 1.5l.6 3.1c.1.5.7.9 1.2.9h16.3c.6 0 1.1-.4 1.3-.9l.6-3.1c.1-.5-.2-1.2-.7-1.5z">
								   </path>
							 </svg> 
							<span>选择图片…</span>
						</label>
						</div>
						<!-- 上传图片结束 -->
						<!-- Form Buttons -->
						<div class="buttons">
							<!--<input type="button" class="button" value="预览" />-->
							<input type="submit" class="button" value="发帖" />
						</div>
						<!-- End Form Buttons -->
					</form>
				</div>
				<!-- End Box -->

			</div>
			<!-- End Content -->
			
			<!-- Sidebar -->
			<div id="sidebar">
				
				<!-- Box -->
				<div class="box">
					
					<!-- Box Head -->
					<div class="box-head">
						<h2>我在社区</h2>
					</div>
					<!-- End Box Head-->
					
					<div class="box-content">
						<div class="memberIntroWrap">
							<div class="memberIntro">
								<div class="headImgWrap">
									<s:if test="person!=null">
										<img src="..<s:property value='person.image.pathName'/>"/>
									</s:if>
									<s:else>
									<img src="res/images/youke.png"/>
									</s:else>
								</div>
								<div class="infoWrap">
									<div class="title">
										<img src="res/images/user.png"/>
										<s:if test="person!=null">
										<s:property value='person.realName'/>
										</s:if>
										<s:else>
											游客
										</s:else>
									</div>
									<s:if test="#session.currentUser!=null">
										<!-- 
										<div class="score">
											积分：<s:property value='#session.currentUser.integration'/>分
										</div>
										 -->
										<div class="score">
											<a class="signUp" href="javascript:void(0);">
												<s:if test="#session.currentUser.hasSign">
													已签
												</s:if>
												<s:else>
													签到
												</s:else>
											</a>
										</div>
									</s:if>
								</div>								
							</div>	
							<div style="clear:both;"></div>
							<div class="forumInfo">
								<s:if test="#session.currentUser!=null">
								<div class="experienceWrap">
									<!-- <div class="title">排名：<span>3212</span></div> -->
									<div class="innerExperienceWrap">
										<div class="title">经验：<span>
											<s:if test="#session.currentUser!=null">
												<s:if test="#session.currentUser.experience<100">
													<s:property value='#session.currentUser.experience'/>/100
												</s:if>
												<s:elseif test="#session.currentUser.experience>=100&&(#session.currentUser.experience<1000)">
													<s:property value='#session.currentUser.experience'/>/1000
												</s:elseif>
												<s:elseif test="#session.currentUser.experience>=1000&&(#session.currentUser.experience<10000)">
													<s:property value='#session.currentUser.experience'/>/10000
												</s:elseif>
												<s:else>
													老熟人了
												</s:else>
											</s:if>
										</span></div>
										<div class="votebox" >
											<dl class="barbox">
												<dd class="barline">
													
												<s:if test="#session.currentUser.experience<100">
													<div w="<s:property value='#session.currentUser.experience'/>" 
													style="width:0px;" class="experience"></div>
												</s:if>
												<s:elseif test="#session.currentUser.experience>=100&&(#session.currentUser.experience<1000)">
													<div w="<s:property value='#session.currentUser.experience/10'/>" 
													style="width:0px;" class="experience"></div>
												</s:elseif>
												<s:elseif test="#session.currentUser.experience>=1000&&(#session.currentUser.experience<10000)">
													<div w="<s:property value='#session.currentUser.experience/100'/>" 
													style="width:0px;" class="experience"></div>
												</s:elseif>
												<s:else>
													<div w="100" 
													style="width:0px;" class="experience"></div>
												</s:else>
												</dd>
											</dl>
										</div>
									</div>
								</div>
								</s:if>
							</div>
						</div>
					</div>
				</div>
				<!-- End Box -->
			</div>
			<!-- End Sidebar -->
			
			<div class="cl">&nbsp;</div>			
		</div>
		<!-- Main -->
	</div>
</div>
<!-- End Container -->

<!-- Footer -->
<div id="footer">
	<div class="shell">
		<span class="left">&copy; 2015 - 动起来</span>
	<!--  	<span class="right">
			设计方：<a href="#" title="#">湖南理工学院信息学院信工12-2BF(张俊)</a>
		</span> -->
	</div>
</div>
<!-- End Footer -->
<script type="text/javascript">
	$(function(){
		$(".deleteBtn").click(function(){
			if(!confirm("删除是不可恢复的，确定要删除？"))
				return;
			//删除帖子
			baseUrl=$(this).attr("baseUrl");
			var articleId=$(this).attr("articleId");
			$.post("articleanddeleteArticle", {"article.id":articleId},function(data){
			   		var arr=new Array();
					$.each(data, function(i, item) {
						arr.push(item);					           
					});					
					if(arr[0]){//true时表示操作成功，更改界面元素状态							
						alert("删帖成功！");
						document.location=baseUrl;
					}else{
						alert(arr[1]);	
					}	
		 	},'json'); 
		});
		$(".supportBtn").click(function(){
			//点赞或取消点赞
			var articleId=$(this).attr("articleId");
			var flag=$("#supportNumber"+articleId).attr("flag");
			var supportNumber=Number($("#supportNumber"+articleId).html());	
			var param="{\"article.id\":\""+articleId+"\",\"article.hasSupport\":";
			if(flag=="false"){//每个帖子只允许点赞一次
				param+="\"false\"}";
				supportNumber-=1;
			}else{
				param+="\"true\"}";
				supportNumber+=1;				
			}
			param=JSON.parse(param);		
			
					
			$.post("articleandsupprortArticle",param,function(data){
			   		var arr=new Array();
					$.each(data, function(i, item) {
						arr.push(item);					           
					});					
					if(arr[0]){//true时表示操作成功，更改界面元素状态							
						//document.location=document.location;
						$("#supportNumber"+articleId).html(supportNumber);
						if(flag=="false"){//每个帖子只允许点赞一次
							$("#supportNumber"+articleId).attr("flag","true");
						}else{
							$("#supportNumber"+articleId).attr("flag","false");			
						}
						
					}else{
						alert(arr[1]);	
					}	
		 	},'json'); 
		});
		//签到
		$(".signUp").click(function(){
			var html=$(this).html();
			var thisObj=this;
			if(html=="已签")
				return;
			$.post("articleanduserSignIn",null,function(data){
			   		var arr=new Array();
					$.each(data, function(i, item) {
						arr.push(item);					           
					});					
					if(arr[0]){//true时表示操作成功，更改界面元素状态
					//	$(thisObj).html("已签");
						document.location=document.location;
					}else{
						alert(arr[1]);	
					}	
		 	},'json'); 
		});
		//关注圈子
		$(".careForum").click(function(){
			
			var forumId=$(this).attr("forumId");
			var html=$(this).html();
			var thisObj=this;
			if(html=="已关注")
				return;
			$.post("forumandcareForum",{"forum.id":forumId},function(data){
			   		var arr=new Array();
					$.each(data, function(i, item) {
						arr.push(item);					           
					});					
					if(arr[0]){//true时表示操作成功，更改界面元素状态
						$(thisObj).html("已关注");
					}else{
						alert(arr[1]);	
					}	
		 	},'json'); 
		});
	});
</script>	
</body>
</html>
<!-- made by danyuan -->