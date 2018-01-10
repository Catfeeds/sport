<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	basePath += "admin/";
%>
<!DOCTYPE html >
<html>
<head>
<base ref="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>产品管理</title>
<script type="text/javascript" src="../res/js/jquery-1.8.3.min.js"></script>
<!-- 引入分页下标 -->
<link href="../res/commonComponents/resizeTable/css/dividePage.css"
	rel="stylesheet" type="text/css" />
<!-- 引入控件美化组件 -->
<link href="../res/css/component.css" type="text/css" rel="stylesheet" />
<link href="../res/admin/css/productList.css" type="text/css"
	rel="stylesheet" />
<!-- 引入下拉列表组件 -->
<link href="../res/commonComponents/dropDownList/css/dropdownlist.css"
	rel="stylesheet" type="text/css">
<script src="../res/commonComponents/dropDownList/js/dropdownlist.js"></script>
<!-- 引入弹出框组件 -->
<link rel="stylesheet" type="text/css"
	href="../res/commonComponents/popDialog/css/xcConfirm.css" />
<script src="../res/commonComponents/popDialog/js/xcConfirm.js"
	type="text/javascript" charset="utf-8"></script>

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
$(function(){
	
 // 通过原生select控件创建自定义下拉框
    var ddl_picture1= createDropList("#typeRoot");
   var ddl_picture2=createDropList("#typeParent");
     function createDropList(id){
    	list=DropDownList.create({
	        select:$(id),
		        attrs:{
		            column :5,
		            width :200,					
		        }
		    });
		    return list;
    }
    //利用异步请求联动更新分类下拉列表状态
    ddl_picture1.change(function(){	    		
    	    createList2();    		
	});
	ddl_picture2.change(function(){	
    	   	typeId=ddl_picture2.val();
		if(typeId!=-1)
			document.location="placeProductandplaceProductList?product.type.id="+typeId+"&page.pageNumber=1";	
	});
	
	
	function createList2(){
			$("#parentTypeWrap").empty();
    		$("#parentTypeId").css('display','none');
    		
    		/****************创建第二个下拉列表********************/
    		var parentTypeId=ddl_picture1.val();	
    		
    		var select="<select id='typeParent'>";
    		$.post("productTypeandgetChildTypes",
		 			{ "productType.id":parentTypeId },
						function(data){
							 //解析数组,获取该类别下所有子项
					        $.each(data, function(i, item) {
					           select+="<option value='"+item.id+"'>"+item.typeName+"</option>";					           
					        });
					        select+="</select>";
					        //alert(select);
					        $("#parentTypeWrap").html(select);
					         ddl_picture2= createDropList('#typeParent');
							 $("#parentTypeId").css('display','block');
							typeId=ddl_picture2.val();
							if(typeId!=-1)
								document.location="placeProductandplaceProductList?product.type.id="+typeId+"&page.pageNumber=1";	
							 /*****************创建第三个选择列表并显示****************/	
							// alert(ddl_picture2);
							 if(ddl_picture2)						 								 						 	
							  ddl_picture2.change(function(){
							  			typeId=ddl_picture2.val();
							  			
										if(typeId!=-1)
											document.location="placeProductandplaceProductList?product.type.id="+typeId+"&page.pageNumber=1";						
								});
								
								/**************创建结束****************/
						},"json"); 	 
	}	
});

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
	if(operate=="placeProductanddeletePlaceProduct")
	{
		var txt=  "确定要删除该产品？";
		var option = {
			title: "提示：",
			btn: parseInt("0011",2),
			onOk: function(){				
					$.post(operate,
					 	{ "product.id":id },
						function(data){
							var arr=new Array();
							$.each(data, function(i, item) {
								arr.push(item);					           
							});
							if(arr[0]){//true时表示操作成功，更改界面元素状态								
								//$("#productItem"+id).empty().hide();
								document.location=document.location;
							}
							window.wxc.xcConfirm(arr[1], window.wxc.xcConfirm.typeEnum.info);													
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
		if(flagName=="product.hasTop"){
			//状态的更改
			flag=$("#topControlId"+id).attr("ref");
			if(flag=="true")
				flag="false";
			else
				flag="true";
			$.post(operate,
			 	{ "product.id":id ,
			 		"product.hasTop" :flag
			 	},
				function(data){
					var arr=new Array();
					$.each(data, function(i, item) {
						arr.push(item);					           
					});
					if(arr[0]){//true时表示操作成功，更改界面元素状态
						
						if($("#hasTopContent"+id).html()=="取消置顶"){
							$("#hasTopContent"+id).html("推荐置顶");
							$("#topControlId"+id).attr("ref","false");
						}else{
							$("#hasTopContent"+id).html("取消置顶");
							$("#topControlId"+id).attr("ref","true");
						}
					}
					//提示反馈信息给用户
					window.wxc.xcConfirm(arr[1], window.wxc.xcConfirm.typeEnum.info);				
			},'json'); 	
		}else{
			//状态的更改
			flag=$("#sellControlId"+id).attr("ref");
			if(flag=="true")
				flag="false";
			else
				flag="true";
			$.post(operate,
			 	{ "product.id":id ,
			 		"product.hasBegin" :flag
			 	},
				function(data){
					var arr=new Array();
					$.each(data, function(i, item) {
						arr.push(item);					           
					});
					if(arr[0]){//true时表示操作成功，更改界面元素状态						
						if($("#sellContent"+id).html()=="产品下架"){
							$("#sellContent"+id).html("产品上架");
							flag=$("#sellControlId"+id).attr("ref","false");
						}else{
							$("#sellContent"+id).html("产品下架");
							flag=$("#sellControlId"+id).attr("ref","true");
						}						
					}
					//提示反馈信息给用户
					window.wxc.xcConfirm(arr[1], window.wxc.xcConfirm.typeEnum.info);				
			},'json'); 	
		}
		
}	

function deleteBatch(){
		if(!confirm("删除是不可恢复的，确定要删除？"))
				return;
		var ids="-1";
		var i=0;
		$("input[name=ids]:checked").each(
			function(){
				ids+=","+this.value;
			}
		);		
		var txt=  "确定要删除您选中的产品？";
		var option = {
			title: "提示：",
			btn: parseInt("0011",2),
			onOk: function(){	//回调函数			
					$.post("placeProductanddeleteSelectedProducts",
					 	{"ids":ids},
						function(data){
							var arr=new Array();
							$.each(data, function(i, item) {
								arr.push(item);					           
							});
							if(arr[0]){//true时表示操作成功，更改界面元素状态
								/*$("input[name=ids]:checked").each(
									function(){
										$("#productItem"+this.value).empty().hide();
									}
								);	*/
								document.location=document.location;							
							}
							window.wxc.xcConfirm(arr[1], window.wxc.xcConfirm.typeEnum.info);													
					},'json'); 						
			},
			onCancel:function(){
				//取消后什么也不做
			}
		}
		window.wxc.xcConfirm(txt, "custom", option);			
}		
</script>

</head>

<body>
	<div class="addType">
		<div class="title">选择查看某分类下的产品:</div>
		<div class="productTypeLists">
			<div class="item">
				<div class="selectContent" id="typeRootWrap">
					<select id='typeRoot'>
						<option value="-1">选择分类</option>
						<s:iterator value="types">
							<s:if test="type.parentProductType.id==id">
							<option selected="selected"  value="<s:property value='id'/>">
								<s:property value="typeName" />
							</option>
							</s:if>
							<s:else>
							<option value="<s:property value='id'/>">
								<s:property value="typeName" />
							</option>
							</s:else>
														
						</s:iterator>
					</select>
				</div>
			</div>
			<div class="item" id="parentTypeId" id="typeParentWrap">
				<div class="selectContent" id="parentTypeWrap">
					<select id='typeParent'>
						<option value="-1">选择分类</option>
						<s:iterator value="type.parentProductType.childrenProductTypes">
							<s:if test="type.id==id">
							<option selected="selected"  value="<s:property value='id'/>">
								<s:property value="typeName" />
							</option>
							</s:if>
							<s:else>
							<option value="<s:property value='id'/>">
								<s:property value="typeName" />
							</option>
							</s:else>							
						</s:iterator>
					</select>
				</div>
			</div>
			<div class="item" >
				<a  class="button blue middle" id="getAllProductsBtn" 
					href="placeProductandplaceProductList?page.pageNumber=1"
					style="margin-top:5px;margin-left:20px;" >&nbsp;所有产品&nbsp;&nbsp;</a>
			</div>
			
			<div class="item" >
				<a  class="button blue middle" id="getAllProductsBtn" 
					href="placeProductandplaceProductList?page.pageNumber=1&product.hasTop=true"
					style="margin-top:5px;margin-left:20px;" >已置顶产品</a>
			</div>
			<div class="item" >
				<a  class="button blue middle" id="getAllProductsBtn" 
					href="placeProductandplaceProductList?page.pageNumber=1&product.hasBegin=true"
					style="margin-top:5px;margin-left:20px;" >已上架产品</a>
			</div>
			
			
		</div>
	</div>
	<div style="clear:both;"></div>
	<!-- 产品列表展示部分 -->
	<div class="productListWrap">
		<div class="productTypePath">
			<span>
				<s:if test="type==null||(type.parentProductType==null)">
					&raquo;&nbsp;公司所有产品
				</s:if>
				<s:else>
					&raquo;<s:property value="type.parentProductType.parentProductType.typeName"/>&nbsp;
					&gt;<s:property value="type.parentProductType.typeName"/>&nbsp;
					&gt;<s:property value="type.typeName"/>
				</s:else>				
			</span>
		</div>
		<div class="productList">
			<s:iterator value="products">
				<div id="productItem<s:property value='id'/>" class="item">
					<div class="productInfoWrap">
						<div class="productImg">
							<a href="placeProductandplaceProductDetail?product.id=<s:property value='id'/>" >
								<img src="../<s:property value='currentImage.pathName'/>"/>
							</a>
						</div>
						<div class="productBaseInfoWrap">
							<div class="productName">
								<a href="placeProductandplaceProductDetail?product.id=<s:property value='id'/>" >
									<s:property value="productName"/>
								</a>
							</div>
							<div class="typePath">分类：
								<span class="contentStyle">
									<s:property value="type.parentProductType.typeName"/>>
									<s:property value="type.typeName"/>
								</span>
							</div>
							<div class="price">
								普通价：<span class="moneyStyle"><s:property value="normalPrice"/>&yen;</span>&nbsp;
								促销价：<span class="moneyStyle"><s:property value="bargainPrice"/>&yen;</span>&nbsp;
							</div>
							<div class="stock">
								总计售出：<span class="contentStyle"><s:property value="totalSoldNumber"/>件 &nbsp;</span>
							</div>
							<div class="siteInfo">
								场馆名：<a href="siteandsiteDetail?site.id=<s:property value='site.id'/>">
									<s:property value='site.siteName'/>
								</a>&nbsp;&nbsp;
								地址：<s:property value="site.address.parentAddress.parentAddress.addressName"/>>
									<s:property value="site.address.parentAddress.addressName"/>>
									<s:property value="site.address.addressName"/>&nbsp;
									<s:property value="site.siteAddress"/>
							</div>
						</div>						
						<div class="productDetailWrap">
							<span style="width:100%;text-align:center;">产品详情：</span>
							<span class="moreInfo">
								<a href="placeProductandplaceProductDetail?product.id=<s:property value='id'/>" >
									更多&raquo;
								</a>
							</span>
							 <span
							class="productDetail">
								<s:property escapeHtml="false" value='detail'/>
							</span>							
						</div>
					</div>
					<div class="productOperate">
						<span class="chooseBox"><input type="checkbox" name="ids" value="<s:property value='id'/>"/></span>
						<span id="getQrcodeBtn">
							<a href="placeProductandplaceProductDetail?product.id=<s:property value='id'/>"
								 class="button blue middle" >查看/修改</a>&nbsp;&nbsp;
							<a href="javascript:operateNoReturn3('placeProductandtopProduct',<s:property value='id'/>,
								'product.hasTop'
								);"	ref="<s:property value='hasTop'/>" id="topControlId<s:property value='id'/>" class="button blue middle" >
								<span id="hasTopContent<s:property value='id'/>">
									<s:if test="hasTop">
										取消置顶
									</s:if>
									<s:else>
										推荐置顶
									</s:else>
								</span>
							</a>&nbsp;&nbsp;
							<a href="javascript:operateNoReturn3('placeProductanddisableProduct',<s:property value='id'/>,
							'product.hasBegin'
							);" ref="<s:property value='hasBegin'/>" id="sellControlId<s:property value='id'/>" class="button blue middle" >
								<span id="sellContent<s:property value='id'/>">
									<s:if test="hasBegin">
									产品下架
									</s:if>
									<s:else>
									产品上架
									</s:else>
								</span>								
							</a>&nbsp;&nbsp;
							<a href="javascript:operateNoReturn('placeProductanddeletePlaceProduct',<s:property value='id'/>);" 
								class="button blue middle" >删除</a>&nbsp;&nbsp;
							<a href="placeandplaceList?placeProduct.id=<s:property value='id'/>&site.id=<s:property value='site.id'/>&type.id=<s:property value='type.id'/>" class="button blue middle" >
							管理场地</a>&nbsp;&nbsp;
							<a href="commentandcommentList?comment.product.id=<s:property value='id'/>" class="button blue middle" >查看评论</a>&nbsp;&nbsp;					
						</span>						
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
				<li><input type="button" class="button blue middle" id="deleteSelectedBtn"
					onclick="deleteBatch();" value="删除选中">
				</li>
				<!-- 如果当前页是第一页 -->
				<s:if test="page.pageNumber<=1">
					<li class="disablepage">首页</li>
					<li class="disablepage">上一页</li>
				</s:if>
				<!-- 否则 -->
				<s:else>
					<li><a
						href="placeProductandplaceProductList?type.id=<s:property value='type.id'/>&page.pageNumber=1">首页</a>

					</li>
					<li><a
						href="placeProductandplaceProductList?type.id=<s:property value='type.id'/>&page.pageNumber=<s:property value='page.pageNumber-1'/>">上一页</a>
					</li>
				</s:else>
				<!-- 如果总页码小于7页，就显示全部页码 -->
				<s:if test="page.totalPageNumber<=7">
					<s:iterator begin="1" var="i" end="page.totalPageNumber">
						<s:if test="#i==page.pageNumber">
							<li class="currentpage"><s:property /></li>
						</s:if>
						<s:else>
							<li><a
								href="placeProductandplaceProductList?type.id=<s:property value='type.id'/>&page.pageNumber=<s:property/>">
									<s:property /> </a>
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
								<li><a
									href="placeProductandplaceProductList?type.id=<s:property value='type.id'/>&page.pageNumber=<s:property/>">
										<s:property /> </a>
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
								<li><a
									href="placeProductandplaceProductList?type.id=<s:property value='type.id'/>&page.pageNumber=<s:property/>">
										<s:property /> </a>
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
								<li><a
									href="placeProductandplaceProductList?type.id=<s:property value='type.id'/>&page.pageNumber=<s:property/>">
										<s:property /> </a>
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
					<li class="nextpage"><a
						href="placeProductandplaceProductList?type.id=<s:property value='type.id'/>&page.pageNumber=<s:property value='page.pageNumber+1'/>">下一页</a>
					</li>
					<li class="nextpage"><a
						href="placeProductandplaceProductList?type.id=<s:property value='type.id'/>&page.pageNumber=<s:property value='page.totalPageNumber'/>">尾页</a>
					</li>
				</s:else>
			</ul>
			</s:if>
		</div>
	</div>
</body>
</html>
