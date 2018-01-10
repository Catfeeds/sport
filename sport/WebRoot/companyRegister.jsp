<%@ page language="java"  contentType="text/html; charset=UTF-8" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE HTML >
<html>
  <head>
    <base href="<%=basePath%>">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="res/commonComponents/singleFileUpload/css/uploadSingleFile.css"	type="text/css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="res/css/merchantsSettled.css">
    <!-- 引入控件美化组件 -->
		<link href="res/css/component.css" type="text/css" rel="stylesheet" />
		<script src="res/js/jquery.validate-1.13.1.js" type="text/javascript"></script>
		<!-- 弹出登录注册对话框 -->
	<link rel="stylesheet" href="res/commonComponents/loginPopDialog/css/loginbox.css"  type="text/css"/>
	<script type="text/javascript" src="res/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="res/js/header.js"></script>
	<!-- 弹出框结束 -->
    <title>商家入驻</title>
<script type="text/javascript">
	$(function(){
		$("input[type=file]").change(function(){$(this).parents(".uploader").find(".filename").val($(this).val());});
		$("input[type=file]").each(function(){			
			if($(this).val()==""){$(this).parents(".uploader").find(".filename").val("请选择您公司的注册凭证...");}
		});
	});
</script>

</head>
  <body>
    <!--固定头部-->
    <iframe src="header" frameborder="0" scrolling="no" width="100%" height="190px"></iframe>
   
    <div class="merchantsSettledBox">
      <!--这里是流程图-->
      <div style="float:left" class="flowChat">
        <img src="res/images/processpic.png"/>
      </div>

      <!--这里是申请表-->
     <form action="companyandaddCompany" method="post" enctype="multipart/form-data" id="company-form">
     <p style="color:red;">&nbsp;&nbsp;&nbsp;！注意：*为必填项</p>
      <div class="merchantsSettled" style="float:left;margin-left:15px">      	  
			<div class="logoImg">			
				<span class="uploadSigleFile"> 
					<span style="width:200px;">商家入驻凭证:</span>
					<span class="uploader blueChooser"> 
						<input type="text"	class="filename " readonly="readonly" /> 
						<input type="button" class="fileButton" value="选择  *" /> 
						<input type="file"	 name="file" size="30" />  
					</span> 
				</span>				
			</div>
		
        <div class="enterInfo" style="margin-top:0px">
          <div class="titdiv">商家法人姓名：</div>
          <input class="input"  type="text" name="manager.realName" placeholder="请填写申请人" /> *
        </div>
        <div class="enterInfo">
          <div  class="titdiv">公司热线电话：</div>
          <input class="input"  type="text" name="company.phone" placeholder="请填写申请人电话" /> *
        </div>
        <div class="enterInfo">
          <div  class="titdiv">商&nbsp;家&nbsp;名&nbsp;称：&nbsp;&nbsp;&nbsp;</div>
          <input class="input"  type="text" name="company.companyName" placeholder="请填写商家名称" /> *
        </div>
        <div class="enterInfo">
          <div  class="titdiv">管理员账号申请：</div>
          <input class="input"  type="text" name="manager.userName" placeholder="请填写管理员账号" /> *
        </div>
        <div class="enterInfo">
          <div  class="titdiv">管理员密码填写：</div>
          <input class="input"  type="password" name="manager.password" placeholder="请填写后台登陆密码" /> *
        </div>
        <div class="enterInfo">
          <div  class="titdiv">管理员密码确认：</div>
          <input class="input"  type="password" name="manager.passwordConfirm" placeholder="请填写后台登陆密码" /> *
        </div>
        <div class="enterInfo" style="height:70px">
          <div  class="titdiv">商&nbsp;家&nbsp;地&nbsp;址：</div>
          <div style="margin-left:50px">
         	 <select id="province" >
         	   <s:iterator value="rootAddrs">
	            	<option value="<s:property value='id'/>"><s:property value='addressName'/></option>
	           </s:iterator>
	         </select> 
	         <select id="city" >
	           <s:iterator value="rootAddrs[0].childrenAddress">
	            	<option value="<s:property value='id'/>"><s:property value='addressName'/></option>
	           </s:iterator>
	         </select> 
	         <select id="region" name="company.address.id">
	             <s:iterator value="rootAddrs[0].childrenAddress[0].childrenAddress">
	           		<option value="<s:property value='id'/>"><s:property value='addressName'/></option>
	            </s:iterator>
	          </select> *
			</div>
        </div>
        <div class="enterInfo" style="height:160px">
            <div class="titdiv">商&nbsp;家&nbsp;简&nbsp;介：&nbsp;</div>
          <textarea class="sizeOfInput" name="company.introduction" style="resize:none; text-align:left;font-family:微软雅黑;font-size:16px;color:#333;width:400px"   placeholder="这里是商家简介" rows="6" ></textarea>
        </div>     
	<br/>
        <div>
          <input class="submit" type="submit" value="提交申请" style="float:right;margin-top:10px;margin-right:25px"/>
        </div>
      </div>
		</form>
