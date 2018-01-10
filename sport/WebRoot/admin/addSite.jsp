<%@ page language="java"  contentType="text/html; charset=UTF-8" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	basePath+="admin/";
%>

<!DOCTYPE HTML >
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>添加场馆</title>
    <!-- 图片上传控件 -->
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
		<script src="../res/js/jquery.validate-1.13.1.js" type="text/javascript"></script>
<style>
body{
	margin:0;
	padding:0;}
div{
	margin-top:2px;}
.leftContentWrap,form{
	width:480px;
	float:left;
	margin-left:5px;
	}
.rightContentWrap{
	width:500px;
	height:500px;
	margin-left:10px;
	float:left;
	
	
}
.rightContent{
	margin-top:100px;
	margin-bottom:50px;
}
h4{
	line-height:20px;
	margin:10px 0;}
span{
	margin-top:2px;}
.inputs{
	height:auto;}
.inputs input[type="text"]{
	width:200px;}
.inputs input[type="tel"]{
	width:200px;}
.inputs input[type="number"]{
	width:50px;}
.inputs input[type="address"]{
	width:300px;}

.inputs select{}
.inputs textarea{
	padding:0;
	margin:auto;
	line-height:20px;
	font-size:16px;
	overflow:hidden;
	resize:none;}
.inputs ul{
	width:320px;
	margin-right:70px !important;
	margin-top:5px !important;
	margin-bottom:5px;
	padding:0;
	height:40px;
	float:right;}
.inputs li{
	list-style:none;
	float:left;
	line-height:20px;
	width:80px;}
.inputs table{
	width:380px;}
.span_title1{
	display:-moz-inlin-box;
	display:inline-block;
	width:80px;
	text-align:left;
	line-height:30px;
	margin:1px 0;}
.span_title2{
	display:-moz-inlin-box;
	display:inline-block;
	width:80px;
	height:auto;
	text-align:left;
	line-height:30px;
	vertical-align:top;}
.span_title3{
	display:-moz-inlin-box;
	display:inline-block;
	width:80px;
	height:auto;
	text-align:left;
	line-height:30px;
	vertical-align:top;}
	
