<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>个人中心</title>
		<link href="./res/css/tbsp-sns-min.css" type="text/css" rel="stylesheet">
		<!-- 引入控件美化组件 -->
		<link href="res/css/component.css" type="text/css" rel="stylesheet" />
		<link href="res/css/userHome.css" type="text/css" rel="stylesheet" /> 
		<link href="res/commonComponents/singleFileUpload/css/uploadSingleFile.css"	type="text/css" rel="stylesheet" />
		<script src='res/js/jquery-1.8.3.min.js' type="text/javascript"></script>
		<!-- 引入在线编辑器 -->
		<script type="text/javascript" charset="utf-8" src="./res/ueditor/ueditor.config.js"></script>
		<script type="text/javascript" charset="utf-8"	src="./res/ueditor/ueditor.all.min.js"></script>
		<script type="text/javascript" charset="utf-8"	src="./res/ueditor/lang/zh-cn/zh-cn.js"></script>
		<!-- 引入下拉列表组件 -->
		<link href="./res/commonComponents/dropDownList/css/dropdownlist.css" rel="stylesheet" type="text/css">
		<script src="./res/commonComponents/dropDownList/js/dropdownlist.js"></script>
		<!-- 引入日历组件 -->
		<link rel="stylesheet" type="text/css" href="res/commonComponents/calendar/css/jcDate.css" media="all" />		
		<script type="text/javascript" src="res/commonComponents/calendar/js/jQuery-jcDate.js" charset="utf-8"></script>
		<!-- 引入弹出框组件 -->
		<link rel="stylesheet" type="text/css"	href="res/commonComponents/popDialog/css/xcConfirm.css" />
		<script src="../res/commonComponents/popDialog/js/xcConfirm.js"	type="text/javascript" charset="utf-8"></script>
		<style type="text/css">
			input[type=text].textLength1{
				width:160px;
				height:30px;
			}
		</style>
