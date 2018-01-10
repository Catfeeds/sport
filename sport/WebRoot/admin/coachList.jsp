<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
		basePath+="admin/";
%>

<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
		<meta charset="utf-8" />
		<title>教练管理</title>
		<script type="text/javascript" src="../res/js/jquery-1.8.3.min.js" ></script>
		<link rel="stylesheet" href="../res/admin/css/cd.css"  type="text/css" />
		<link href="../res/commonComponents/resizeTable/css/dividePage.css"
		rel="stylesheet" type="text/css" />
		
		
		<style>
			.cd-c-hide {
				display: none;
				width: 600px;
				border: 2px dashed blue;
				background: #FFFFFF;
				position: fixed;
				top:50%;
				left:50%;
				z-index: 9;
				margin:-250px 0 0 -330px; /*修正div位置*/
				padding-bottom: 10px;
				-moz-border-radius: 15px; 
				-webkit-border-radius: 15px; 
				border-radius:15px;
			}
			.cd-c-back {
				display: none;
				width: 100%;
				height: 100%;
				position: fixed;
				top:0;
				left:0;
				background: #f1f1f1;
				z-index: 8;
				opacity:0.4;
				filter:alpha(opacity=40);  
			}
			.cd-c-hide h2 {
				font-size: 18px;
				font-family: "微软雅黑";
				color: #d10000;
				text-align: center;
				margin: 5px auto;
			}
			.cd-c-hide-box p {
				line-height: 24px;
				font-size: 14px;
				
			}
			.cd-c-hide-box p span {
				line-height: 24px;
				font-size: 14px;
				display:-moz-inline-box; 
				display:inline-block; 
				width:75px;		
				margin-left: 10px;
			}
			.cd-c-hide-box .cd-c-hide-cb {
				padding: 5px 40px;
			}
			.cd-c-hide .cd-c-hide-cbtn {
				width: 24px;
				height: 24px;
				background: url(../res/images/cbtn.png) no-repeat;
				position: absolute;
				top: 8px;
				right: 8px;
				cursor: pointer;
			}
			/* 时间表 */
			.selectTime {
				border:0px solid #666;
			}
			td {
				width:90px;
				height:24px;
				line-height:24px;
				cursor:pointer;
				background:#ddd;
				border:5px solid #fff;
				font-size:14px;
				font-family:arial;
				text-align: center;
			}
			.tdSelect{
				background:#3CF;
			}
			.operation {
				width: 400px;
				height: 25px;
				margin-left: 100px;
			}
			
			ul,li {
				margin: 0px;
				padding: 0px;
			}
			.operation ul li {
				list-style-type: none;
				float: left;
				line-height: 25px;
				width: 100px;
				text-align: center;
				margin-left: 20px;
				border: 1px solid #666;
			}
			.operation ul li:hover {
				color: #fff;
				background-color: #39c;
			}
		</style>
		<script>
			$(document).ready(function(){
				$(".cd-c-dbtn").click(function(){
					$(".cd-c-hide").slideDown(200);
					$(".cd-c-back").slideDown(200);
				});
				$(".cd-c-hide-cbtn").click(function(){
					$(".cd-c-hide").slideUp(200);
					$(".cd-c-back").slideUp(200);
				});
			});
		</script>
		
	</head>
	<s:url var="searchUrl" value="coachandcoachList" includeParams="none">
		<s:param name="page.pageSize" value="page.pageSize" />
		<!-- 保证至少有一个参数，这样就会有一个？号 -->
	</s:url>
	<body>
		<h1 style="font-size:24px;margin:10px 0px 0px 20px;">教练管理</h1>
		<div class="CoachType" style="margin-top:20px;">
			<s:if test="coach.skillType==null">
				<s:a style="color:red;" href="javascript:void(0);">不限类型</s:a>&nbsp;&nbsp;&nbsp;&nbsp;
			</s:if>
			<s:else>
				<s:a href="%{searchUrl}&coach.skillType.id=-1&coach.homeAddress.id=%{coach.homeAddress.id}">不限类型</s:a>&nbsp;&nbsp;&nbsp;&nbsp;
			</s:else>
			<s:iterator value='types'>
				<s:if test="coach.skillType.id==id">
					<s:a style="color:red;" href="javascript:void(0);"><s:property value='typeName'/></s:a>
				</s:if>
				<s:else>
					<s:a href="%{searchUrl}&coach.skillType.id=%{id}&coach.homeAddress.id=%{coach.homeAddress.id}"><s:property value='typeName'/></s:a>
				</s:else>
				&nbsp;&nbsp;&nbsp;&nbsp;
			</s:iterator>
		</div>
		<div class="homeAddress" style="margin-top:20px;">
			<s:if test="coach.homeAddress==null">
				<s:a style="color:red;" href="javascript:void(0);">不限地区</s:a>&nbsp;&nbsp;&nbsp;&nbsp;
			</s:if>
			<s:else>
				<s:a href="%{searchUrl}&coach.homeAddress.id=-1&coach.skillType.id=%{coach.skillType.id}">不限地区</s:a>&nbsp;&nbsp;&nbsp;&nbsp;
			</s:else>
			<s:iterator value="cityAddrs">
				<s:if test="coach.homeAddress.id==id">
					<s:a style="color:red;" href="javascript:void(0);"><s:property value='addressName'/></s:a>
				</s:if>
				<s:else>
					<s:a href="%{searchUrl}&coach.homeAddress.id=%{id}&coach.skillType.id=%{coach.skillType.id}"><s:property value='addressName'/></s:a>
				</s:else>
				&nbsp;&nbsp;&nbsp;&nbsp;
			</s:iterator>
		</div>
		<div class="cd-nav-box"> 
			<ul>
				<li style="width:40px;">选择</li>
				<li style="width:130px;">头像</li>
				<li style="width:220px;">个人信息</li>
				<li style="width:535px;">个人简介</li>
				<li style="width:65px;">操作</li>
			</ul>
		</div>
		
		<div style="clear:both;"></div>
		<div style="width:96%;margin:15px auto;border:1px solid #ddd;"></div>	
		<div class="cd-box">
			<ul>
			<s:if test="#session.coachs!=null">
				<s:iterator value="#session.coachs">
				<li id="coachItem<s:property value='id '/>">
					<div class="cd-c-box">
						<div class="cd-c-choose">
							<input type="checkbox" value="<s:property value='id'/>" name="coachId">
						</div>
						<div class="cd-c-pic">
							<img src="..<s:property value='photoes[0].pathName'/>" border="0" />
						</div>
						<div class="cd-c-detail">
							<p class="cd-c-name"><s:property value="realName" /></p>
							<p>性别：<s:property value="sex" />	</p>
							<p>电话：<s:property value="phone" /></p>	
							<p>邮箱：<s:property value="email" /></p>	
							<p>居住地：<s:property value="homeAddress.parentAddress.addressName" />>
									<s:property value="homeAddress.addressName" />
							</p>
						</div>
						<div class="cd-c-intro">
							<p>
								<s:property escapeHtml="false" value='detail'/>
							</p>
						</div>
						<div class="cd-c-op" style="width:500px;float:left;">
							<p><a href="coachandcoachDetail?coach.id=<s:property value='id'/>" class="cd-c-dbtn">详情</a>
								&nbsp;&nbsp;&nbsp;&nbsp; 
								<a href="commentandcommentList?comment.coach.id=<s:property value='id'/>" class="cd-c-dbtn">管理评论</a>
								&nbsp;&nbsp;&nbsp;&nbsp; 
								<a href="orderandorderList?order.coach.id=<s:property value='id'/>" class="cd-c-dbtn">管理订单</a>
								&nbsp;&nbsp;&nbsp;&nbsp; 
								<a href="acountandacountList?acount.clearFlag=1&acount.acountType=1&acount.coach.id=<s:property value='id'/>" class="cd-c-dbtn">财务管理</a>
							</p>
							<br />
						</div>
						<shiro:hasPermission name="top:*">
						<div class="topValueWrap" style="float:left;">
							<div style="margin:10px 0;">推荐指数：(影响搜索排名)</div>
							<div>
								<select  name="coachTopValue<s:property value='id'/>">
									<s:iterator begin="0" end="10" status="st">
										<s:if test="topValue==#st.index">
											<option selected="selected" value="<s:property value='#st.index'/>"><s:property value='#st.index'/></option>
										</s:if>
										<s:else>
											<option value="<s:property value='#st.index'/>"><s:property value='#st.index'/></option>
										</s:else>
									</s:iterator>
								</select>
								&nbsp;&nbsp;
								<a class="btn-a alterTopValue" 
									coachId="<s:property value='id'/>" href="javascript:void(0);">提交修改</a>
							</div>
						</div>
						</shiro:hasPermission>
					</div>
					
					<div class="cd-c-back"></div>
				</li>
				</s:iterator>
			</s:if>
			</ul>
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
		<div style="clear:both;"></div>
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
	//选择所有进行操作  
