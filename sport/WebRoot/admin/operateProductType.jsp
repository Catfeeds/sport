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
<title>左右布局滑动切换Tab选项卡</title>
<script type="text/javascript" src="../res/js/jquery-1.8.3.min.js"></script>
<!-- 引入控件美化组件 -->
<link href="../res/css/component.css" type="text/css" rel="stylesheet" />
<link href="../res/admin/css/operateProductType.css" type="text/css"	rel="stylesheet" />

<!-- 引入树形控件 -->
<link rel="stylesheet" type="text/css"	href="../res/commonComponents/tree/css/SimpleTree.css" />
<script type="text/javascript"	src="../res/commonComponents/tree/js/SimpleTree.js"></script>
<!-- 引入宽度可变表格 -->
<link href="../res/commonComponents/resizeTable/css/table.css"	rel="stylesheet" type="text/css" />
<script	src="../res/commonComponents/resizeTable/js/colResizable-1.5.min.js"></script>
<!-- 引入下拉列表组件 -->
<link href="../res/commonComponents/dropDownList/css/dropdownlist.css"	rel="stylesheet" type="text/css">
<script src="../res/commonComponents/dropDownList/js/dropdownlist.js"></script>
<!-- 引入弹出框组件 -->
<link rel="stylesheet" type="text/css"	href="../res/commonComponents/popDialog/css/xcConfirm.css" />	
<script src="../res/commonComponents/popDialog/js/xcConfirm.js"	type="text/javascript" charset="utf-8"></script>

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
	
	//创建分类的树形结构
	$(".st_tree").SimpleTree({	
		/* 可无视代码部分*/
		click:function(a){
			//if(!$(a).attr("hasChild"))
				//alert($(a).attr("ref"));
				//alert("修改子类");
		}
		
	});
	$(".addChildType a").click(
		function(){
			//alert("添加子类");
		}
	);
	$("li a.showChildren").click(
		function(){
			document.location=$(this).attr("href");
			
		}
	);
	//树形控件添加子类
 	$(".addTypeTreeItem").click(function(){
 					var typeName,typeIntro;
					var txt=  "请输入类别名：";
					var parentTypeId=$(this).attr('ref');
					window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.input,{
						onOk:function(v){
							typeName=v;
							txt="请输入类别简介：";
							window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.input,{
								onOk:function(v){
									typeIntro=v;
									addProduct(parentTypeId,typeName,typeIntro);																
								}
							});
						}
					});
	});
	//发出异步请求添加产品类型
	function addProduct(parentTypeId,typeName,typeIntro){
					$.post("productTypeandaddProductType",
		 				{ "parentType.id":parentTypeId ,
		 					"productType.typeName": typeName.trim(),
		 					"productType.introduction":typeIntro.trim() },
							function(data){
								 var arr=new Array();
								$.each(data, function(i, item) {
									arr.push(item);					           
								});
								
								if(arr[0]){//true时表示操作成功，更改界面元素状态								
									document.location=ducument.location;
								}
								alert(arr[1]);	
							},'json');
	}
	
});

	//批量选择进行操作
			function checkedAll() {
				
				if($("#chooseAllBtn").attr("value")=="选择所有"){
					$("#chooseAllBtn").attr("value","取消选择");
					$("input[name='managerId']").attr('checked','checked');
				}else{
					//alert($("#chooseAllBtn").attr("value"));
					$("input[name='managerId']").removeAttr('checked');
					$("#chooseAllBtn").attr("value","选择所有");
				}
			}
function deleteProductType(id){
	if(!confirm("删除是不可恢复的，确定要删除？"))
				return;
	$.post("productTypeanddeleteProductType", {"productType.id":id},
			   function(data){
			   	 	var arr=new Array();
					$.each(data, function(i, item) {
						arr.push(item);					           
					});								
					if(arr[0]){//true时表示操作成功，更改界面元素状态								
						//$("#type"+id).empty().hide();		
						document.location=document.location;	
					}
					alert(arr[1]);	
			   },'json');
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
		$.post("productTypeanddeleteTypes", {"ids":ids},
			   function(data){
			   	 	var arr=new Array();
					$.each(data, function(i, item) {
						arr.push(item);					           
					});								
					if(arr[0]){//true时表示操作成功，更改界面元素状态								
						/*$("input:checked").each(
						function(){
								$("#type"+this.value).empty().hide();
							}
						);*/
						document.location=document.location;				
					}
					alert(arr[1]);	
			   },'json');
}		
			
</script>

</head>

<body>

	<div class="addType">
		<div class="title">类别管理</div>
	</div>
