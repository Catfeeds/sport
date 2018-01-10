<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
basePath += "sport/";

%>

<!DOCTYPE HTML>
<html>
  <head>
    
        <title>
            享动
        </title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
        <link rel="stylesheet" type="text/css" href="../res/css/style.css"  />
        <link rel="stylesheet" type="text/css" href="../res/css/sportBook.css"  />
        <script type="text/javascript" src="../res/js/jquery-1.7.2.min.js">
        </script>
        <script src="../res/js/common.js" type="text/javascript">
        </script>

		<script type="text/javascript" src="../res/js/jquery.flexslider-min.js">
		</script>
		<script type="text/javascript">
			$(document).ready(function() {

				$('.myflexslider').flexslider({

					controlNav: true,

					directionNav: false,

					animation: "slide",

					//manualControls: ".myflexslider .slidenav"
				});

			});
		</script>  


    
    </head>
    
    <body>
        
        <!--页眉开始-->
        <div id="header">

             <div class="areaSelect" style="position:absolute;left:20px;top:13px;width:50px;overflow: hidden;background:#3cf;color:#fff;
		font-size:14px;">
                岳阳
            </div>

            <!-- top banner -->
            <div class="topbanner">
                <div class="topbannerWord" style="z-index:1;">    
                    我要预订
                </div>
                <div class="clear"></div>
            </div>
            <!-- top banner -->   

            <!--幻灯片 开始-->
                   

            <div class="myflexslider" style="margin-top:1px;">
                <ul class="slides">
                    <li>
                        <img src="../res/images/img1.jpg" width="100%" />
                    </li>
                    <li>
                        <img src="../res/images/img2.jpg" width="100%" />
                    </li>
                    <li>
                        <img src="../res/images/img3.jpg" width="100%" />
                    </li>
                    <li>
                        <img src="../res/images/img4.jpg" width="100%" />
                    </li>
                </ul>
            </div>
            <!--幻灯片 结束-->
        </div>
        <div id="content">
            <!--导航开始-->
            <ul class="channellist">
                <li>
                    <a href="sportClass.jsp" >
                        <div class="ChannelIcon">
                            <img src="../res/images/6.png" />
                        </div>
                        <div class="ChannelName">
                            足球
                        </div>
                    </a>
                    
                </li>
                <li>
                    <a href="sportClass.jsp" >
                        <div class="ChannelIcon">
                            <img src="../res/images/5.png" />
                        </div>
                        <div class="ChannelName">
                            羽毛球
                        </div>
                    </a>
                </li>
                <li>
                    <a href="sportClass.jsp" >
                        <div class="ChannelIcon">
                            <img src="../res/images/3.png" />
                        </div>
                        <div class="ChannelName">
                            乒乓球
                        </div>
                    </a>
                </li>
                <li>
                    <a href="sportClass.jsp" >
                        <div class="ChannelIcon">
                            <img src="../res/images/4.png" />
                        </div>
                        <div class="ChannelName">
                            游泳
                        </div>
                    </a>
                    
                </li>
                <li>
                    <a href="sportClass.jsp" >
                        <div class="ChannelIcon">
                            <img src="../res/images/1.png" />
                        </div>
                        <div class="ChannelName">
                            健身房
                        </div>
                    </a>
                </li>
                <li>
                    <a href="sportClass.jsp" >
                        <div class="ChannelIcon">
                            <img src="../res/images/2.png" />
                        </div>
                        <div class="ChannelName">
                            篮球
                        </div>
                    </a>
                </li>
            </ul>
            <!--导航结束-->
            <div class="clear">
            </div>
            <div>
                <div class="hotPic">
                </div>
                <div class="hotSportHall">
                  热门场馆
                </div>
            </div>

            <div>
                <ul class="productList">
                    <li>
                        <a href="sportBook.jsp">
                            <img src="../res/images/productPic1.jpg" />
                            <p class="productTitle">岳阳市体育中心 羽毛球馆</p>
                            <p class="productPrice">¥30</p>
                            <span class="book">预定</span>
                        </a>
                    </li>
                                       <li>
                        <a href="sportBook.jsp">
                            <img src="../res/images/productPic1.jpg" />
                            <p class="productTitle">岳阳市体育中心 羽毛球馆</p>
                            <p class="productPrice">¥30</p>
                            <span class="book">预定</span>
                        </a>
                    </li>                    <li>
                        <a href="sportBook.jsp">
                            <img src="../res/images/productPic1.jpg" />
                            <p class="productTitle">岳阳市体育中心 羽毛球馆</p>
                            <p class="productPrice">¥30</p>
                            <span class="book">预定</span>
                        </a>
                    </li>                    <li>
                        <a href="sportBook.jsp">
                            <img src="../res/images/productPic1.jpg" />
                            <p class="productTitle">岳阳市体育中心 羽毛球馆</p>
                            <p class="productPrice">¥30</p>
                            <span class="book">预定</span>
                        </a>
                    </li>                    <li>
                        <a href="sportBook.jsp">
                            <img src="../res/images/productPic1.jpg" />
                            <p class="productTitle">岳阳市体育中心 羽毛球馆</p>
                            <p class="productPrice">¥30</p>
                            <span class="book">预定</span>
                        </a>
                    </li>
                </ul>
            </div>

        </div>

    </body>

</html>