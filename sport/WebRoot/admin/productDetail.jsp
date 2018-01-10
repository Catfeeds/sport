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
		<title>产品详细信息</title>
		<!-- 引入日历组件 -->
		<link rel="stylesheet" type="text/css" href="../res/commonComponents/calendar/css/jcDate.css" media="all" />		
		<!-- 引用控制层插件样式 -->
		<link rel="stylesheet" href="uploadFiles/control/css/uploadProducts.css" type="text/css">
		<link href="../res/css/component.css" type="text/css" rel="stylesheet" />
		<script type="text/javascript" src="../res/js/jquery-1.8.3.min.js"></script>
		<!-- 引入在线编辑器 -->
		<script type="text/javascript" charset="utf-8" src="../res/ueditor/ueditor.config.js"></script>
		<script type="text/javascript" charset="utf-8"	src="../res/ueditor/ueditor.all.min.js"></script>
		<script type="text/javascript" charset="utf-8"	src="../res/ueditor/lang/zh-cn/zh-cn.js"></script>
		<!-- 引入下拉列表组件 -->
		<link href="../res/commonComponents/dropDownList/css/dropdownlist.css" rel="stylesheet" type="text/css">
		<script src="../res/commonComponents/dropDownList/js/dropdownlist.js"></script>
	</head>
	
	<body>
<script type="text/javascript">
/*		
$(document).ready(
		function (){					
			//ue=UE.getEditor('productDetail').setShow();
			var ue = UE.getEditor('productDetail');
			$("#productDetail").hide();	
		}
	);
	//system error
	function myerror(_message,_url,_line)
		    {
		       alert("错误信息：" + _message
		            +"\n错误的URI：" + _url
		            +"\n错误的行数：" + _line
		       );
		 
		       return true; //屏蔽系统的事件
		    }
    //绑定错误事件
    window.onerror = myerror;
	*/
</script>
	    <!--<div id="productImgUpload" class="productImgUpload"></div>  -->
		<div class="unloadProductWrap">
			<div class="uploadFormWrap">
				<form action="productandaddProduct" method="post">
				<div class="uploadItem lists">
					<div class="itemIitle">
					商品分类： 
					</div>
					<div class="itemContent">
						<span id="productType">
							<s:if test="productType==null||(productType.parentProductType==null)">
								&raquo;&nbsp;公司所有产品
							</s:if>
							<s:else>
								&raquo;<s:property value="productType.parentProductType.parentProductType.typeName"/>&nbsp;
								&raquo;<s:property value="productType.parentProductType.typeName"/>&nbsp;
								&raquo;<s:property value="productType.typeName"/>
							</s:else>
						</span>
					</div>
				</div>
				<div class="uploadItem">
					<div class="itemIitle">商品名：</div>
					<div calss="itemContent">
						<span id="productName"><s:property value="productInfo.productName"/></span>
					</div>
				</div>
				<div class="uploadItem">
					<div class="itemIitle">
					产品数量：
					</div>
					<div calss="itemContent">
					<span id="productNumber"><s:property value="productInfo.productNumber" /></span>
					</div>
				</div>
				
				<div class="uploadItem">
					<div class="itemIitle">
					等级：
					</div>
					<div calss="itemContent">
						<span id="productLevel">
							<s:property value="productInfo.level"/>
						</span>
					</div>
				</div>
				<div class="uploadItem">
					<div class="itemIitle">
					普通价(&nbsp;&yen;&nbsp;)：
					</div>
					<div calss="itemContent">
						<span id="normalPrice">
							<s:property value="productInfo.normalPrice"/>
						</span>
					</div>
					<div class="itemIitle">
					会员价(&nbsp;&yen;&nbsp;)：
					</div>
					<div calss="itemContent">
						<span id="memberPrice">
							<s:property value="productInfo.memberPrice" />
						</span>						
					</div>
				</div>
				<div class="uploadItem">
					<div class="itemIitle">
					邮费(&nbsp;&yen;&nbsp;)：
					</div>
					<div calss="itemContent">
						<span id="sendCost">
							<s:property value="productInfo.sendCost" />
						</span>
					</div>
				</div>
				<div class="uploadItem">
					<div class="itemIitle">
					生产日期：</div>
					<div calss="itemContent">
						<span id="productDate">
							<s:property value="productInfo.productDate" />
						</span>
					</div>
				</div>
				<div class="uploadItem">
					<div class="itemIitle">
					保质期：
					</div>
					<div calss="itemContent">
						<span id="saveDays">
							<s:property value="productInfo.saveDays"/>(天)
						</span>						
					</div>
				</div>				
				<div class="uploadItem">
					<div class="itemIitle">
					尺寸：</div>
					<div calss="itemContent">
						<span id="size">
							<s:property value="productInfo.size"/>
						</span>						
					</div>
				</div>
				<div class="uploadItem">
					<div class="itemIitle">
					颜色：</div>
					<div calss="itemContent">
						<span id="color">
							<property value="productInfo.color"/>
						</span>
					</div>
				</div>
				<div class="uploadItem" style="clear:both;">
					<div class="itemIitle">
					产品简介：
					</div>
					<div calss="itemContent" >
						<span id="introduction">
							<s:property value="productInfo.introduction"/>
						</span>						
					</div>
				</div>
				<div class="productImgs">
					<hr><br>
					<div class="bigImgs">
					
					</div>
					<div class="normalImgs">
					
					</div>
					<div class=middleImgs>
					
					</div>
				</div>
				<div style="clear:both;"></div>
				<div >
					<div>产品详情：</div>											
					<div id="productDetail">
						<s:property escapeHtml="false" value="productInfo.detail"/>
					</div>
				</div>			
				</form>
			</div>
			
</div>

</body>
</html>







