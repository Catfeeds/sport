<%@ page language="java"  contentType="text/html; charset=UTF-8" import="java.util.*" pageEncoding="UTF-8"%>
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
	<link href="../res/commonComponents/progressWork/css/progressWork.css" rel="stylesheet" type="text/css" />
	<!-- 引入日历组件 -->
	<link rel="stylesheet" type="text/css" href="../res/commonComponents/calendar/css/jcDate.css" media="all" />
	<!-- 引入控件美化组件 -->
	<link href="../res/css/component.css" type="text/css" rel="stylesheet" />
	
	<script  src="../res/commonComponents/progressWork/js/event.js"></script>
	<script  src="../res/commonComponents/progressWork/js/tween.js"></script>
	<script type="text/javascript" src="../res/js/jquery-1.8.3.min.js"></script>
	<!-- 引入下拉列表组件 -->
	<link href="../res/commonComponents/dropDownList/css/dropdownlist.css" rel="stylesheet" type="text/css">
	<script src="../res/commonComponents/dropDownList/js/dropdownlist.js"></script>
	<!-- 引入在线编辑器 -->
	<script type="text/javascript" charset="utf-8" src="../res/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8"	src="../res/ueditor/ueditor.all.min.js"></script>
	<script type="text/javascript" charset="utf-8"	src="../res/ueditor/lang/zh-cn/zh-cn.js"></script>
	<script src="../res/js/jquery.validate-1.13.1.js" type="text/javascript"></script>
	<Style>
	.wrong+span{
 		color:#f00;

 		letter-spacing:1px;
 		margin-left:10px;
 	}	
	</Style>
<script type="text/javascript">

$(function(){

			// 生成在线编辑器		
			
			var ue1 = UE.getEditor('managerDetail',{
		        initialFrameWidth : 480,
		        initialFrameHeight: 200
		    });
		    ue1.render('myEditor2',{
		        autoFloatEnabled : false
		    });
			$("#managerDetail").show();	
			var ue2=UE.getEditor("managerPositionInfo",{
		        initialFrameWidth : 480,
		        initialFrameHeight: 200
		    });
		    ue2.render('myEditor2',{
		        autoFloatEnabled : false
		    });
			$("#managerPositionInfo").show();
			
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
	//初始化下拉列表
	 // 通过原生select控件创建自定义下拉框
    var ddl_picture = DropDownList.create({
        select:$('#nationality'),
        attrs:{
            column :5,
            width :200,
			
        }
    });
	ddl_picture.change(function(){
		//alert(ddl_picture.val());
	});
});
</script>
</head>

