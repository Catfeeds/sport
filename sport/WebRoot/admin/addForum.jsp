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
<!DOCTYPE html>
<html>
<head>


<title>添加社交圈</title>

<meta charset="utf-8" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<link rel="stylesheet" type="text/css" href="../res/css/addForum.css">

<script type="text/javascript" src="../res/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="../res/js/selectlist.js" ></script>


</head>

<script type="text/javascript">
$(function(){
	$("input[type=file]").change(function(){$(this).parents(".uploader").find(".filename").val($(this).val());});
	$("input[type=file]").each(function(){
	if($(this).val()==""){$(this).parents(".uploader").find(".filename").val("选择您喜欢的图标...");}
	});
});
</script>
<body>
	
	<div class="addForum">
		<form method="post" action="forumandaddForum" enctype="multipart/form-data">
			<table border="0px" cellspacing="0" cellpadding="0">
				<tr>
					<td class="label" style="padding-top:20px;">论坛图标：</td>
					<td>
						<div class="logoBox" style="width:250px;text-align:left;">
							<div class="currentLogo" style="width:100%;text-align:center;">
								<img src="" alt="提交后这里将展示您的图标" />
							</div>
							<div class="uploader" style="width:100%;text-align:center;margin-bottom:30px;">
								<div class="uploader blue1">
									<input type="text" class="filename" readonly="readonly"/>
									<input type="button" name="file" class="button1" value="选择"/>
									<input type="file" size="30" name="file" accept="image/*"/>
								</div>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">论坛名：</td>
					<td>
						<input type="text" class="forumName" name="forum.forumName" maxlength="20"/>
					</td>
				</tr>
				<tr>
					<td class="label">论坛类型：</td>
					<td>
						<select id="forumClass" name="forum.classType">
							<option value="1">个人</option>
							<option value="2">入驻商家</option>
							<option value="3">平台拥有者</option>
							<option value="4">其它类型</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="label">论坛分类：</td>
					<td>
						<select id="forumType" name="forum.type.id">
							<s:iterator value='allTypes'>
								<option value="<s:property value='id'/>">
									<s:property value='typeName'/>
								</option>
							</s:iterator>	
						</select>
					</td>
				</tr>
				<tr>
					<td class="label">论坛简介：</td>
					<td>
						<textarea cols="60" rows="5" name="forum.introduction" maxlength="400" placeholder="请输入论坛简介，请不要超过400个字..." ></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<div class="submitBtn">
							<input type="submit" value="提交"
								class="blue button little">
						</div>
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	

</body>
</html>
