<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
			basePath+="admin/";
%>
<%@taglib uri="/struts-tags" prefix="s"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'addDiscount.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<!-- 引入基本样式 -->
<link rel="stylesheet" type="text/css" href="../res/css/base.css" />
<!-- 引入单独样式 -->
<link rel="stylesheet" type="text/css" href="../res/admin/css/addDiscount.css" />
<!-- 引入JQ库 -->
<script type="text/javascript" src="../res/js/jquery-1.8.3.min.js"></script>
<!-- 引入日历组件 -->
<link rel="stylesheet" type="text/css" href="../res/commonComponents/calendar/css/jcDate.css" media="all" />
<script type="text/javascript" src="../res/commonComponents/calendar/js/jQuery-jcDate.js" charset="utf-8"></script>
<!-- 引入在线编辑器 -->
<script type="text/javascript" charset="utf-8" src="../res/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8"	src="../res/ueditor/ueditor.all.min.js"></script>
<script type="text/javascript" charset="utf-8"	src="../res/ueditor/lang/zh-cn/zh-cn.js"></script>
<!-- 引入图片预览 -->
<script type="text/javascript" src="../weixin/res/js/upload.js"></script>

<style>
img{
    border: none;
    font-size: 0;
    vertical-align: top;
}

.person {
    width: 100%;
    border: 1px solid #ddd;
    margin-bottom: 10px;
}
.person label{
    width: 100%;
    height:30px;
    line-height:30px;
    text-align: center;
    background-color: #3cf;
    color: #fff;
}

.join label {
    display: inline-block;
    margin-bottom: 0px;
    font-weight: 700;
}

.join img {
    width: 100%;
    height: auto;
    max-width: 100%;
}

.join label span {
    font-weight: normal;
}

.join label svg {
    fill: currentColor;
    margin-top: -0.25em;
    margin-right: 0.25em;
}

input.upload {
    width: 0.1px;
    height: 0.1px;
    opacity: 0;
    overflow: hidden;
    position: absolute;
    z-index: -1;
}
.text-left {
	font-size:14px;
	min-width:80px;
}
</style>

<script type="text/javascript">
$(function(){
	//选择时间控件 
	$("input#activityStartTime").jcDate({					       
		IcoClass : "jcDateIco",
		Event : "click",
		Speed : 100,
		Left : 0,
		Top : 28,
		format : "-",
		Timeout : 100
	});
	$("input#activityEndTime").jcDate({					       
		IcoClass : "jcDateIco",
		Event : "click",
		Speed : 100,
		Left : 0,
		Top : 28,
		format : "-",
		Timeout : 100
	});	
	// 生成在线编辑器		
	var ue1 = UE.getEditor('discountDetail',{
        initialFrameWidth : 480,
        initialFrameHeight: 200
    });
    ue1.render('myEditor2',{
        autoFloatEnabled : false
    });
	$("#discountDetail").show();
	//上传按钮
	$("input[type=file]").change(function(){
		$(this).parents(".uploader").find(".filename").val($(this).val());
	});
	$("input[type=file]").each(function(){
		if($(this).val()==""){
			$(this).parents(".uploader").find(".filename").val("没有选中图片...");
		}
	});
});	
</script>

</head>

<body>
	<h2>修改优惠活动</h2>
	<div class="add-d">
		<form action="discountandalterDiscount" method="post" enctype="multipart/form-data">
			<input type="hidden" name="discount.id" value="<s:property value='discount.id'/>"/>
			<table>
				<tr>
					<td class="text-left">标　　题：</td>
					<td><input type="text" maxlength="20" name="discount.title" value="<s:property value='discount.title'/>" placeholder="活动标题，请不要超过20字..." class="text-flag text-title"/></td>
				</tr>
				<s:if test="discount.type==2">
					<tr>
						<td class="text-left">类型：</td>
						<td><input type="radio" name="discount.type" maxlength="20" value="2" checked="checked"/>场馆
							&nbsp;&nbsp;<input type="radio" name="discount.type" maxlength="20" value="1"/>教练
						</td>
					</tr>
				</s:if>
				<s:else>
					<tr>
						<td class="text-left">类型：</td>
						<td><input type="radio" name="discount.type" maxlength="20" value="2" />场馆
							&nbsp;&nbsp;<input type="radio" name="discount.type" maxlength="20" value="1" checked="checked"/>教练
						</td>
					</tr>
				</s:else>
				<tr>
					<td class="text-left">活动时间：</td>
					<td>
						<s:date name="discount.beginDate" format="yyyy-MM-dd"/>
						-
						<s:date name="discount.endDate" format="yyyy-MM-dd"/>
					</td>
				</tr>
				<tr>
					<td class="text-left">封面图片：</td>
					<td>
						<div class="join">
							<div class="person">
								<div id="preview">
									<img id="imghead" src="..<s:property value='discount.preViewImg.pathName'/>" />
							    </div>
							    <input type="file" accept="image/*" name="file" onchange="previewImage(this)" class="upload" id="file">
							    <label for="file">
							    	<svg xmlns="http://www.w3.org/2000/svg" width="15" height="12" viewBox="0 0 20 17">
								    	<path d="M10 0l-5.2 4.9h3.3v5.1h3.8v-5.1h3.3l-5.2-4.9zm9.3 11.5l-3.2-2.1h-2l3.4 2.6h-3.5c-.1 0-.2.1-.2.1l-.8 2.3h-6l-.8-2.2c-.1-.1-.1-.2-.2-.2h-3.6l3.4-2.6h-2l-3.2 2.1c-.4.3-.7 1-.6 1.5l.6 3.1c.1.5.7.9 1.2.9h16.3c.6 0 1.1-.4 1.3-.9l.6-3.1c.1-.5-.2-1.2-.7-1.5z">
								    	</path>
							    	</svg> 
							    	<span>选择图片…</span>
							    </label>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td class="text-left">活动简介：</td>
					<td>
						<textarea class="text-intro" maxlength="100" rows="3" cols="62" placeholder="活动简介，请不要超过100字...">
						<s:property value='discount.introduction'/>
						</textarea>
					</td>
				</tr>
				<tr>
					<td class="text-left">活动详情：</td>
				</tr>
				<tr>
					<td colspan="2">
						<textarea id="discountDetail"><s:property value='discount.detail'/></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="确认修改" />
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>
