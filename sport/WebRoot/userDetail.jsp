<%@ page language="java"  contentType="text/html; charset=UTF-8" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<%@ taglib uri="/struts-tags" prefix="s"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>用户个人信息</title>
    <meta name="description" content="">
    <meta name="author" content="templatemo">
    
    <link href='http://fonts.useso.com/css?family=Open+Sans:400,300,400italic,700' rel='stylesheet' type='text/css'>
    <link href="res/css/font-awesome.min.css" rel="stylesheet">
    <link href="res/css/bootstrap.min.css" rel="stylesheet">
    <link href="res/css/templatemo-style.css" rel="stylesheet">
<!-- 弹出登录注册对话框 -->
	<link rel="stylesheet" href="res/commonComponents/loginPopDialog/css/loginbox.css"  type="text/css"/>
	<script type="text/javascript" src="res/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="res/js/header.js"></script>
	<!-- 弹出框结束 -->
	<!-- 引入日历组件 -->
		<link rel="stylesheet" type="text/css" href="res/commonComponents/calendar/css/jcDate.css" media="all" />		
		<script type="text/javascript" src="res/commonComponents/calendar/js/jQuery-jcDate.js" charset="utf-8"></script>
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="js/html5shiv.min.js"></script>
      <script src="js/respond.min.js"></script>
    <![endif]-->
    
    <script src="res/js/jquery.validate-1.13.1.js" type="text/javascript"></script>
    
<style>

		.pre-file-box {
		position: relative;
		width: 110px;
		float:right;
		
	}
	.pre-btn {
		background-color: #FFF;
		border: 1px solid #CDCDCD;
		margin: 10px 20px;
		height: 40px;
		width: 100px;
	}

	.pre-file {
		position: absolute;
		height: 80px;
		filter: alpha(opacity: 0);
		opacity: 0;
		width: 100px;
		border: 2px dashed #f00;
	}
	 #preheadimg img  {  
 		width:150px;  
		 height:120px; 
		 float: left;
 	}  	
 	.wrong+div{
 		color:#f00;
 		float:left;
 		letter-spacing:1px;
 		margin-left:5px;
 	}
</style>
  </head>
  <body>
  <!-- header -->
<iframe src="header" scrolling="no" frameborder="0" width="100%" height="190px"></iframe>
<!-- /header -->
    <!-- Left column -->
    
