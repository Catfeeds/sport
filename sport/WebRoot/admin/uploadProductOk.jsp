<%@ page language="java"  contentType="text/html; charset=UTF-8" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	basePath+="admin/";
%>
<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">
		<title>上传图片成功!</title>
		
		<link href="../res/css/component.css" type="text/css" rel="stylesheet" />
		<script type="text/javascript" src="../res/js/jquery-1.8.3.min.js"></script>
		<style type="text/css">

	*{
		margin:0px;
		padding:0px;
		font-size:14px;
	}

	.submitBox {
		width:400px;
		margin:0px auto;
	}

	.fileName {
		position: relative;
		overflow: hidden;
		zoom: 1;
		margin-bottom: 5px;
		margin-top:15px;
		
	}
	
	.fileName .alignRight {
		float: left;
		width: 150px;
		color: #333;
		text-align: right;
		margin-right: 5px;
	}

	.fileName .alignRight b{
		display: inline-block;
		width: 6px;
		color: #b10000;
		padding: 0 2px;
		vertical-align: middle;
		text-align: center;
	}

	.alignRight label b {
		color: #b10000;
		display: inline-block;
		padding: 0 0 0 2px;
		vertical-align: middle;
		width: 6px;
		text-align: center;
	}

	.alignLeft {
		float:left;
			
	}

	.downloadBox {
		width:310px;	
		margin:0px auto;
	}

	.downloadBox ul {
		margin:0px;
		padding:0px;
	}

	.downloadBox ul li{
		list-style-type:none;
		height:30px;
		line-height:30px;
		width:300px;
		text-align:left;
		margin:0px auto;
	}

	.blue {
		color: #D9EEF7;
		border: 1px solid #0076A3;
		background: transparent -moz-linear-gradient(center top , #00ADEE, #0078A5) repeat scroll 0% 0%;
	}

	.blue:hover {
		background: #007ead;
		background: -webkit-gradient(linear, left top, left bottom, from(#0095cc), to(#00678e));
		background: -moz-linear-gradient(top,  #0095cc,  #00678e);
		filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#0095cc', endColorstr='#00678e');
	}

	.blue:active {
		color: #80bed6;
		background: -webkit-gradient(linear, left top, left bottom, from(#0078a5), to(#00adee));
		background: -moz-linear-gradient(top,  #0078a5,  #00adee);
		filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#0078a5', endColorstr='#00adee');
	}

	.bigrounded {
		border-radius: 2em;
	}

	.button {
		display: inline-block;
		vertical-align: baseline;
		margin: 0px 2px;
		outline: medium none;
		cursor: pointer;
		text-align: center;
		text-decoration: none;
		font: 14px/100% Arial,Helvetica,sans-serif;
		padding: 0.5em 2em 0.55em;
		text-shadow: 0px 1px 1px rgba(0, 0, 0, 0.3);
		border-radius: 0.5em;
		box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.2);
	}

	a {
		color: #339;
		text-decoration: none;
	}
</style>
		
	</head>
<script type="text/javascript">
	/*//system error
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
	*/
</script>	
<body>
	<div style="text-align:center;">
		<form action="qrcodeanddownloadQrcodeImagesZip" method="post" id="subform" name="subform" >
			<input type="hidden" name="productId" value="<s:property value='product.id'/>"/>
			<div class="submitBox">
				<div class="fileName">
					<div class="alignRight">
						<label for="fea2">文件名<b>*</b>:</label>
					</div>
					<div class="alignLeft">
						<input type="text" name="zipName"/><br>
					</div>
				</div>
				<div class="fileName">
					<div class="alignRight">
						设置下载密码<b>*</b>:
					</div>
					<div class="alignLeft">
						<input type="password" name="password"/><br>
					</div>
				</div>
			</div>
			<div style="margin:5px auto;">
				-----------------------------选择下载---------------------------------<br>
			</div>

			<div class="downloadBox">
				<ul class="ulBox">
					<li>
						<input type="radio" checked="checked" name="newFlag" value="true"/>
						下载该类产品新添加库存的二维码
					</li>
					<li>
						<input type="radio" name="newFlag" value="false"/>
						下载该产品所有二维码
					</li>
					<li style="padding-left:20px;">
						<a class="button blue bigrounded" href="#" name="submit" onclick="document.getElementById('subform').submit();return false" >
						下载二维码压缩包</a>
					</li>
				</ul>
			</div>


		</form>
	</div>
	   
</body>
</html>







