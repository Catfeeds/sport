<%@ page language="java" contentType="text/html; charset=UTF-8"  import="java.util.*" isELIgnored="false" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	basePath+="admin/";
%>
<!DOCTYPE html >
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>左右布局滑动切换Tab选项卡</title>
	<link href="../res/admin/css/managerDetail.css" rel="stylesheet" type="text/css" />
	<link href="../res/commonComponents/progressWork/css/progressWork.css" rel="stylesheet" type="text/css" />
	<!-- 引入日历组件 -->
	<link rel="stylesheet" type="text/css" href="../res/commonComponents/calendar/css/jcDate.css" media="all" />
	<!-- 引入控件美化组件 -->
	<link href="../res/css/component.css" type="text/css" rel="stylesheet" />
	<link href="../res/commonComponents/singleFileUpload/css/uploadSingleFile.css"	type="text/css" rel="stylesheet" />
	<script  src="../res/commonComponents/progressWork/js/event.js"></script>
	<script  src="../res/commonComponents/progressWork/js/tween.js"></script>
	<script type="text/javascript" src="../res/commonComponents/progressWork/js/jquery-1.8.3.min.js"></script>
	<!-- 引入在线编辑器 -->
	<script type="text/javascript" charset="utf-8" src="../res/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8"	src="../res/ueditor/ueditor.all.min.js"></script>
	<script type="text/javascript" charset="utf-8"	src="../res/ueditor/lang/zh-cn/zh-cn.js"></script>
	<!-- 引入下拉列表组件 -->
	<link href="../res/commonComponents/dropDownList/css/dropdownlist.css" rel="stylesheet" type="text/css">
	<script src="../res/commonComponents/dropDownList/js/dropdownlist.js"></script>
	<script src="../res/js/jquery.validate-1.13.1.js" type="text/javascript"></script>
<script type="text/javascript">
//系统检错
	//system error
	/*function myerror(_message,_url,_line)
		    {
		       alert("错误信息：" + _message
		            +"\n错误的URI：" + _url
		            +"\n错误的行数：" + _line
		       );
		 
		       return true; //屏蔽系统的事件
		    }
    //绑定错误事件
    window.onerror = myerror;*/
/*$(function(){	
	//权限操作
	//移到右边
	$('#add').click(function(){
		//先判断是否有选中
		if(!$("#allRights option").is(":selected")){			
			alert("请选择需要移动的选项")
		}
		//获取选中的选项，删除并追加给对方
		else{
			$('#allRights option:selected').appendTo('#rights');
		}	
	});
	
	//移到左边
	$('#remove').click(function(){
		//先判断是否有选中
		if(!$("#rights option").is(":selected")){			
			alert("请选择需要移动的选项")
		}
		else{
			$('#rights option:selected').appendTo('#allRights');
		}
	});
	
	//全部移到右边
	$('#add_all').click(function(){
		//获取全部的选项,删除并追加给对方
		$('#allRights option').appendTo('#rights');
	});
	
	//全部移到左边
	$('#remove_all').click(function(){
		$('#rights option').appendTo('#allRights');
	});
	
	//双击选项
	$('#allRights').dblclick(function(){ //绑定双击事件
		//获取全部的选项,删除并追加给对方
		$("option:selected",this).appendTo('#rights'); //追加给对方
	});
	
	//双击选项
	$('#rights').dblclick(function(){
		$("option:selected",this).appendTo('#allRights');
	});
	
});*/
</script>
</head>

