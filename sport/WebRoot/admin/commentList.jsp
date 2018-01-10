<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>xx</title>
<script type="text/javascript" src="../res/js/jquery-1.8.3.min.js"></script>
	<link rel="stylesheet" type="text/css" href="../res/admin/css/orderListBase.css">
	<link rel="stylesheet" type="text/css" href="../res/admin/css/orderListBox.css">
	<link href="../res/commonComponents/resizeTable/css/dividePage.css"
	rel="stylesheet" type="text/css" />
	<style>
	.forumLogoBox img {
		width:100px;
		height:100px;
	}
	.opBox {
		height:34px;
		border-bottom:1px solid #ddd;
		margin:5px 10px;
		margin-left:50px;
	}
	.opBox ul li {
		margin:0px;
		padding:0px 10px;
		text-align:center;
		line-height:30px;
		float:left;
		list-style:none;
	}
	.opBox ul li input {
		padding:5px 5px;
		vertical-align:middle;
	}
	a {
		margin:0px;
		padding:0px;
	}
	.abutton {
    border: none;
    outline: none;
    color: #FFF;
    font-size: 1.2em;
    padding:10px 20px;
    font-weight: 500;
    background: #47a1ce;
    line-height: 3em;
}
td {
 text-align: center;
} 
	</style> 
</head>
<s:if test="comment.coach!=null">
	<input type="hidden" name="commentType" value="1"/>
	<s:url var="searchUrl" value="commentandcommentList" includeParams="none">
			<s:param name="page.pageSize" value="page.pageSize" />
			<s:param name="comment.coach.id" value="comment.coach.id" />
			<!-- 保证至少有一个参数，这样就会有一个？号 -->
	</s:url>
</s:if>
<s:elseif test="comment.site!=null">
	<input type="hidden" name="commentType" value="2"/>
	<s:url var="searchUrl" value="commentandcommentList" includeParams="none">
			<s:param name="page.pageSize" value="page.pageSize" />
			<s:param name="comment.site.id" value="comment.site.id" />
			<!-- 保证至少有一个参数，这样就会有一个？号 -->
	</s:url>
</s:elseif>
<s:elseif test="comment.company!=null">
	<input type="hidden" name="commentType" value="3"/>
	<s:url var="searchUrl" value="commentandcommentList" includeParams="none">
			<s:param name="page.pageSize" value="page.pageSize" />
			<s:param name="comment.company.id" value="comment.company.id" />
			<!-- 保证至少有一个参数，这样就会有一个？号 -->
	</s:url>
</s:elseif>
<s:elseif test="comment.product!=null">
	<input type="hidden" name="commentType" value="4"/>
	<s:url var="searchUrl" value="commentandcommentList" includeParams="none">
			<s:param name="page.pageSize" value="page.pageSize" />
			<s:param name="comment.product.id" value="comment.product.id" />
			<!-- 保证至少有一个参数，这样就会有一个？号 -->
	</s:url>
