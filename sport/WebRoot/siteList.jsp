<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
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
a{color:#333;text-decoration:none;margin:10px;}
a:hover{ color:#ff3b2e;}

</style>
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
						$("input:checked").each(function(){
								$("#siteAllInfo"+this.value).empty().hide();
								$("#siteAllInfoAddr"+this.value).empty().hide();
							});	
					}else{
						alert(arr[1]);		
					}
		 },'json');
}
</script>
   </head>
  <body>
  	<s:if test="sites!=null">
  	<s:iterator value="sites">
  		<table style="width:90%;">
			<tr id="siteAllInfo<s:property value='id'/>">
				<td rowspan="2" style="width: 20px; " ><input type="checkbox" value="<s:property value='id'/>" name="siteId"></td>
				<td rowspan="2" style="width:200px;text-align:center;"> <img src="..<s:property value='images[0].pathName'/>" style="max-width:200px;height:60px;margin:0 auto;"  /></td>
				<td style="width: 80px">场馆名：</td>
				<td style="width: 100px"><s:property value='siteName'/></td>
				<td style="width: 80px">热线电话</td>
				<td style="width: 100px"><s:property value='sitePhone'/></td>
				<td><a href="siteandsiteDetail?site.id=<s:property value='id'/>">详情</a>
					<a href="placeProductandtoAddProduct?site.id=<s:property value='id'/>">添加场地类型</a>
					<a href="siteanddeleteSite?site.id=<s:property value='id'/>">删除</a></td>
			</tr>
			<tr id="siteAllInfoAddr<s:property value='id'/>" style="background: #eee;">
				<td >场馆地址：</td><td colspan="4" ><s:property value='siteAddress'/></td>
			</tr>
		</table>
	</s:iterator>
	</s:if>	 
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
					<li><a href="coachandcoachList?page.pageNumber=1">首页</a>
					</li>
					<li><a
						href="coachandcoachList?page.pageNumber=<s:property value='page.pageNumber-1'/>">上一页</a>
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
								href="coachandcoachList?page.pageNumber=<s:property/>">
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
									href="coachandcoachList?page.pageNumber=<s:property/>">
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
									href="coachandcoachList?page.pageNumber=<s:property/>">
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
									href="coachandcoachList?page.pageNumber=<s:property/>">
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
		
				<s:else>
					<li class="nextpage"><a
						href="coachandcoachList?page.pageNumber=<s:property value='page.pageNumber+1'/>">下一页</a>
					</li>
					<li class="nextpage"><a
						href="coachandcoachList?page.pageNumber=<s:property value='page.totalPageNumber'/>">尾页</a>
					</li>
				</s:else>
			</ul>
		</div>
  </body>
  
</html>