function checkedAll() {
				
				if($("#chooseAllBtn").attr("value")=="选择所有"){
					$("#chooseAllBtn").attr("value","取消选择");
					$("input[name='coachId']").attr('checked','checked');
				}else{
					//alert($("#chooseAllBtn").attr("value"));
					$("input[name='coachId']").removeAttr('checked');
					$("#chooseAllBtn").attr("value","选择所有");
				}
			}
		/*	function myerror(_message,_url,_line)
		    {
		       alert("错误信息：" + _message
		            +"\n错误的URI：" + _url
		            +"\n错误的行数：" + _line
		       );
		 
		       return true; //屏蔽系统的事件
		    }
    //绑定错误事件
    window.onerror = myerror;*/

	function deleteBatch(){
		if(!confirm("删除是不可恢复的，确定要删除？"))
				return;
		var ids="-1";
		var i=0;
		$("input:checked").each(
			function(){
				ids+=","+this.value;
			}
		);				
		$.post("coachanddeleteCoachs", {"ids":ids},
			   function(data){
					var arr=new Array();
					$.each(data, function(i, item) {
						arr.push(item);					           
					});					
					if(arr[0]){//true时表示操作成功，更改界面元素状态							
						alert("删除教练成功！");
						document.location=document.location;
					}else{
						alert(arr[1]);	
					}		
			   },'text');
}	
$(function(){
	//alert();
	$(".alterTopValue").click(function(){
		//alert();
		var coachId=$(this).attr("coachId");
		var topValue=$("select[name=coachTopValue"+coachId+"]").val();		
		$.post("coachandtopCoach", {"coach.id":coachId,"coach.topValue":topValue},function(data){
			   		var arr=new Array();
					$.each(data, function(i, item) {
						arr.push(item);					           
					});					
					if(arr[0]){//true时表示操作成功，更改界面元素状态							
						alert("修改推荐指数成功！");
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
