<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
basePath += "cocah/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>享动</title>
<script type="text/javascript" src="../res/js/scroll.js"></script>
<style>

*{margin:0;padding:0;list-style-type:none;}
a,img{border:0;}
body{font:12px/180% Arial, Helvetica, sans-serif, "新宋体";}

.scroll{width:device-width;height:170px;margin:2px auto 0 auto; position:relative;overflow:hidden;}
.mod_01{float:left;width:device-width;}
.mod_01 img{display:block;width:device-width;height:170px;}
.dotModule_new{padding:0 5px;height:11px;line-height:6px;-webkit-border-radius:11px;background:rgba(45,45,45,0.5);position:absolute;bottom:5px;right:10px;z-index:11;}
#slide_01_dot{text-align:center;margin:3px 0 0 0;}
#slide_01_dot span{display:inline-block;margin:0 3px;width:5px;height:5px;vertical-align:middle;background:#f7f7f7;-webkit-border-radius:5px;}
#slide_01_dot .selected{background:#66ff33;}
.mainbody{
	margin:auto;
	width:device-width;
		border-left: #FFF solid 2px;
	border-right: #FFF solid 2px;}
.maintitle{
	height:30px;
	margin:auto;
	padding:inherit;
	background-color:#3cf;}
.maintitle_unit{
	width:20%; height:30px;  float:left;
	}
.title_p1{
	font-size:20px; 
	font-weight:bolder;
	line-height:30px;
	margin-left:10px;
	color:#FFF;}
homeico{
	background:url(../res/images/ico.png) no-repeat -110px 0px;
	margin:auto;
	width:50px;
	height:30px;
	float:right;
	display: inline-block;
	vertical-align:middle;
	cursor:pointer;}
backico{
	background:url(../res/images/ico.png) no-repeat -60px 0px;
	margin:auto;
	width:60px;
	height:30px;
	float:left;
	display: inline-block;
	vertical-align:middle;
	cursor:pointer;}

.select_day_list{}
.select_day_unit{
	height:30px;
	margin-top:20px;
	color:#777;
	border-bottom: dotted #666666 1px;
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
</style>


</head>

<body>
<div class="mainbody">
	<div  class="maintitle">
        <div class="maintitle_unit"><a href="sportClass.jsp"><backico></backico></a></div>
        <div class="maintitle_unit" style="width:56% !important; text-align:center; margin-left:3% ">
        <b class="title_p1"></b>
        </div>
        <div class="maintitle_unit"><a href="sport.jsp">
          <homeico></homeico>
        </a></div>
    </div>
   
<div class="scroll">
	<div class="slide_01" id="slide_01">
		<div class="mod_01"><a href="#"><img src="../res/images/02856300.jpg" alt=""></a></div>
		<div class="mod_01"><a href="#"><img src="../res/images/50849300.jpg" alt=""></a></div>
		<div class="mod_01"><a href="#"><img src="../res/images/54330800.jpg" alt=""></a></div>

	</div>
	<div class="dotModule_new">
		<div id="slide_01_dot"></div>
	</div>
</div>
	<div>
    <p style="font-size:18px; font-weight:700; margin-left:20px; margin-top:10px; color:#39c;">张天辉</p><hr style="width:60%"/>
			<p style="margin-left:20px; font:16px;"><span>场馆地址：</span>岳阳市岳阳楼区岳阳市委旁</p>
            <p style="margin-left:20px; font:16px;"><span>联系电话：</span>0731-87945613</p>
            <p style="margin-left:20px; font:16px;"><span>场馆价格：</span>30元起</p>
            <p style="margin-left:20px; font:16px;"><span>附加服务：</span>wifi、饮料、器材售卖</p>
            <p style="margin-left:20px; font:16px;"><span>公共交通：</span>5路、7路、31路市委下</p>
	
    </div>
    <div style="height:40px; background-color:#fff; margin:10px auto; padding:inherit; border-bottom:#39C 1px dashed;"> 
    	<p style="font-size:18px; font-weight:700; margin-left:20px; margin-top:10px; color:#39c;"> 场馆预定</p><hr style="width:40%"/>
    </div>
    <div class="select_day_list">
    <div class="select_day_unit">
    	<p>
        <strong>9月1日 周二</strong>
        <span>可定</span>
        <a href="sportBookOrder.jsp">立即预定</a>
        </p>
    </div>
        <div class="select_day_unit">
    	<p>
        <strong>9月2日 周三</strong>
        <span style="color:#F00 !important">不可定</span>
        <a style="background-color:#000 !important;">立即预定</a>
        </p>
    </div>
        <div class="select_day_unit">
    	<p>
        <strong>9月3日 周四</strong>
        <span>可定</span>
        <a>立即预定</a>
        </p>
    </div>
        <div class="select_day_unit">
    	<p>
        <strong>9月4日 周五</strong>
        <span>可定</span>
        <a>立即预定</a>
        </p>
    </div>
        <div class="select_day_unit">
    	<p>
        <strong>9月5日 周六</strong>
        <span>可定</span>
        <a>立即预定</a>
        </p>
    </div>
        <div class="select_day_unit">
    	<p>
        <strong>9月6日 周日</strong>
        <span>可定</span>
        <a>立即预定</a>
        </p>
    </div>
            <div class="select_day_unit">
    	<p>
        <strong>9月7日 周一</strong>
        <span>可定</span>
        <a>立即预定</a>
        </p>
    </div>
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