</s:elseif>
<body>
	<h2 class="sub-header" style="margin-left:70px;font-size:25px;font-weight:bold;font-family:'微软雅黑';margin-top:20px;">评论管理</h2>
	<div class="opBox">
		<ul>
			<li>
				<s:if test="comment.lowScore==0&&(comment.highScore==0)">
					<input type="radio" name="clc" id="clc-1" checked/><label >&nbsp;全部</label>
				</s:if>
				<s:else>
					<s:a href="%{searchUrl}">
					<input type="radio" name="clc" id="clc-1" /><label >&nbsp;全部</label>
					</s:a>
				</s:else>
			</li>
			<li>
				<s:if test="comment.lowScore==0&&(comment.highScore>0)">					
					<input type="radio" name="clc" checked="checked" id="clc-2"/><label >&nbsp;好评</label>					
				</s:if>
				<s:else>
					<s:a href="%{searchUrl}&comment.highScore=3">
					<input type="radio" name="clc" id="clc-2"/><label >&nbsp;好评</label>
					</s:a>
				</s:else>
			</li>
			<li>
				<s:if test="comment.lowScore>0&&(comment.highScore>0)">	
					<input type="radio" name="clc" checked="checked" id="clc-3"/><label >&nbsp;中评</label>
				</s:if>
				<s:else>
					<s:a href="%{searchUrl}&comment.highScore=3&comment.lowScore=2">
						<input type="radio" name="clc" id="clc-3"/><label >&nbsp;中评</label>
					</s:a>
				</s:else>
			</li>
			<li>
				<s:if test="comment.lowScore>0&&(comment.highScore==0)">	
					<input type="radio" checked="checked" name="clc" id="clc-4"/><label >&nbsp;差评</label>
				</s:if>
				<s:else>
					<s:a href="%{searchUrl}&comment.lowScore=2">
						<input type="radio" name="clc" id="clc-4"/><label >&nbsp;差评</label>
					</s:a>
				</s:else>
			</li>
		</ul>
	</div>
	<div class="table-responsive" style="margin-left:50px;margin-right:50px;">
		<table class="table table-striped" >
			<thead>
				<tr>
					<th style="min-width:50px;width:50px;">选择</th>
					<th style="min-width:120px;width:120px;">用户</th>
					<th style="min-width:120px;width:120px;">评论对象</th>
					<th >评论内容</th>
					<th style="min-width:70px;width:70px;">评论等级</th>
					<th style="min-width:140px;width:140px;">评论时间</th>
					<th style="min-width:70px;width:70px;">是否回复</th>
					<th style="min-width:100px;width:100px;">操作</th>
				</tr>
			</thead>
			<tbody>
			<s:if test="comments!=null">
				<s:iterator value="comments">			
					
					<tr id="commentAllInfo<s:property value='id'/>">
						<td><input type="checkbox" name="commentId" class="commentItem" value="<s:property value='id' />"/></td>
						<td><s:property value="comment.userName" /></td>
						<s:if test='product!=null'>
							<td><s:property value="product.productName" /></td>
						</s:if>
						<s:else>
							<td><s:property value="coach.skillType.typeName" /></td>
						</s:else>
						<td ><s:property value="detail" /></td>
						<td><s:property value="score" /></td>
						<td><s:date name="time" format="yyyy-MM-dd hh:mm:ss"/></td>
						<td>
							<s:if test="hasReply">
								是
							</s:if>
							<s:else>
								否
							</s:else>
						</td>
						<td>
							<s:if test="hasReply">
								<a href="javascript:void(0);" class="detail" value="<s:property value='id'/>" >查看回复</a>
							</s:if>
							<s:else>
								<a href="javascript:void(0);" class="detail" value="<s:property value='id'/>" >回复</a>
							</s:else>
							|<a class="deleteBtn" commentId="<s:property value='id'/>" href="javascript:void(0)">删除</a>
						</td>			
					</tr>
					<div class="tover" id="detailBox<s:property value='id'/>">
						<div class="tclose">
							<div class="boxTitle">
								回复评论
								<a href="javascript:void(0)" class="closeBtn">
									<img src="../res/images/closeBtn.png">
								</a>
							</div>
						</div>
						<div style="margin:20px 10px;">
							<s:if test="hasReply">
								回复内容：<s:property value='replyContent'/>
							</s:if>
							<s:else>
							<textarea name="replyEditor<s:property value='id'/>" rows="10" cols="100"></textarea>
							</s:else>
						</div>
						<div style="clear:both;"></div>
						<s:if test="!hasReply">
						<div style="width:100px;margin:20px auto;">
							<a href="javascript:void(0)" class="replyBtn" commentId="<s:property value='id'/>" class="abutton"> 回  复</a>
						</div>
						</s:if>
					</div>
					<div class="tback"></div><!--背景淡出-->									
					
				</s:iterator>
			</s:if>	
			<s:else>
				很遗憾，暂时还没有任何用户留下评论!
			</s:else>
			</tbody>
			
		</table>
	</div>
	
 
	<div class="operation">
		<ul>
			<a id="chooseAllBtn" onclick="checkedAll();" style="cursor:pointer;">
				<li>选择所有</li>
			</a>
			<a onclick="deleteBatch();" style="cursor:pointer;"	>
				<li>删除选中</li>
			</a>
		</ul>
	</div>
	
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
					<li><s:a href="%{searchUrl}&page.pageNumber=1">首页</s:a></li>
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
	

	<script type="text/javascript">
	//详情展示
jQuery(document).ready(function($) {
	$('.detail').click(function(){
		var temp = $(this).attr("value");
		$('.tback').fadeIn(100);
		$('#detailBox'+temp).slideDown(200);
	})
	$('.tclose .closeBtn').click(function(){
		$('.tback').fadeOut(100);
		$('.tover').slideUp(200);
	});
});
	</script>
	<script type="text/javascript">
	//选择所有进行操作
	function checkedAll() {
					
		if($("#chooseAllBtn li").html()=="选择所有"){
			$("#chooseAllBtn li").html("取消选择");
			$("input[name='commentId']").attr('checked','checked');
		}else{
			$("input[name='commentId']").removeAttr('checked');
			$("#chooseAllBtn li").html("选择所有");
		}
	}
	</script>
	<script type="text/javascript">
	//删除选中
	function deleteBatch(){
		var ids="-1";
		var i=0;
		$("input[class=commentItem]:checked").each(
			function(){
				ids+=","+this.value;
			}
		);				
		alert(ids);
		$.post("commentanddeleteSelectedComments", {"ids":ids},
			   function(data){
			   	 var arr=new Array();
					$.each(data, function(i, item) {
						arr.push(item);					           
					});
					
					if(arr[0]){//true时表示操作成功，更改界面元素状态								
						$("input:checked").each(
						function(){
								//$("#commentAllInfo"+this.value).remove();
								document.location=document.location;
							}
						);	
					}else{
						alert(arr[1]);		
					}
		 },'json');
	}
	$(function(){
		$(".replyBtn").click(function(){
			var commentId=$(this).attr("commentId");
			var replyContent=$("textarea[name=replyEditor"+commentId+"]").val();
			//alert(replyContent);
			$.post("commentandreplyComment", {"comment.id":commentId,"comment.replyContent":replyContent},
			   function(data){
			   	 var arr=new Array();
					$.each(data, function(i, item) {
						arr.push(item);					           
					});
					
					if(arr[0]){//true时表示操作成功，更改界面元素状态								
						document.location=document.location;
					}else{
						alert(arr[1]);		
					}
		 	},'json');
		});	
	$(".deleteBtn").click(function(){
		var commentId=$(this).attr("commentId");
		$.post("commentanddeleteComment", {"comment.id":commentId},
			   function(data){
			   	 var arr=new Array();
					$.each(data, function(i, item) {
						arr.push(item);					           
					});
					
					if(arr[0]){//true时表示操作成功，更改界面元素状态	
						alert("删除评论成功！");							
						document.location=document.location;
					}else{
						alert(arr[1]);		
					}
		 	},'json');
	});		
});
	</script>
</body>
</html>