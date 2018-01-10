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
        
<title>享动</title>
<link rel="stylesheet" type="text/css" href="weixin/res/css/slideTool.css"  />
<script type="text/javascript" src="weixin/res/js/jquery-1.7.2.min.js">
</script>
<script type="text/javascript" src="weixin/res/js/common.js" >
</script>
<script type="text/javascript" src="weixin/res/js/jquery.flexslider-min.js">
</script>

<style>

*{margin:0;padding:0;list-style-type:none;}
a,img{border:0;}
body{font:12px/180% Arial, Helvetica, sans-serif, "新宋体";}

.mainbody {
	margin:auto;
	width:99%;
	border-left: #FFF solid 2px;
	border-right: #FFF solid 2px;
}
.maintitle {
	height:40px;
	margin:auto;
	padding:inherit;
	background-color:#3cf;
}
.maintitle_unit {
	width:20%;
	height:40px;
}
.title_p1 {
	font-size:16px;
	font-weight:bold;
	line-height:40px;
	color:#FFF;
}


.select_day_list{
	padding-bottom:10px;
}
.select_day_unit{
	height:30px;
	margin-top:20px;
	color:#777;
	border-bottom: dotted #666666 1px;
	padding-left:10px;
	}
.select_day_unit strong{
	font-size:16px; margin-left:10px;
	}
.select_day_unit span{	
	color:#39C; font-size:14px; margin-left:20px;
}
.select_day_unit a{
	font-size:16px;
	font-weight:800;
	height:25px;
	width:80px;
	line-height:25px;
	padding:inherit;
	text-align:center;
	background-color:#f60;		
	color:#fff;
	float:right;
	margin-right:20px;
	border-radius:15px;
	text-decoration:none;
}
.select_day_unit a:hover{ color:#000; background-color:39c;}


/* Anonymous ---------------------------*/

.slides li img {
	max-height:170px;
	min-height:170px;
}

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

.ct-box {
	margin:5px 0px;
	width:100%;
}

.ct-box span {
	display:inline-block;
	display:-moz-inline-box;
	width:45%; 
	padding:8px 0px;
	font-size:14px;
	margin-left:3%;
}

#focusme {
     position:absolute;
     top:100px;
     border:1px solid #fff;
     width:0px;
     color:#fff;
     opacity: 0.0; 
}
#ellipsistext {
	display:-moz-inline-box; 
    display:inline-block;
	width:70px;
	height:26px;
	line-height:26px;
	white-space:nowrap; 
	overflow : hidden;
	text-overflow: ellipsis;
}
</style>

	<script type="text/javascript">
		$(function() {
			document.getElementById("focusme").focus();
			
			$('.myflexslider').flexslider({
				controlNav: true,
				directionNav: false,
				animation: "slide",
				//manualControls: ".myflexslider .slidenav"
			});
			
			$(".m-bbtn").click(function(){
				window.history.back(-1);
			});
			
			$(".m-hbtn").click(function(){
				self.location='weixin/weixinandchooseCoach'; 
			});
		});
	</script> 


</head>

