<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE HTML>
<html>
  <head>
    
	<title>优惠信息</title>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"
	/>
	
	<link rel="stylesheet" type="text/css" href="res/css/based.css">
	<link rel="stylesheet" type="text/css" href="res/css/discountList.css"  />


	<script type="text/javascript" src="res/js/jquery-1.7.2.min.js">
	</script>
	<script src="res/js/common.js" type="text/javascript">
	</script>
	

</head>
<body>
	<!--顶部开始-->
	<div id="top">
		<!-- top banner -->
        <div class="topbanner">
            <div class="topbannerWord" style="z-index:1;">    
                优惠信息
            </div>
            <div class="clear"></div>
        </div>
        <!-- top banner -->  
	</div>
	<!--顶部结束-->

	<div id="content">
		<div class="discountListBox">
			<ul class="discountList">
				<a href="discountDetail.jsp">
					<li>
						<div class="ChannelName">
							岳阳市体育中心羽毛球馆
						</div>
						<div class="ChannelPicture">
							<img src="res/images/img2.jpg" />
						</div>
						<div class="ChannelIntroduction">
							岳阳市体育中心羽毛球馆免费开放
						</div>
						<div class="ShowInfo">
							点击查看详情&gt;&gt;
						</div>
					</li>
				</a>
				<a href="discountDetail.jsp">
					<li>
						<div class="ChannelName">
							钟四海室内健身
						</div>
						<div class="ChannelPicture">
							<img src="res/images/img1.jpg" />
						</div>
						<div class="ChannelIntroduction">
							钟四海室内健身优惠办理会员
						</div>
						<div class="ShowInfo">
							点击查看详情&gt;&gt;
						</div>
					</li>
				</a>
				<a href="#">
					<li>
						<div class="ChannelName">
							XXX 游泳馆
						</div>
						<div class="ChannelPicture">
							<img src="res/images/img4.jpg" />
						</div>
						<div class="ChannelIntroduction">
							两人一起，一人免单
						</div>
						<div class="ShowInfo">
							点击查看详情&gt;&gt;
						</div>
					</li>
				</a>
			</ul>
			<!--子频道显示 结束-->
			<div class="clear">
			</div>
		</div>
	</div>
</body>

</html>