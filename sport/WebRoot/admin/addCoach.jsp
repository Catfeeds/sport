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
<!DOCTYPE html >
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>添加某场馆的私人教练</title>
<link href="../res/commonComponents/progressWork/css/progressWork.css"
	rel="stylesheet" type="text/css" />
<link href="../res/admin/css/addCoach.css"
	rel="stylesheet" type="text/css" />
<!-- 引入日历组件 -->
<link rel="stylesheet" type="text/css"
	href="../res/commonComponents/calendar/css/jcDate.css" media="all" />
<!-- 引入控件美化组件 -->
<link href="../res/css/component.css" type="text/css" rel="stylesheet" />
<link href="../res/commonComponents/singleFileUpload/css/uploadSingleFile.css"	type="text/css" rel="stylesheet" />

<script src="../res/commonComponents/progressWork/js/event.js"></script>
<script src="../res/commonComponents/progressWork/js/tween.js"></script>
<script type="text/javascript" src="../res/js/jquery-1.8.3.min.js"></script>
<script src="../res/admin/js/addCoach.js"></script>
<!-- 引入下拉列表组件 -->
<link href="../res/commonComponents/dropDownList/css/dropdownlist.css"
	rel="stylesheet" type="text/css">
<script src="../res/commonComponents/dropDownList/js/dropdownlist.js"></script>
<!-- 上传组件js引入 -->
<!-- 上传组件css引入 -->	
<link rel="stylesheet" href="uploadFiles/control/css/zyUpload.css" type="text/css">
<!-- 引用核心层插件 -->
<script type="text/javascript" src="uploadFiles/core/zyFile.js"></script>
<!-- 引用控制层插件 -->
<script type="text/javascript" src="uploadFiles/control/js/zyUpload.js"></script>
<!-- 引入在线编辑器 -->
<script type="text/javascript" charset="utf-8"
	src="../res/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8"
	src="../res/ueditor/ueditor.all.min.js"></script>
<script type="text/javascript" charset="utf-8"
	src="../res/ueditor/lang/zh-cn/zh-cn.js"></script>

<script type="text/javascript">
	$(function(){

			// 生成在线编辑器				
			var ue = UE.getEditor('coachDetail',{
		        initialFrameWidth : 480,
		        initialFrameHeight: 200
		   	 });
		   	 ue.render('myEditor2',{
		        autoFloatEnabled : false
		    });
			$("#coachDetail").show();	
			
});
</script>

<script>

$(function(){
	$(".selectTimeTable tr td").bind("click",function(){
		$(this).toggleClass("tdSelect");
	});


	$(".coach-time-optional ul li span.chooseItem").bind("click",function(){
		$(this).toggleClass("coach-time-selected");
	});
	
		
		
});
</script>

<script>$(function(){
	$("input[type=file]").change(function(){$(this).parents(".uploader").find(".filename").val($(this).val());});
	$("input[type=file]").each(function(){
	if($(this).val()==""){$(this).parents(".uploader").find(".filename").val("选择您喜欢的头像...");}
	});
});
</script>

<Style>
	.wrong+span{
 		color:#f00;

 		letter-spacing:1px;
 		margin-left:10px;
 	}	
	</Style>
			<style>
		.optional-input{
			width:50px;
			background-color:transparent;
			border:2px solid #FFF;
			margin-left:10px;
		}
		.clearfix{
			clear: both;
		}
		
		.coach-time-optional{
			height: auto;
		}
		.coach-time-optional ul{
			list-style: none;
		}
		.coach-time-optional li{
			background-color: rgb(168,203,247);
			cursor: pointer;
			line-height: 20px;
			font-size: 12px;
			font-weight: 400;
			padding: 5px 10px 5px 20px;
			margin: 5px 10px 5px auto;
		}
		.coach-time-optional li span{
			font-size:18px;
		}
		.coach-time-optional li span.chooseItem:hover{
			background-color: rgb(79,202,101);
		}
		.coach-time-selected{
			background-color:rgb(79,202,101)  !important;
		}
		.coach-time-unable{
			background-color:rgb(180,180,180)  !important;
		}
		.coach-time-noselecet{
			background-color: rgb(200,200,200) !important;
		}
		.coach-list{
			float: left; width: 250px; 
			padding: 5px 20px;
			margin: 5px; border: 1px solid #6495ED;
		}
	</style>
	<style>
.body{
	margin:0;
	padding:0;}
.tbut{
	color:#f00;
	cursor:pointer;
	}
