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
<title>操作产品级别</title>
<script type="text/javascript" src="../res/js/jquery-1.8.3.min.js"></script>
<!-- 引入分页下标 -->
<link href="../res/commonComponents/resizeTable/css/dividePage.css"
	rel="stylesheet" type="text/css" />
<link href="../res/commonComponents/resizeTable/css/table.css"
	rel="stylesheet" type="text/css" />
<!-- 引入控件美化组件 -->
<link href="../res/css/component.css" type="text/css" rel="stylesheet" />
<link href="../res/admin/css/levelList.css" type="text/css"
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

</head>
<script type="text/javascript">
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
	if(operate=="levelanddeleteLevel")
	{
		var txt=  "确定要删除该等级信息？";
		var option = {
			title: "提示：",
			btn: parseInt("0011",2),
			onOk: function(){				
					$.post(operate,
					 	{ "level.id":id },
						function(data){
							window.wxc.xcConfirm(data, window.wxc.xcConfirm.typeEnum.info);							
					},'text'); 						
			},
			onCancel:function(){
				//取消后什么也不做
			}
		}
		window.wxc.xcConfirm(txt, "custom", option);
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
		$.post("levelanddeleteSelectedLevels", {"ids":ids},
			   function(data){
			   	 var arr=new Array();
					$.each(data, function(i, item) {
						arr.push(item);					           
					});								
					if(arr[0]){//true时表示操作成功，更改界面元素状态								
						$("input:checked").each(
						function(){
								$("#levelId"+this.value).empty().hide();
							}
						);				
					}
					alert(arr[1]);	
			   },'json');
}		
$(function(){
	$(".deleteBtn").click(function(){
		var id=$(this).attr("LevelId");
		$.post("levelanddeleteLevel", {"level.id":id},
			   function(data){
			   	 	var arr=new Array();
					$.each(data, function(i, item) {
						arr.push(item);					           
					});								
					if(arr[0]){//true时表示操作成功，更改界面元素状态								
						$("#levelId"+id).empty().hide();			
					}
					alert(arr[1]);	
			   },'json');
	});
});
</script>
<body>
	<s:url  var="searchUrl" value="levelandlevelList" includeParams="none">
		<s:param name="page.pageSize" value="page.pageSize"></s:param>
	</s:url>
	<div class="addLevelTitleText">添加等级信息</div>
	<!-- 添加产品等级信息 -->
	<form action="levelandaddLevel" method="post">	
	<div class="addLevelWrap">
		<div class="leveBaseInfo">
			<div class="levelNameWrap">
				<div class="title floatLeft">等级名称:&nbsp;&nbsp;&nbsp;</div>
				<div class="levelNameInnerWrap floatLeft">
					<input type='text' name='level.levelName'/>
					<div style="margin-top:10px;padding:5px;border:1px solid rgb(222,222,222);">
						&nbsp;&nbsp;
						<input type="radio" checked="checked" name="level.flag" value="0"/>场地
						&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="level.flag" value="1"/>教练						
					</div>
				</div>
				<div class="chooseTypeWrap floatLeft">
					<div class="title">选择分类:</div>
					<div class="productTypeLists">
						<div class="item">
							<div class="selectContent" id="productTypeRootWrap">
								<select id='productTypeRoot'>
									<option value="-1">选择分类</option>
									<s:iterator value="types">
										<s:if test="productType.parentProductType.parentProductType.id==id">
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
						<div class="item" id="parentTypeId" id="productTypeParentWrap">
							<div class="selectContent" id="parentTypeWrap">
								<select id='productTypeParent'>
									<option value="-1">选择分类</option>
									<s:iterator value="productType.parentProductType.parentProductType.childrenProductTypes">
										<s:if test="productType.parentProductType.id==id">
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
						
					</div>
				</div>
			</div>
			<div style="clear:both;"></div>
			<br>
			<div class="levelNameWrap">
				<div class="title floatLeft">等级简介:&nbsp;&nbsp;&nbsp;</div>
				
			</div>
				<div class="levelIntroInnerWrap">
					<textarea name="level.introduction"></textarea>
				</div>
			</div>			
		<div class="addLevelBtnWrap"><input type="submit" value="等级添加" class="button blue"/></div>	<br>	</div>	
	</div>
	<input type="hidden" id="typeId" name="type.id" value="0"/>
	</form>
	<div style="clear:both;"></div>
	<!-- 等级搜索部分 -->
	
	<div class="addLevelTitleText">所有等级信息列表</div>

	<div style="clear:both;"></div>
	<!-- 等级列表部分开始 -->
		<div class="listWrap">
			<table id="levelList" width="100%" border="0" cellpadding="0"
			cellspacing="0">
			<tr>
				<th width="40px">选择</th>
				<th>等级名</th>
				<th>等级简介</th>
				<th>所属的产品分类</th>
				<th width="200px">操作</th>
			</tr>
			<s:if test="levels!=null">
				<s:iterator value="levels">
					<tr id="levelId<s:property value='id'/>">
						<td class="left"><input type="checkbox" value="<s:property value='id'/>" name="ids"></input>
						</td>
						<td levelName="levelName<s:property value='id'/>"><s:property value="levelName" />
						</td>
						<td><s:property value="introduction" />
						</td>
						<td><s:property value="type.typeName" />
						</td>
						<td>
							<a class="button blue" href="levelandtoAlterLevel?level.id=<s:property value='id'/>">修改</a>
							
							<a class="deleteBtn button blue" LevelId="<s:property value='id'/>" href="javascript:void(0);">删除</a>
							
						</td>
					</tr>
				</s:iterator>
			</s:if>

		</table>
	</div>
	<!-- 等级列表部分结束 -->
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
<script type="text/javascript">
$(function(){	
 // 通过原生select控件创建自定义下拉框
    var ddl_picture1= createDropList("#productTypeRoot");
   var ddl_picture2=createDropList("#productTypeParent");
   	var level_list=createDropList("#productLevel");
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
    	    $("#typeId").attr("value",ddl_picture2.val());			
	});
	function createList1(){
		$("#productTypeRootWrap").empty();
		$("#parentTypeWrap").empty();
       	$("#parentTypeId,#productTypeRootWrap").css('display','none');
    	parentTypeId=-1;//表示获取根类
    	var select="<select id='productTypeRoot'>";    		
    		$.post("productTypeandgetChildTypes",
		 			{ "productType.id":parentTypeId },
						function(data){
							alert("aaa");
							 //解析数组,获取该类别下所有子项
					        $.each(data, function(i, item) {
					           select+="<option value='"+item.id+"'>"+item.typeName+"</option>";					           
					        });
					        select+="</select>";
					        //alert(select);
					        $("#productTypeRootWrap").html(select);
					         ddl_picture1= createDropList('#productTypeRoot');
							 $("#productTypeRootWrap").css('display','block');
							 createList2();
							 $("#parentTypeId").css('display','block');
							 /*****************创建第二个选择列表并显示****************/						 								 						 	
								  ddl_picture1.change(function(){
								  	if(ddl_picture1.val()!=-1)
							  			createList2();							
								});								
								/**************创建结束****************/
						},"json"); 	 
	}
	
	function createList2(){
			$("#parentTypeWrap").empty();
    		$("#productTypeWrap").empty();
    		$("#parentTypeId").css('display','none');
    		
    		/****************创建第二个下拉列表********************/
    		var parentTypeId=ddl_picture1.val();	
    		var select="<select id='productTypeParent'>";
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
					         ddl_picture2= createDropList('#productTypeParent');
							 $("#parentTypeId").css('display','block');
							 $("#typeId").attr("value",ddl_picture2.val());	
							 if(ddl_picture2)						 								 						 	
							  ddl_picture2.change(function(){
							  			$("#typeId").attr("value",ddl_picture2.val());					
								});
						},"json"); 	 
	}	
});
		
	</script>
</body>
</html>
