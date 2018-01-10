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
	<title>享动</title>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"
	/>
	
	<link rel="stylesheet" type="text/css" href="weixin/res/css/based.css">
	<link rel="stylesheet" type="text/css" href="weixin/res/css/writeNote.css"  />


	<script type="text/javascript" src="weixin/res/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="weixin/res/js/upload.js"></script>
	<style>
		/* Anonymous ---------------------------*/
		.m-bbtn {
			width:32px;
			height:32px;
			position:absolute;
			left:4px;
			top:0px;
			padding:4px 4px;
		}
		.m-bbtn img, .m-hbtn img {
			width:32px;
			height:32px;
		}
	</style>
	
	<style>
		img{
		    border: none;
		    font-size: 0;
		    vertical-align: top;
		}
		
		.person {
		    width: 100%;
		    border: 1px solid #ddd;
		    margin-bottom: 10px;
		}
		.person label{
		    width: 100%;
		    height:30px;
		    line-height:30px;
		    text-align: center;
		    background-color: #3cf;
		    color: white;
		}
		
		.join label {
		    display: inline-block;
		    margin-bottom: 0px;
		    font-weight: 700;
		}
		
		.join img {
		    width: 100%;
		    height: auto;
		    max-width: 100%;
		}
		
		.join label span {
		    font-weight: normal;
		}
		
		.join label svg {
		    fill: currentColor;
		    margin-top: -0.25em;
		    margin-right: 0.25em;
		}
		
		input.upload {
		    width: 0.1px;
		    height: 0.1px;
		    opacity: 0;
		    overflow: hidden;
		    position: absolute;
		    z-index: -1;
		}
	</style>
	
	<script type="text/javascript">
		$(function() {
			
			$(".m-bbtn").click(function(){
				window.history.back(-1);
			});
			document.getElementById("title-text").focus();
		});
		
	</script> 
	
</head>
<body>
	<!--顶部开始-->
	<div id="top">
		<div class="m-bbtn">
			<img alt="" src="weixin/res/images/back.png" />
		</div>
		<!-- top banner -->
        <div class="topbanner">
            <div class="topbannerWord" style="z-index:1;">    
                发布帖子
            </div>
            <div class="clear"></div>
        </div>
        <!-- top banner -->  
	</div>
	<!--顶部结束-->

	<div id="content">
		<div class="discountListBox">

			<div class="comment">
				<ul class="discountList">
					<li>	
						<div class="LeaveComment">
							<h1>
								发布帖子
							</h1>
						</div>
						<form action="weixin/articleandaddArticle" method="post" enctype="multipart/form-data">
							<input type="hidden" name="article.forum.id"  value="<s:property value='forum.id'/>"/>
							<input type="hidden" name="forum.id"  value="<s:property value='forum.id'/>"/>
							<input type="hidden"  name="article.articleType" value="1">
							<table border="0px" cellpadding="0px" cellspacing="3px" class="commenttable">
								<tbody>
									<tr>
										<td colspan="2">
											<input name="article.title" type="text" id="title-text" placeholder="帖子标题" />
										</td>
									</tr>
									<tr>
										<td colspan="2">
											<textarea id="CommentContent" name="article.content" placeholder="帖子内容"  style="min-height:100px; _height:100px;word-wrap: break-word; overflow-y:auto;"></textarea>
										</td>
									</tr>
									<tr>
										<td colspan="2">
											<div class="join">
												<div class="person">
													<div id="preview">
														<img id="imghead" src="" />
												    </div>
												    <input type="file"  name="file"  capture="camera" multiple="multiple" accept="image/*" onchange="previewImage(this)" class="upload" id="file">
												    <label for="file">
												    	<svg xmlns="http://www.w3.org/2000/svg" width="15" height="12" viewBox="0 0 20 17">
													    	<path d="M10 0l-5.2 4.9h3.3v5.1h3.8v-5.1h3.3l-5.2-4.9zm9.3 11.5l-3.2-2.1h-2l3.4 2.6h-3.5c-.1 0-.2.1-.2.1l-.8 2.3h-6l-.8-2.2c-.1-.1-.1-.2-.2-.2h-3.6l3.4-2.6h-2l-3.2 2.1c-.4.3-.7 1-.6 1.5l.6 3.1c.1.5.7.9 1.2.9h16.3c.6 0 1.1-.4 1.3-.9l.6-3.1c.1-.5-.2-1.2-.7-1.5z">
													    	</path>
												    	</svg> 
												    	<span>选择图片…</span>
												    </label>
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<td colspan="2">
											<input class="ui-btn-submit" type="submit" name="submit" value="发布帖子" />
										</td>
									</tr>
								</tbody>
							</table>
						</form>
					</li>
				</ul>
			</div>
		</div>
	</div>
</body>

</html>