.tback {
	z-index: 9998;
	position:fixed;
	top:0;
	left:0;
	width:100%;
	height:100%;
	background:#000;
	opacity:0.4;
	filter:alpha(opacity=40);
	display:none
}
.tover {
	z-index:9999;
	position:fixed;
	top:50%;
	left:50%;
	width:660px;
	height:360px;
	margin:-180px 0 0 -330px;
	border-radius:5px;
	border:solid 2px #666;
	background-color:#fff;
	display:none;
	box-shadow: 0 0 10px #666;
}
.coach-product-value{
background-color: rgb(168,203,247);
border:1px #FFF solid;
width:80px;
margin-left:20px;
}
.queding{
background-color: rgb(168,203,247);
font-size:18px;
padding:5px 10px;
}	
</style>

</head>


<body>
	<form action="coachandaddCoach" method="post" id="coach-form">
	<div class="tabmain">		
			<div id="outerWrap">
				<div id="sliderParent"></div>
				<div class="blueline" id="blueline" style="top: 0px; "></div>
				<ul class="tabGroup">
					<li class="tabOption selectedTab">基本信息填写</li>
					<li class="tabOption">联系方式</li>					
					<li class="tabOption">工作时间安排</li>
					<li class="tabOption">服务区选择</li>
					<li class="tabOption">服务产品选择</li>
					<li class="tabOption">个人风采展示</li>
					<li class="tabOption">个人详情介绍</li>
				</ul>
				<div id="container">
					<div id="content">
						<div class="tabContent  selectedContent">
							<h3 style="">私人教练个人基本信息</h3>
							<div class="innerContent">
								<dl>
									<dt>
										<span class="high">姓名：</span>
									</dt>
									<dd>
										<input type="text" name="coach.realName"
											class="inputText textLength1"></input>
									</dd>
								</dl>
								<dl>
									<dt>
										<span class="high">性别：</span>
									</dt>
									<dd>
										<input type="radio" name="coach.sex" checked="checked"
											value="男" />&nbsp;男&nbsp;&nbsp; <input type="radio"
											name="coach.sex" value="女" />&nbsp;女
									</dd>
								</dl>
								<dl>
									<dt>
										<span class="high">生日：</span>
									</dt>
									<dd>
										<input type="text" id="coachBirthday" name="coach.birthday"
											class="inputText textLength1"></input>
									</dd>
								</dl>
								
								<dl>
									<dt>
										<span class="high">登录账户名：</span>
									</dt>
									<dd>
										<input type="text" name="coach.userName"
											class="inputText textLength1"></input>
									</dd>
								</dl>
								<dl>
									<dt>
										<span class="high">密码：</span>
									</dt>
									<dd>
										<input type="password" name="coach.password" id="coach-password"
											class="inputText textLength1"></input>
									</dd>
								</dl>
								<dl>
									<dt>
										<span class="high">密码确认：</span>
									</dt>
									<dd>
										<input type="password" name="coach.passwordConfirm"
											class="inputText textLength1"></input>
									</dd>
								</dl>
							</div>
						</div>
						<div class="tabContent">
							<h3>个人联系方式</h3>
							<div class="innerContent">
								<dl>
									<dt>
										<span class="high">手机号码：</span>
									</dt>
									<dd>
										<input type="text" name="coach.phone"
											class="inputText textLength1"></input>
									</dd>
								</dl>
								<dl>
									<dt>
										<span class="high">家用电话号：</span>
									</dt>
									<dd>
										<input type="text" name="coach.telephone"
											class="inputText textLength1"></input>
									</dd>
								</dl>

								<dl>
									<dt>
										<span class="high">邮箱：</span>
									</dt>
									<dd>
										<input type="text" name="coach.email"
											class="inputText textLength1"></input>
									</dd>
								</dl>
								<dl>
									<dt>
										<span class="high">邮编：</span>
									</dt>
									<dd>
										<input type="text" name="coach.postcode"
											class="inputText textLength1"></input>
									</dd>
								</dl>
								<dl>
									<dt>
										<span class="high">居住地区选择：</span>
									</dt>
									<dd>
											<select id="province1" >
								            	<s:iterator value="rootAddrs">
								            		<option value="<s:property value='id'/>"><s:property value='addressName'/></option>
								            	</s:iterator>
								            </select> 
								            <select id="city1" >
								               <s:iterator value="rootAddrs[0].childrenAddress">
								            		<option value="<s:property value='id'/>"><s:property value='addressName'/></option>
								            	</s:iterator>
								            </select> 
								            <select id="region1" name="coach.homeAddress.id">
								                <s:iterator value="rootAddrs[0].childrenAddress[0].childrenAddress">
								            		<option value="<s:property value='id'/>"><s:property value='addressName'/></option>
								            	</s:iterator>
								            </select>
									</dd>
								</dl>
								<dl>
									<dt>
										<span class="high">区内详细地址：</span>
									</dt>
									<dd>
										<input type="text" name="coach.addressName"
											class="inputText" style="width:400px;"></input>
									</dd>
								</dl>
							</div>
						</div>
						
						<div class="tabContent">
							<h3>时间安排</h3>
							<div class="innerContent">
								<div style="clear:both;"></div>
								<div class="contentBody" style="margin-left:-100px;">
									<div style="font-size:18px;font-family:'微软雅黑';">周时间安排</div>
									<div class="selectWeek">
										 <ul class="week">
								            <li><input id="w1"  class="weekItem"  type="checkbox" checked="checked" value="">&emsp;周一</li>
								            <li><input id="w2"  class="weekItem"  type="checkbox" checked="checked" value="">&emsp;周二</li>
								            <li><input id="w3"  class="weekItem"  type="checkbox" checked="checked" value="">&emsp;周三</li>
								            <li><input id="w4"  class="weekItem"  type="checkbox" checked="checked" value="">&emsp;周四</li>
								            <li><input id="w5"  class="weekItem"   type="checkbox" checked="checked" value="">&emsp;周五</li>
								            <li><input id="w6"  class="weekItem"  type="checkbox" checked="checked" value="">&emsp;周六</li>
								            <li><input id="w7"  class="weekItem"  type="checkbox" checked="checked" value="">&emsp;周日</li>
								            <input type="hidden" id="weekstring"   name="coach.weekJobTime" value="1,1,1,1,1,1,1"/>
								             <!--coach.weekJobTime 星期营业时间--> 
								           </ul>
									</div>
									<div style="clear:both;"></div>
									<div style="font-size:18px;font-family:'微软雅黑';">日时间安排</div>
									<div class="selectTime">									
									<div class="coach-time-optional">
										<ul>
												<li>
												<span class="chooseItem">上午 09：00--12：00</span>
												&emsp;&emsp;默认价格:<input type="text" name="coach.baseCostPrices" class="optional-input" />
												<input type="hidden" id="times0" name="coach.dayJobTimeArr" value="0"/>&yen;</li>
												<li><span class="chooseItem">下午 14：00--17：00</span>
												&emsp;&emsp;默认价格:<input type="text" name="coach.baseCostPrices" class="optional-input" />
												<input type="hidden" id="times1" name="coach.dayJobTimeArr" value="0"/>&yen;</li>
												<li><span class="chooseItem">晚上 19：00--21：00</span>
												&emsp;&emsp;默认价格:<input type="text" name="coach.baseCostPrices" class="optional-input" />
												<input type="hidden" id="times2" name="coach.dayJobTimeArr" value="0"/>&yen;</li>
												
												&emsp;&emsp;全天价格:<input type="text" name="coach.baseCostPrices" style="width:50px;border: 1px solid rgb(66,66,66);margin:5px;"  />
												<input type="hidden" id="times2" name="coach.dayJobTimeArr" value="0"/>&yen;
												
											</ul>
									</div>
									</div>
									<div style="clear:both;"></div>
								</div>								
							</div>
						</div>	
						<div class="tabContent">
							<h3>服务区选择</h3>
							<div class="innerContent">
								<div style="clear:both;"></div>
								<div class="contentBody" style="margin-left:-100px;">																	
									<div style="clear:both;"></div>
									<div style="font-size:18px;font-family:'微软雅黑';">您可提供服务的活动地点选择(最多<span id="totalRegionNumber">4</span>个)</div>
									<div class="extraService">
										<div class="selectedAddressWrap">
											<div class="addressItem">
												您已选择以下<span id="regionNumber">0</span>
												个活动区域，最多还可选<span id="spareNumber" >4</span>个
											</div>
										<!--	<div class='addressItem' id='addrItemId1'><span class='selectedaddress'>湖南-> 岳阳 ->岳阳楼区</span>
												<span class='removeBtn'><a class='blue button' addrItemId='1' addrId='1' href='javascript:void(0);'>移除</a></span>
												<input type='hidden' name='coach.addrIds' value='0'/>
											</div>
										  -->	
										</div>
										<div></div>
										<div class="addressChooseComponents">
											<div style="margin-bottom:10px;">
												<span id="addressPromptWrapId" style="color:red;"></span>
											</div>
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
								            <select id="region" >
								                <s:iterator value="rootAddrs[0].childrenAddress[0].childrenAddress">
								            		<option value="<s:property value='id'/>"><s:property value='addressName'/></option>
								            	</s:iterator>
								            </select>
								            &nbsp;&nbsp;&nbsp;
								            <span class="addBtn"><a class="blue button" id="addRegionBtn" href="javascript:void(0)">添加地区</a></span>
								            
										</div>
									</div>
																											
								</div>								
							</div>
						</div>
						<div class="tabContent">
							<h3>选择您可以提供的服务产品</h3>
							<div class="innerContent">
								
								<div class="contentBody" style="margin-left:-100px;">
									<div style="clear:both;"></div>
									<div class="extraService" style="margin-top:10px;">
										<span  style="font-size:18px;font-family:'微软雅黑';">默认价格:</span>
										<input type="text" name="coach.basePrice"
														class="inputText textLength1"></input>	(单位：&yen;)									
									</div><br/>
									<div style="clear:both;"></div>
									<div class="extraService" style="margin-top:10px;">
									<span  style="font-size:18px;font-family:'微软雅黑';">用户上限:</span>
										<input type="text" name="coach.employNumber"
														class="inputText textLength1"></input>	(单位：个)									
									</div>
									<p>每次同时为用户提供服务的用户数上限</p><br/>
									<div style="clear:both;"></div>
									
									<div class="extraService" style="margin-top:10px;">
									<span  style="font-size:18px;font-family:'微软雅黑';">教练项目:&emsp;&emsp;</span>
										<select name="coach.skillType.id" id="TypeSelect" style="font-size:16px;font-family:'微软雅黑';">
											<s:iterator value='types'>
												<option value='<s:property value='id'/>' style="font-size:18px;font-family:'微软雅黑';"><s:property value="typeName"/></option>
											</s:iterator>
										</select>
										&emsp;&emsp;&emsp;&emsp;&emsp;&nbsp;										
									</div>
									<p>选择您的擅长项目(只能一种)</p>
									<div style="clear:both;"></div>
									<div style="font-size:18px;font-family:'微软雅黑';margin-top:30px;">选择产品：</div>
									<p>选择您可以提供的产品(多选)；点击相应的产品可自定义产品价格</p>	
									<div class="extraService">
										<ul class="week" id="productsList">
											<s:iterator value="products" status="st">
												<li><input  class="weekItem productItem"
													 type="checkbox" productId="<s:property value='id'/>"
													  id="productItem<s:property value='id'/>"
													value="<s:property value='id'/>" name="coach.coachProductIds">&emsp;
													<input type='hidden' 
														value='<s:property value="product.normalPrice"/>'
													 	id='costs<s:property value="id"/>'/>
													<label class='tbut' productId="<s:property value='id'/>" >
														<s:property value='productName'/>
													</label>													
												</li>											
											</s:iterator>								
										</ul>								
									</div>
									<div id="coastHiddenDiv" style="display:none;">
										<!-- 这里存放某种产品的价格集 -->
										
									</div>
									<!-- 弹出  -->
									<div class="tover">
									     <div class="tclose" style="text-align:right;">
									      <a href="javascript:;" title="关闭" class="close">×</a>
									     </div>
									     <center style=" margin-top:30px !important;">
											<div class="coach-time-optional" style="width:400px;">
												<ul>
												<li><span>上午 09：00--12：00</span>
													<input type="text"  name="floatvalue0" value='0' class="coach-product-value"/>&nbsp;&yen;
												</li>
												<li><span>下午 14：00--17：00</span>
													<input type="text"  name="floatvalue1"  value='0'  class="coach-product-value"/>&nbsp;&yen;
												</li>
												<li><span>晚上 19：00--21：00</span>
													<input type="text"  name="floatvalue2"  value='0'  class="coach-product-value"/>&nbsp;&yen;
												</li>
												<li><span>全天 09：00--21：00</span>
													<input type="text"  name="floatvalue3"  value='0'  class="coach-product-value"/>&nbsp;&yen;
												</li>
												</ul>
											</div>	
									    <input type="button" id="setCostBtn" class="queding" value="确定" />
									
									    </center>
									</div>
									<div class="tback"></div><!--背景淡出-->	
									<!-- 弹出 end -->				
								</div>									
							</div>
						</div>
						<div class="tabContent">
						
							<h3>上传个人展示图片</h3>
							<div class="innerContent">
								<div style="clear:both;"></div>
								<div class="contentBody" style="margin-left:-100px;">																	
									<div style="clear:both;"></div>
									<div style="font-size:18px;font-family:'微软雅黑';">个人生活照</div>
									<div class="uploadItem" id="uploadImagesWrapId" style="display:none;">
										<!-- 这里保存场馆图片上传之后的图片id集，之后保存到产品中去 -->		
									</div>	
									<!--上传组件-->		
									<div style="width:400px;height:300px;">		
										<div id="coachImgUpload" ></div>
									</div>
								</div>								
							</div>
							
						</div>
						
						<div class="tabContent">
							<h3>个人简介：</h3>
							<dl>
								<dt>
									<span class="high">简介：</span>
								</dt>
								<dd>
									<textarea id="coachDetail" name="coach.detail"></textarea>
								</dd>
							</dl>
							
							
						</div>
						
					</div>
				</div>
			</div>
		
	</div>
