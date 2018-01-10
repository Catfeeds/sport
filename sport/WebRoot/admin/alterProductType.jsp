<%@ page language="java"  contentType="text/html; charset=UTF-8" isELIgnored="false" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html >
<html>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	basePath+="admin/";	
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>修改产品分类信息</title>
<base href="<%=basePath%>">
<link href="../res/css/component.css" type="text/css" rel="stylesheet" />
<link href="../res/admin/css/wordsRecord.css" rel="stylesheet" type="text/css">
<link href="../res/commonComponents/singleFileUpload/css/uploadSingleFile.css"	type="text/css" rel="stylesheet" />
<script type="text/javascript" src="../res/commonComponents/progressWork/js/jquery-1.8.3.min.js"></script>
</head>
<script type="text/javascript">
$(function(){
		$("input[type=file]").change(function(){$(this).parents(".uploader").find(".filename").val($(this).val());});
		$("input[type=file]").each(function(){
		if($(this).val()==""){$(this).parents(".uploader").find(".filename").val("请选择该分类的图标...");}
		});
	});
</script>
<body>
	<center>
	<h1>修改分类信息</h1>	
		<form  action="productTypeandupdateProductType" method="post" enctype="multipart/form-data">
			<input type="hidden" name="productType.id" value="<s:property value='productType.id'/>"/>
			<div class="typeImg">
				<div class="imgTitle">当前图标:</div>
						<div class="imgPreview">
							<img  src="..<s:property value='productType.image.pathName'/>"/>
						</div>
				<div class="uploadSigleFile"> 
						<span class="uploader blueChooser"> 
							<input type="text"	class="filename" readonly="readonly" /> 
							<input type="button" class="fileButton" value="选择" /> 
							<input type="file" name="file"	size="30" /> 
						</span> 
				</div>
			</div>
			分类名：&nbsp;&nbsp;&nbsp;&nbsp;<input name="productType.typeName" type="text"  value="<s:property value='productType.typeName'/>"/>
				<div class="intro" style="margin-top:20px;">
					<span >分类简介：</span>
					<textarea cols="40" rows="10" name="productType.introduction" ><s:property value='productType.introduction'/></textarea>
				</div>
				<div class="modify">
					<input type="submit"  class="button blue middle" value="修改">
				</div>
		</form>
	</center>
</body>
</html>