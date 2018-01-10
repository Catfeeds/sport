<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
basePath +="admin/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
   <!-- 上传组件css引入 -->	
    	<link rel="stylesheet" href="uploadFiles/control/css/zyUpload.css" type="text/css">
		<script type="text/javascript" src="../res/js/jquery-1.8.3.min.js"></script>
		<!-- 上传组件js引入 -->
		<!-- 引用核心层插件 -->
		<script type="text/javascript" src="uploadFiles/core/zyFile.js"></script>
		<!-- 引用控制层插件 -->
		<script type="text/javascript" src="uploadFiles/control/js/zyUpload.js"></script>
		<!-- 引入在线编辑器 -->
		<script type="text/javascript" charset="utf-8" src="../res/ueditor/ueditor.config.js"></script>
		<script type="text/javascript" charset="utf-8"	src="../res/ueditor/ueditor.all.min.js"></script>
		<script type="text/javascript" charset="utf-8"	src="../res/ueditor/lang/zh-cn/zh-cn.js"></script>
	<style>
	
	b{
		line-height: 24px;
		font-size: 18px;
		font-weight: normal;
	}
	input{
		vertical-align:middle;
		width: 500px;
		margin-left: 10px !important;
		margin: auto;
		height: 30px;
		border:1px solid rgb(231,231,235);
	}
	.inline{
		margin: 2px 0;
	}
	.intips{
		font-size: 16px;
		color: rgb(180,170,170);
	}	
	 #preview, .img, img  {  
 		width:150px;  
		 height:80px; 
		 float: left;
 	}  	
 	#preview  {  
		border:1px solid rgb(231,231,235);  
	}  
	.hiddens{
		
	}
	.file-box {
		position: relative;
		width: 110px;
		float:right;
		
	}
	.btn {
		background-color: #FFF;
		border: 1px solid #CDCDCD;
		margin: 10px 20px;
		height: 40px;
		width: 100px;
	}
	.txt {
		height: 22px;
		width: 300px;
		background: rgb(231,232,235);
	}	
	.file {
		position: absolute;
		height: 40px;
		filter: alpha(opacity: 0);
		opacity: 0;
		width: 100px;
		border: 2px dashed #f00;
	}
	</style>
	
	<body>
	<div style="background: rgb(231,232,235); width: 700px; margin: auto; padding: 15px;">
		<div class="inline"><b>标题</b></div>
		<div>
			<span><input type="text" onkeyup="javascript:setShowLength(this, 15, 'titlein');" /></span>
			<span class="intips" id="titlein">15/15</span>
		</div>
		<div class="inline"><b>作者</b></div>
		<div>
			<span><input type="text" onkeyup="javascript:setShowLength(this, 15, 'titleins');" /></span>
			<span class="intips" id="athorins" >15/15</span>
		</div>
		<div class="inline"><b>封面图</b></div>
		<div style="width: 300px; height: 85px;margin-left: 20PX;">
			<div class="file-box">
				<input type="file" class="file" onchange="preview(this);document.getElementById('textfield').value=this.value" />
				<input type='button' class='btn' value='选择图片...' />
			</div>
			<div id="preview" ></div>
			<input type='text' readonly="readonly" id='textfield' class='txt' /> 
		</div>
		<br />
		<div>
			<b>正文</b>
		</div>
		<div>
			<span class="inputs">
	       <textarea  style="width:480px;height:300px;" id="siteDetail" name="site.detail"></textarea></span> 
	       <br> <!--site.service 附加服务 --> 
		</div>
	</div>
	
	
	<script>
	function setShowLength(obj, maxlength, id)
{
    var rem = maxlength - obj.value.length;
    var wid = id;
    if (rem < 0){
        rem = 0;
    }
    document.getElementById(wid).innerHTML =  rem + "/15";
}
</script>
 <script type="text/javascript">
 function preview(file) {
	var prevDiv = document.getElementById('preview');
	
	if (file.files && file.files[0]) {
		var reader = new FileReader();
		reader.onload = function(evt) {
			
			prevDiv.innerHTML = '<img src="' + evt.target.result + '" />';
		}
		reader.readAsDataURL(file.files[0]);
	} else {
		prevDiv.innerHTML = '<div class="img" style="filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src=\'' + file.value + '\'"></div>';
	}
}</script>  
	</body>
</html>

