<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>财务记账</title>
				<script src="js/jquery-1.9.1.min.js"></script>
		<script src="res/js/jquery.min.js" type="text/javascript"></script>
		<script type="text/javascript" src="res/js/jQuery-jcDate.js" charset="utf-8"></script>
		<script src="res/js/finance.js" type="text/javascript" charset="UTF-8"></script>
		
		<link rel="stylesheet" type="text/css" href="res/css/jcDate.css" media="all" />
		<link rel="stylesheet" type="text/css" href="res/css/finance.css" charset="UTF-8" />
		<link href="../res/css/component.css"
	rel="stylesheet" type="text/css" />
	<link href="../res/commonComponents/resizeTable/css/dividePage.css"
	rel="stylesheet" type="text/css" />
	</head>
	<body>
	<s:url var="searchUrl" value="acountandacountList" includeParams="none">
			<s:param name="page.pageSize" value="page.pageSize" />
			<!-- 保证至少有一个参数，这样就会有一个？号 -->
	</s:url>
		<div class="finance-mainbody">
			<div class="finance-title">
				<h2>享动平台时间段：
						<input class="jcDate " name="beginDate" value="<s:date name='acount.acountBeginDate' format='yyyy-MM-dd'/>"
						 style="width:120px; height:20px; line-height:20px; padding:4px;" />
						&sim;
						<input class="jcDate " name="endDate"  value="<s:date name='acount.acountEndDate' format='yyyy-MM-dd'/>"
						 style="width:120px; height:20px; line-height:20px; padding:4px;" />
					&nbsp;的账单
					&nbsp;<a href="javascript:void(0);"  class="blue button" style="width:60px;height:25px;font-size:16px;line-height:25px;" 
						id="lookBtn" baseUrl="<s:property value='searchUrl'/>">查询</a>
				</h2>
				<shiro:hasPermission name="acount:*">
				<s:if test="acount.company.id>0">
				</s:if>
				<s:elseif test="acount.site.id>0">
				</s:elseif>
				<s:elseif test="acount.coach.id>0">
				</s:elseif>
				<s:else>
				<!-- 选择某个城市的公司账单 -->
				<div class="address" style="margin-top:20px;text-align:left;margin:20px 0;">
					<s:if test="acount.address==null">
						<s:a  class="addressItem" addressId="-1" style="color:red;" href="javascript:void(0);">不限地区</s:a>&nbsp;&nbsp;&nbsp;&nbsp;
					</s:if>
					<s:else>
						<s:a class="addressItem" addressId="-1"  href="%{searchUrl}&acount.address.id=-1">不限地区</s:a>&nbsp;&nbsp;&nbsp;&nbsp;
					</s:else>
					<s:iterator value="cityAddrs">
						<s:if test="acount.address.id==id">
							<s:a class="addressItem" addressId="%{id}" style="color:red;" href="javascript:void(0);"><s:property value='addressName'/></s:a>
						</s:if>
						<s:else>
							<s:a class="addressItem" addressId="%{id}" href="%{searchUrl}&acount.address.id=%{id}"><s:property value='addressName'/></s:a>
						</s:else>
						&nbsp;&nbsp;&nbsp;&nbsp;
					</s:iterator>
				</div>
				<!-- 结束  -->
				</s:else>
				</shiro:hasPermission>
				<div style="clear:both;"></div>
				<i>共- <b class="finance-title-allrecord"><s:property value='page.totalItemNumber'/></b> -条记录 
					&nbsp;<s:property value='page.pageNumber'/>/<s:property value='page.totalPageNumber'/>页
				</i>
				<div class="finance-select-financetype">
					<ul>
						<s:if test="acount.site.id>0">
							<a href="javascript:void(0);">
								<s:if test="acount.acountType==2">
									<input type="radio" name="acountType" id="allfinance" value="2" checked="checked" /> 
								</s:if>
								<s:else>
									<input type="radio" name="acountType" id="allfinance" value="2" /> 
								</s:else>
								<label for="allfinance">场馆</label>
							</a></li>
						</s:if>
						<s:elseif test="acount.coach.id>0">
							<li><a href="javascript:void(0);">
								<s:if test="acount.acountType==1">
									<input type="radio" name="acountType" id="coachfinance" checked="checked" value="1"/>
								</s:if>
								<s:else>
									<input type="radio" name="acountType" id="coachfinance" value="1"/>
								</s:else>
								<label for="coachfinance">教练</label>
							</a></li>
						</s:elseif>
						<s:elseif test="acount.company.id>0">
							<li><a href="javascript:void(0);">
								<s:if test="acount.acountType==3">
									<input type="radio" name="acountType" id="sportfinance" checked="checked" value="3"/>
								</s:if>
								<s:else>
									<input type="radio" name="acountType" id="sportfinance" value="3"/>
								</s:else>
								<label for="sportfinance">公司</label>
							</a></li>
						</s:elseif>
						<s:else>
							<li><a href="javascript:void(0);">
								<s:if test="acount.acountType==2">
									<input type="radio" name="acountType" id="allfinance" value="2" checked="checked" /> 
								</s:if>
								<s:else>
									<input type="radio" name="acountType" id="allfinance" value="2" /> 
								</s:else>
								<label for="allfinance">场馆</label>
							</a></li>
							<li><a href="javascript:void(0);">
								<s:if test="acount.acountType==1">
									<input type="radio" name="acountType" id="coachfinance" checked="checked" value="1"/>
								</s:if>
								<s:else>
									<input type="radio" name="acountType" id="coachfinance" value="1"/>
								</s:else>
								<label for="coachfinance">教练</label>
							</a></li>
							<li><a href="javascript:void(0);">
								<s:if test="acount.acountType==3">
									<input type="radio" name="acountType" id="sportfinance" checked="checked" value="3"/>
								</s:if>
								<s:else>
									<input type="radio" name="acountType" id="sportfinance" value="3"/>
								</s:else>
								<label for="sportfinance">公司</label>
							</a></li>
						</s:else>						
					</ul>
				</div>
				<!-- 
				<div class="finance-search">
					<input class="finance-search-button" type="button" name="searchBtn"
						 baseUrl="<s:property value='searchUrl'/>" value="搜索" />
					<input class="finance-search-input" type="text" name="searchKey" placeholder="     Search" />
				</div>
				 -->
			</div>
			<div class="clearfix"></div>
			<div>
				<table class="finance-table"cellspacing="0">
					<thead>							
							<td class="finance-thead-type">类型</td>
							<td class="finance-thead-name" id="acountTypeName">名</td>
							<td class="finance-thead-date"> 订单最近结算时间</td>
							<td class="finance-thead-date"> 订单开始时间</td>
							<td class="finance-thead-date"> 订单结束时间</td>
							<td class="finance-thead-value">已结算金额</td>
							<td class="finance-thead-value">可结算金额</td>
							<td class="finance-thead-date"> 是否已结算</td>
							<td class="finance-thead-operate">操作</td>
						</tr>
					</thead>
					<tbody>
						<s:iterator value="acounts">
						<tr>
							<s:if test="acountType==2">
								<td class="finance-tbody-type">场馆</td>
								<td class="finance-tbody-name">
									<div><s:property value='site.siteName'/></div>
								</td>
							</s:if>
							<s:elseif test="acountType==1">
								<td class="finance-tbody-type">教练</td>
								<td class="finance-tbody-name">
									<div><s:property value='coach.realName'/></div>
								</td>
							</s:elseif>
							<s:elseif test="acountType=3">
								<td class="finance-tbody-type">公司</td>
								<td class="finance-tbody-name">
									<div><s:property value='company.companyName'/></div>
								</td>
							</s:elseif>
							<td class="finance-date"> <div>
								<s:date name='latestAcount.beginDate' format="yyyy-MM-dd"/>
								<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;至<br>
								<s:date name='latestAcount.endDate' format="yyyy-MM-dd"/>
							</div></td>
							<td class="finance-date"> <div><s:date name='beginDate' format="yyyy-MM-dd"/></div></td>
							<td class="finance-date"> <div><s:date name='endDate' format="yyyy-MM-dd"/></div></td>
							<td class="finance-tbody-value">&yen;<s:property value='payedTotalFee'/></td>
							<td class="finance-tbody-value">&yen;<s:property value='totalFee'/></td>
							<td class="finance-date"> <div>
								<s:if test="status==1">
									未结算
								</s:if>
								<s:elseif test="status==2">
									已结算
								</s:elseif>
								<s:else>
									无需结算
								</s:else>
							</div></td>
							
							<s:if test="status==1&&(beginDate!=null)&&(endDate!=null)">
								<td class="finance-tbody-operate">&nbsp;
									<shiro:hasPermission name="acount:*">
									<a href="javascript:void(0);"
										class="ensureBtn" 
										payedDate="<s:property value='payedDate'/>"
										beginDate="<s:property value='beginDate'/>"
										endDate="<s:property value='endDate'/>"
										totalFee="<s:property value='totalFee'/>"
										coachId="<s:property value='coach.id'/>"
										companyId="<s:property value='company.id'/>"
										siteId="<s:property value='site.id'/>"
									>结算</a>&emsp;
									</shiro:hasPermission>
									<a  href="javascript:void(0);"
										class="detailBtn"
										baseUrl="acountandacountItemList?page.pageSize=<s:property value='page.pageSize'/>"
										payedDate="<s:property value='payedDate'/>"
										beginDate="<s:property value='beginDate'/>"
										endDate="<s:property value='endDate'/>"
										totalFee="<s:property value='totalFee'/>"
										coachId="<s:property value='coach.id'/>"
										companyId="<s:property value='company.id'/>"
										siteId="<s:property value='site.id'/>"
									>明细</a>
								
							</s:if>
							<s:else>
								<td class="finance-tbody-operate">&nbsp;
									<a  href="javascript:void(0);"
										class="detailBtn"
										baseUrl="acountandacountItemList?page.pageSize=<s:property value='page.pageSize'/>"
										payedDate="<s:property value='payedDate'/>"
										beginDate="<s:property value='beginDate'/>"
										endDate="<s:property value='endDate'/>"
										totalFee="<s:property value='totalFee'/>"
										coachId="<s:property value='coach.id'/>"
										companyId="<s:property value='company.id'/>"
										siteId="<s:property value='site.id'/>"
									>明细</a>
								
							</s:else>
							<shiro:hasPermission name="acount:*">
							<s:if test="acount.company.id>0">
							</s:if>
							<s:elseif test="acount.site.id>0">
							</s:elseif>
							<s:elseif test="acount.coach.id>0">
							</s:elseif>
							<s:else>
								<s:if test="id>0">
									<a href="javascript:void(0);" class="deleteBtn" acountId="<s:property value='id'/>">
										删除
									</a>
								</s:if>
							</s:else>
							</shiro:hasPermission>
							</td>
						</tr>
						</s:iterator>						
					</tbody>
				</table>
			</div>
			<s:if test="page!=null&&(page.totalPageNumber>0)">
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
	</s:if>
			<div class="finance-footer">
				<a href="admin/acountanddownloadAcountList">
				<input type="button"  value="导出Excel" /></a>
				<!-- 
				<p>可结算金额：&ensp;<r>1024.00</r>&ensp;元</p>
				<p>已结算总金额：&ensp;<r>1024.00</r>&ensp;元</p>
				 -->
			</div>
			<div class="clearfix"></div>
		</div>
