<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">

	<meta charset="UTF-8">
	<meta name="Generator" content="EditPlus®">
	<meta name="author" content="">
	<meta name="Keywords" content="">
	<meta name="Description" content="" />

	<title>享动</title>


	<link href="res/css/base.css" rel="stylesheet" type="text/css">
	<link href="res/css/index.css" rel="stylesheet" type="text/css">
	<!-- 弹出登录注册对话框 -->
	<link rel="stylesheet" href="res/commonComponents/loginPopDialog/css/loginbox.css"  type="text/css"/>
	<script type="text/javascript" src="res/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="res/js/header.js"></script>
	<!-- 弹出框结束 -->
	
	<style type="text/css">
		.slider .slider-container .slider-wrapper .slide a img {
			width:990px;
			height:424px;
		}
	</style>
	
</head>
<body>
	

	<iframe src ="header" frameborder="0" marginheight="0" marginwidth="0" frameborder="0" scrolling="no" width="100%" height="190px;"></iframe> 

	
	<!-- ad player start -->
	<div class="slider">
		<div class="slider-container">
			<div class="slider-wrapper">
				<div class="slide"> <a href="javascript:void(0)"><img src="res/images/banner1.png" alt=""></a> </div>
				<div class="slide"> <a href="simpleSearch?condition.searchType=place&condition.searchFlag=complex&condition.address.id=0"><img src="res/images/banner2.png" alt=""></a> </div>
				<div class="slide"> <a href="simpleSearch?condition.searchType=coach&condition.searchFlag=complex&condition.address.id=0"><img src="res/images/banner3.png" alt=""></a> </div>
				<div class="slide"> <a href="forum/forumIndex.jsp"><img src="res/images/banner4.png" alt=""></a> </div>
			</div>
		</div>
	</div>	
	<!-- ad player end -->

	<iframe src="footer.jsp" width="100%" height="200px" frameborder="0" scrolling="no"></iframe>


	<script type="text/javascript" src="res/js/slider.js"></script> 

	<script type="text/javascript">
		(function() {
			Slider.init({
				target: $('.slider'),
				time: 3000
			});
		})();
	</script>

	
	<!-- mainbanner select start -->
	<script type="text/javascript">
		$(".mainbannerNav ul li").hover(function(){
		$(this).addClass("mainbannerSelected").siblings().removeClass("mainbannerSelected");
		});
	</script>
	<!-- mainbanner select end -->
		

</body>
</html>