<body>
<div class="tabmain">
<form action="managerandaddManager" method="post" id="addmanager-form">
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
            <p style="color:red; float:left">*为必填信息</p>
		  <div class="innerContent">
		
			  <dl>
				<dt><span class="high">姓名：</span></dt>
				<dd>
					<input type="text" name="manager.realName" class="inputText textLength1"></input> *
				</dd>
			  </dl>
			 <dl>
				<dt><span class="high">性别：</span></dt>
				<dd>
					<input type="radio" name="manager.sex" checked="checked" value="男"/>&nbsp;男&nbsp;&nbsp;
					<input type="radio" name="manager.sex" value="女"/>&nbsp;女
				</dd>
			  </dl>
			  <dl>
				<dt><span class="high">生日：</span></dt>
				<dd>
					<input type="text" id="managerBirthday" name="manager.birthday" class="inputText textLength1"></input>				
				</dd>
			  </dl>
			  <dl>
				<dt><span class="high">国籍：</span></dt>
				<dd>
					<select id="nationality" name="manager.nationality">
							<option value="中国">中国</option>
							<option value="美国">美国</option>
							<option value="印度">印度</option>
							<option value="俄罗斯">俄罗斯</option>
							<option value="英国">英国</option>
							<option value="澳大利亚">澳大利亚</option>
						</select>
				</dd>
			  </dl>
			  <dl>
				<dt><span class="high">登录账户名：</span></dt>
				<dd>
					<input type="text" name="manager.userName" class="inputText textLength1"></input> *				
				</dd>
			  </dl>
			  <dl>
				<dt><span class="high">密码：</span></dt>
				<dd>
					<input type="password" name="manager.password" id="managerpassword" class="inputText textLength1"></input> *				
				</dd>
			  </dl>
			  <dl>
				<dt><span class="high">密码确认：</span></dt>
				<dd>
					<input type="password" name="manager.passwordConfirm" class="inputText textLength1"></input> *				
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
					<input type="text" name="manager.phone" class="inputText textLength1"></input>
					
				</dd>
			  </dl>
			  <dl>
				<dt><span class="high">家用电话号：</span></dt>
				<dd>
					<input type="text" name="manager.telephone" class="inputText textLength1"></input>				
				</dd>
			  </dl>
			  
			  <dl>
				<dt><span class="high">邮箱：</span></dt>
				<dd>
					<input type="text" name="manager.email" class="inputText textLength1"></input>				
				</dd>
			  </dl>
			  <dl>
				<dt><span class="high">邮编：</span></dt>
				<dd>
					<input type="text" name="manager.postcode" class="inputText textLength1"></input>				
				</dd>
			  </dl>
			  
		  </div>
        </div>
        <div class="tabContent">
          <h3>公司职位设定</h3>
           <div class="innerContentPosition">
			  <dl>
				<dt><span class="high">职位简介：</span></dt>
				<dd>
					<textarea  id="managerPositionInfo" name="manager.positionIntro"></textarea>				
				</dd>
			  </dl>
			</div>
        </div>
        <div class="tabContent">
          <h3>系统管理权限分配</h3>
		  <div class="selectbox">
			<div class="select-bar">
				<select multiple="multiple" id="allRights">
					<s:iterator value="manager.roles">
						<s:iterator value="rights">
						<option value="<s:property value='id'/>" checked="checked"><s:property value='detail'/></option>
						</s:iterator>
					</s:iterator>
					<s:iterator value="manager.rights">
						<option value="<s:property value='id'/>" checked="checked"><s:property value='detail'/></option>
					</s:iterator>
				</select>
			</div>

			<div class="btn-bar">
				<p><span id="add">
					<input type="button" value=">"  class="button blue little" title="移动选择项到右侧"/>
				</span></p>
				<p><span id="add_all">
					<input type="button" value=">>" title="全部移到右侧" class="button blue little"/>
				</span></p>
				<p><span id="remove">
					<input type="button" value="<" title="移动选择项到左侧" class="button blue little"/>
				</span></p>
				<p><span id="remove_all">
					<input type="button"  value="<<" title="全部移到左侧" class="button blue little"/>
				</span></p>
			</div>

			<div class="select-bar">
				<select multiple="multiple"   id="rights"></select>
			</div>	
			<div id="hiddenDataDiv">
				
			</div>
		</div>
        </div>
        <div class="tabContent">
          <h3>个人简介：</h3>
          <dl>
				<dt><span class="high">简介：</span></dt>
				<dd>
					<textarea  id="managerDetail" name="manager.detail"></textarea>				
				</dd>
			  </dl>
        </div>        
     
      </div>
    </div>
  </div>
 <div style="margin:0 auto; text-align:center;margin-top:5px;border-top:2px solid rgb(222,222,222);padding-top:5px;">
	(填写完所有的信息再提交)&nbsp;&nbsp;<input type="submit" onclick="onSubmit();" value="提交" class="blue button little">
</div>
</form>
</div>
<script>
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
	$(function (){
		$("input#managerBirthday").jcDate({					       
				IcoClass : "jcDateIco",
				Event : "click",
				Speed : 100,
				Left : 0,
				Top : 28,
				format : "-",
				Timeout : 100
		});
		
		///********************************************************校验//
	$("#addmanager-form").validate({
		 	rules:{
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
 				},
 				"manager.phone":{
 					required:true,
 					digits:true,
 					minlength:11,
 					maxlength:11
 				},
 				"manager.email":{
 					email:true,
 				},
 				"manager.postcode":{
 					digits:true,
 					minlength:6,
 					maxlength:6
 				}
 				
 			},
 			messages:{
 				"manager.realName":{
 					required:"必填项",
 					minlength:"用户名最小为2位",
 					maxlength:"用户名最大为10位"
 				},
 				"manager.userName":{
 					required:"必填项",
 					minlength:"登录名最小为2位",
 					maxlength:"登录名最大为10位"
 				},
 				"manager.password":{
 					required:"必填项",
 					minlength:"密码最小为4位",
 					maxlength:"密码最大为16位"
 				},
 				"manager.passwordConfirm":{
 				 equalTo:"两次密码填写不正确"
 				},
 				"manager.phone":{
 					required:"必填项",
 					digits:"请填写正确11位手机号",
 					minlength:"请填写正确11位手机号",
 					maxlength:"请填写正确11位手机号"
 				},
 				"manager.email":{
 					email:"请填写正确email地址包含@.com等字符",
 				},
 				"manager.postcode":{
 					digits:"请填写正确6位国内邮编",
 					minlength:"请填写正确6位国内邮编",
 					maxlength:"请填写正确6位国内邮编"
 				}
 			},
 			errorClass:"wrong",
 			errorElement:"span"  
		});
		
		
	});
	function onSubmit(){
		var rights="";
		$("select#rights option").each(function(index){
			if(index==0)
				rights+=$(this).val();
			else
				rights+=","+$(this).val();
		});
		/*alert(rights);
		$("select[name=rights]").val(rights);
		var rights1=$("select[name=rights]").val();*/
		var html="<input type='hidden' name='ids' value='"+rights+"' />";
		$("#hiddenDataDiv").append(html);
		//alert(rights);
		//return false;
	}
</script>
<div style="text-align:center;margin:50px 0; font:normal 14px/24px 'MicroSoft YaHei';">
</div>
</body>
</html>