</head>
<script type="text/javascript">
<!--
	$(function(){
		$("input[type=file]").change(function(){$(this).parents(".uploader").find(".filename").val($(this).val());});
		$("input[type=file]").each(function(){
		if($(this).val()==""){$(this).parents(".uploader").find(".filename").val("请选择你喜欢的头像...");}
		});
	});
	$(function(){		
		$("#uploadHeadImgBtn").click(
			function(){
				var data = new FormData();   
			    data.append('file', $('input[name=file]')[0].files[0]);  
			    $.ajax({  
			        url: 'userandalterSelfHeadImg',  
			        type: 'POST',  
			        data: data,  
			        processData: false,  // 告诉jQuery不要去处理发送的数据  
			        contentType: false , // 告诉jQuery不要去设置Content-Type请求头  
			        dataType:'json'
			    }).done(function(data){  
			       	var arr=new Array();
					$.each(data, function(i, item) {
						arr.push(item);					           
					});
					if(arr[0]){//true时表示操作成功，更改界面元素状态								
						$("#currentImgId").attr('src',"."+arr[1]);
						$('input[name=file]').val('');
					}else{
						alert(arr[1]);
					}	
			    });  
			    return false;  
		});
		//后台处理的路径
		var operateUrl="userandalterUserSelfInfo";
		//密码
		var currentPasswordId="#currentPassword";
		var currentPasswordIdBtn=currentPasswordId+"Btn";
		var currentPasswordContent="<input type='password' name='user.password' id='currentPassowrdInput'  class='inputText textLength1'/>";
		$(currentPasswordIdBtn).click(
			function(){
				
				if($(currentPasswordIdBtn).html()=="修改"){
					var content=$(currentPasswordId).html();
					$(currentPasswordIdBtn).html("确定");
					$(currentPasswordId).html(currentPasswordContent);					
					//$("#currentPassowrdInput").val(content);
				}else{
					var newPassword=$("#currentPassowrdInput").val();
					
					$.post(operateUrl,
					 	{   "user.password":newPassword,
					 		"alterFlag":"password"
					 	 },
						function(data){
							var arr=new Array();
							$.each(data, function(i, item) {
								arr.push(item);					           
							});
							if(arr[0]){//true时表示操作成功，更改界面元素状态								
								$(currentPasswordIdBtn).html("修改");
								$(currentPasswordId).html($("#currentPassowrdInput").val());
							}else{
								alert(arr[1]);
							}												
					},'json'); 
					
				}
			}
		);
		//姓名
		var currentRealNameId="#currentRealName";
		var currentRealNameIdBtn=currentRealNameId+"Btn";
		var currentRealNameContent="<input type='text' name='user.realName' id='currentRealNameInput' class='inputText textLength1'/>";
		$(currentRealNameIdBtn).click(
			function(){
				
				if($(currentRealNameIdBtn).html()=="修改"){
					var content=$(currentRealNameId).html();
					$(currentRealNameIdBtn).html("确定");
					$(currentRealNameId).html(currentRealNameContent);					
					$("#currentRealNameInput").val(content);
				}else{
					var newValue=$("#currentRealNameInput").val();
					
					$.post(operateUrl,
					 	{   "user.realName":newValue,
					 		"alterFlag":"realName"
					 	 },
						function(data){
							var arr=new Array();
							$.each(data, function(i, item) {
								arr.push(item);					           
							});
							if(arr[0]){//true时表示操作成功，更改界面元素状态								
								$(currentRealNameIdBtn).html("修改");
								$(currentRealNameId).html(newValue);
							}												
					},'json'); 
					
				}
			}
		);
		//性别
		var currentSexId="#currentSex";
		var currentSexIdBtn=currentSexId+"Btn";
		var currentSexContent="<input type='radio' value='男'  name='sex' />&nbsp;男&nbsp;"+
								"<input type='radio' value='女' name='sex' />&nbsp;女";
		$(currentSexIdBtn).click(
			function(){
				
				if($(currentSexIdBtn).html()=="修改"){
					var content=$(currentSexId).html();
					$(currentSexIdBtn).html("确定");
					$(currentSexId).html(currentSexContent);					
					$("input[value="+content+"]").attr('checked','checked');
				}else{
					var newValue=$("input[name=sex]:checked").val();
					
					$.post(operateUrl,
					 	{   "user.sex":newValue,
					 		"alterFlag":"sex"
					 	 },
						function(data){
							var arr=new Array();
							$.each(data, function(i, item) {
								arr.push(item);					           
							});
							if(arr[0]){//true时表示操作成功，更改界面元素状态								
								$(currentSexIdBtn).html("修改");
								$(currentSexId).html(newValue);
							}												
					},'json'); 
					
				}
			}
		);
		//生日
		var currentBirthdayId="#currentBirthday";
		var currentBirthdayIdBtn=currentBirthdayId+"Btn";
		var currentBirthdayContent="<input type='text' name='birthday' id='birthday' class='inputText textLength1'/>";
		$(currentBirthdayIdBtn).click(
			function(){
				
				if($(currentBirthdayIdBtn).html()=="修改"){
					var content=$(currentBirthdayId).html();
					$(currentBirthdayIdBtn).html("确定");
					$(currentBirthdayId).html(currentBirthdayContent);										
					$("input#birthday").val(content);
					$("input#birthday").jcDate({					       
							IcoClass : "jcDateIco",
							Event : "click",
							Speed : 100,
							Left : 0,
							Top : 28,
							format : "-",
							Timeout : 100
					});
				}else{
					var newValue=$("input[name=birthday]").val();
					
					$.post(operateUrl,
					 	{   "user.birthday":newValue,
					 		"alterFlag":"birthday"
					 	 },
						function(data){
							var arr=new Array();
							$.each(data, function(i, item) {
								arr.push(item);					           
							});
							if(arr[0]){//true时表示操作成功，更改界面元素状态								
								$(currentBirthdayIdBtn).html("修改");
								$(currentBirthdayId).html(newValue);
							}												
					},'json'); 
					
				}
			}
		);
		//电话
		var currentPhoneId="#currentPhone";
		var currentPhoneIdBtn=currentPhoneId+"Btn";
		var currentPhoneContent="<input type='text' name='phone' class='inputText textLength1'/>";
		$(currentPhoneIdBtn).click(
			function(){
				
				if($(currentPhoneIdBtn).html()=="修改"){
					var content=$(currentPhoneId).html();
					$(currentPhoneIdBtn).html("确定");
					$(currentPhoneId).html(currentPhoneContent);					
					$("input[name=phone]").val(content);
				}else{
					var newValue=$("input[name=phone]").val();
					
					$.post(operateUrl,
					 	{   "user.phone":newValue,
					 		"alterFlag":"phone"
					 	 },
						function(data){
							var arr=new Array();
							$.each(data, function(i, item) {
								arr.push(item);					           
							});
							if(arr[0]){//true时表示操作成功，更改界面元素状态								
								$(currentPhoneIdBtn).html("修改");
								$(currentPhoneId).html(newValue);
							}												
					},'json'); 
					
				}
			}
		);
		//座机号
		var currentTelephoneId="#currentTelephone";
		var currentTelephoneIdBtn=currentTelephoneId+"Btn";
		var currentTelephoneContent="<input type='text' name='telephone' class='inputText textLength1'/>";
		$(currentTelephoneIdBtn).click(
			function(){
				
				if($(currentTelephoneIdBtn).html()=="修改"){
					var content=$(currentTelephoneId).html();
					$(currentTelephoneIdBtn).html("确定");
					$(currentTelephoneId).html(currentTelephoneContent);					
					$("input[name=telephone]").val(content);
				}else{
					var newValue=$("input[name=telephone]").val();
					
					$.post(operateUrl,
					 	{   "user.telephone":newValue,
					 		"alterFlag":"telephone"
					 	 },
						function(data){
							var arr=new Array();
							$.each(data, function(i, item) {
								arr.push(item);					           
							});
							if(arr[0]){//true时表示操作成功，更改界面元素状态								
								$(currentTelephoneIdBtn).html("修改");
								$(currentTelephoneId).html(newValue);
							}												
					},'json'); 
					
				}
			}
		);
		//邮箱
		var currentEmailId="#currentEmail";
		var currentEmailIdBtn=currentEmailId+"Btn";
		var currentEmailContent="<input type='text' name='email' class='inputText textLength1'/>";
		$(currentEmailIdBtn).click(
			function(){
				
				if($(currentEmailIdBtn).html()=="修改"){
					var content=$(currentEmailId).html();
					$(currentEmailIdBtn).html("确定");
					$(currentEmailId).html(currentEmailContent);					
					$("input[name=email]").val(content);
				}else{
					var newValue=$("input[name=email]").val();
					
					$.post(operateUrl,
					 	{   "user.email":newValue,
					 		"alterFlag":"email"
					 	 },
						function(data){
							var arr=new Array();
							$.each(data, function(i, item) {
								arr.push(item);					           
							});
							if(arr[0]){//true时表示操作成功，更改界面元素状态								
								$(currentEmailIdBtn).html("修改");
								$(currentEmailId).html(newValue);
							}												
					},'json'); 
					
				}
			}
		);
		//邮箱
		var currentDetailId="#currentDetail";
		var currentDetailIdBtn=currentDetailId+"Btn";
		var currentDetailContent="<div>产品详情：</div>"+
								"<div style='clear:both;'></div>"+
								"<textarea style='height:100px;width:600px;' name='detail' id='personDetail'></textarea>";
		$(currentDetailIdBtn).click(
			function(){
				
				if($(currentDetailIdBtn).html()=="编辑"){
					var content=$(currentDetailId).html();
					$(currentDetailIdBtn).html("确定");
					$(currentDetailId).html(currentDetailContent);					
					var ue=UE.getEditor('personDetail');
					 ue.addListener("ready", function () {
				        // editor准备好之后才可以使用
				        //content=$.trim(content);
				        ue.execCommand('insertHtml', content);				 
				       });
					$("#personDetail").show();
				}else{
					var newValue=UE.getEditor('personDetail').getContent()
					
					$.post(operateUrl,
					 	{   "user.detail":newValue,
					 		"alterFlag":"detail"
					 	 },
						function(data){
							var arr=new Array();
							$.each(data, function(i, item) {
								arr.push(item);					           
							});
							if(arr[0]){//true时表示操作成功，更改界面元素状态								
								$(currentDetailIdBtn).html("编辑");
								//销毁ueditor
								UE.getEditor('personDetail').destroy();
								$(currentDetailId).html(newValue);
							}												
					},'json'); 
					
				}
			}
		);
	});
