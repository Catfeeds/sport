<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE HTML>
<html>
  <head>
    
        <title>
            V社区
        </title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
        <link rel="stylesheet" type="text/css" href="res/css/style.css"  />
        <link rel="stylesheet" type="text/css" href="res/css/vcommunity.css"  />
        <script type="text/javascript" src="res/js/jquery-1.7.2.min.js">
        </script>
        <script src="res/js/common.js" type="text/javascript">
        </script>
    </head>
    
    <body>
        
        <!--页眉开始-->
        <div id="header">

            <!-- top banner -->
            <div class="topbanner">
                <div class="topbannerWord" style="z-index:1;">    
                    V社区
                </div>
                <div class="clear"></div>
            </div>
            <!-- top banner -->   
        </div>
        <div id="content">
            <!--导航开始-->
            <ul class="channellist">
                <li>
                    <a href="#" onclick="if(type1.style.display=='none'){type1.style.display='';
                    type2.style.display='none';}
                          else{type1.style.display='none';}">
                        <div class="ChannelIcon">
                            <img src="res/images/sportPic.png" />
                        </div>
                        <div class="ChannelName">
                            场馆
                        </div>
                    </a>
                    
                </li>
                <li>
                    <a href="#" onclick="if(type2.style.display=='none'){type2.style.display='';
					type1.style.display='none';}
                          else{type2.style.display='none';}">
                        <div class="ChannelIcon">
                            <img src="res/images/coachPic.png" />
                        </div>
                        <div class="ChannelName">
                            教练
                        </div>
                    </a>
                </li>
            </ul>
            <!--导航结束-->
            <div class="clear">
            </div>

            <!-- 四个分类下的小分类 -->
            <div  id="type1" style="display:none;">
                <ul class="hide">
                    <li><a href="sportClass.jsp"> 足球</a></li>
                    <li><a href="#"> 羽毛球</a></li>
                    <li><a href="#"> 乒乓球</a></li>
                    <li><a href="#"> 游泳</a></li>
                    <li><a href="#"> 健身房</a></li>
					<li><a href="#"> 篮球</a></li>
                </ul>
            </div>
            <div  id="type2" style="display:none;">
                <ul class="hide">
                    <li><a href="#">减脂瘦身</a></li>
                    <li><a href="#">塑形增肌</a></li>
                    <li><a href="#">武术搏击</a></li>
                    <li><a href="#">晨跑</a></li>
                    <li><a href="#">游泳</a></li>
					<li><a href="#">团体课</a></li>
                </ul>
            </div>
            <div class="clear">
            </div>
            <div>
                <div class="hotSportHall">
                </div>
            </div>

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
					<a href="discountDetail.jsp">
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
            </div>

        </div>

        <div id="writeBar">
    		<a href="writeNote.jsp">
    			发布帖子
    		</a>
    	</div>

    </body>

</html>