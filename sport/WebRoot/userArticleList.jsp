<%@ page language="java"  contentType="text/html; charset=UTF-8" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">  
    <title>用户个人帖子管理</title>
    <meta name="description" content="">
    <meta name="author" content="templatemo">
    
    <link href='http://fonts.useso.com/css?family=Open+Sans:400,300,400italic,700' rel='stylesheet' type='text/css'>
    <link href="res/css/font-awesome.min.css" rel="stylesheet">
    <link href="res/css/bootstrap.min.css" rel="stylesheet">
    <link href="res/css/templatemo-style.css" rel="stylesheet">
    <!-- 引入分页下标 -->
<link href="./res/commonComponents/resizeTable/css/dividePage.css"
	rel="stylesheet" type="text/css" />
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="js/html5shiv.min.js"></script>
      <script src="js/respond.min.js"></script>
    <![endif]-->
<!-- 弹出登录注册对话框 -->
	<link rel="stylesheet" href="res/commonComponents/loginPopDialog/css/loginbox.css"  type="text/css"/>
	<script type="text/javascript" src="res/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="res/js/header.js"></script>
	<!-- 弹出框结束 -->
<style>
	.postcol div,p{
		float: left;
		margin-left: 5%;
	}
	.postcol p{
		display:block;white-space:nowrap; overflow:hidden; text-overflow:ellipsis;
		text-align: left;
		width:35%;
	}
	.postcol span{
		float: left;
		width:15%;
		margin-right:;
	}
</style>
  </head>
  <body>  
  <s:url var="searchUrl" value="articleanduserArticleList" includeParams="none">
	<s:param name="page.pageSize" value="page.pageSize"></s:param>
</s:url>
    <!-- header -->
<iframe src="header" scrolling="no" frameborder="0" width="100%" height="190px"></iframe>
<!-- /header -->
<div style="width:1000px; margin: auto auto 20px auto;">
    <!-- Left column -->
    		<div class="templatemo-flex-row">
			<div class="templatemo-sidebar" style="float: left;">
				<div class="profile-photo-container">
					<img src=".<s:property value='#session.currentUser.image.pathName'/>" alt="个人头像" class="img-responsive">
						<h3 style="text-align: center; padding: 5px;"><s:property value='#session.currentUser.realName'/></h3>
				</div>
				<nav class="templatemo-left-nav">
										<ul>
						<li><a href="userHome"><i class="fa fa-home fa-fw"></i>个人首页</a></li>
			            <li><a href="useranduserDetail"   >个人资料管理</a></li>
			            <li><a href="orderanduserOrderList">订单管理</a></li>
			            <li><a href="forumanduserCaredForum">关注的圈子</a></li>
			            <li><a href="articleanduserArticleList"  class="active">我的帖子</a></li>
					</ul>
				</nav>
			</div>
      <!-- Main content --> 
      <div class="templatemo-content col-1 light-gray-bg">
        <div class="templatemo-content-container">
          <div class=" flex-content-row">
            <div class="templatemo-content-widget white-bg col-2">
              <div class="media margin-bottom-30">
                  <h2 class="media-heading text-uppercase blue-text">我的帖子</h2>
                   
              </div>
              <div class="table-responsive">
                <table class="table" >
                  <tbody>
                    <tr>
                      <td class="postcol">
                      	<div class="circle green-bg" ></div>
                      	<p>帖子内容</p>                      	  
                      	<span>社交圈名</span>   
                      	<span>发表时间</span> 
                      	<span>回复数量</span>               
                      </td>
                    </tr> 
                    <s:iterator value='articles'>
                    <tr>
                    	
                      <td class="postcol">
                      	<div class="circle green-bg" ></div>
                      	<s:if test='rootArticle==null'>
                    		<a href="forum/articleandarticleDetail?rootArticle.id=<s:property value='id'/>">
                    	</s:if>
                    	<s:else>
                    		<a href="forum/articleandarticleDetail?rootArticle.id=<s:property value='rootArticle.id'/>">
                    	</s:else>
                      	<p><s:property value='content'/></p>                      
                      	<span><s:property value='forum.forumName'/></span> 
                      	<span><s:date name='date' format='yyyy-MM-dd hh:mm:ss'/></span>
                      	<span><s:property value='childrenArticles.size()'/></span> 
                      	</a>                    
                      </td> 
                                       
                    </tr>  
                    </s:iterator>          
                    
                  </tbody>
                </table>
              </div>             
            </div>
          </div>         
               
        
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
    </div>
    <!-- JS -->
    <script>
      $(document).ready(function(){
        // Content widget with background image
        var imageUrl = $('img.content-bg-img').attr('src');
        $('.templatemo-content-img-bg').css('background-image', 'url(' + imageUrl + ')');
        $('img.content-bg-img').hide();
        //post color 表格变色
        var i=1;
        $("tr").each(function(){
        	$(this).removeClass("white-bg");
        	$(this).removeClass("black-bg");
        	if(i%2==0){$(this).addClass("white-bg ")}
        	else{$(this).addClass("black-bg")}
        	i++;
        });
      });
    </script>
    <iframe src="footer.jsp" scrolling="no" frameborder="0" width="100%" height="165px"></iframe>
  </body>
</html>