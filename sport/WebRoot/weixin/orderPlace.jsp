<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<title>场馆预定</title>

<style>
.ordercell{
	border-radius:10px;
	color:#fff;
	background-color:#39c;
	width:auto;
	max-width:200px;
	padding:5px;
	text-align:center;
	}

body{	padding:0; margin:0;}
a{ color:#000;text-decoration:none;}
.mainbody {
	margin:auto;
	width:99%;
	border-left: #FFF solid 2px;
	border-right:	#FFF solid 2px;
}
.maintitle {
	height:40px;
	margin:auto;
	padding:inherit;
	background-color:#3cf;
}
.maintitle_unit {
	width:99%;
	height:40px;
	float:left;
}
.title_p1 {
	font-size:16px;
	font-weight:bold;
	line-height:40px;
	color:#FFF;
	font-family: "微软雅黑";
}


.selecthail{
	font-size:10px;
	padding:0;
	text-align:center;
	min-width:100%;
	}
	
.selecthail tr{
	height:10px;}
#r0{background-color:#D4D4D4; min-width:device-width;overflow:scroll !important;}
#d0{ background-color:#D4D4D4; }
td{
	min-width:50px;
	height:30px;
	max-width:device-width;
}
.occupy_td{
	background-color:#BBB; 
	}
.able_td{
	background-color:#3F6;;
	cursor:pointer;}
.selected_td{
	background-color:#39C;
	cursor:pointer;}
	
	
.order{
	font-size:14px;
	padding:0 10px;}
.order p{
	width:90%;
	margin:10px auto;}
.order span{
	width:50%;
	margin:1px 5px;
	padding:2px 5px;
	border:#39C 1px solid;
	height:20px;}
.buttona{ 
	margin:0 auto;
	margin-bottom:20px !important;
	width:99%;
	text-align:center;
	padding:inherit;}
.buttona a{
	font-size:16px;
	font-weight:800;
	height:40px;
	padding:10px 120px;
	line-height:40px;
	text-align:center;
	background-color:#f60;		
	color:#fff;border-radius:10px;
	text-decoration:none;}
.buttona a:hover{ color:#000; background-color:39c;}

/* Anonymous ---------------------------*/
.m-bbtn {
	width:32px;
	height:32px;
	position:absolute;
	left:4px;
	top:0px;
	padding:4px 4px;
}
.m-hbtn {
	width:32px;
	height:32px;
	position:absolute;
	right:4px;
	top:0px;
	padding:4px 4px;
}
.m-bbtn img, .m-hbtn img {
	width:32px;
	height:32px;
}
</style>
<script type="text/javascript" src="weixin/res/js/jquery-1.7.2.min.js"></script>
</head>
<script type="text/javascript">
	$(function() {
		
		$(".m-bbtn").click(function(){
			window.history.back(-1);
		});
		
		$(".m-hbtn").click(function(){
			self.location='weixin/weixinandchoosePlace'; 
		});
	});
</script> 
<body>
<div class="mainbody">
<div class="m-bbtn">
				<img alt="" src="weixin/res/images/back.png" />
			</div>
			<div class="m-hbtn">
				<img alt="" src="weixin/res/images/home.png" />
			</div>
	<div  class="maintitle">
        <div class="maintitle_unit" style="width:100% !important; text-align:center; margin:0px auto;">
        <b class="title_p1"><s:date name="dates[week]" format="MM月 dd日/" timezone="ch" /> 
	        		<s:property	value="weeks[week]" /></b>
        </div>
  </div>
    <div style="clear:both;"></div>
    <div style="width:device-width; overflow:scroll !important; ">
<table class="selecthail">
    <tr id=r0>
    	<td id=d0>时间</td>
        
		<s:iterator value="sitePreOrderInfo.placesDayInfo">
			<td id="d<s:property value='place.id'/>">场地
					<s:property	value="place.placeName" />
			</td>
		</s:iterator>
    </tr>
    <s:iterator begin="8" end="21" var="i" status="outStatus">
		<tr id="r<s:property value='#outStatus.index'/>">
			<td id="d0"><s:property	value="i" />-<s:property value='#i+1' />时</td>
			<s:iterator value="sitePreOrderInfo.placesDayInfo" status="innerStatus">
				<s:if
					test="order.orderInfos[#outStatus.index+8]>0&&(place.prices[#outStatus.index+8]>0)">
					<td id="d<s:property value='#innerStatus.index+1'/>"
							class="able_td"
							timeId="<s:property value='#outStatus.index+8'/>"	
							placeId="<s:property value='place.id'/>"	
							preOrderId="<s:property value='order.id'/>"					
							selectTime="false"
							price="<s:property value='place.prices[#outStatus.index+8]'/>">
							&yen;<s:property
							value="place.prices[#outStatus.index+8]" />
					</td>
				</s:if>
				<s:else>
					<td id="d<s:property value='#innerStatus.index+1'/>"
							class="occupy_td"
							timeId="<s:property value='#outStatus.index+8'/>">无
					</td>
				</s:else>
			</s:iterator>
		</tr>
	</s:iterator>
</table>
</div>
	<div style="border:hidden">
        <div style="height:20px;">
            <img src="weixin/res/images/tishi.png" height="20">
        </div>
        <div style="margin:20px auto;text-align:center;">       
        	<s:if test="sitePreOrderInfo.product.type.typeName.equals(\"足球\")">
        		<s:property value='sitePreOrderInfo.place.placeProduct.type.typeName'/>预定足球最少2个小时，否则无效！（2小时为一场比赛）
        	</s:if> 
        </div>
        <div class="order">
        <p>您已选择</p>
        <div id="ordersBox"></div>
           <!--  <p style="text-align:center;"><span>17-18时 场馆1</span><span>17-18时 场馆1</span></p>
            <p style="text-align:center;"><span>17-18时 场馆1</span><span>17-18时 场馆1</span></p> -->
        <span>已选择<b
						style="color:#F00; font-size:18px; font-weight:600"
						id="orderedNumber"> </b>个场次,单击取消</span>
					<hr />
					<strong style="margin-left:2em;">共<b
						style="color:#F00; font-size:18px; font-weight:600"
						id="totalPrice"> 0 </b>元</strong> <br /> <br />
        </div>
       </div>
	   <div>
			<div class="buttona">
				 <a href="weixin/orderandsubmitOrder?week=<s:property value='week'/>">预定</a>
			</div>
		</div>
		

	
		

<script src="weixin/res/js/jquery-1.7.2.min.js" type="text/javascript"></script>
<script>
$(function(e) {
	var timePlaceNumber=0;//记录已经选择的场次数目
	var totalPrice=0;//所选场次的总金额
    $('.able_td').click(function(){
			var thisObj=this;
			var timeId=$(this).attr('timeId');
			var preOrderId = $(this).attr('preOrderId');
			var placeId = $(this).attr('placeId');
			var price=$(this).attr("price");
			//alert("timeId:"+timeId+"  preOrderId:"+preOrderId+" placeId:"+placeId+"  price:"+price);
			var selectTimeFlag=$(this).attr("selectTime");
		
			if(selectTimeFlag=="false"){
				if(timePlaceNumber>7){
					alert("不好意思，您一次最多只能预订8个场次的场地！");
					return ;
				}
				
				var nextTdId=timeId-1+2;
				var itemContent="<p orderItemId='0' class='ordercell'   id='orderedItem"+timeId+placeId+"'> "+timeId+" : 00-"+nextTdId+" : 00    "+placeId+"号场"+"</p>";
				
				//alert("选中成功,TimeId:"+timeId+"  placeId:"+placeId);			
				$.post("orderandaddItem",
		    			{"item.placePreOrder.id":preOrderId,
		    			 "item.time":timeId
		    			},
		    			function(data){
		    				var arr=new Array();
		    				$.each(data, function(i, item) {
								arr.push(item);					           
							});
		    				if(arr[0]){		    					
		    					$("#ordersBox").append(itemContent);
		    					$("#orderedItem"+timeId+placeId).attr("orderItemId",arr[1]);
		    					timePlaceNumber++;
		    					$(thisObj).attr("selectTime","true");
		    					var price=$(thisObj).attr("price")-1+1;
		    					totalPrice=totalPrice+price;
		    					$(thisObj).toggleClass('selected_td');
		    					$("#orderedNumber").html(timePlaceNumber);
		    					$("#totalPrice").html(totalPrice);
		    				}else{
		    					alert(arr[1]);
		    					
		    				}
		    	},"json");
			}else{
				var orderedId="#orderedItem"+timeId+placeId;
				
				//alert("取消选择成功，TimeId:"+timeId+"  placeId:"+placeId);
				$.post("orderanddeleteItem",
		    			{"item.id":$(orderedId).attr("orderItemId")},
		    			function(data){
		    				var arr=new Array();
		    				$.each(data, function(i, item) {
								arr.push(item);					           
							});
		    				if(arr[0]){
		    					//删除该订单项界面
		    					$(orderedId).replaceWith("");
		    					timePlaceNumber--;
		    					$(thisObj).attr("selectTime","false");
		    					var price=$(thisObj).attr("price");
		    					totalPrice=totalPrice-price;
		    					
		    					$(thisObj).toggleClass('selected_td');
		    					$("#orderedNumber").html(timePlaceNumber);
		    					$("#totalPrice").html(totalPrice);
		    				}else{
		    					alert(arr[1]);
		    				}
		    	},"json");
			}
		});
});
</script>    
    
</body>
</html>
