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
		<title>上传场地产品到服务器</title>
		<!-- 引入日历组件 -->
		<link rel="stylesheet" type="text/css" href="../res/commonComponents/calendar/css/jcDate.css" media="all" />		
		<!-- 引用控制层插件样式 -->
		<link rel="stylesheet" href="uploadFiles/control/css/zyUpload.css" type="text/css">
		<link rel="stylesheet" href="uploadFiles/control/css/uploadProducts.css" type="text/css">
		<link href="../res/css/component.css" type="text/css" rel="stylesheet" />
		<script type="text/javascript" src="../res/js/jquery-1.8.3.min.js"></script>
		<!-- 引用核心层插件 -->
		<script type="text/javascript" src="uploadFiles/core/zyFile.js"></script>
		<!-- 引用控制层插件 -->
		<script type="text/javascript" src="uploadFiles/control/js/zyUpload.js"></script>
		<!-- 引用初始化JS -->
		<script type="text/javascript" src="uploadFiles/productImgUpload.js"></script>
		<!-- 引入在线编辑器 -->
		<script type="text/javascript" charset="utf-8" src="../res/ueditor/ueditor.config.js"></script>
		<script type="text/javascript" charset="utf-8"	src="../res/ueditor/ueditor.all.min.js"></script>
		<script type="text/javascript" charset="utf-8"	src="../res/ueditor/lang/zh-cn/zh-cn.js"></script>
		<!-- 引入下拉列表组件 -->
		<link href="../res/commonComponents/dropDownList/css/dropdownlist.css" rel="stylesheet" type="text/css">
		<script src="../res/commonComponents/dropDownList/js/dropdownlist.js"></script>
		<script src="../res/js/jquery.validate-1.13.1.js" type="text/javascript"></script>
		<style type="text/css">
			a:hover{
				color:#343446;
			}
			.selectContent select  {
				border:1px solid rgb(122,144,256) !important;
			}
				.wrong+span{
 		color:#f00;
 		
 		letter-spacing:1px;
 		margin-left:5px;
 	}
		</style>
	</head>
	
	<body>
<script type="text/javascript">
		
$(document).ready(
		function (){					
			//ue=UE.getEditor('productDetail').setShow();
			var ue = UE.getEditor('productDetail',{
		        initialFrameWidth : 480,
		        initialFrameHeight: 100
		    });
		    ue.render('myEditor2',{
		        autoFloatEnabled : false
		    });
			$("#productDetail").show();	
		}
	);
	//system error
	function myerror(_message,_url,_line)
		    {
		       return true; //屏蔽系统的事件
		    }
    //绑定错误事件
    window.onerror = myerror;
	
