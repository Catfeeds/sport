<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>账单明细</title>
				<script src="res/js/jquery-1.9.1.min.js"></script>
		<script src="res/js/jquery.min.js" type="text/javascript"></script>
		<script type="text/javascript" src="res/js/jQuery-jcDate.js" charset="utf-8"></script>
		<script src="res/js/finance.js" type="text/javascript" charset="UTF-8"></script>
		
		<link rel="stylesheet" type="text/css" href="res/css/jcDate.css" media="all" />
		<link rel="stylesheet" type="text/css" href="res/css/finance.css" charset="UTF-8" />
		<link href="../res/commonComponents/resizeTable/css/dividePage.css"
	rel="stylesheet" type="text/css" />
	</head>
	<body>
		<s:url var="searchUrl" value="acountandacountItemList" includeParams="none">
			<s:param name="page.pageSize" value="page.pageSize" />
			<s:param name="acount.coach.id" value="acount.coach.id" />
			<s:param name="acount.company.id" value="acount.company.id" />
			<s:param name="acount.site.id" value="acount.site.id"  />
			<!-- 保证至少有一个参数，这样就会有一个？号 -->
		</s:url>
		<div class="finance-mainbody">
			<div class="finance-title">
				<h2><s:if test="acount.coach!=null">
						教练：<s:property value='acount.coach.realName'/>
					</s:if>
					<s:elseif test="acount.site!=null">
						场馆：<s:property value='acount.site.siteName'/>
					</s:elseif>
					<s:else>
						公司:<s:property value='acount.company.companyName'/>
					</s:else>
						<s:date name="acount.acountBeginDate" format='yyyy-MM-dd'/>
						&sim;
						<s:date name="acount.acountEndDate" format='yyyy-MM-dd'/>时间段的
					账单明细
				</h2>
				<i>共- <b class="finance-title-allrecord"><s:property value='page.totalItemNumber'/></b> -条记录 &nbsp;
					<s:property value='page.pageNumber'/>/<s:property value='page.totalPageNumber'/>
				</i>
				<!-- 
				<div class="finance-search">
					<input class="finance-search-button" type="button" value="搜索" />
					<input class="finance-search-input" type="text" placeholder="     Search" />
				</div>
				 -->
			</div>
			<div class="clearfix"></div>
			<div>
				<table class="finance-table"cellspacing="0">
					<thead>
							<td class="finance-thead-No">订单编号</td>
							<td class="finance-thead-name">
								<s:if test='acount.coach!=null'>
									教练名
								</s:if>
								<s:elseif test="acount.site!=null">
									场馆名
								</s:elseif>
								<s:else>
									场馆名/教练名
								</s:else>
							</td>
							<td class="finance-thead-date">订单支付时间</td>
							<td class="finance-thead-date"> 订单总金额</td>
							<td class="finance-thead-date"> 订单状态</td>
							<td class="finance-thead-operate">查看订单</td>													
						</tr>
					</thead>
					<tbody>
						<s:iterator value='items'>
							<tr>
								<td class="finance-tbody-No"><s:property value='orderNumber'/></td>
								<td class="finance-tbody-name">
									<s:property value='ownerName'/>
								</td>
								<td class="finance-tbody-date"> <div>
									<s:date name='payTime' format="yyyy-MM-dd hh:mm:ss"/>
								</div></td>
								<td class="finance-tbody-date"> <div><s:property value='totalAcount'/></div></td>
								<td class="finance-tbody-date"> <div><s:property value='orderStatus'/></div></td>
								<td class="finance-tbody-name">
									<a href="orderandorderList?order.orderNumber=<s:property value='orderNumber'/>"/>
										订单详情
									</a>
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
				<s:if test="items!=null&&items.size()>0">
					<a href="javascript:void(0);"
						class="downloadBtn"
						baseUrl="acountanddownloadAcountItemList?page.pageSize=<s:property value='page.pageSize'/>"
						beginDate="<s:property value='acount.acountBeginDate'/>"
						endDate="<s:property value='acount.acountEndDate'/>"
						coachId="<s:property value='acount.coach.id'/>"
						companyId="<s:property value='acount.company.id'/>"
						siteId="<s:property value='acount.site.id'/>">
					<input type="button" value="导出Excel" />
					</a>
				</s:if>
				
				<p>可结算金额：&ensp;<r><s:property value='acount.payedTotalFee'/></r>&ensp;元</p>
				<p>已结算总金额：&ensp;<r><s:property value='acount.totalFee'/></r>&ensp;元</p>
			</div>
			<div class="clearfix"></div>
		</div>
		<script type="text/javascript">
			$(function(){
				//查看明细
				$(".downloadBtn").click(function(){
					var baseUrl=$(this).attr("baseUrl");			
					var beginDate=$(this).attr("beginDate");
					var endDate=$(this).attr("endDate");			
					var coachId=$(this).attr("coachId");
					var companyId=$(this).attr("companyId");
					var siteId=$(this).attr("siteId");								
					if(coachId!=undefined&&(coachId!=""))
						baseUrl+="&acount.coach.id="+coachId;
					else if(siteId!=undefined&&(siteId!=""))
						baseUrl+="&acount.site.id="+siteId;
					else
						baseUrl+="&acount.company.id="+companyId;
					
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
			});
		</script>
	</body>
</html>