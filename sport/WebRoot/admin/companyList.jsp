<%@ page language="java" import="java.util.*"
	contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
			basePath+="admin/";
%>
<!DOCTYPE html >
<html>
<head>
<base ref="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>左右布局滑动切换Tab选项卡</title>
<script type="text/javascript" src="../res/js/jquery-1.8.3.min.js"></script>
<!-- 引入分页下标 -->
<link href="../res/commonComponents/resizeTable/css/dividePage.css"
	rel="stylesheet" type="text/css" />
<!-- 引入控件美化组件 -->
<link href="../res/css/component.css" type="text/css" rel="stylesheet" />
<link href="../res/admin/css/companyList.css" type="text/css"
	rel="stylesheet" />
<!-- 引入弹出框组件 -->
<link rel="stylesheet" type="text/css"
	href="../res/commonComponents/popDialog/css/xcConfirm.css" />
<script src="../res/commonComponents/popDialog/js/xcConfirm.js"
	type="text/javascript" charset="utf-8"></script>

</head>
<script type="text/javascript">
/*function myerror(_message,_url,_line)
		    {
		       alert("错误信息：" + _message
		            +"\n错误的URI：" + _url
		            +"\n错误的行数：" + _line
		       );
		 
		       return true; //屏蔽系统的事件
		    }
    //绑定错误事件
    window.onerror = myerror;*/
	//批量选择进行操作
function checkedAll() {
				
	if($("#chooseAllBtn").attr("value")=="选择所有"){
		$("#chooseAllBtn").attr("value","取消选择");
		$("input[name='ids']").attr('checked','checked');
	}else{
		//alert($("#chooseAllBtn").attr("value"));
		$("input[name='ids']").removeAttr('checked');
		$("#chooseAllBtn").attr("value","选择所有");
	}
}

function operateNoReturn(operate,id){
	cancelFlag=false;
	if(operate=="companyanddeleteCompany")
	{
		var txt=  "确定要注销该公司所有信息？";
		var option = {
			title: "提示：",
			btn: parseInt("0011",2),
			onOk: function(){				
					$.post(operate,
					 	{ "company.id":id },
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
							//document.location=document.location;
					},'json'); 						
			},
			onCancel:function(){
				//取消后什么也不做
			}
		}
		window.wxc.xcConfirm(txt, "custom", option);
	}
	
}

function operateNoReturn3(operate,id,flagName){	
			//状态的更改
			flag=$("#activeCompany"+id).attr("ref");
			if(flag=="true")
				flag="false";
			else
				flag="true";
		
			$.post(operate,
			 	 {
			 	 	"company.flag":flag,
			 	 	"company.id":id
			 	 },
				function(data){
					var arr=new Array();
					$.each(data, function(i, item) {
						arr.push(item);					           
					});
					if(arr[0]){//true时表示操作成功，更改界面元素状态
						
						if($("#activeCompany"+id).html()=="激活"){
							$("#activeCompany"+id).html("关闭");
							$("#activeCompany"+id).attr("ref","false");
						}else{
							$("#activeCompany"+id).html("激活");
							$("#activeCompany"+id).attr("ref","true");
						}
					}
					//提示反馈信息给用户
					window.wxc.xcConfirm(arr[1], window.wxc.xcConfirm.typeEnum.info);				
			},'json'); 	
		
}
function deleteBatch(){
		var ids="-1";
		var i=0;
		$("input:checked").each(
			function(){
				ids+=","+this.value;
			}
		);				
		$.post("companyanddeleteCompanys", {"ids":ids},
			   function(data){
			   	  var arr=new Array();
					$.each(data, function(i, item) {
						arr.push(item);					           
					});
					
					if(arr[0]){//true时表示操作成功，更改界面元素状态								
						//$("#discountAllInfo"+discountId).remove();
						document.location=document.location;
					}else{
						alert(arr[1]);
					}	
			   },'json');
}		
	