td{
	width:35px;
	padding:0 5px;
	height:20px;
	line-height:20px;
	cursor:pointer;
	background:#999;}
.befor_td{
	background:#3CF;}
.select_td{
	background:#3CF;}
	 	.wrong+div{
 		color:#f00;

 		letter-spacing:1px;
 		margin-left:50px;
 	}	
	
</style>
  </head>
  
  <body>
  	<div class="leftContentWrap">
	   <form action="siteandaddSite" id="site-form" method="post" enctype="multipart/form-data" > 
	    <h4>基本信息</h4> 
	   <input type="hidden"/><!--所属公司 所属公司从登录信息中读取（session）-->
	  <div>
	       <span class="span_title1">场馆名</span> 
	       <span class="inputs"><textarea name="site.siteName" cols="38" rows="1" ></textarea></span>
	       <br><!--site.siteName 名字-->
	   </div>
	   <div>   
	       <span class="span_title1">场馆电话</span> 
	       <span class="inputs"><textarea name="site.sitePhone" cols="38" rows="1" ></textarea></span>
	       <br><!--site.sitePhone 电话--> 
	   </div> 
	 
	   <h4>位置信息</h4> 
	   <div>
	       <span class="span_title1">所属地区</span>
	       <span class="inputs">
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
	            <select id="region" name="site.address.id">
	                <s:iterator value="rootAddrs[0].childrenAddress[0].childrenAddress">
	            		<option value="<s:property value='id'/>"><s:property value='addressName'/></option>
	            	</s:iterator>
	            </select>
	       </span>
	        <br>
	   </div>
	   <div>
	       <span class="span_title1">场馆地址：</span>
	       <span class="inputs"><textarea name="site.siteAddress" cols="38" rows="1" ></textarea></span> 
	       <br> <!--site.siteAddress 详细地址--> 
	   </div>
	   <div>
	       <span class="span_title2">乘车路线： </span>
	       <span class="inputs"><textarea name="site.route" cols="38" rows="3" ></textarea></span> 
	       <br> <!--site.route乘车路线--> 
	   </div>
	   <h4 style="margin:0 2 0 0;">附加服务</h4> 
	   <div>
	       <span class="inputs">
	       <textarea cols="38" rows="3"  style="margin-left:85px;" name="site.service"></textarea></span> 
	       <br> <!--site.service 附加服务 --> 
	   </div>
	   <!-- 
	   <h4 style="margin:0 2 0 0;">售卖零食有</h4> 
	   <div>
	       <span class="inputs">
	       <textarea cols="38" rows="3"  style="margin-left:85px;" name="site.sellProducts"></textarea></span> 
	       <br>
	   </div>
	    -->
	       <h4>场地信息：</h4>
	   <div>
	       <span class="span_title2"></span>
	       <span class="inputs">
	           <ul class="week">
	            <li><input id="w1"  class="weekItem"  type="checkbox" checked="checked" value="">&emsp;周一</li>
	            <li><input id="w2"  class="weekItem"  type="checkbox" checked="checked" value="">&emsp;周二</li>
	            <li><input id="w3"  class="weekItem"  type="checkbox" checked="checked" value="">&emsp;周三</li>
	            <li><input id="w4"  class="weekItem"  type="checkbox" checked="checked" value="">&emsp;周四</li>
	            <li><input id="w5"  class="weekItem"   type="checkbox" checked="checked" value="">&emsp;周五</li>
	            <li><input id="w6"  class="weekItem"  type="checkbox" checked="checked" value="">&emsp;周六</li>
	            <li><input id="w7"  class="weekItem"  type="checkbox" checked="checked" value="">&emsp;周日</li>
	            <input type="hidden" id="weekstring"   name="site.weekJobTime" value="1,1,1,1,1,1,1"/>
	             <!--site.weekJobTime 星期营业时间--> 
	           </ul>
	          
	       </span>
	   </div>
	   <br>
	   <div>
	   	   <span style="float:left; width:20px; margin-top:10px; margin-left:40px">营业时间</span>
	       <span class="inputs" style="float:right; margin-right:10px;">
	        <hr/>
	        <table>
	            <tr >
	                <td timeId="0"><input type="hidden" id="times0" name="site.dayJobTimes" value="0"/>00:00</td>
	                <td timeId="1"><input type="hidden" id="times1" name="site.dayJobTimes" value="0"/>01:00</td>
	                <td timeId="2"><input type="hidden" id="times2" name="site.dayJobTimes" value="0"/>02:00</td>
	                <td timeId="3"><input type="hidden" id="times3" name="site.dayJobTimes" value="0"/>03:00</td>
	                <td timeId="4"><input type="hidden" id="times4" name="site.dayJobTimes" value="0"/>04:00</td>
	                <td timeId="5"><input type="hidden" id="times5" name="site.dayJobTimes" value="0"/>05:00</td>
	            </tr>
	            <tr>
	                 <td timeId="6"><input type="hidden" id="times6" name="site.dayJobTimes" value="0"/>06:00</td>
	                <td timeId="7"><input type="hidden" id="times7" name="site.dayJobTimes" value="0"/>07:00</td>
	                <td timeId="8"><input type="hidden" id="times8" name="site.dayJobTimes" value="0"/>08:00</td>
	                <td timeId="9" class="select_td"><input type="hidden" id="times9" name="site.dayJobTimes" value="1"/>09:00</td>
	                <td timeId="10" class="select_td"><input type="hidden" id="times10" name="site.dayJobTimes" value="1"/>10:00</td>
	                <td timeId="11" class="select_td"><input type="hidden" id="times11" name="site.dayJobTimes" value="1"/>11:00</td>
	            </tr>
	            <tr>
	                <td timeId="12"><input type="hidden" id="times12" name="site.dayJobTimes" value="0"/>12:00</td>
	                <td timeId="13"><input type="hidden" id="times13" name="site.dayJobTimes" value="0"/>13:00</td>
	                <td timeId="14" class="select_td"><input type="hidden" id="times14" name="site.dayJobTimes" value="1"/>14:00</td>
	                <td timeId="15" class="select_td"><input type="hidden" id="times15" name="site.dayJobTimes" value="1"/>15:00</td>
	                <td timeId="16" class="select_td"><input type="hidden" id="times16" name="site.dayJobTimes" value="1"/>16:00</td>
	                <td timeId="17"><input type="hidden" id="times17" name="site.dayJobTimes" value="0"/>17:00</td>
	            </tr>
	            <tr>
	                <td timeId="18"><input type="hidden" id="times18" name="site.dayJobTimes" value="0"/>18:00</td>
	                <td timeId="19" class="select_td"><input type="hidden" id="times19" name="site.dayJobTimes" value="1"/>19:00</td>
	                <td timeId="20" class="select_td"><input type="hidden" id="times20" name="site.dayJobTimes" value="1"/>20:00</td>
	                <td timeId="21" class="select_td"><input type="hidden" id="times21" name="site.dayJobTimes" value="1"/>21:00</td>
	                <td timeId="22"><input type="hidden" id="times22" name="site.dayJobTimes" value="0"/>22:00</td>
	                <td timeId="23"><input type="hidden" id="times23" name="site.dayJobTimes" value="0"/>23:00</td>
	            </tr>
	        </table> 
	           
	       </span>
	   </div>
	   <div class="uploadItem" id="uploadImagesWrapId" style="display:none;">
			<!-- 这里保存场馆图片上传之后的图片id集，之后保存到产品中去 -->		
		</div>	
	   <div>
	       <center>
	       <div style="padding:5px 100px; margin:10px auto;width:200px;height:100px;" > </div>
	       </center>
	   </div>
	    <h4 style="margin:0 2 0 0;">场馆详情：</h4> 
	   <div>
	       <span class="inputs">
	       <textarea  style="width:480px;height:300px;" id="siteDetail" name="site.detail"></textarea></span> 
	       <br> <!--site.service 附加服务 --> 
	   </div>
	    <div>
	       <center>
	       <input type="submit" id="submit" value="提交" style="padding:5px 100px; margin:10px auto;" /> 
	       </center>
	   </div>
	  </form>
  </div>
  <div class="rightContentWrap">
  		
  		<div class="rightContent">
  			<h4>上传场馆图片</h4> 
  			<!--上传组件-->				
			<div id="siteImgUpload" ></div>
  		</div>
  </div>
  </body>
  
<script>

//地区的联动
$(function(){
	
//时间选择控件 表格形式

	    $('tr td').click(function(){//选择变色控件
			$(this).toggleClass("select_td");
			var timesId="#times"+$(this).attr("timeId");
			var value=$(timesId).val();
			if(value=="0"){				
				$(timesId).val("1");
			}else{				
				$(timesId).val("0");
			}
		});


	//在线编辑器
	var ue = UE.getEditor('siteDetail',{
        initialFrameWidth : 480,
        initialFrameHeight: 300
    });
	ue.render('myEditor2',{
        autoFloatEnabled : false
    });
	$("#siteDetail").show();	
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
	createUploadComponent("imageanduploadImages","bigpic","img",1);
	//创建上传文件组件
	function createUploadComponent(action,type,getName,productId){
		
		// 初始化插件
		$("#siteImgUpload").zyUpload({
			width            :   "500px",                 // 宽度
			height           :   "300px",                 // 高度
			itemWidth        :   "120px",                 // 文件项的宽度
			itemHeight       :   "100px",                 // 文件项的高度
			url              :   action,  // 上传文件的路径
			multiple         :   true,                    // 是否可以多个文件上传
			dragDrop         :   true,                    // 是否可以拖动上传文件
			del              :   true,                    // 是否可以删除文件
			finishDel        :   false,  				  // 是否在上传文件完成后删除预览
			imgType			 :	 type,				  //图片类型
			imgName			 :	 getName,							//上传后接收该文件的File名
			productId		 :	 productId,							//0代表是新添加的产品,这里只要随机生成一个就行了，只要该次按顺序添加就行了。
			/* 外部获得的回调接口 */
			onSelect: function(files, allFiles){                    // 选择文件的回调方法
				console.info("当前选择了以下文件：");
				console.info(files);
				console.info("之前没上传的文件：");
				console.info(allFiles);
			},
			onDelete: function(file, surplusFiles){                     // 删除一个文件的回调方法
				console.info("当前删除了此文件：");
				console.info(file);
				console.info("当前剩余的文件：");
				console.info(surplusFiles);
			},
			onSuccess: function(file,responseInfo,type){                    // 文件上传成功的回调方法
				//alert("此文件上传成功："+unescape(encodeURIComponent(file.name))+"  服务器上名字为："+responseInfo);
				/*
				 	<input type='checkbox' name='product.smallImageNames' checked='checked' value=''>
					<input type='checkbox' name='product.midImageNames' checked='checked' value=''>
					<input type='checkbox' name='product.bigImageNames' checked='checked' value=''>
				 * */
				var content;
					if(responseInfo)
						responseInfo= $.parseJSON(responseInfo); 
					//alert("child:"+responseInfo+"type");
				switch(type){
				case "bigpic":content="<input type='checkbox' name='site.imageIds' checked='checked' value='"+responseInfo+"'>";
					break;
				case "midpic":content="<input type='checkbox' name='site.imageIds' checked='checked' value='"+responseInfo+"'>";
					break;
				case "smallpic":content="<input type='checkbox' name='site.imageIds' checked='checked' value='"+responseInfo+"'>";
					break;
				}
				$("#uploadImagesWrapId").append(content);
				//console.info(file);
			},
			onFailure: function(file,responseInfo){                    // 文件上传失败的回调方法
				//console.info("此文件上传失败：");
				//console.info(file);
				alert("此文件上传失败："+file.name+"  信息:"+responseInfo);
			},
			onComplete: function(file,responseInfo,type){           // 上传完成的回调方法
				//alert("文件上传完成");
				
			}
		});
		
	}
});
</script>
<script>
$(document).ready(function() {
	//所属地区
	$('select').click(function(){
		var address=$('#region option').val();
		$("#address").val(address);
		});
	});
</script>


<script>
//营业时间(星期)

$('form').find(':checkbox').bind('click',function(){
		var week='';
		$(".weekItem").each(function(index){
			if($(this).attr("checked")=="checked"){
				week+="1";
			}else{
				week+="0";
			}
			if(index!=6)
				week+=",";
		});
		//alert(week);
		$("#weekstring").val(week);//字符串赋值
});

$("#site-form").validate({
		 	rules:{
 				"site.siteName":{
 					required:true,
 					minlength:2,
 					maxlength:20
 				},
 				"site.siteAddress":{
 					required:true,
 					minlength:8,
 					maxlength:25
 				}
 			},
 			messages:{
 				"site.siteName":{
 					required:"场馆名为必填项",
 					minlength:"场馆名最小长度为2位",
 					maxlength:"场馆名最大长度为20位"
 				},
 				"site.siteAddress":{
 					required:"场馆地址为必填项",
 					minlength:"场馆地址最小为8位",
 					maxlength:"场馆地址最大长度为25位"
 				}
 			},
 			errorClass:"wrong",
 			errorElement:"div"  
});
</script>
  
</html>