<div style="margin:0 auto; text-align:center;margin-top:5px;border-top:2px solid rgb(222,222,222);padding-top:5px;">
	(填写完所有的信息再提交)&nbsp;&nbsp;<input type="submit"  value="提交" class="blue button little">
</div>
</form>

<script type="text/javascript">
var container = document.getElementById('container');
var content = document.getElementById('content');
var oDivs = DOM.children(content, "div");
oDivs[0].st = 0;
for (var i = 1; i < oDivs.length; i++) {
    oDivs[i].st = oDivs[i].offsetTop;
}
var oLis = DOM.getElesByClass("tabOption");
var flag = 0;
var upFlag = oLis.length;; (function() {
    function fn(e) {
        e = e || window.event;
        if (e.wheelDelta) {
            var n = e.wheelDelta;
        } else if (e.detail) {
            var n = e.detail * -1;
        }
        if (n > 0) {
            container.scrollTop -= 12;
        } else if (n < 0) {
            container.scrollTop += 12;
        }
        slider.style.top = container.scrollTop * container.offsetHeight / content.offsetHeight + "px";
        slider.offsetTop * (content.offsetHeight / container.offsetHeight);
        var st = container.scrollTop;
        if (st > this.preSt) {
            for (var j = 0; j < oLis.length; j++) {
                if (st < oDivs[j].st) break;
            }
            if (oLis[j - 2] && this.preLi !== j) {
                if ((j) > (flag + 1)) {
                    DOM.removeClass(oLis[j - 2], "selectedTab");
                    DOM.addClass(oLis[j - 1], "selectedTab");
                    animate(blueline, {
                        top: (j - 1) * 48
                    },
                    500, 2);
                }
            }
            flag = j - 1;
        } else if (st < this.preSt) {
            for (var j = oLis.length - 1; j >= 0; j--) {
                if (st > oDivs[j].st) break;
            }
            if (oLis[j + 2] && this.preLi !== j) {
                if (flag === undefined) return;
                if ((j) < (flag)) {
                    for (var k = 0; k < oLis.length; k++) {
                        DOM.removeClass(oLis[k], "selectedTab");
                    };
                    DOM.addClass(oLis[j + 1], "selectedTab");
                    animate(blueline, {
                        top: (j + 1) * 48
                    },
                    500, 2);
                    upFlag = j + 1;
                }
            }
        }
        this.preSt = st;
        if (e.preventDefault) e.preventDefault();
        return false;
    }
    container.onmousewheel = fn;
    if (container.addEventListener) container.addEventListener("DOMMouseScroll", fn, false);
    slider = document.createElement('span');
    slider.id = "slider";
    slider.style.height = container.offsetHeight * (container.offsetHeight / content.offsetHeight) + "px";
    sliderParent.appendChild(slider);
    on(slider, "mousedown", down);
    var blueline = document.getElementById("blueline");
    function changeTab() {
        var index = DOM.getIndex(this);
        for (var i = 0; i < oLis.length; i++) {
            DOM.removeClass(oLis[i], "selectedTab");
        }
        DOM.addClass(this, "selectedTab");
        animate(container, {
            scrollTop: oDivs[index].st
        },
        500, 1);
        var t = oDivs[index].st * container.offsetHeight / content.offsetHeight;
        animate(slider, {
            top: t
        },
        500);
        animate(blueline, {
            top: index * 48
        },
        500, 2);
    }
    var tabPannel1 = document.getElementById("outerWrap");
    var oLis = DOM.children(DOM.children(tabPannel1, "ul")[0], "li");
    for (var i = 0; i < oLis.length; i++) {
        oLis[i].onclick = changeTab;
    };
})();
	</script>
	<script type="text/javascript"
		src="../res/commonComponents/calendar/js/jQuery-jcDate.js"
		charset="utf-8"></script>
	<script src="../res/js/custom-file-input.js"></script>
