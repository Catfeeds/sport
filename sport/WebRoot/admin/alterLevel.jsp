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


</script>
<body>
	<div class="addLevelTitleText">修改等级信息</div>
	<!--修改产品等级信息 -->
	<form action="levelandalterLevel" method="post">	
	<input type="hidden" name="level.id" value="<s:property value='level.id'/>"/>
	<div class="addLevelWrap" style="border:none;">
		<div class="leveBaseInfo">
			<div class="levelNameWrap">
				<div class="title floatLeft">等级名:&nbsp;&nbsp;&nbsp;</div>
				<div class="levelNameInnerWrap floatLeft">
					<input type='text' name='level.levelName' value="<s:property value='level.levelName'/>"/>					
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
										<s:if test="level.type.parentProductType.id==id">
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
									<s:iterator value="level.type.parentProductType.childrenProductTypes">
										<s:if test="level.type.id==id">
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
			<div class="levelIntroWrap">
				<div class="title">等级简介:</div>
				<div class="levelIntroInnerWrap">
					<textarea name="level.introduction"><s:property value="level.introduction"/></textarea>
				</div>
			</div>			
		</div>	
		<div class="addLevelBtnWrap"><input type="submit" value="提交修改" class="button blue"/></div>
	</div>
	<input type="hidden" id="typeId" name="level.type.id" value="<s:property value='level.type.id'/>"/>
	</form>
	
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
