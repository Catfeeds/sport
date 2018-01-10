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
		<title>上传图片到服务器</title>
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
	<style type="text/css">
			a:hover{
				color:#343446;
			}
		</style>
	</head>
	
	<body>
<script type="text/javascript">
		
$(document).ready(
		function (){					
			//ue=UE.getEditor('productDetail').setShow();
			var ue = UE.getEditor('productDetail');
			$("#productDetail").show();	
		}
	);
	/*//system error
	function myerror(_message,_url,_line)
		    {
		       alert("错误信息：" + _message
		            +"\n错误的URI：" + _url
		            +"\n错误的行数：" + _line
		       );
		 
		       return true; //屏蔽系统的事件
		    }
    //绑定错误事件
    window.onerror = myerror;*/
	
</script>
	    <!--<div id="productImgUpload" class="productImgUpload"></div>  -->
		<div class="unloadProductWrap">
			<div class="uploadFormWrap">
				<form action="productandaddProduct" method="post">
				<div class="uploadItem">
					<div class="itemIitle">商品名：</div>
					<div calss="itemContent">
						<input type="text" name="product.productName" value="<s:property value='productInfo.productName'/>" class="inputText textLength1"></input>
					</div>
				</div>
				<div class="uploadItem">
					<div class="itemIitle">
					产品起始编号：
					</div>
					<div calss="itemContent">
					<input type="text" name="product.startProductNumber"  class="inputText textLength1"></input>
					
					</div>
				</div>
				<div class="uploadItem">
					<div class="itemIitle">
					产品数量：
					</div>
					<div calss="itemContent">
					<input type="text" name="product.productNumber" class="inputText textLength1"></input>
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
									<s:iterator value="rootTypes">
										<s:if test="productType.parentProductType.parentProductType.id==id">
										<option selected="selected"  value="<s:property value='id'/>">
											<s:property value="typeName" />
										</option>
										</s:if>
										<s:else>
										<option value="<s:property value='id'/>">
											<s:property value="typeName" />
										</option>
										</s:else>										
									</s:iterator>
								</select>
							</div>
						</div>
						<div class="item" id="parentTypeId" id="productTypeParentWrap">
							<div class="selectContent" id="parentTypeWrap">
								<select id='productTypeParent' >
									<s:iterator value="productType.parentProductType.parentProductType.childrenProductTypes">
										<s:if test="productType.parentProductType.id==id">
										<option selected="selected"  value="<s:property value='id'/>">
											<s:property value="typeName" />
										</option>
										</s:if>
										<s:else>
										<option value="<s:property value='id'/>">
											<s:property value="typeName" />
										</option>
										</s:else>							
									</s:iterator>
								</select>
							</div>
						</div>
						<div class="item lastitem" id="childTypeId">
							<div class="selectContent" id="productTypeWrap">
								<select id='productType'>
									<s:iterator
										value="productType.parentProductType.childrenProductTypes">
										<s:if test="productType.id==id">
										<option selected="selected"  value="<s:property value='id'/>">
											<s:property value="typeName" />
										</option>
										</s:if>
										<s:else>
										<option value="<s:property value='id'/>">
											<s:property value="typeName" />
										</option>
										</s:else>
									</s:iterator>
								</select>
							</div>
						</div>								
					</div>
				</div>
				<div class="uploadItem">
					<div class="itemIitle">
					等级：
					</div>
					<div calss="itemContent">
						<select id="productLevel" name="product.level">
							<s:if test="productInfo.level.equals(\"一等品\")">
								<option selected="selected" value="一等品">一等品</option>
							</s:if>
							<s:else>
								<option value="一等品">一等品</option>
							</s:else>
							<s:if test="productInfo.level.equals(\"二等品\")">
								<option selected="selected" value="二等品">二等品</option>
							</s:if>
							<s:else>
								<option value="二等品">二等品</option>
							</s:else>
							<s:if test="productInfo.level.equals(\"三等品\")">
								<option selected="selected" value="三等品">三等品</option>
							</s:if>
							<s:else>
								<option value="三等品">三等品</option>
							</s:else>
						</select>
					</div>
				</div>
				<div class="uploadItem">
					<div class="itemIitle">
					普通价(&nbsp;&yen;&nbsp;)：
					</div>
					<div calss="itemContent">
						<input type="text" name="productInfo.normalPrice"  value="<s:property value='productInfo.normalPrice'/>" class="inputText textLength1"></input>
					</div>
					<div class="itemIitle">
					会员价(&nbsp;&yen;&nbsp;)：
					</div>
					<div calss="itemContent">
						<input type="text" name="product.memberPrice" value="<s:property value='productInfo.memberPrice'/>"  class="inputText textLength1"></input>
					</div>
				</div>
				<div class="uploadItem">
					<div class="itemIitle">
					邮费(&nbsp;&yen;&nbsp;)：
					</div>
					<div calss="itemContent">
						<input type="text" name="product.sendCost"  value="<s:property value='productInfo.sendCost'/>" class="inputText textLength1"></input>
					</div>
				</div>
				<div class="uploadItem">
					<div class="itemIitle">
					生产日期：</div>
					<div calss="itemContent">
					<input type="text" name="product.productDate" id="productDate" value="<s:property value='productInfo.productDate'/>"  class="inputText textLength1"></input>
					</div>
				</div>
				<div class="uploadItem">
					<div class="itemIitle">
					保质期：
					</div>
					<div calss="itemContent">
						<input type="text" name="product.saveDays" value="<s:property value='productInfo.saveDays'/>"  class="inputText textLength1"></input>(天)
					</div>
				</div>
				
				<div class="uploadItem">
					<div class="itemIitle">
					尺寸：</div>
					<div calss="itemContent">
						<input type="text" name="product.size" value="<s:property value='productInfo.size'/>"  class="inputText textLength1"></input>
					</div>
				</div>
				<div class="uploadItem">
					<div class="itemIitle">
					颜色：</div>
					<div calss="itemContent">
						<input type="text" name="product.color" value="<s:property value='productInfo.color'/>"  class="inputText textLength1"></input>
					</div>
				</div>
				<div class="" style="clear:both;">
					<div class="itemIitle">
					产品简介：
					</div>
					<div calss="itemContent" >
						<input type="text" name="product.introduction" value="<s:property value='productInfo.introduction'/>"  style="width:400px;" class="inputText textLength1"></input>
					</div>
				</div>
				<div class="uploadItem">
					<div >
					<span>产品详情：<a id="showOrHideEditor" class="button blue">隐藏编辑器</a></span>
					</div>
					<div style="clear:both;"></div>
					<div id="editor">
						<textarea style="height:100px;width:600px;"  value="" name="product.detail" id="productDetail"><s:property value='productInfo.detail'/></textarea>
					</div>
				</div>	
				<div class="uploadItem" id="uploadImagesWrapId" style="display:none;">
					<!-- 这里保存产品图片上传之后的图片id集，之后保存到产品中去 -->
					<input id="productTypeId" type="hidden" name="product.productTypeId" 
					value="<s:property value='rootTypes[0].childrenProductTypes[0].childrenProductTypes[0].id'/>"/>
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
					产品普通图片：
					<input type="button" id="uploadNormalImgs" value="上传"  class="button blue"></input>
					
				</div>				
				<div class="uploadItemBtn">
					产品小图（利用放大镜时需要）：
					<input type="button" id="uploadSmallImgs" value="上传" class="button blue"></input>
				</div>
				<div class="uploadItemBtn">
					产品大图（利用放大镜时需要）：
					<input type="button" id="uploadBigImgs" value="上传" class="button blue"></input>
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
	});
</script>
</body>
</html>







