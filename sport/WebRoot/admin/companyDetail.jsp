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
<title><s:property value='company.companyName'/>公司详情</title>
	<link href="../res/admin/css/companyDetail.css" rel="stylesheet" type="text/css" />
	<link href="../res/commonComponents/progressWork/css/progressWork.css" rel="stylesheet" type="text/css" />
	<!-- 引入日历组件 -->
	<link rel="stylesheet" type="text/css" href="../res/commonComponents/calendar/css/jcDate.css" media="all" />
	<!-- 引入文件上传组件-->
	<link href="../res/commonComponents/singleFileUpload/css/uploadSingleFile.css"
	type="text/css" rel="stylesheet" />
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
	<!--  Anonymous  -->
	<style>
	.operate {
		margin-top:20px;	
	}
	select{
	border:1px solid rgb(122,144,256) !important;
	}
	.wrong+span{
 		color:#f00;
 		
 		letter-spacing:1px;
 		margin-left:5px;
 	}
	</style>
	<!--  Anonymous  -->
	
</head>
<script type="text/javascript">
$(function(){
		$("input[type=file]").change(function(){$(this).parents(".uploader").find(".filename").val($(this).val());});
		$("input[type=file]").each(function(){
		if($(this).val()==""){$(this).parents(".uploader").find(".filename").val("请选择你公司的logo...");}
		});
	});
