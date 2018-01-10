<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
basePath +="admin/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>场馆列表</title>
    <link href="../res/commonComponents/resizeTable/css/dividePage.css" rel="stylesheet" type="text/css" />
    		<script src="../res/commonComponents/resizeTable/js/colResizable-1.5.min.js"></script>
    		<script type="text/javascript" src="../res/js/jquery-1.8.3.min.js"></script>
     <style>
table{
	table-layout: fixed;
	text-align:left;
	border: 1px solid #666666;
}
td{
	}
.btn-a{
	color:#333;
	text-decoration:none;
	margin:5px;
	font-size:14px;
	padding:5px;
	line-height:25px;
	border-radius:5px;
	border:rgb(46,106,177) 1px solid;
}
.btn-a:hover{ color:#ff3b2e;}

</style>
   </head>
<s:url var="searchUrl" value="siteandsiteList" includeParams="none">
		<s:param name="page.pageSize" value="page.pageSize" />
		<!-- 保证至少有一个参数，这样就会有一个？号 -->
</s:url>
  <body>
  
		<div class="address" style="margin-top:20px;">
			<s:if test="site.address==null">
				<s:a style="color:red;" href="javascript:void(0);">不限地区</s:a>&nbsp;&nbsp;&nbsp;&nbsp;
			</s:if>
			<s:else>
				<s:a href="%{searchUrl}&site.address.id=-1&coach.skillType.id=%{coach.skillType.id}">不限地区</s:a>&nbsp;&nbsp;&nbsp;&nbsp;
			</s:else>
			<s:iterator value="cityAddrs">
				<s:if test="site.address.id==id">
					<s:a style="color:red;" href="javascript:void(0);"><s:property value='addressName'/></s:a>
				</s:if>
				<s:else>
					<s:a href="%{searchUrl}&site.address.id=%{id}&coach.skillType.id=%{coach.skillType.id}"><s:property value='addressName'/></s:a>
				</s:else>
				&nbsp;&nbsp;&nbsp;&nbsp;
			</s:iterator>
		</div>
  	<s:if test="sites!=null">
  	<s:iterator value="sites" status="outSt">
  		<table style="width:90%;">
			<tr id="siteAllInfo<s:property value='id'/>">
				<td rowspan="2" style="width: 20px; " ></td></td>
				<td rowspan="2" style="width:200px;text-align:center;"> <img src="..<s:property value='images[0].pathName'/>" style="max-width:200px;height:60px;margin:0 auto;"  /></td>
				<td style="width: 80px">场馆名：</td><td style="width: 100px">
					<s:property value='siteName'/></td>
				<td style="width: 80px">热线电话</td><td style="width: 100px">
					<s:property value='sitePhone'/></td>
				<td>
				<a class="btn-a" href="siteandsiteDetail?site.id=<s:property value='id'/>">详情</a>
				<a class="btn-a" href="placeProductandtoAddProduct?site.id=<s:property value='id'/>">添加场地类型</a>
				<a class="btn-a" href="addDiscount.jsp?siteId=<s:property value='id'/>">添加优惠活动</a>
															
				</td>
				
			</tr>
			
			<tr id="siteAllInfoAddr<s:property value='id'/>"  style="background: #eee;">
				<td >场馆地址：</td><td colspan="4" ><s:property value='siteAddress'/></td>	
						
			</tr>
			<shiro:hasPermission name="top:*">
			<tr >				
				<td colspan="3" style="text-align:right;">所属公司:&nbsp;&nbsp;&nbsp;</td><td colspan="4">	
					<a href="companyandcompanyDetail?company.id=<s:property value='id'/>">
					<s:property value='company.companyName'/>
				</td>		
			</tr>
			</shiro:hasPermission>
			<tr>
				<td></td>
				
				<td>
				<shiro:hasPermission name="top:*">
				推荐指数：(影响搜索排名)
				</shiro:hasPermission>
				</td>
				<td><shiro:hasPermission name="top:*">
					<select  name="siteTopValue<s:property value='id'/>">
						<s:iterator begin="0" end="10" status="st">
							<s:if test="sites[#outSt.index].topValue==#st.index">
								<option selected="selected" value="<s:property value='#st.index'/>"><s:property value='#st.index'/></option>
							</s:if>
							<s:else>
								<option value="<s:property value='#st.index'/>"><s:property value='#st.index'/></option>
							</s:else>
						</s:iterator>
					</select>
					&nbsp;&nbsp;</shiro:hasPermission>
				</td>				
				<td><shiro:hasPermission name="top:*">
					<a class="btn-a alterTopValue" style="float:left;"
						siteId="<s:property value='id'/>" href="javascript:void(0);">提交修改</a>
					</shiro:hasPermission>
				</td>
				<td></td>
				<td>									
					<a class="btn-a" style="float:left;" onclick="return confirm('删除是不可恢复的，确定要删除？')" href="siteanddeleteSite?site.id=<s:property value='id'/>">删除场馆</a>	
				</td>
				<td>
					<a class="btn-a" style="float:left;" href="orderandorderList?order.site.id=<s:property value='id'/>">管理订单</a>	
					<a class="btn-a" style="float:left;" href="acountandacountList?acount.clearFlag=1&acount.acountType=2&acount.site.id=<s:property value='id'/>">财务管理</a>	
					<a class="btn-a" style="float:left;" href="commentandcommentList?comment.site.id=<s:property value='id'/>">管理评论</a>
				</td>
			</tr>
		</table>
	</s:iterator>
	</s:if>	 
  	
<div class="pagination">
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
		</div>
  </body>
  <script type="text/javascript">
	//选择所有进行操作
function checkedAll() {
				
				if($("#chooseAllBtn").attr("value")=="选择所有"){
					$("#chooseAllBtn").attr("value","取消选择");
					$("input[name='siteId']").attr('checked','checked');
				}else{
					//alert($("#chooseAllBtn").attr("value"));
					$("input[name='siteId']").removeAttr('checked');
					$("#chooseAllBtn").attr("value","选择所有");
				}
			}
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
		
		$.post("siteanddeleteSites", {"ids":ids},function(data){
			   	 var arr=new Array();
					$.each(data, function(i, item) {
						arr.push(item);					           
					});
					
					if(arr[0]){//true时表示操作成功，更改界面元素状态							
						/*$("input:checked").each(function(){
								$("#siteAllInfo"+this.value).empty().hide();
								$("#siteAllInfoAddr"+this.value).empty().hide();
							});	*/
						document.location=document.location;
					}
					alert(arr[1]);		
		 },'json');
}

$(function(){
	$(".alterTopValue").click(function(){
		var siteId=$(this).attr("siteId");
		var topValue=$("select[name=siteTopValue"+siteId+"]").val();	
		//alert(topValue);	
		$.post("siteandtopSite", {"site.id":siteId,"site.topValue":topValue},function(data){
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
</html>
