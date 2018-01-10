<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
basePath +="admin/";
%>
<!doctype html>
<html>
<head>
<title>无标题文档</title>
<style>
body{
	margin:0;
	padding:0;}
table td{
	margin:auto;
	padding:auto;}
input{
	font-size:14px;
}
.timeinput{
	width:30px;
	margin:auto;}

.timeselect td{
	width:35px;
	padding:0 5px;
	height:20px;
	line-height:20px;
	cursor:pointer;
	background:#3CF;
	}
.select_td{
	background:#999 !important;}	
</style>
<style>

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
	width:500px;
	height:360px;
	margin:-180px 0 0 -330px;
	border-radius:5px;
	border:solid 2px #666;
	background-color:#fff;
	display:none;
	box-shadow: 0 0 10px #666;
}
.abutton{
	outline: none;
	color: #000;
	padding:inherit;
	font-size: 16px;
   	padding:0 5px;
	font-weight: 500;
	background:#fff;
	border:rgb(55,112,220) 1px solid;
	width:120px;}
a{color:#333;text-decoration:none;}
a:hover{ color:#ff3b2e;}

.placetab{
			width: 90%;
			margin: 10px auto;
			text-align: center;
			border-bottom: 1px solid #ccc;
			border-left:1px solid #ccc ;
		}
		.placetab td{
			border-top: 1px solid #ccc;
			border-right:1px solid #ccc ;
		}
		.placeul{list-style: none;}
		.placeul li{
			float: left;
			border-bottom:solid 2px #999;
			cursor: pointer;
			width: auto;
			text-align:center;
			line-height: 18px;
			padding:3px 10px;
			background: rgb(213,222,219);
			color:#000;
			font-size:18px; 
			margin-bottom:8px;
			}
			.selectli{
			background: #fff !important;
			border: solid 2px #999;
			border-bottom:none !important;}
		</style>
<script type="text/javascript" src="../res/js/jquery-1.8.3.min.js"></script>
<link href="../res/commonComponents/resizeTable/css/dividePage.css" rel="stylesheet" type="text/css" />
</head>

<body>
<div id="tab">
		<!-- 	<ul class="placeul">
				<s:iterator value="allTypes">
					<s:if test="type.id==id">
						<li class="selectli"><s:property value='typeName'/></li>
					</s:if>
					<s:else>
						<li ><a href="placeandplaceList?site.id=<s:property value='site.id'/>&type.id=<s:property value='id'/>">
						<s:property value='typeName'/></a></li>
					</s:else>
				</s:iterator>				
			</ul>
		 -->	
		<center> <h1><s:property value='placeProduct.productName'/>场地产品下的所有场地操作</h1>	</center>	
<div style="clear:both"></div>
<s:if test="places!=null">
	<s:iterator value="places"><!-- 下一个 -->
	<form action="placeandalterPlace" method="post">
			<input type="hidden" name="place.id" value="<s:property value='id'/>"/>
			<table cellspacing="0" class="placetab" id="siteAllInfo<s:property value='id'/>">
			<tr style="background: #eee;">
				<td rowspan="3" style="border-right: 1px solid #666666;">
				<input type="checkbox" value="<s:property value='id'/>" name="siteId"</td>
				<td>时间</td>
				<td>00:00</td><td>01:00</td><td>02:00</td>
                <td>03:00</td><td>04:00</td><td>05:00</td>           
                <td>06:00</td><td>07:00</td><td>08:00</td>
                <td>09:00</td><td>10:00</td><td>11:00</td>
                <td>12:00</td><td>13:00</td><td>14:00</td>
                <td>15:00</td><td>16:00</td><td>17:00</td>
                <td>18:00</td><td>19:00</td><td>20:00</td>
                <td>21:00</td><td>22:00</td><td>23:00</td>
			</tr>	
			<tr>	
				<td>价格</td>
				<s:iterator value="prices" var="pric"   status="st"><!-- 下一个 -->
							<td>	
							<s:if test="#pric>0">
								 <input name="place.prices" class="timeinput"    value="<s:property />"/>
							</s:if>
							<s:else>
								 <input type="hidden" name="place.prices" class="timeinput"    value="<s:property />"/>
								----
							</s:else>
							</td>
				</s:iterator>
            </tr>
            <tr style="border-top:1px solid #666666 ;">
				<td colspan="3" name="placeName" >场地名:</td><td colspan="3">
					<input type="text" name="place.placeName" value="<s:property value='placeName'/>"/>
				</td>
				<td colspan="2"></td>
				<td colspan="3">					
				</td>
				<td colspan="14">
			
				<a  href="javascript:void(0);">
					<input class="deleteItemBtn" placeId="<s:property value='id'/>" type="button" value="删除"/>
				</a>
				<input  type="submit" value="修改"  /></td>
			</tr>
		</table>
		</form>
	</s:iterator>
</s:if>		
		
	</div>

<div class="pagination">
		
			<ul>
			<li><input class="but" type="button" value="添加"/></li>
				<li><input id="chooseAllBtn" type="button" value="选择所有" onclick="checkedAll();"></li>
				<li><input type="button" id="ondelete" value="删除选中"></li>
				<!-- 如果当前页是第一页 -->
				<s:if test="page.pageNumber<=1">
					<li class="disablepage">首页</li>
					<li class="disablepage">上一页</li>
				</s:if>
				<!-- 否则 -->
				<s:else>
					<li><a href="placeandplaceList?page.pageNumber=1">首页</a>
					</li>
					<li><a
						href="placeandplaceList?page.pageNumber=<s:property value='page.pageNumber-1'/>">上一页</a>
					</li>
				</s:else>
				<!-- 如果总页码小于7页，就显示全部页码 -->
				<s:if test="page.totalPageNumber<=7">
					<s:iterator begin="1" var="i" end="page.totalPageNumber">
						<s:if test="#i==page.pageNumber">
							<li class="currentpage">
										<s:property /> 
								</li>
						</s:if>
						<s:else>
							<li><a href="placeandplaceList?page.pageNumber=<s:property/>">
									<s:property /> </a></li>
						</s:else>
					</s:iterator>
				</s:if>
				<!-- 否则中间的隐藏，值显示离当前页最近的7页 -->
				<s:else>
					<s:if
						test="page.pageNumber>4&&page.pageNumber<(page.totalPageNumber-4)">
						<li>...</li>
						<s:iterator begin="page.pageNumber-3" var="i"
							end="page.pageNumber+3">
							<s:if test="page.pageNumber==#i">
								<li class="currentpage">
										<s:property /> 
								</li>
							</s:if>
							<s:else>
								<li><a
									href="placeandplaceList?page.pageNumber=<s:property/>">
										<s:property /> </a></li>
							</s:else>
						</s:iterator>
						<li>...</li>
					</s:if>
					<s:elseif test="page.pageNumber<=4">
						<s:iterator begin="1" var="i" end="7">
							<s:if test="page.pageNumber==#i">
								<li class="currentpage">
										<s:property /> 
								</li>
							</s:if>
							<s:else>
								<li><a href="placeandplaceList?page.pageNumber=<s:property/>">
										<s:property /> </a></li>
							</s:else>
						</s:iterator>
						<li>...</li>
					</s:elseif>
					<s:elseif test="page.pageNumber+4>=page.totalPageNumber">
						<li>...</li>
						<s:iterator begin="page.pageNumber-3" var="i"
							end="page.totalPageNumber">
							<s:if test="page.pageNumber==#i">
								<li class="currentpage">
										<s:property /> 
								</li>
							</s:if>
							<s:else>
								<li><a
									href="placeandplaceList?page.pageNumber=<s:property/>">
										<s:property /> </a></li>
							</s:else>
						</s:iterator>
					</s:elseif>
				</s:else>
				<!-- 如果当前页是最后一页 -->
				<s:if test="page.pageNumber==page.totalPageNumber">
					<li class="disablepage">下一页</li>
					<li class="disablepage">尾页</li>
				</s:if>
		
				<s:else>
					<li class="nextpage"><a
						href="placeandplaceList?page.pageNumber=<s:property value='page.pageNumber+1'/>">下一页</a>
					</li>
					<li class="nextpage"><a
						href="placeandplaceList?page.pageNumber=<s:property value='page.totalPageNumber'/>">尾页</a>
					</li>
				</s:else>
			</ul>
			
		</div>

<div class="tover">
     <div class="tclose" style="text-align:right;">
      <a href="javascript:;" title="关闭" class="close">×</a>
     </div>
    <center style=" margin-top:30px !important;">
    <span>场地名:&emsp;&emsp;</span>
    <input type="hidden" id="siteid" name="place.site.id" value="<s:property value='site.id'/>" />
    <span><input id="names" type="text" name="place.name" value="1"/></span><br/>
    <span>场地同一价:</span>
    <span><input id="vlaues" type="text" name="" value="25"/></span><br/>
    <span>
    	<input type="hidden" id="produtId" name="place.product.id" value="<s:property value='placeProduct.id'/>">
								
		
    </span><br/>
    <span>场地开放时间</span><br/>
    
    <table class="timeselect">
            <tr>
                <td>00:00</td><td>01:00</td><td>02:00</td>
                <td>03:00</td><td>04:00</td><td>05:00</td>
            </tr>
            <tr>
                <td>06:00</td><td>07:00</td><td>08:00</td>
                <td>09:00</td><td>10:00</td><td>11:00</td>
            </tr>
            <tr>
                <td>12:00</td><td>13:00</td><td>14:00</td>
                <td>15:00</td><td>16:00</td><td>17:00</td>
            </tr>
            <tr>
                <td>18:00</td><td>19:00</td><td>20:00</td>
                <td>21:00</td><td>22:00</td><td>23:00</td>
            </tr>
        </table> 
    <input type="button" class="queding" value="确定" />

    </center>
</div>
<div class="tback"></div>

<!--背景淡出-->
<!---->
</body>

<script type="text/javascript">
$(function() {
	$(".deleteItemBtn").click(function (){
		if(!confirm("删除是不可恢复的，确定要删除？"))
				return;
		var placeId=$(this).attr("placeId");
		$.post("placeanddeletePlace", {"place.id":placeId},function(data){
			   	 var arr=new Array();
				$.each(data, function(i, item) {
						arr.push(item);					           
				});
						
				if(arr[0]){//true时表示操作成功，更改界面元素状态							
					//$("#siteAllInfo"+placeId).remove();
					//alert("删除场地成功！");
					document.location=document.location;
				}else{
					alert(arr[1]);
				}
						
			 },'json');	
	});
   $(document).ready(function(e) {
			$("li").click(function(){
				
				$("li").removeClass("selectli");
				$(this).addClass("selectli");		
				
				});
        });
/**将时间价格字符串转换*/
	$(".tover td").mouseup(function(){
/****时间联动（天）时间选择控件 表格形式***/
		$(this).toggleClass("select_td");//选择变色控件
		if($('.tover td').eq(0).is('.select_td')){
			var str = "1";}
		else{var str = "0";}//初始化赋值
		for(i=1;i<24;i++){
			if($('.tover td').eq(i).is('.select_td')){
				str += ",1";}
			else{str += ",0";}
		}
		$("#timestring").val(str);//字符串赋值
	//	alert(str);
		});
 

 
 
 
    $('.but').click(function(){
/**点击弹出*/
	//	alert();
		$('.tback').fadeIn(100);
		$('.tover').slideDown(200);
	});
	
	$('.tclose .close').click(function(){
/**点击关闭*/
		$('.tback').fadeOut(100);
		$('.tover').slideUp(200);
	});
	

	$('.queding').click(function(){
/**添加时间*/
	/**post数据获取****/
		var placename=$("#names").val();
		var siteid=$("#siteid").val();

		var vlaues=$("#vlaues").val();
		var productId=$("#produtId").val();
		var timevlauestr="";
		if($('.tover td').eq(0).is('.select_td')){//价格字符串初始化
				timevlauestr="-1";}
		else{timevlauestr +=vlaues;}
		for(var i=1;i<24;i++){//价格字符串
			if($('.tover td').eq(i).is('.select_td')){//价格字符串
				timevlauestr +=","+"-1";}
			else{timevlauestr +=","+vlaues;}
		}
		//alert(timevlauestr);
		/****post提交表单*****/
		
		$.post("placeandaddPlace", {"place.placeName":placename,
									"place.site.id":siteid,
									"place.product.id":productId,
									"place.timePrice":timevlauestr},function(data){
			var arr=new Array();
			$.each(data, function(i, item) {
				arr.push(item);					           
			});
			if(arr[0]){//判断是否插入成功
				document.location=document.location;
			}
			else{alert("插入错误")}
		},'json');
		/*****post方法结束*******/
		//淡出
		$('.tback').fadeOut(100);
		$('.tover').slideUp(200);
	});
	
		$('#ondelete').click(function(){
		if(!confirm("删除是不可恢复的，确定要删除？"))
				return;
/**批量删除***/
			var ids="-1";
			var i=0;
			$("input:checked").each(function(){
					ids+=","+this.value;
					//alert(ids);
				});
				//alert("post");	
			$.post("placeanddeleteSelectedPlace", {"ids":ids},function(data){
		//	alert("post true");	
				   	 var arr=new Array();
						$.each(data, function(i, item) {
							arr.push(item);					           
						});
						
						if(arr[0]){//true时表示操作成功，更改界面元素状态							
							$("input:checked").each(function(){
									$("#siteAllInfo"+this.value).empty().hide();
								});	
						}
						else{alert(arr[1]);}		
			 },'json');	
		});	
	
	
});
</script>

  <script type="text/javascript">
	//选择所有进行操作
	function checkedAll() {
				
				if($("#chooseAllBtn").attr("value")=="选择所有"){
					$("#chooseAllBtn").attr("value","取消选择");
					$("input[name='siteId']").attr('checked','checked');
				}else{
					//alert($("#chooseAllBtn").attr("value"));
					$("input[name='siteId']").removeAttr('checked');
					$("#chooseAllBtn").attr("value","选择所有");
				}
			}

</script>



</html>
