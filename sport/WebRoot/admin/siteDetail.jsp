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
    <title>场馆详情</title>
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

.select_td{
	background:#3CF;}
	
input[type="submit"]{
	border:#eee 1px solid;
	background:rgb(0,183,238);
	color:#fff;
	font-size:18px;
}
.sitedetail-a {
border:rgb(0,183,238) 1px solid;
	background:#eee;
	color:#333;
	font-size:14px;
	padding:2px;
	 margin:10px ;
	 border-radius:10px;
	 float:left
	 }
		.wrong+div{
 		color:#f00;
 		letter-spacing:1px;
 		margin-left:5px;
 	}
	
</style>
  </head>
  
  <body>
  <div class="leftContentWrap">
	   <form id="site-form" action="siteandalterSite" method="post" enctype="multipart/form-data" > 
	   <h4>基本信息</h4> 
	   <input type="hidden" /><!--所属公司 所属公司从登录信息中读取-->
		<input type= "hidden" name="site.id" value="<s:property value='site.id'/>" readonly="readonly"
	   	style="border:none; margin-left:20px;"
	   />
	  <div>
	       <span class="span_title1">场馆名</span> 
	       <span class="inputs">
	       		<textarea name="site.siteName" cols="38" rows="1" value="<s:property value='site.siteName'/>" ><s:property value='site.siteName'/></textarea>
	       </span>
	       <br><!--site.siteName 名字-->
	   </div>
	   <div>   
	       <span class="span_title1">场馆电话</span> 
	       <span class="inputs">
	       	<textarea name="site.sitePhone" cols="38" rows="1" value="<s:property value='site.sitePhone'/>" ><s:property value='site.sitePhone'/></textarea>
	      </span>
	       <br><!--site.sitePhone 电话--> 
	   </div> 
	 
	   <h4>位置信息</h4> 
	
	   <div>
	       <span class="span_title1">所属地区</span>
	       <span class="inputs">
	            <select id="province" >
	            	<s:iterator value="rootAddrs">
	            		<s:if test="id==site.address.parentAddress.parentAddress.id">
	                		<option selected="selected" value="<s:property value='id'/>"><s:property value='addressName'/></option>
	                	</s:if>
	                	<s:else>
	                		<option value="<s:property value='id'/>"><s:property value='addressName'/></option>
	                	</s:else>
	            	</s:iterator>
	            </select> 
	            <select id="city" >
	               <s:iterator value="site.address.parentAddress.parentAddress.childrenAddress">
	            		<s:if test="id==site.address.parentAddress.id">
	                		<option selected="selected" value="<s:property value='id'/>"><s:property value='addressName'/></option>
	                	</s:if>
	                	<s:else>
	                		<option value="<s:property value='id'/>"><s:property value='addressName'/></option>
	                	</s:else> 
	            	</s:iterator>
	            </select> 
	            <select id="region" name="site.address.id">
	                <s:iterator value="site.address.parentAddress.childrenAddress">
	                	<s:if test="id==site.address.id">
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
	    <div>
	       <span class="span_title1">场馆地址：</span>
	       <span class="inputs">
	       		<textarea name="site.siteAddress" cols="38" rows="1" value="<s:property value='site.siteAddress'/>" ><s:property value='site.siteAddress'/></textarea>
	       </span> 
	       <br> <!--site.siteAddress 详细地址--> 
	   </div>
	   <div>
	       <span class="span_title2">乘车路线： </span>
	       <span class="inputs"><textarea name="site.route" cols="38" rows="3" value="<s:property value='site.route'/>" ><s:property value='site.route'/></textarea></span> 
	       <br> <!--site.route乘车路线--> 
	   </div>
	   <h4 style="margin:0 2 0 0;">附加服务</h4> 
	   <div>
	       <span class="inputs">
	       <textarea cols="38" rows="3"  style="margin-left:85px;" name="site.service" value="<s:property value='site.service'/>"><s:property value='site.service'/></textarea></span> 
	       <br> <!--site.service 附加服务 --> 
	   </div>
	   <!-- 
	    <h4 style="margin:0 2 0 0;">售卖零食</h4> 
	   <div>
	       <span class="inputs">
	       <textarea cols="38" rows="3"  style="margin-left:85px;" name="site.sellProducts" value="<s:property value='site.sellProducts'/>"><s:property value='site.sellProducts'/></textarea></span> 
	       <br> 
	   </div>
	    -->
	       <h4>场地信息：</h4>
	   <div>
	       <span class="span_title2"></span>
	       <span class="inputs">
	           <ul class="week">
	           	<s:iterator value="site.weekJobTimes"  var="time" status="st"><!-- 下一个 -->
					<s:if test="#time==1" >
						<li><input  class="weekItem" type="checkbox" checked="checked" ></li>
					</s:if>
					<s:else>
						<li><input  class="weekItem" type="checkbox"  ></li>
					</s:else>
			</s:iterator>
	            <input type="hidden" id="weekstring"   name="site.weekJobTime" value="<s:property value='site.weekJobTime'/>"/>
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
	            <tr>
	             <s:iterator value="site.dayJobTimes"  var="time" status="st"><!-- 下一个 -->
					<s:if test="#time==1" >
						<td class="select_td"></td>
					</s:if>
					<s:else>
						<td></td>
					</s:else>
					<s:if test="(#st.index+1)%6==0">
						</tr><tr>
					</s:if>				
	            </s:iterator>
	            </tr>
	         </table> 
	         <input type="hidden" id="timestring" value="<s:property value='site.dayJobTime'/>" name="site.dayJobTime"/> 
	       </span>
	        <div class="uploadItem" id="uploadImagesWrapId" style="display:none;">
				<!-- 这里保存场馆图片上传之后的图片id集，之后保存到产品中去 -->		
			</div>	
	   </div>
	 
	   <div>
	       <center> 
	       <div style="width:250px;margin:0 120px; padding:auto">	     		
	     		
	     	</div>
	     	<input type="submit" id="submit" value="提交" style="padding:5px 100px; margin:10px auto;" /> 
	       </center>
	   </div>
	    <h4 style="margin:0 2 0 0;">场馆详情：</h4> 
	   <div>
	       <span class="inputs">
	       <textarea  style="width:480px;height:300px;" id="siteDetail" name="site.detail" ><s:property escapeHtml="false" value="site.detail"/></textarea></span> 
	       <br> <!--site.service 附加服务 --> 
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
 
 
 <script type="text/javascript">
function myerror(_message,_url,_line)
		    {
		     
		 
		       return true; //屏蔽系统的事件
		    }
    //绑定错误事件
    window.onerror = myerror;
   
</script>
 
<script type="text/javascript">
//页面加载初始化
$(document).ready(function() {
var weekstr=["&emsp;周一","&emsp;周二","&emsp;周三","&emsp;周四","&emsp;周五","&emsp;周六","&emsp;周日"];
	for(var i=0;i<7;i++){
		str=weekstr[i];
		$("li").eq(i).append(str);
		ids='w'+(i+1);//alert(ids);
		$("li>input").eq(i).attr('id',ids);
	}
		var timestr=["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23"];
	for(var i=0;i<24;i++){
		var daytimestr=timestr[i]+":00";
		$('td').eq(i).append(daytimestr);	
	}
	//alert(daytimestr);//497
});

</script>


<script>
//地区的联动
$(function(){
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
			width            :   "650px",                 // 宽度
			height           :   "200px",                 // 高度
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
	
///********************************************************校验//
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
//时间联动（天）
//时间选择控件 表格形式
$(document).ready(function(e) {
	    $('td').mouseup(function(){//选择变色控件
		$(this).toggleClass("select_td");
		
			if($('td').eq(0).is('.select_td')){
				var str = "1";}
			else{var str = "0";}//初始化赋值
			for(i=1;i<24;i++){
				if($('td').eq(i).is('.select_td')){
					str += ",1";}
				else{str += ",0";}
			}
		
			$("#timestring").val(str);//字符串赋值
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
</script>

</html>