<body>
<div class="tabmain">
  <div id="outerWrap">
    <div id="sliderParent"></div>
    <div class="blueline" id="blueline" style="top: 0px; "></div>
    <ul class="tabGroup">
      <li class="tabOption selectedTab">基本信息填写</li>
      <li class="tabOption">联系方式</li>
      <li class="tabOption">公司职位</li>
      <li class="tabOption">权限分配</li>
      <li class="tabOption">个人详情介绍</li>
    </ul>
    <div id="container">
      <div id="content">
        <div class="tabContent  selectedContent">
          <h3 style="">管理员个人基本信息</h3>
         
		  <div class="innerContent">
		  	  <dl>
		  	  	<div class="headImgWrap">
		  	  		<input type="hidden" name="managerId" value="<s:property value='manager.id'/>"/>
					<!-- 头像显示与修改 ,放在左侧  -->
						<div class="imgTitle">当前头像:</div>
						<div class="imgPreview">
							<img id="currentImgId" src="..<s:property value='manager.image.pathName'/>"/>
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
		  	  </dl>
			  <dl>
				<dt><span class="high">姓名：</span></dt>
				<dd>
					<div id="realName"><form id="realname-form">
						<div class="alterContent" id="currentRealName">${manager.realName }</div>
						<div class="alterBtn">
						<a href="javascript:void(0);" id="currentRealNameBtn" class="button blue">修改</a>
						</div>
					</form></div>
				</dd>
			  </dl>
			 <dl>
				<dt><span class="high">性别：</span></dt>
				<dd>
					<div id="sex">
						<div class="alterContent" id="currentSex">${manager.sex }</div>
						<div class="alterBtn">
						<a href="javascript:void(0);" id="currentSexBtn" class="button blue">修改</a>
						</div>
					</div>
				</dd>
			  </dl>
			  <dl>
				<dt><span class="high">生日：</span></dt>
				<dd>
					<div id="birthday">
						<div class="alterContent" id="currentBirthday">
							<s:date name="manager.birthday" format="yyyy-MM-dd"/>
						</div>
						<div class="alterBtn">
						<a href="javascript:void(0);" id="currentBirthdayBtn" class="button blue">修改</a> 
						</div>
					</div>		
				</dd>
			  </dl>
			  
			
		  </div>
        </div>
        <div class="tabContent">
          <h3>个人联系方式</h3>
         <div class="innerContent">
			  <dl>
				<dt><span class="high">手机号码：</span></dt>
				<dd>
					<div id="phone">
						<div class="alterContent"  id="currentPhone">${manager.phone }</div>
						<div class="alterBtn">
							<a href="javascript:void(0);"  id="currentPhoneBtn" class="button blue">修改</a>
						</div>
					</div>
				</dd>
			  </dl>
			  <dl>
				<dt><span class="high">家用电话号：</span></dt>
				<dd>
					<div id="telphone">
						<div class="alterContent"  id="currentTelephone">${manager.telephone }</div>
						<div class="alterBtn">
							<a href="javascript:void(0);" id="currentTelephoneBtn" class="button blue">修改</a>
						</div>
					</div>				
				</dd>
			  </dl>
			  
			  <dl>
				<dt><span class="high">邮箱：</span></dt>
				<dd>
					<div id="email">
						<div class="alterContent" id="currentEmail">${manager.email }</div>
						<div class="alterBtn">
							<a href="javascript:void(0);" id="currentEmailBtn" class="button blue">修改</a>
						</div>
					</div>				
				</dd>
			  </dl>
			   <dl>
				<dt><span class="high">邮编：</span></dt>
				<dd>
					<div id="postcode">
						<div class="alterContent" id="currentPostcode">${manager.postcode }</div>
						<div class="alterBtn">
							<a href="javascript:void(0);" id="currentPostcodeBtn" class="button blue">修改</a>
						</div>
					</div>				
				</dd>
			  </dl>
			  
		  </div>
        </div>
        <div class="tabContent">
          <h3>公司职位设定</h3>
           <div class="innerContentPosition">
			  <dl>
				<dt><span class="high">公司职位：</span></dt>
				<dd>
					<div id="levelPosition">
						<div class="alterContent">${manager.levelPosition }</div>
						<div class="alterBtn">
							<input type="button"  onclick="replaceEditor('levelPosition')"  class="button blue little" value="编辑">
						</div>
					</div>
				</dd>
			  </dl>
			    <dl>
				<dt><span class="high">登录账号：</span></dt>
				<dd>
					<div id="userName">
						<div class="alterContent" id="currentUserName">${manager.userName }</div>
						<div class="alterBtn">
						不可修改
						</div>
					</div>				
				</dd>
			  </dl>
			  <dl>
				<dt><span class="high">密码：</span></dt>
				<dd>
					<div id="password">
						<div class="alterContent"  id="currentPassword">${manager.password }</div>
						<div class="alterBtn">
						<a href="javascript:void(0);" id="currentPasswordBtn" class="button blue">修改</a>
						</div>
					</div>			
				</dd>
			  </dl>
			 
			</div>
        </div>
        <div class="tabContent"><!-- 权限分配 -->
          <h3>系统管理权限分配</h3>
		  <dl>
				<dt><span class="high">该管理员具有的权限：</span></dt>
				<dd>
					<div id="positionIntro">
						<div class="content">
							<s:iterator value="manager.roles">
								<s:iterator value="rights">									
										&nbsp;|&nbsp;									
									<s:property value='detail'/>
								</s:iterator>
							</s:iterator>
							<s:iterator value="manager.rights">									
										&nbsp;|&nbsp;									
									<s:property value='detail'/>
							</s:iterator>
						</div>
						
					</div>				
				</dd>
			  </dl>
		</div>
        
        <div class="tabContent">
          <h3>个人简介：</h3>
          <dl>
				<dt><span class="high">简介：</span></dt>
				<dd>
					<div id="detail">
						<div class="alterContent"  id="currentDetail">${manager.detail }</div>
						<div class="alterBtn">
							<a href="javascript:void(0);" id="currentDetailBtn" class="blue button">编辑</a>
						</div>
					</div>		
				</dd>
			  </dl>
        </div>        
     
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
$(function(){
///********************************************************校验//
});
</script>
<script>
/***********控制整个页面的分页滚动等特效**********/
var container=document.getElementById('container');
var content=document.getElementById('content');
var oDivs=DOM.children(content,"div");oDivs[0].st=0;
for(var i=1;i<oDivs.length;i++){oDivs[i].st=oDivs[i].offsetTop;}
var oLis=DOM.getElesByClass("tabOption");
var flag=0;
var upFlag=oLis.length;
;(function(){function fn(e){e=e||window.event;
	if(e.wheelDelta){var n=e.wheelDelta;}else if(e.detail){var n=e.detail*-1;}	
	if(n>0){container.scrollTop-=12;}else if(n<0){	container.scrollTop+=12;}
	 slider.style.top=container.scrollTop*container.offsetHeight/content.offsetHeight+"px";
	 slider.offsetTop*(content.offsetHeight/container.offsetHeight);	
	var st=container.scrollTop;
	if(st>this.preSt){
			for(var j=0;j<oLis.length;j++){	if(st<oDivs[j].st) break;}						
			if(oLis[j-2]&&this.preLi!==j){
				if((j)>(flag+1)){DOM.removeClass(oLis[j-2],"selectedTab");	DOM.addClass(oLis[j-1],"selectedTab");animate(blueline,{top:(j-1)*48},500,2);}}	flag=j-1;		
		}else if(st<this.preSt){			
			for(var j=oLis.length-1;j>=0;j--){if(st>oDivs[j].st) break;}
			if(oLis[j+2]&&this.preLi!==j){if(flag===undefined)return ;				
					if((j)<(flag)){	for(var k=0;k<oLis.length;k++){	DOM.removeClass(oLis[k],"selectedTab");};DOM.addClass(oLis[j+1],"selectedTab");	animate(blueline,{top:(j+1)*48},500,2);upFlag=j+1;}}}	this.preSt=st;if(e.preventDefault)e.preventDefault();return false;}
container.onmousewheel=fn;
if(container.addEventListener)container.addEventListener("DOMMouseScroll",fn,false);
slider=document.createElement('span');
slider.id="slider";
slider.style.height=container.offsetHeight*(container.offsetHeight/content.offsetHeight)+"px";
sliderParent.appendChild(slider);
on(slider,"mousedown",down);
var blueline=document.getElementById("blueline");
function changeTab(){
	var index=DOM.getIndex(this);	
	for(var i=0;i<oLis.length;i++){	DOM.removeClass(oLis[i],"selectedTab");	}
	DOM.addClass(this,"selectedTab");	
	animate(container,{scrollTop:oDivs[index].st},500,1);
	var t=oDivs[index].st*container.offsetHeight/content.offsetHeight;	
	animate(slider,{top:t},500);animate(blueline,{top:index*48},500,2);	
}
var tabPannel1=document.getElementById("outerWrap");
var oLis=DOM.children(DOM.children(tabPannel1,"ul")[0],"li");
for(var i=0;i<oLis.length;i++){	oLis[i].onclick=changeTab;};
})();
</script>
<script type="text/javascript" src="../res/commonComponents/calendar/js/jQuery-jcDate.js" charset="utf-8"></script>
<script type="text/javascript">
	$(function(){
		var managerId=$("input[name=managerId]").val();
		//alert(managerId);
		$("#uploadHeadImgBtn").click(
			function(){
				var data = new FormData();  
				data.append('manager.id',managerId); 
			    data.append('file', $('input[name=file]')[0].files[0]);  
			    $.ajax({  
			        url: 'managerandalterHeadImg',  
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
						$("#currentImgId").attr('src',".."+arr[1]);
						$('input[name=file]').val('');
					}else{
						alert(arr[1]);
					}	
			    });  
			    return false;  
		});
		//后台处理的路径
		var operateUrl="managerandalterManagerInfo";
		//密码
		var currentPasswordId="#currentPassword";
		var currentPasswordIdBtn=currentPasswordId+"Btn";
		var currentPasswordContent="<input type='password' name='manager.password' id='currentPassowrdInput'  class='inputText textLength1'/>";
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
					 	{   "manager.password":newPassword,
					 		"alterFlag":"password",
					 		"manager.id":managerId
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
		var currentRealNameContent="<input type='text' name='manager.realName' id='currentRealNameInput' class='inputText textLength1'/>";
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
					 	{   "manager.realName":newValue,
					 		"alterFlag":"realName",
					 		"manager.id":managerId
					 	 },
						function(data){
							var arr=new Array();
							$.each(data, function(i, item) {
								arr.push(item);					           
							});
							if(arr[0]){//true时表示操作成功，更改界面元素状态								
								$(currentRealNameIdBtn).html("修改");
								$(currentRealNameId).html(newValue);
							}else{
								alert(arr[1]);
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
					 	{   "manager.sex":newValue,
					 		"alterFlag":"sex",
					 		"manager.id":managerId
					 	 },
						function(data){
							var arr=new Array();
							$.each(data, function(i, item) {
								arr.push(item);					           
							});
							if(arr[0]){//true时表示操作成功，更改界面元素状态								
								$(currentSexIdBtn).html("修改");
								$(currentSexId).html(newValue);
							}else{
								alert(arr[1]);
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
					content=$.trim(content);
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
					 	{   "manager.birthday":newValue,
					 		"alterFlag":"birthday",
					 		"manager.id":managerId
					 	 },
						function(data){
							var arr=new Array();
							$.each(data, function(i, item) {
								arr.push(item);					           
							});
							if(arr[0]){//true时表示操作成功，更改界面元素状态								
								$(currentBirthdayIdBtn).html("修改");
								$(currentBirthdayId).html(newValue);
							}else{
								alert(arr[1]);
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
					 	{   "manager.phone":newValue,
					 		"alterFlag":"phone",
					 		"manager.id":managerId
					 	 },
						function(data){
							var arr=new Array();
							$.each(data, function(i, item) {
								arr.push(item);					           
							});
							if(arr[0]){//true时表示操作成功，更改界面元素状态								
								$(currentPhoneIdBtn).html("修改");
								$(currentPhoneId).html(newValue);
							}else{
								alert(arr[1]);
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
					 	{   "manager.telephone":newValue,
					 		"alterFlag":"telephone",
					 		"manager.id":managerId
					 	 },
						function(data){
							var arr=new Array();
							$.each(data, function(i, item) {
								arr.push(item);					           
							});
							if(arr[0]){//true时表示操作成功，更改界面元素状态								
								$(currentTelephoneIdBtn).html("修改");
								$(currentTelephoneId).html(newValue);
							}else{
								alert(arr[1]);
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
					 	{   "manager.email":newValue,
					 		"alterFlag":"email",
					 		"manager.id":managerId
					 	 },
						function(data){
							var arr=new Array();
							$.each(data, function(i, item) {
								arr.push(item);					           
							});
							if(arr[0]){//true时表示操作成功，更改界面元素状态								
								$(currentEmailIdBtn).html("修改");
								$(currentEmailId).html(newValue);
							}else{
								alert(arr[1]);
							}												
					},'json'); 
					
				}
			}
		);
		//邮编
		var currentPostcodeId="#currentPostcode";
		var currentPostcodeIdBtn=currentPostcodeId+"Btn";
		var currentPostcodeContent="<input type='text' name='postcode' class='inputText textLength1'/>";
		$(currentPostcodeIdBtn).click(
			function(){
				
				if($(currentPostcodeIdBtn).html()=="修改"){
					var content=$(currentPostcodeId).html();
					$(currentPostcodeIdBtn).html("确定");
					$(currentPostcodeId).html(currentPostcodeContent);					
					$("input[name=postcode]").val(content);
				}else{
					var newValue=$("input[name=postcode]").val();
					
					$.post(operateUrl,
					 	{   "manager.postcode":newValue,
					 		"alterFlag":"postcode",
					 		"manager.id":managerId
					 	 },
						function(data){
							var arr=new Array();
							$.each(data, function(i, item) {
								arr.push(item);					           
							});
							if(arr[0]){//true时表示操作成功，更改界面元素状态								
								$(currentPostcodeIdBtn).html("修改");
								$(currentPostcodeId).html(newValue);
							}else{
								alert(arr[1]);
							}												
					},'json'); 
					
				}
			}
		);
		//个人简介
		var currentDetailId="#currentDetail";
		var currentDetailIdBtn=currentDetailId+"Btn";
		var currentDetailContent="<div>产品详情：</div>"+
								"<div style='clear:both;'></div>"+
								"<textarea style='height:200px;width:400px;' name='detail' id='personDetail'></textarea>";
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
					 	{   "manager.detail":newValue,
					 		"alterFlag":"detail",
					 		"manager.id":managerId
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
							}else{
								alert(arr[1]);
							}												
					},'json'); 
					
				}
			}
		);
		
	});
	$(function(){
		$("input[type=file]").change(function(){$(this).parents(".uploader").find(".filename").val($(this).val());});
		$("input[type=file]").each(function(){
		if($(this).val()==""){$(this).parents(".uploader").find(".filename").val("请选择你喜欢的头像...");}
		});
	});
</script>

<div style="text-align:center;margin:50px 0; font:normal 14px/24px 'MicroSoft YaHei';">
</div>
</body>
</html>