<div style="width:1000px; margin: auto auto 20px auto;">
		<div class="templatemo-flex-row">
			<div class="templatemo-sidebar" style="float: left;">
				<div class="profile-photo-container">
					<img src=".<s:property value='#session.currentUser.image.pathName'/>" alt="个人头像" class="img-responsive">
						<h3 style="text-align: center; padding: 5px;"><s:property value='#session.currentUser.realName'/></h3>
				</div>
				
				<nav class="templatemo-left-nav">
				<ul>
						<li><a href="userHome"><i class="fa fa-home fa-fw"></i>个人首页</a></li>
			            <li><a href="useranduserDetail"   class="active">个人资料管理</a></li>
			            <li><a href="orderanduserOrderList">订单管理</a></li>
			            <li><a href="forumanduserCaredForum">关注的圈子</a></li>
			            <li><a href="articleanduserArticleList">我的帖子</a></li>
					</ul>
				</nav>
			</div>
      <!-- Main content -->
      <div class="templatemo-content col-1 light-gray-bg" style=" width:80%;float:right;">
        <div class="templatemo-content-container templatemo-content-widget white-bg">
            <form class="templatemo-login-form" id="UserDetail-form"
             action="userandalterUser" method="post" enctype="multipart/form-data">
           <br /><br />
             <div class="row form-group">
                <div class="col-lg-6 col-md-6 form-group"> 
                	<label >新头像预览：</label>
                  <div style="width: 280px; height: 85px;margin-left:40PX; margin-buttom:10px">
						<div class="pre-file-box">
						<input type="file" class="pre-file" name="file" onchange="preheadimg(this);document.getElementById('textfield').value=this.value" />
						<input type='button' class='pre-btn' value='选择图片...' />
						</div>
						<div id="preheadimg"></div>
				</div>
                </div>
              </div>
             
              <div class="row form-group">
                <div class="col-lg-6 col-md-6 form-group">                  
                    <label for="inputUserName">登录名：</label>
                    <input type="text" readonly="readonly" class="form-control" id="inputUserName" name="user.userName" value="<s:property value='user.userName'/>" placeholder="<s:property value='user.userName'/>">                  
                </div>
              </div>
              <!--  ******************************************          -->
              <div class="row form-group">
                <div class="col-lg-6 col-md-6 form-group">                  
                    <label for="inputName">姓名：</label>
                    <input type="text" class="form-control" id="inputName" name="user.realName" value="<s:property value='user.realName'/>" placeholder="<s:property value='user.realName'/>">                                 
                </div>
              </div>
              <!--  ******************************************          -->
              <div class="row form-group">
                <div class="col-lg-6 col-md-6 form-group">                  
                    <label for="inputPassword">密码</label>
                    <input type="password" class="form-control" name="user.password" id="inputPassword" value="<s:property value='user.password'/>"  placeholder="*************">                  
                </div>
              </div>
              <!--  ******************************************          -->
             <div class="row form-group">
                <div class="col-lg-6 col-md-6 form-group">  
                    
                    <div class="templatemo-block margin-bottom-5">
                    	<label>性别</label> &emsp;&emsp;&emsp;
                    	<s:if test="user.sex.equals(\"男\")">
                    		<input type="radio" name="user.sex" id="r1" value="男" checked>
                     		<label for="r1" class="font-weight-400"><span></span>先生</label>&emsp;
                     		<input type="radio" name="user.sex" id="r2" value="女">
                      		<label for="r2" class="font-weight-400"><span></span>女士</label>
                    	</s:if>
                    	<s:else>
                    		<input type="radio" name="user.sex" id="r1" value="男" >
                     		<label for="r1" class="font-weight-400"><span></span>先生</label>&emsp;
                     		<input type="radio" name="user.sex" id="r2" value="女" checked>
                      		<label for="r2" class="font-weight-400"><span></span>女士</label>
                    	</s:else>   
                    </div>       
                </div>
              </div>
               <!--  ******************************************          -->
               <div class="row form-group">
              	<div class="col-lg-6 col-md-6 form-group">                  
                    <label for="inputBirthday">生日</label>
                    <input type="text" class="form-control" name="user.birthday" id="inputBirthday" value="<s:date name='user.birthday' format='yyyy-MM-dd'/>" placeholder="<s:date name='user.birthday' format='yyyy-MM-dd'/>">
                </div>
              </div>
              <!--  ******************************************          -->
              <div class="row form-group">
                  <div class="col-lg-6 col-md-6 form-group">                  
                    <label for="inputEmail">邮箱</label>
                    <input type="emails" class="form-control" name="user.email" id="inputEmail" value="<s:property value='user.email'/>" placeholder="<s:property value='user.email'/>">                  
                </div>                
              </div>
              <!--  ******************************************          -->
              <div class="row form-group">
                <div class="col-lg-6 col-md-6 form-group">                  
                    <label for="inputPhone">手机</label>
                    <input  type="tel" class="form-control" name="user.phone" id="inputPhone" value="<s:property value='user.phone'/>" placeholder="<s:property value='user.phone'/>">
                </div>
                </div>
               <!--  ******************************************          -->

              <div class="row form-group">
                <div class="col-lg-6 form-group">                   
                    <label class="control-label" for="inputNote">个人简介</label>
                    <textarea class="form-control" name="user.detail" id="inputNote" rows="3"><s:property escapeHtml="false" value="user.detail"/></textarea>
                </div>
              </div>
     
              <div class="form-group text-left">
              	<div style="margin-left: 20%; padding-bottom: 10px;;">
                <button type="submit" class="templatemo-blue-button">&emsp;修&emsp;改&emsp;</button>
                &emsp;&emsp;
                <button type="reset" class="templatemo-white-button">&emsp;重&emsp;置&emsp;</button>    
              	</div>
              </div>
            </form>
          </div>

        </div>
      </div>
    </div>

    <!-- JS -->
    
	<script type="text/javascript">
		 function preheadimg(file) {
			var prevDiv = document.getElementById('preheadimg');
			
			if (file.files && file.files[0]) {
				var reader = new FileReader();
				reader.onload = function(evt) {
					
					prevDiv.innerHTML = '<img src="' + evt.target.result + '" />';
				}
				reader.readAsDataURL(file.files[0]);
			} else {
				prevDiv.innerHTML = '<div class="img" style="filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src=\'' + file.value + '\'"></div>';
			}
		}
		$(function(){
				
				$("#inputBirthday").jcDate({					       
							IcoClass : "jcDateIco",
							Event : "click",
							Speed : 100,
							Left : 0,
							Top : 28,
							format : "-",
							Timeout : 100
			});
			
			
			
			
			
		});
		
	</script>
	<script type="text/javascript">
	//表单校验
    $(document).ready(function () {
		$("#UserDetail-form").validate({
		 	rules:{
 				"user.realName":{
 					minlength:2,
 					maxlength:10
 				},
 				"user.password":{
 					required:true,
 					minlength:4,
 					maxlength:16
 				},
 				"user.email":{
 					email:true
 				}
 			},
 			messages:{
 				"user.realName":{
 					minlength:"用户姓名最小长度为2位",
 					maxlength:"用户姓名最大长度为10位"
 				},
 				"user.password":{
 					required:"密码为必填",
 					minlength:"密码最小长度为4位",
 					maxlength:"密码最大长度为16位"
 				},
 				"user.email":{
 					email:"请填写正确的邮箱格式 必须包含@.com等字样"
 				}
 			},
 			errorClass:"wrong",
 			errorElement:"div"  
		});
	});
	
	
	</script>  
  	
  
  	<iframe src="footer.jsp" scrolling="no" frameborder="0" width="100%" height="165px"></iframe>
  	
  </body>
</html>
