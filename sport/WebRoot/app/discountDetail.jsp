<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE HTML>
<html>
  <head>
    
	<title>优惠信息</title>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"
	/>
	
	<link rel="stylesheet" type="text/css" href="res/css/based.css">
	<link rel="stylesheet" type="text/css" href="res/css/discountDetail.css"  />


	<script type="text/javascript" src="res/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="res/js/common.js" ></script>
	

</head>
<body>
	<!--顶部开始-->
	<div id="top">
		<!-- top banner -->
        <div class="topbanner">
            <div class="topbannerWord" style="z-index:1;">    
                优惠信息
            </div>
            <div class="clear"></div>
        </div>
        <!-- top banner -->  
	</div>
	<!--顶部结束-->

	<div id="content">
		<div class="discountListBox">
			<ul class="discountList">
				<li>
					<h1>岳阳市体育中心羽毛球馆免费开放</h1>
					<div class="InfoTime">2015-08-29 10:09:57</div>
					<div class="InfoPicture">
					<img src="res/images/img1.jpg" alt="这个是模板内容详细页面" />
					</div>
					<div class="InfoContent">
					时间在流逝中抒写着自己，淡淡的记忆中总是有墨砚浓重的一笔。其实美丽的故事都是没有结局的，只因为它没有结局所以才会美丽。这就像为什麽悲剧总是比喜剧更让人难忘，也就像人们总是找寻的真爱，却往往擦肩而去。
					<br /> 
					<img alt="" src="res/images/img2.jpg"  />
					<br /> 不是这个时代远离了爱情，而是人们一开始就没有想过用一颗心去坚定地温暖另一颗心。不是爱情不再永恒，而是浮躁和易变的心！我们总感觉心灵承受着无尽的累，是因为很多时候我们放大了欲望，追逐了过多不属于自己的东西。
					<br /> 
					<img alt="" src="res/images/img3.jpg"/>
					<br /> 用单纯的眼看人生，你会少了许多莫名的烦忧；用幸福的脚印丈量生活，你就会步履轻盈而洒脱。
					</div>
				</li>
			</ul>
			<!--子频道显示 结束-->
			<div class="clear">
			</div>	

			<div class="comment">
				<ul class="discountList">
					<li>
						<div class="CommentList">
							<h1>
								评论列表
							</h1>
						</div>
						<div>
			                <ul>
			                	<li>
			                		<div>
			                			<div class="personalImg">
			                				<img src="res/images/1.png" />
			                			</div>
			                			<div>
			                				<div>
			                					<span class="personalName">路人甲
			                					路人甲</span>
			                					<span class="replyTime">2015-08-30 17:04:08</span>
			                				</div>
			                				<div class="replyContent">
			                					这里是评论内容
			                				</div>
			                			</div>
			                		</div>
			                	</li>
			                </ul>
			            </div>
						<div class="LeaveComment">
							<h1>
								我要评论
							</h1>
						</div>
						<form action="/" id="frmComment" method="post">
							<table border="0px" cellpadding="0px" cellspacing="3px" class="commenttable">
								<tbody>
									<tr>
										<td class="t1">
											<span class="required">
												评论内容*
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