<script type="text/javascript">
	$(function(){
		var typeNameArr=["","教练","场馆","公司"];
		var typeName=$("input[name=acountType]:checked").val();
		$("#acountTypeName").prepend(typeNameArr[typeName]);
		$("#lookBtn").click(function(){
			var baseUrl=$(this).attr("baseUrl");
			var typeId=$("input[name=acountType]:checked").val();
			var addressId=-1;
			$(".addressItem").each(function(index){
				if($(this).attr("href")=="javascript:void(0);"){
					addressId=$(this).attr("addressId");
				}
			});
			var beginDate=$("input[name=beginDate]").val();
			var endDate=$("input[name=endDate]").val();
			if(typeId!=undefined)
				baseUrl+="&acount.acountType="+typeId;
			if(addressId!=undefined)
			baseUrl+="&acount.address.id="+addressId;
			if(beginDate!=undefined&&(beginDate!=""))
			baseUrl+="&acount.acountBeginDate="+beginDate;
			if(endDate!=undefined&&(endDate!=""))
			baseUrl+="&acount.acountEndDate="+endDate;
			//alert(baseUrl);
			document.location=baseUrl;
		});//ensureAcount
		$(".ensureBtn").click(function(){
			if(!confirm("此操作表示您已经将营业额结算给场馆、教练或平台加盟商了，确定已经结算了？"))
				return;
			var payedDate=$(this).attr("payedDate");
			var beginDate=$(this).attr("beginDate");
			var endDate=$(this).attr("endDate");
			var totalFee=$(this).attr("totalFee");
			var coachId=$(this).attr("coachId");
			var companyId=$(this).attr("companyId");
			var siteId=$(this).attr("siteId");
			var jsonStr="{";
			if(payedDate!=undefined&&(payedDate!=""))
				jsonStr+="\"acount.payedDate\":\""+payedDate+"\",";
			if(beginDate!=undefined&&(beginDate!=""))
				jsonStr+="\"acount.beginDate\":\""+beginDate+"\",";
			if(endDate!=undefined&&(endDate!=""))
				jsonStr+="\"acount.endDate\":\""+endDate+"\",";
			if(totalFee!=undefined&&(totalFee!=""))
				jsonStr+="\"acount.totalFee\":\""+totalFee+"\",";
			if(coachId!=undefined&&(coachId!=""))
				jsonStr+="\"acount.coach.id\":\""+coachId+"\"";
			if(companyId!=undefined&&(companyId!=""))
				jsonStr+="\"acount.company.id\":\""+companyId+"\"";
			if(siteId!=undefined&&(siteId!=""))
				jsonStr+="\"acount.site.id\":\""+siteId+"\"";
			jsonStr+="}";
			//alert(jsonStr);
		//	return;
			var json=JSON.parse(jsonStr);
			$.post("acountandensureAcount", json,function(data){
			   		var arr=new Array();
					$.each(data, function(i, item) {
						arr.push(item);					           
					});					
					if(arr[0]){//true时表示操作成功，更改界面元素状态							
						alert("确定已结算成功！");
						document.location=document.location;
					}else{
						alert(arr[1]);	
					}	
		 	},'json'); 
		});
		//查看明细
		$(".detailBtn").click(function(){
			var baseUrl=$(this).attr("baseUrl");			
			var beginDate=$(this).attr("beginDate");
			var endDate=$(this).attr("endDate");			
			var coachId=$(this).attr("coachId");
			var companyId=$(this).attr("companyId");
			var siteId=$(this).attr("siteId");
			var typeId=$("input[name=acountType]:checked").val();
			if(typeId!=undefined){
				if(typeId=="1")
					baseUrl+="&acount.coach.id="+coachId;
				else if(typeId=="2")
					baseUrl+="&acount.site.id="+siteId;
				else
					baseUrl+="&acount.company.id="+companyId;
			}
			if(beginDate!=undefined&&(beginDate!="")){
				baseUrl+="&acount.acountBeginDate="+beginDate;
				//baseUrl+="&acount.acountBeginDate="+beginDate;
			}
			if(endDate!=undefined&&(endDate!="")){
				baseUrl+="&acount.acountEndDate="+endDate;
				//baseUrl+="&acount.acountEndDate="+endDate;
			}
			//alert(baseUrl);
			//return;
			document.location=baseUrl;
		});
		$(".deleteBtn").click(function(){
			if(!confirm("删除是不可恢复的，确定要删除？"))
				return;
			var acountId=$(this).attr("acountId");
			$.post("acountanddeleteAcount", {"acount.id":acountId},function(data){
			   		var arr=new Array();
					$.each(data, function(i, item) {
						arr.push(item);					           
					});					
					if(arr[0]){//true时表示操作成功，更改界面元素状态							
						alert("删除账单成功！");
						document.location=document.location;
					}else{
						alert(arr[1]);	
					}	
		 	},'json'); 
		});
		//简单搜索功能暂时不提供
		$("input[name=searchBtn]").click(function(){
			var typeId=$("input[name=acountType]:checked").val();
			var searchKey=$("input[name=searchKey]").val();			
			var baseUrl=$(this).attr("baseUrl");			
			if(searchKey!=undefined&&(searchKey!=""))
				baseUrl+="&acount.searchKey="+searchKey;
			if(typeId!=undefined)
				baseUrl+="&acount.acountType="+typeId;
			//清空其它条件
			
			alert(baseUrl);
			document.location=baseUrl;
		});
	});
</script>
	</body>
</html>