//-->
</script>
 <body>
 		<div class="contentWrap">

   			<div class="pageItemWrap" id="userBasicInfo">
						<div class="page-title">基本信息</div>
						<div class="pageItem">
							<div class="headImgWrap">
								<!-- 头像显示与修改 ,放在左侧  -->
								<div class="imgTitle">当前头像:</div>
								<div class="imgPreview">
									<img id="currentImgId" src=".<s:property value='user.image.pathName'/>"/>
								</div>
								<span class="uploadSigleFile"> 
									<span class="uploader blueChooser"> 
										<input type="text"	class="filename " readonly="readonly" /> 
										<input type="button" class="fileButton" value="选择" /> 
										<input type="file"  accept="image/*" name="file"	size="30" /> 
									</span> 
									<span class="uploader"> 
										<input	type="button" id="uploadHeadImgBtn" class="button blue" value="上传" /> 
									</span> 
								</span>
							</div>
							<div class="basicInfoWrap">
								<div class="item">
									<div class="title">登录账号：</div>
									<div class="content" ><s:property value='user.userName'/></div>
								</div>
								<div class="item">
									<div class="title">密码：</div>
									<div class="content" id="currentPassword">******</div>
									<div class="operate">
										<a href="javascript:void(0);" id="currentPasswordBtn" class="button blue">修改</a> 
									</div>
								</div>
								<div class="item">
									<div class="title">姓名：</div>
									<div class="content" id="currentRealName"><s:property value='user.realName'/></div>
									<div class="operate">
										<a href="javascript:void(0);" id="currentRealNameBtn" class="button blue">修改</a> 
									</div>
								</div>
								<div class="item">
									<div class="title">性别：</div>
									<div class="content" id="currentSex"><s:property value='user.sex'/></div>
									<div class="operate">
										<a href="javascript:void(0);" id="currentSexBtn" class="button blue">修改</a> 
									</div>
								</div>
								<div class="item">
									<div class="title">生日：</div>
									<div class="content" id="currentBirthday"><s:date name='user.birthday' format="yyyy-MM-dd"/></div>
									<div class="operate" >
										<a href="javascript:void(0);" id="currentBirthdayBtn" class="button blue">修改</a> 
									</div>
								</div>
								<div class="item">
									<div class="title">电话：</div>
									<div class="content" id="currentPhone"><s:property value='user.phone'/></div>
									<div class="operate">
										<a href="javascript:void(0);"  id="currentPhoneBtn" class="button blue">修改</a> 
									</div>
								</div>
								<div class="item">
									<div class="title">座机号：</div>
									<div class="content" id="currentTelephone"><s:property value='user.telephone'/></div>
									<div class="operate" >
										<a href="javascript:void(0);" id="currentTelephoneBtn" class="button blue">修改</a> 
									</div>
								</div>
								<div class="item">
									<div class="title" >邮箱：</div>
									<div class="content" id="currentEmail"><s:property value='user.email'/></div>
									<div class="operate">
										<a href="javascript:void(0);" id="currentEmailBtn" class="button blue">修改</a> 
									</div>
								</div>
							</div>
							<!-- 个人简介 -->
						
							<div style="witdh:100%;text-align:center;font-size:24px;font-weight:bold;clear:both;">个人简介</div>
							<div class="personalIntro" id="currentDetail"><s:property escapeHtml="false" value="user.detail"/></div>
							<div class="operateIntro" ><a href="javascript:void(0);" id="currentDetailBtn" class="blue button">编辑</a></div>
						</div>
					</div>
				</div>
 </body>
</html>