<script src="../res/js/jquery.validate-1.13.1.js" type="text/javascript"></script>
		<!-- jQuery版本
		<script src="../res/js/jquery-v1.min.js"></script>
		<script src="../res/js/jquery.custom-file-input.js"></script>
		-->
	<script type="text/javascript">
		$(function (){
		$("input#coachBirthday").jcDate({					       
				IcoClass : "jcDateIco",
				Event : "click",
				Speed : 100,
				Left : 0,
				Top : 28,
				format : "-",
				Timeout : 100
		});
		
			$("#coach-form").validate({
		 	rules:{
 				"coach.realName":{
 					required:true,
 					minlength:2,
 					maxlength:10
 				},
 				"coach.userName":{
 					required:true,
 					minlength:2,
 					maxlength:10
 				},
 				"coach.password":{
 					required:true,
 					minlength:4,
 					maxlength:16
 				},
 				"coach.passwordConfirm":{
 				 	equalTo:"#coach-password"
 				},
 				"coach.phone":{
 					required:true,
 					digits:true,
 					minlength:11,
 					maxlength:11
 				},
 				"coach.email":{
 					email:true,
 				},
 				"coach.employNumber":{
 					digits:true,
 				},
 				"coach.basePrice":{
 				required:true,
 				number:true,
 				},
 				"coach.baseCostPrices":{
 					required:true,
 					number:true,
 				},
 				floatvalue0:{
 					required:true,
 					number:true,
 				} ,
 				floatvalue1:{
 					required:true,
 					number:true,
 				} ,
 				floatvalue2:{
 					required:true,
 					number:true,
 				} ,
 				floatvalue3:{
 					required:true,
 					number:true,
 				} ,
 				
 				"coach.postcode":{
 					digits:true,
 					minlength:6,
 					maxlength:6
 				}
 				
 			},
 			messages:{
 				"coach.realName":{
 					required:"必填项",
 					minlength:"用户名最小为2位",
 					maxlength:"用户名最大为10位"
 				},
 				"coach.userName":{
 					required:"必填项",
 					minlength:"登录名最小为2位",
 					maxlength:"登录名最大为10位"
 				},
 				"coach.password":{
 					required:"必填项",
 					minlength:"密码最小为4位",
 					maxlength:"密码最大为16位"
 				},
 				"coach.passwordConfirm":{
 				 equalTo:"两次密码填写不正确"
 				},
 				"coach.phone":{
 					required:"必填项",
 					digits:"请填写正确11位手机号",
 					minlength:"请填写正确11位手机号",
 					maxlength:"请填写正确11位手机号"
 				},
 				"coach.email":{
 					email:"请填写正确email地址包含@.com等字符",
 				},
 				"coach.employNumber":{
 					digits:"请填写整数",
 				},
 				"coach.basePrice":{
 				required:"必填项",
 				number:"请填写数字",
 				},
 				"coach.baseCostPrices":{
 					required:"必填项",
 					number:"请填写数字",
 				},
 				floatvalue:{
 					required:"必填项",
 					number:"请填写数字",
 				} ,
 				floatvalue0:{
 					required:"必填项",
	 				number:"请填写数字",
 				} ,
 				floatvalue1:{
 				required:"必填项",
 				number:"请填写数字",
 				} ,
 				floatvalue2:{
 				required:"必填项",
 				number:"请填写数字",
 				} ,
 				floatvalue3:{
 				required:"必填项",
 				number:"请填写数字",
 				} ,
 				"coach.postcode":{
 					digits:"请填写正确6位国内邮编",
 					minlength:"请填写正确6位国内邮编",
 					maxlength:"请填写正确6位国内邮编"
 				}
 			},
 			errorClass:"wrong",
 			errorElement:"span"  
		});
		
	});
	</script>
	<div
		style="text-align:center;margin:50px 0; font:normal 14px/24px 'MicroSoft YaHei';">
	</div>
</body>
</html>
