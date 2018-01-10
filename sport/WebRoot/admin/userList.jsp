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

<title>所有会员信息列表</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<link href="../res/commonComponents/resizeTable/css/table.css"
	rel="stylesheet" type="text/css" />
<script src="../res/js/jquery-1.8.3.min.js"></script>
<script
	src="../res/commonComponents/resizeTable/js/colResizable-1.5.min.js"></script>
</head>
<script type="text/javascript">
	//选择所有进行操作
function checkedAll() {
				
				if($("#chooseAllBtn").attr("value")=="选择所有"){
					$("#chooseAllBtn").attr("value","取消选择");
					$("input[name='userId']").attr('checked','checked');
				}else{
					//alert($("#chooseAllBtn").attr("value"));
					$("input[name='userId']").removeAttr('checked');
					$("#chooseAllBtn").attr("value","选择所有");
				}
			}
			function myerror(_message,_url,_line)
		    {
		       alert("错误信息：" + _message
		            +"\n错误的URI：" + _url
		            +"\n错误的行数：" + _line
		       );
		 
		       return true; //屏蔽系统的事件
		    }
    //绑定错误事件
    window.onerror = myerror;
</script>
<body>
	<div class="listWrap">
		<table id="ManagerInfoList" width="100%" border="0" cellpadding="0"
			cellspacing="0">
			<tr>
				<th width="40px">选择</th>
				<th>姓名</th>
				<th>性别</th>
				<th>用户名</th>
				<th>密码</th>
				<th>手机号</th>
				<th>座机号</th>
				<th>邮箱</th>
				<th>积分</th>
				<th>会员的等级</th>
				<th>注册日期</th>
				<th width="60px">操作</th>
			</tr>
			<s:if test="#session.users!=null">
				<s:iterator value="#session.users">
					<tr id="userAllInfo<s:property value='id'/>">
						<td class="left"><input type="checkbox" value="<s:property value='id'/>" name="userId"></input>
						</td>
						<td><s:property value="realName" />
						</td>
						<td><s:property value="sex" />
						</td>
						<td><s:property value="userName" />
						</td>
						<td><s:property value="password" />
						</td>
						<td><s:property value="phone" />
						</td>
						<td><s:property value="telphone" />
						</td>
						<td><s:property value="email" />
						</td>
						<td><s:property value="integration" />
						</td>
						<td><s:property value="level" />
						</td>
						<td><s:property value="registerDate" />
						</td>
						<td><a href="useranduserDetail?user.id=<s:property value='id'/>">详情</a>
						</td>
						</td>
					</tr>
				</s:iterator>
			</s:if>

		</table>

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
<script type="text/javascript">

$(function(){		
	$("#ManagerInfoList").colResizable({
		liveDrag:true, 
		gripInnerHtml:"<div class='grip'></div>", 
		draggingClass:"dragging", 
		onResize:null
	});
});
function deleteBatch(){
		var ids="-1";
		var i=0;
		$("input:checked").each(
			function(){
				ids+=","+this.value;
			}
		);				
		
		$.post("useranddeleteUsers", {"ids":ids},
			   function(data){
			   	 var arr=new Array();
					$.each(data, function(i, item) {
						arr.push(item);					           
					});					
					if(arr[0]){//true时表示操作成功，更改界面元素状态								
						/*$("input:checked").each(
						function(){
								$("#userAllInfo"+this.value).empty().hide();
							}
						);	*/
						document.location=document.location;
					}
					alert(arr[1]);		
		 },'json');
}
</script>
	<!-- 代码部分end -->
</body>
</html>