</script>
<body>
	<s:url  var="searchUrl" value="companyandcompanyList" includeParams="none">
		<s:param name="company.companyName" value="company.companyName"/>
	</s:url>
	
	<!-- 公司搜索部分 -->
	<div class="companySearchWrap">
		<div class="searchFormWrap">
			<form name="searchForm" method="post" action="companyandcompanyList">	
				<input  name="company.companyName"  >
				<input type="submit" class="button blue middle" value="搜索">
			</form>			 
		</div>
	</div>
	<!-- 公司列表部分 -->
	<div class="companyListWrap">
		<div class="companyTypePath">
			<span>
				<s:if test="condition!=null">
					&raquo;&nbsp;满足搜索要求的加盟公司					
				</s:if>
				<s:else>
					&raquo;&nbsp;所有加盟公司
				</s:else>				
			</span>
		</div>
		<div class="companyList">
			<s:iterator value="companys">
				<div class="item">
					<div class="companyName">
						<div class="content">
							<a href="companyandcompanyDetail?company.id=<s:property value='id'/>" >
								<div><s:property value="companyName"/></div>
							</a>
						</div>						
					</div>					
					<div class="companyInfoWrap">						
						<div class="companyImg">
							<a href="companyandcompanyDetail?company.id=<s:property value='id'/>" >
								<img src="..<s:property value='logoImage.pathName'/>"/>
							</a>
						</div>						
						<div class="companyInfo">	
							<div class="infoLeft">
								<div class="phone">
									热线电话：<span class="moneyStyle"><s:property value="phone"/></span>
								</div>
								<div class="email">
									公司邮箱：<span class="contentStyle"><s:property value="email"/></span>
								</div>
								<div class="address">
									地址：<span class="contentStyle">
									<s:property value="address.parentAddress.parentAddress.addressName"/>>
									<s:property value="address.parentAddress.addressName"/>>
									<s:property value="address.addressName"/>&nbsp;&nbsp;
									<s:property value="addressDetail"/>
									</span>
								</div>
								<div class="managerName">
									超级管理员：<span class="contentStyle">
										<s:if test="managers==null||(managers.size()<1)">
											暂无
										</s:if>
										<s:else>
											<s:property value="managers[0].realName"/>
										</s:else>
									</span>
								</div>
								<div class="address">
									管理员电话：<span class="contentStyle">
										<s:if test="managers==null||(managers.size()<1)">
											暂无
										</s:if>
										<s:else>
											<s:property value="managers[0].phone"/>
										</s:else>
									</span>
								</div>
							</div>								
							<div class="intro">
								公司简介：
								<div class="companyDetail">
									<p><s:property escapeHtml="false" value='introduction'/>
									
									</p>
								</div>
							</div>
						</div>								
					</div>
					<div class="companyOperate">
							
							<span class="chooseBox"><input type="checkbox" name="ids" value="<s:property value='id'/>"/></span>
							<div class="detailInfo">
							<span >
								<a href="..<s:property value='proofFile.pathName'/>"
									class="button blue middle" >下载凭证</a>&nbsp;&nbsp;
								<s:if test="flag">
									<a id="activeCompany<s:property value='id'/>"
										 ref="<s:property value='flag'/>" 
										 href="javascript:operateNoReturn3('companyandactiveCompany',<s:property value='id'/>,'company.flag');"
									class="button blue middle" >关闭</a>&nbsp;&nbsp;
								</s:if>
								<s:else>
									<a id="activeCompany<s:property value='id'/>"
										 ref="<s:property value='flag'/>" 
								 		href="javascript:operateNoReturn3('companyandactiveCompany',<s:property value='id'/>,'company.flag');"
									class="button blue middle" >激活</a>&nbsp;&nbsp;
								</s:else>
								<a href="companyandcompanyDetail?company.id=<s:property value='id'/>"
									class="button blue middle" >详情</a>&nbsp;&nbsp;
								<a href="orderandorderList?order.company.id=<s:property value='id'/>"
									class="button blue middle" >管理订单</a>&nbsp;&nbsp;
								<a href="acountandacountList?acount.clearFlag=1&acount.acountType=3&acount.company.id=<s:property value='id'/>"
									class="button blue middle" >财务管理</a>&nbsp;&nbsp;
								<a href="javascript:operateNoReturn('companyanddeleteCompany',<s:property value='id'/>)"
									class="button blue middle" >删除</a>&nbsp;&nbsp;
							</span>	
						</div>					
					</div>
				</div>				
			</s:iterator>
			
		</div>
	</div>
	<!-- 分页选择部分 -->
	<div class="pageProducts">
		<div class="pagination">
			<s:if test="page!=null&&(page.totalPageNumber>0)">
			<ul>
				<li><input id="chooseAllBtn" type="button"
					class="button blue middle" value="选择所有" onclick="checkedAll();">
				</li>
				<li><input type="button" class="button blue middle" id="deleteSelectedBtn" onclick="deleteBatch();"
					value="删除选中">
				</li>
				<!-- 如果当前页是第一页 -->
				<s:if test="page.pageNumber<=1">
					<li class="disablepage">首页</li>
					<li class="disablepage">上一页</li>
				</s:if>
				<!-- 否则 -->
				<s:else>
					<li><s:a
						href="%{searchUrl}&page.pageNumber=1">首页</s:a>

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
	
</body>
</html>