<div style="clear:both;"></div>
	<div class="st_tree">
		<ul>
			
			<li class="addChildType"><a  class="addTypeTreeItem" href="javascript:void(0);" class="leafType" ref="-1"
				>添加新根类别</a>
			</li>
			<s:iterator value="rootTypes">
				<li>
					<a href="productTypeandproductTypes?productType.id=<s:property value='id'/>" class="showChildren">
						<s:property value='typeName'/>					
					</a>
				</li>
				<s:if test="childrenProductTypes!=null">
					<s:if test="id==productType.id||(productType.parentProductType.id==id)">
						<ul show="true">
					</s:if>
					<s:else>
						<ul show="false">
					</s:else>					
						<li class="addChildType"><a  class="addTypeTreeItem" href="javascript:void(0);" ref="<s:property value='id'/>">添加子类</a>
						<s:iterator value="childrenProductTypes">
							<li>
								<a href="productTypeandproductTypes?productType.id=<s:property value='id'/>" class="showChildren">
									<s:property value='typeName'/>					
								</a>
							</li>
							<s:if test="childrenProductTypes!=null">
								<s:if test="id==productType.id||(productType.parentProductType.id==id)">
									<ul show="true" onload="$(this).parents('ul').attr('show','true');">
								</s:if>
								<s:else>
									<ul show="false">
								</s:else>
								<!-- <li class="addChildType">
								<a  class="addTypeTreeItem" href="javascript:void(0);" ref="<s:property value='id'/>">
								添加子类</a></li> -->
								<s:iterator value="childrenProductTypes">
									<li>
										<a href="detail" ref="xtgl">
											<s:property value='typeName'/>					
										</a>
									</li>
								</s:iterator>								
								</ul>
							</s:if>
						</s:iterator>
					</ul>
				</s:if>
				
			</s:iterator>
			<li>
				<a href="productTypeandproductTypes?productType.id=-1" class="showChildren">
					查看所有根类别					
				</a>
			</li>
		</ul>
	</div>
	<div class="productTypeDetail">
		<div class="typePath">			
				&gt;&gt;<s:property value="productType.typeName"/>	<br>	<br>	
		</div>
		<table id="ManagerInfoList" width="100%" border="0" cellpadding="0"
			cellspacing="0">
			<tr>
				<th width="40px">选择</th>
				<th>类别名</th>
				<th>类别简介</th>

				<th width="200px">操作</th>
			</tr>
			<s:if test="types!=null">
				<s:iterator value="types" var="type">
					<tr id="type<s:property value='id'/>">
						<td class="left"><input type="checkbox" value="<s:property value='id'/>" name="managerId"></input>
						</td>
						<td><s:property value="typeName" /></td>
						<td><s:property value="introduction" /></td>
						<td><a class="button blue" style="height:20px; width:40px;"
							href="javascript:deleteProductType(<s:property value='id'/>);">删除</a>
							<a class="button blue" style="height:20px; width:40px;"
							href="productTypeandalterProductType?productType.id=<s:property value='id'/>">修改</a>
						</td>
						</td>
					</tr>
				</s:iterator>
			</s:if>

		</table>

		<div class="pagination">
			<ul>
				<li><input id="chooseAllBtn" type="button"
					class="button blue middle" value="选择所有" onclick="checkedAll();">
				</li>
				<li><input type="button" class="button blue middle" onclick="deleteBatch();"
					value="删除选中">
				</li>
				<!-- 如果当前页是第一页 -->
				<s:if test="page.pageNumber<=1">
					<li class="disablepage">首页</li>
					<li class="disablepage">上一页</li>
				</s:if>
				<!-- 否则 -->
				<s:else>
					<li><a href="productTypeandproductTypes?productType.id=<s:property value='productType.id'/>&page.pageNumber=1">首页</a>

					</li>
					<li><a
						href="productTypeandproductTypes?productType.id=<s:property value='productType.id'/>&page.pageNumber=<s:property value='page.pageNumber-1'/>">上一页</a>
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
								href="productTypeandproductTypes?productType.id=<s:property value='productType.id'/>&page.pageNumber=<s:property/>">
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
									href="productTypeandproductTypes?productType.id=<s:property value='productType.id'/>&page.pageNumber=<s:property/>">
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
									href="productTypeandproductTypes?productType.id=<s:property value='productType.id'/>&page.pageNumber=<s:property/>">
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
									href="productTypeandproductTypes?productType.id=<s:property value='productType.id'/>&page.pageNumber=<s:property/>">
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
						href="productTypeandproductTypes?productType.id=<s:property value='productType.id'/>&page.pageNumber=<s:property value='page.pageNumber+1'/>">下一页</a>
					</li>
					<li class="nextpage"><a
						href="productTypeandproductTypes?productType.id=<s:property value='productType.id'/>&page.pageNumber=<s:property value='page.totalPageNumber'/>">尾页</a>
					</li>
				</s:else>
			</ul>
		</div>
	</div>

	</div>
	
	<script>
		$(function(){		
	$("#ManagerInfoList").colResizable({
		liveDrag:true, 
		gripInnerHtml:"<div class='grip'></div>", 
		draggingClass:"dragging", 
		onResize:null
	});
});
	</script>
	<!-- 代码部分end -->
</body>
</html>