</script>
	    <!--<div id="productImgUpload" class="productImgUpload"></div>  -->
		<div class="unloadProductWrap">
			<div class="uploadFormWrap">
				<form id="placeproduct-form" action="placeProductanduploadPlaceProduct" method="post">
				<input type="hidden" name="product.site.id" value="<s:property value='#session.currentSite.id'/>"/>
				<div class="uploadItem">
					<div class="itemIitle">商品名：</div>
					<div calss="itemContent">
						<input type="text" name="product.productName"  class="inputText textLength1"></input>
					</div>
				</div>
				
				<div class="uploadItem lists">
					<div class="itemIitle">
					商品分类： 
					</div>
					<div class="listItemContent">						
						<div class="item">
							<div class="selectContent" id="productTypeRootWrap">
								<select id='productTypeRoot' >
									<s:iterator value="types">
										<option value="<s:property value='id'/>">
											<s:property value="typeName"/>
										</option>
									</s:iterator>
								</select>
							</div>
						</div>
						
						<div class="item lastitem" id="parentTypeId" id="productTypeParentWrap" style="margin-left:5px;">
							<div class="selectContent" id="parentTypeWrap">
								<select id='productTypeParent' name="product.type.id">
									<s:iterator value="types[0].childrenProductTypes">
										<option value="<s:property value='id'/>">
											<s:property value="typeName"/>
										</option>
									</s:iterator>
								</select>
							</div>
						</div>							
					</div>
				</div>
				<div class="uploadItem">
					<div class="itemIitle">
					产品等级：
					</div>
					<div calss="itemContent">
						<select id="productLevel" name="product.level.id" style="border:1px solid rgb(122,144,256)">
							<s:iterator value="levels">
								<option value="<s:property value='id'/>">
									<s:property value="levelName"/>
								</option>
							</s:iterator>
						</select>
					</div>
				</div>
				<div class="uploadItem">
					<div class="itemIitle">
					普通价(&nbsp;&yen;&nbsp;)：
					</div>
					<div calss="itemContent">
						<input type="text" name="product.normalPrice" class="inputText textLength1"></input>
					</div>
					<div style="height:5px"></div>
					<div class="itemIitle">
					促销价(&nbsp;&yen;&nbsp;)：
					</div>
					<div calss="itemContent">
						<input type="text" name="product.bargainPrice" class="inputText textLength1"></input>
					</div>
				</div>
				<div class="" style="clear:both;">
					<div class="itemIitle">
					产品简介：
					</div>
					<div calss="itemContent" >
						<input type="text" name="product.introduction" style="width:400px;" class="inputText textLength1"></input>
					</div>
				</div>
				<div class="uploadItem">
					<div >
						<span>产品详情：<a id="showOrHideEditor" class="button blue">隐藏编辑器</a></span>
					</div>
					<div style="clear:both;"></div>
					<div id="editor">
						<textarea style="height:100px;width:600px;" name="product.detail" id="productDetail">							
						</textarea>
					</div>
				</div>	
				<div class="uploadItem" id="uploadImagesWrapId" style="display:none;">
					<!-- 这里保存产品图片上传之后的图片id集，之后保存到产品中去 -->
					
				</div>	
				<div class="uploadItem" style="float:right;">
					<div class="itemIitle">
					填写完所有信息后完成该产品的上传：
					</div>
					<div style="clear:both;"></div>
					<div calss="itemContent">
						<input type="submit" id="uploadNormalImgs" value="上传产品"  class="button blue"></input>
					</div>
				</div>			
				</form>
			</div>
			<div class="uploadImgs">
			<hr><br>
				<div class="uploadItemBtn">
					上传产品图片：
					<input type="button" id="uploadNormalImgs" value="上传"  class="button blue"></input>
					
				</div>				
				
				<div class="uploadItemBtn" style="text-align:center;">
					状态信息:<span id="uploadShowInfo" >...</span>
				</div>
				<!--上传组件-->
				
				<div id="productImgUpload" class="productImgUpload"></div>
			</div>
			
		</div>
</div>
<script type="text/javascript" src="../res/commonComponents/calendar/js/jQuery-jcDate.js" charset="utf-8"></script>
<script type="text/javascript">
	$(function (){
		$("input#productDate").jcDate({					       
				IcoClass : "jcDateIco",
				Event : "click",
				Speed : 100,
				Left : 0,
				Top : 28,
				format : "-",
				Timeout : 100
		});
		$("#showOrHideEditor").click(function(){
			if($("#showOrHideEditor").html()=="隐藏编辑器"){
				$("#editor").hide();
				$("#showOrHideEditor").html("显示编辑器");
			}else{
				$("#editor").show();
				$("#showOrHideEditor").html("隐藏编辑器");
			}
		});
		
///********************************************************校验//
	$("#placeproduct-form").validate({
		 	rules:{
 				"product.productName":{
 					required:true,
 					minlength:2,
 					maxlength:10
 				},
 				"product.normalPrice":{
 					required:true,
 					number:true,
 					minlength:1,
 					maxlength:10
 				},
 				"product.bargainPrice":{
 					number:true,
 					minlength:1,
 					maxlength:10
 				}
 			},
 			messages:{
 				"product.productName":{
 					required:"商品名必填",
 					minlength:"最短为2位",
 					maxlength:"最长为10位"
 				},
 				"product.normalPrice":{
 					required:"商品价格必填",
 					number:"请填写数字",
 					minlength:"商品价格必填",
 					maxlength:"最大为9999999999"
 				},
 				"product.bargainPrice":{
 					number:"请填写数字",
 					minlength:"商品价格必填",
 					maxlength:"最大为9999999999"
 				}
 			},
 			errorClass:"wrong",
 			errorElement:"span"  
		});
	});
</script>
</body>
</html>

