<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE HTML>
<html>
  <head>
    
	<title>发布帖子</title>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"
	/>
	
	<link rel="stylesheet" type="text/css" href="res/css/based.css">
	<link rel="stylesheet" type="text/css" href="res/css/writeNote.css"  />


	<script type="text/javascript" src="res/js/jquery-1.7.2.min.js"></script>
	<script src="res/js/common.js" type="text/javascript"></script>
	

</head>
<body>
	<!--顶部开始-->
	<div id="top">
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
						<form action="/" id="frmComment" method="post">
							<table border="0px" cellpadding="0px" cellspacing="3px" class="commenttable">
								<tbody>
									<tr>
										<td class="t1">
											<span class="required">
												帖子标题*
											</span>
										</td>
										<td class="t2">
											<input name="verifycode" type="text" />
										</td>
									</tr>
									<tr>
										<td class="t1">
											<span class="required">
												帖子简介*
											</span>
										</td>
										<td class="t2">
											<input name="verifycode" type="text" />
										</td>
									</tr>
									<tr>
										<td class="t1">
											<span class="required">
												帖子内容*
											</span>
										</td>
										<td class="t2">
											<textarea id="CommentContent" name="CommentContent">
											</textarea>
										</td>
									</tr>
									<tr>
										<td class="t1">
											<span class="required">
												&nbsp;&nbsp;&nbsp;&nbsp;验证码*
											</span>
										</td>
										<td class="t2">
											<input id="verifycode" name="verifycode" type="text" style="width:80px"
											maxlength="4" />
											&nbsp;
											<img src="&lt;&gt;" onclick="ChangeCode()" style="cursor:pointer;" id="CommentCode"
											align="absMiddle" />
										</td>
									</tr>
									<tr>
										<td colspan="2">
											<input class="ui-btn-submit" type="submit" name="submit" value="发表评论"
											/>
										</td>
									</tr>
								</tbody>
							</table>
							<input type="hidden" name="__hash__" value="1254345" />
						</form>
					</li>
				</ul>
			</div>
		</div>

		

	</div>
</body>

</html>