</script>
<body>
<div class="tabmain">
<form action="companyandalterCompany" method="post" enctype="multipart/form-data" id="company-form">
	<input type="hidden" name="company.id" value="<s:property value='company.id'/>"/>
  <div id="outerWrap">
    <div id="sliderParent"></div>
    <div class="blueline" id="blueline" style="top: 0px; "></div>
    <ul class="tabGroup">
      <li class="tabOption selectedTab">公司基本信息</li>
      <li class="tabOption">联系方式</li>
      <li class="tabOption">管理员</li>
      <li class="tabOption">简介</li>
      <li class="tabOption">详情</li>
    </ul>
    <div id="container">
      <div id="content">
        <div class="tabContent  selectedContent">
          <h3 style="">公司基本信息</h3>
            <p style="color:red; float:left">*为必填信息</p>
		  <div class="innerContent">
			  <dl>
				<dt><span class="high">公司logo：</span></dt>
				<dd>
					<div class="logoPreview">
						<img src="..<s:property value='company.logoImage.pathName'/>"/>
					</div>
					<div class="uploadSigleFile"> 
						<span class="uploader blueChooser"> 
							<input type="text"	class="filename" readonly="readonly" /> 
							<input type="button" class="fileButton" value="选择" /> 
							<input type="file" name="file"	size="30" /> 
						</span> 
					</div>
				</dd>
			  </dl>
			  <dl>
				<dt><span class="high">公司名：</span></dt>
				<dd>
					<input type="text" name="company.companyName"  value="<s:property value='company.companyName'/>" class="inputText textLength1"></input> *
				</dd>
			  </dl>
			  <dl>
				<dt><span class="high">公司成立日期：</span></dt>
				<dd>
					<input type="text" id="companyDate" name="company.date" value="<s:property value='company.date'/>" class="inputText textLength1"></input>				
				</dd>
			  </dl>			  
		  </div>
        </div>
        <div class="tabContent">
          <h3>公司详情：</h3>
          <div class="innerContent">
				 <dl>
				<dt><span class="high">热线电话：</span></dt>
				<dd>
					<input type="text" name="company.phone" value="<s:property value='company.phone'/>" class="inputText textLength1"></input> *
				</dd>
			  </dl>
			  <dl>
				<dt><span class="high">公司邮箱：</span></dt>
				<dd>
					<input type="text" name="company.email" value="<s:property value='company.email'/>" class="inputText textLength1"></input>				
				</dd>
			  </dl>
			  <dl>
				<dt><span class="high">地址：</span></dt>
				<dd>
					<div>
				       <span class="inputs">
				            <select id="province" >
				            	<s:iterator value="rootAddrs">
				            		<s:if test="id==company.address.parentAddress.parentAddress.id">
				                		<option selected="selected" value="<s:property value='id'/>"><s:property value='addressName'/></option>
				                	</s:if>
				                	<s:else>
				                		<option value="<s:property value='id'/>"><s:property value='addressName'/></option>
				                	</s:else>
				            	</s:iterator>
				            </select> 
				            <select id="city" >
				               <s:iterator value="company.address.parentAddress.parentAddress.childrenAddress">
				            		<s:if test="id==company.address.parentAddress.id">
				                		<option selected="selected" value="<s:property value='id'/>"><s:property value='addressName'/></option>
				                	</s:if>
				                	<s:else>
				                		<option value="<s:property value='id'/>"><s:property value='addressName'/></option>
				                	</s:else> 
				            	</s:iterator>
				            </select> 
				            <select id="region" name="company.address.id">
				                <s:iterator value="company.address.parentAddress.childrenAddress">
				                	<s:if test="id==company.address.id">
				                		<option selected="selected" value="<s:property value='id'/>"><s:property value='addressName'/></option>
				                	</s:if>
				                	<s:else>
				                		<option value="<s:property value='id'/>"><s:property value='addressName'/></option>
				                	</s:else>            		
				            	</s:iterator>
				            </select>
				       </span>
				        <br>
				   </div>
				</dd>
			  </dl>			  
		 </div>
        </div>    
        <div class="tabContent">
          <h3>公司所有管理员信息</h3>
           <div class="innerContentPosition">
			  <dl>
				<dt><span class="high">管理员列表：</span></dt>
				<dd>
					<div class="managerList">
						<s:iterator value="company.managers">
							<div class="managerWrap">
								<div class="managerInfo">
									<div class="item"><s:property value="realName"/></div>
									<div class="item"><s:property value="levelPosition"/></div>
									<div class="item"><s:property value="sex"/></div>
									<div class="item"><s:property value="phone"/></div>
									<div class="item"><s:property value="email"/></div>
								</div>
								<div class="operate">
									<div class="detail"><a href="managerandmanagerDetail?manager.id=<s:property value='id'/>" class="button blue">详情</a></div>
								</div>								
							</div>
						</s:iterator>
					</div>				
				</dd>
			  </dl>
			</div>
        </div>
        <div class="tabContent">
          <h3>公司简单介绍</h3>
           <div class="innerContentPosition">
			  <dl>
				<dt><span class="high">公司简介：</span></dt>
				<dd>
					<textarea  id="companyIntro" name="company.introduction"><s:property value="company.introduction"/></textarea>				
				</dd>
			  </dl>
			</div>
        </div>
        <div class="tabContent">
          <h3>公司详情：</h3>
          <dl>
				<dt><span class="high">公司详细信息描述：</span></dt>
				<dd>
					<textarea  id="companyDetail" name="company.detail"><s:property value="company.detail"/></textarea>				
				</dd>
				<dd>
					
				</dd>
		 </dl>
        </div>     
      </div>
    </div>
  </div>
  <div style="margin:0 auto; text-align:center;margin-top:5px;border-top:2px solid rgb(222,222,222);padding-top:5px;">
	(填写完所有的信息再提交)&nbsp;&nbsp;<input type="submit"  value="提交" class="blue button little">
</div>
</form>
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
	
	
	
	///********************************************************校验//
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
 				"company.email":{
 					email:true
 				},
 				"company.date":{
 					date:true
 				}
 			},
 			messages:{
 				"company.companyName":{
 					required:"必填项",
 					minlength:"用户名最小为2位"
 				},
 				"company.phone":{
 					required:"必填项",
 					digits:"请填写正确电话号不支持'-'符号",
 					minlength:"请填写正确电话号不支持'-'符号",
 					maxlength:"请填写正确电话号不支持'-'符号"
 				},
 				"company.email":{
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
$(function(){
			// 生成在线编辑器				
			var ue1 = UE.getEditor('companyIntro');
			$("#companyIntro").show();	
			var ue2=UE.getEditor("companyDetail");
			$("#companyDetail").show();
			
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
$(function(){
	$("input[type=file]").change(function(){$(this).parents(".uploader").find(".filename").val($(this).val());});
	$("input[type=file]").each(function(){
	if($(this).val()==""){$(this).parents(".uploader").find(".filename").val("请选择公司形象logo...");}
	});
});
</script>
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
		$("input#companyDate").jcDate({					       
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
<div style="text-align:center;margin:50px 0; font:normal 14px/24px 'MicroSoft YaHei';">
</div>
</body>
</html>