<body>
	
	<div class="mainbody">
	<input type="text" id="focusme"  />
		<div class="m-bbtn">
			<img alt="" src="<%=basePath%>/weixin/res/images/back.png" />
		</div>
		<div class="m-hbtn">
			<img alt="" src="<%=basePath%>/weixin/res/images/home.png" />
		</div>
		<div class="maintitle">
			<div class="maintitle_unit"
				style="width:100% !important; text-align:center; margin:0px auto;">
				<b class="title_p1"><s:property value='coach.realName'/> </b>
			</div>
		</div>

		<div style="clear:both;"></div>
		<div id="header">
			<div class="myflexslider" style="margin-top:1px;">
                <ul class="slides">
                <s:iterator value='coach.photoes' status="status">
                	<li>
                        <img src=".<s:property value='pathName'/>" width="100%" />
                    </li>
                 </s:iterator>  
                </ul>
            </div>
		</div>
		
		<div>
			<p
				style="font-size:18px; font-weight:700; margin-left:20px; margin-top:10px; color:#39c;"><s:property value='coach.realName'/></p>
			<hr style="width:60%" />
			<p style="margin-left:20px; font:16px;margin-top:10px;">
				<span>居住地：</span>岳阳市岳阳楼区岳阳市委旁 <a
					href="http://api.map.baidu.com/marker?location=113.094192,29.381201&output=html&src=weiba|weiweb"><span
					style=" color:#39f;font-size:14px;">看地图</span>
				</a>
			</p>
			<p style="margin-left:20px; font:16px;">
				<span>联系电话：</span><a href="tel:<s:property value='coach.phone'/>"><s:property value='coach.phone'/></a>
			</p>
			<p style="margin-left:20px; font:16px;">
				<span>起步价格：</span><s:property value='coach.basePrice'/>元起
			</p>
			<p style="margin-left:20px; font:16px;">
				<span>项目类型：</span><s:property value='coach.skillType.typeName'/>
			</p>
			<p style="margin-left:20px; font:16px;">
				<span>活动区域：</span>
				<s:iterator value="coach.addrs">
					<s:property value='parentAddress.addressName'/>>
            			<s:property value='addressName'/>&nbsp;&nbsp;
				</s:iterator>
			</p>

		</div>
		<div style="height:110px; background-color:#fff; margin:10px auto; padding:inherit; border-bottom:#39C 1px dashed;">
			<p style="font-size:18px; font-weight:700; margin-left:20px; margin-top:10px; color:#39c;">
				教练预定
			</p>
			<hr style="width:60%" />
			<div style="clear:both;"></div>
			<div class="ct-box">
				<a href="weixin/weixinandchooseDayCoach?coach.id=<s:property value='coach.id'/>">
		    		<label for="ids<s:property value='id'/>">
		    			<span>
		    			<s:if test="coachProduct==null">
		    				<input type="radio" name="producttype" checked="checked" id="ids1" />
		    			</s:if>
		    			<s:else>
		    				<input type="radio" name="producttype" id="ids1" />
		    			</s:else>
		    				教练自行安排
		    			</span>
		    		</label>
		    	</a>
		    	<s:iterator value='coach.coachProducts'>
		    		<a href="weixin/weixinandchooseDayCoach?coach.id=<s:property value='coach.id'/>&coachProduct.id=<s:property value='id'/>">
		    		<label for="ids<s:property value='id'/>">
		    			<span>
		    			<s:if test="coachProduct.id==id">
		    				<input type="radio" name="producttype" checked="checked" id="ids1" />
		    			</s:if>
		    			<s:else>
		    				<input type="radio" name="producttype" id="ids1" />
		    			</s:else>
		    				<s:property value="productName"/>
		    			</span>
		    		</label>
		    		</a>
		    	</s:iterator>
		    	<!-- 
				<span><input type="radio" name="ctc" id="ctc3" checked /><label for="ctc3"> 羽毛球陪练</label> </span>
				 -->
			</div>
		</div>
		<div style="clear:both;"></div>
		<div class="select_day_list" >
			<s:iterator value="dates" var="date" begin="0" status="status">
				<div class="select_day_unit">
					<p>
						<s:if test="coach.weekJobTimes[weekIndexArr[#status.index]]==1">
						<strong><s:date name="#date" format="MM月 dd日/" timezone="ch" />
							<s:property value="weeks[#status.index]" /></strong>
							 <span id="ellipsistext" >&nbsp;<s:property value='coachProduct.productName'/></span> 
							 <s:if test="coachProduct!=null">
								 <a	href="weixin/weixinandorderCoach?coach.id=<s:property value='coach.id'/>&coachProduct.id=<s:property value='coachProduct.id'/>&week=<s:property value='#status.index'/>">
								立即预订</a>
							</s:if>
							<s:else>
								<a	href="weixin/weixinandorderCoach?coach.id=<s:property value='coach.id'/>&week=<s:property value='#status.index'/>">
								立即预订</a>
							</s:else>
						</s:if>
						<s:else>
							<strong><s:date name="#date" format="MM月 dd日/" timezone="ch" />
							<s:property value="weeks[#status.index]" /></strong>
							 <span id="ellipsistext" >&nbsp;<s:property value='coachProduct.productName'/></span> 
								<a href="javascript:void(0);" style="background:black;">不可预订</a>
							
						</s:else>
					</p>
				</div>
			</s:iterator>				
		</div>

	</div>
</body>
<script type="text/javascript">
if(document.getElementById("slide_01")){
	var slide_01 = new ScrollPic();
	slide_01.scrollContId   = "slide_01"; //内容容器ID
	slide_01.dotListId      = "slide_01_dot";//点列表ID
	slide_01.dotOnClassName = "selected";
	slide_01.arrLeftId      = "sl_left"; //左箭头ID
	slide_01.arrRightId     = "sl_right";//右箭头ID
	slide_01.frameWidth     = 480;
	slide_01.pageWidth      = 480;
	slide_01.upright        = false;
	slide_01.speed          = 10;
	slide_01.space          = 30; 
	slide_01.initialize(); //初始化
}
</script>
</html>
