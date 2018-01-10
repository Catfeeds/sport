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
	<link rel="stylesheet" href="res/css/noteDetail.css" type="text/css" media="all" />
	<link href="res/commonComponents/toTop/css/zzsc.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="res/commonComponents/progressBar/css/css.css" />
	<script type="text/javascript" src="res/commonComponents/imgChange/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="res/js/articleDetail.js"></script>
		<!-- 引入图片预览 -->
	<script type="text/javascript" src="res/js/upload.js"></script>
	<script type="text/javascript">
	$(function(){
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
<s:url var="searchUrl" value="articleandarticleDetail" includeParams="none">
	<s:param name="page.pageSize" value="page.pageSize"></s:param>
	<s:param name="rootArticle.id" value="rootArticle.id"></s:param>
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
			    <li><a href="articleandtypeForum?forum.id=<s:property value='forum.id'/>" class="active"><span>
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
    <a href="javascript:;" class="uc-2vm"></a>
	<div class="uc-2vm-pop dn">
		<h2 class="title-2wm">用微信扫一扫</h2>
		<div class="logo-2wm-box">
			<img src="res/images/weixin.jpg" alt="享动" width="240" height="240">
		</div>
	</div>
	<!-- 
    <a href="#" target="_blank" class="feedback"></a>
     -->
    <a href="javascript:;" class="go"></a>
</div>

<!-- Container -->
<div id="container">
	<div class="shell">
		
		<!-- Small Nav -->
		<div class="small-nav">
			<a href="articleandforumIndex">享动论坛</a>
			<span>&gt;</span>
			帖子详情
		</div>
		<!-- End Small Nav -->
		
		<!-- Main -->
		<div id="noteDetailWrap">
			<div class="cl">&nbsp;</div>
			
			<!-- Content -->
			<div id="noteDetailContentWrap">
				
				<!-- Box -->
				<div class="noteDetailBox">
					<!-- Box Head -->
					<div class="noteDetailBox-head">
						<h2 class="left">帖子详情</h2>
					</div>
					<!-- End Box Head -->	
					<div class="noteDetailInnerWrap">
						<!--楼层项开始 -->
						<div class="noteDetailItem">
							<div class="noteDetailTitleWrap">
								<div class="noteOwnerInfo">
									<div class="noteOwnerImg">
										<img src="..<s:property value='rootArticle.talker.image.pathName'/>"/>
									</div>
									<div class="userName">
										<a herf="javascript:void(0);"><s:property value='rootArticle.talker.realName'/></a>									
									</div>
								</div> 
								
								<div class="noteTitleDetailWrap">
									<div class="noteTitleDetail">
										<p>标题：<s:property value='rootArticle.title'/></p><br/><br/>
										<s:if test="image!=null">
										<div class="articleImgWrap">
											<img src="..<s:property value='rootArticle.image.pathName'/>"/>
										</div>
										</s:if>
										<p>内容：<s:property value='rootArticle.content'/></p>
									</div>
								</div>
							</div>
							<!-- 对帖子的操作 --> 
							<div class="operateNote">
								<div class="noteRight">
									<shiro:hasPermission name="forum:*">
									<span class="report">
										<a href="javascript:void(0);"
											articleId="<s:property value='rootArticle.id'/>"
										 class="deleteBtn" >
											删贴
										</a>
									</span> 
									</shiro:hasPermission>
									&nbsp;&nbsp;
									<span class="floor">楼主</span>&nbsp;
									<span class="time"><s:date name="rootArticle.date" format="yyyy-MM-dd hh:mm:ss"/> </span>
									&nbsp;&nbsp;
									<span class="expandReply">
										<a  href="articleandarticleDetail?rootArticle.id=<s:property value='rootArticle.id'/>#replyRootArticleWrap" >
										回复楼主
										</a>
									</span>
								</div>
							</div>
						</div>
						<!--楼层项结束-->
<!-- ********************************************层主帖子华丽分割线*************************************** -->						
						
						<s:iterator value='childArticles'  status="st">
						<!--楼层项开始 -->
						<div class="noteDetailItem">
							<div class="noteDetailTitleWrap">
								<div class="noteOwnerInfo">
									<div class="noteOwnerImg">
										<img src="..<s:property value='talker.image.pathName'/>"/>
									</div>
									<div class="userName">
										<a herf="javascript:void(0);" 
											id="talkerName<s:property value='id'/>">
											<s:property value='talker.realName'/></a>									
									</div>
								</div>
								
								<div class="noteTitleDetailWrap">
									<div class="noteTitleDetail">
										<p>说：<s:property value='content'/></p>
										<br/><br/>
										<s:if test="image!=null">
										<div class="articleImgWrap">
											<img src="..<s:property value='image.pathName'/>"/>
										</div>
										</s:if>
																				
									</div>
								</div>
							</div>
							<!-- 对帖子的操作 -->
							<div class="operateNote">
								<div class="noteRight">
									<shiro:hasPermission name="forum:*">
									<span class="report">
										<a href="javascript:void(0);"
											articleId="<s:property value='id'/>"
										 class="deleteBtn" >
											删贴
										</a>
									</span> 
									</shiro:hasPermission>
									&nbsp;&nbsp;
									<span class="floor">
										<s:property value='#st.index+(page.pageNumber-1)*page.pageSize+2'/>
									楼</span>&nbsp;
									<span class="time"><s:date name="date" format="yyyy-MM-dd hh:mm:ss"/> </span>
									&nbsp;&nbsp;
									<span class="expandReply">
										<a class="expandReplyBtn" id="expandReplyBtn<s:property value='id'/>" 
											ref="<s:property value='id'/>" href="javascript:void(0);"
										 content="回复(<s:property value='childrenArticles.size()'/>)">
										 回复(<b><s:property value='childrenArticles.size()'/></b>)</a>
									</span>
								</div>
							</div>
							<!-- 回复贴开始 style="display:none;"-->
							<div class="noteDetailReplyWrap" 
									id="replyItemsWrap<s:property value='id'/>" 
									style="display:none;">
								<div class="replyItemWrap">
									<div class="replyItems" id="replyItems<s:property value='id'/>">
									<s:iterator value='childrenArticles' status="innerStatus">
									<!-- 子项开始-->
									<div class="replyItem">
										<div class="replyItemInnerWrap">
											<div class="replyUserImg">
												<img src="..<s:property value='talker.image.pathName'/>"/>
											</div>
											<div class="replayContentWrap"> 
												<div class="userName" 
													id="user<s:property value='id'/>"><s:property value='talker.realName'/>：</div>
												<div class="replyContent">
													<s:property value='content'/>
												</div> 
											</div> 
										</div>
										<div class="replayBtnWrap">
											<span >
												<s:date name="date" format="yyyy-MM-dd hh:mm:ss"/> &nbsp;&nbsp;
											</span>
											<span><a href="javascript:void(0);"
													 ref="<s:property value='id'/>" 
													 talkerId="<s:property value='talker.id'/>"
													 rootId="<s:property value='childArticles[#st.index].id'/>"
													  class="replayBtn button">回复</a> 
											</span>
										</div>
									</div>
									<!-- 子项结束 -->
									</s:iterator>
									
									</div>
									<div class="replyEditorOperateWrap">
										<div class="replayOperate">
												<!-- Pagging -->
												<div class="pagging paggingBgColor">
													<div class="left" id="totalPageNumberWrap<s:property value='id'/>">共<s:property value='childrenArticles.size()/page.pageSize+1'/>页</div>
													<div class="right"> 
														<div class="right">
														<!-- 这里是回复贴分页   -->
														
														<a href="javascript:void(0);" class="replayOwnerBtn" 
														id="replayOwnerBtn<s:property value='id'/>" ref="<s:property value='id'/>">我也说一句</a>
														</div>
													</div>												
												</div>
												<!-- End Pagging -->
										<div class="littleReplyEditorWrap" id="replyUserEditorWrap<s:property value='id'/>" style="display:none;">
											<!-- 楼层回复编辑框 -->
											<div class="replyEditorWrap">
												<div class="editorWrap">
													<textarea id="replyUserEditor<s:property value='id'/>" 
														parentArticleId=""
														replyerId="<s:property value='talker.id'/>"
													 class="field size2" rows="10" cols="30"></textarea>
												</div>
											</div>
											<div class="replyOperate">
												<input type="button" class="button replyBtn"
													parentArticleId="<s:property value='id'/>" 
													value="发表" />
											</div>
										</div>
									</div>
								</div>
								
							</div>
							<!-- 回复贴结束 -->
						</div>
						<!--楼层项结束-->
						</s:iterator>
					</div>	
					<!-- 公告贴分页开始 -->
						<s:if test="page.totalPageNumber>0">
							<div class="pagging paggingBgColor">
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
					<!-- Pagging -->
					<!-- 
					<div class="pagging paggingBgColor">
						<div class="left">共245页</div>
						<div class="right">
							<a href="#">首页</a>
							<a href="#">上一页</a>
							<a href="#">1</a>
							<a href="#">2</a>
							<a href="#">3</a>
							<a href="#">4</a>								
							<span>...</span>
							<a href="#">245</a>
							<a href="#">下一页</a>
							<a href="#">尾页</a>
						</div>
					</div> -->
					<!-- End Pagging -->
				</div>
				<!-- End Box -->
				
				<!-- Box -->
				<!-- 回复贴主-->
				<div class="saidWrap">
					<!-- Box Head -->
					<div class="saidWrap-head">
						<h2 class="left">发表回复</h2>
					</div>
					<!-- End Box Head -->
					
					<form action="articleandaddArticle" method="post" enctype="multipart/form-data">	
						<input type="hidden" name="article.parentArticle.id" value="<s:property value='rootArticle.id'/>"/>	
						<input type="hidden" name="rootArticle.id" value="<s:property value='rootArticle.id'/>"/>				
						<input type="hidden"  name="article.articleType" value="1">
						<!-- Form -->
						<div class="form">					
								<p>
									<span class="req">不超过1000字</span>
									<label>详情 <span>(必填项)</span></label>
									<a name="replyRootArticleWrap">
									<textarea class="field size1" rows="10" name="article.content" cols="30"></textarea>
									</a>
								</p>								
						</div>
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
						<!-- End Form -->						
						<!-- Form Buttons -->
						<div class="buttons buttonsWrap">
							<!--<input type="button" class="button" value="预览" />-->
							<input type="submit" class="button" value="发表" />
						</div>
						<!-- End Form Buttons -->
					</form>
				</div>
				<!-- End Box -->

			</div>
			<!-- End Content -->
			
			
			
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
		<span class="right">
			设计方：<a href="#" title="#">湖南理工学院信息学院信工12-2BF(张俊)</a>
		</span>
	</div>
</div>
<!-- End Footer -->
<script type="text/javascript">
	
</script>		
</body>
</html>
<!-- made by danyuan -->