</div>
    <!--固定尾部-->
    <div>
      <iframe src="footer.jsp" frameborder="0" scrolling="no" width="100%" height="175px"></iframe>
    </div>
	<script type="text/javascript">
		$(function(){
			//添加省份选择联动
			$("#province").change(function(){	
				 getChildAddrs(this.value,"#city","#region");
			});
			$("#city").change(function(){	
				getChildAddrs($("#city option:selected").val(),"#region");
			});
			function getChildAddrs(addressId,selectId,childSelectId){
				$.post("addressandgetChildAddrs",
					{ "address.id":addressId },
						function(data){
						 //解析数组,获取该类别下所有子项
						 	var options="";    	
							 $.each(data, function(i, item) {
							   options+="<option value='"+item.id+"'>"+item.addressName+"</option>";					           
							 });
							 if(options=="")
							 	options+="<option value='-1'>暂无子地区</option>";
							    //alert(options);
							    $(selectId).html(options);
							    //如果还有子地区继续初始化					    
								if(childSelectId){
									//alert($(selectId+" option:first").val());
									getChildAddrs($(selectId+" option:first").val(),childSelectId);
								}						
				},"json"); 	
			}
			
			
			
			
			
			
			
			//表单校验***********************************
		$("#company-form").validate({
		 	rules:{
 				"company.companyName":{
 					required:true,
 					minlength:2
 				},
 				"company.phone":{
 					required:true,
 					digits:true,
 					minlength:11,
 					maxlength:12
 				},
 				"manager.realName":{
 					required:true,
 					minlength:2,
 					maxlength:10
 				},
 				"manager.userName":{
 					required:true,
 					minlength:2,
 					maxlength:10
 				},
 				"manager.password":{
 					required:true,
 					minlength:4,
 					maxlength:16
 				},
 				"manager.passwordConfirm":{
 				 equalTo:"#managerpassword"
 				}
 			},
 			messages:{
 				"company.companyName":{
 					required:"必填项",
 					minlength:"用户名最小为2位"
 				},
 				"company.phone":{
 					required:"必填项",
 					digits:"请填写正确号码",
 					minlength:"号码长度不对",
 					maxlength:"号码长度不对"
 				},
 				"manager.realName":{
 					required:"必填项",
 					minlength:"用户名最小为2位",
 					maxlength:"最大为10位"
 				},
 				"manager.userName":{
 					required:"必填项",
 					minlength:"登录名最小为2位",
 					maxlength:"最大为10位"
 				},
 				"manager.password":{
 					required:"必填项",
 					minlength:"密码最小为4位",
 					maxlength:"密码最大为16位"
 				},
 				"manager.passwordConfirm":{
 				 equalTo:"两次密码不一致"
 				}
 
 			},
 			errorClass:"wrong",
 			errorElement:"span"  
		});
		
		});
	</script>
  </body></html>