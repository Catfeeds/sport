<%@ page language="java"  contentType="text/html; charset=UTF-8" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>运动场馆</title>
  <script src="js/jquery.min.js"></script>
  <script type="text/javascript" src="res/js/slider.js"></script> 
<script type="text/javascript" src="res/js/jquery-1.8.3.min.js"></script>
  <link href="res/css/zsport.css" rel="stylesheet" type="text/css" >
	<link href="res/css/base.css" rel="stylesheet" type="text/css">
	<link href="res/css/index.css" rel="stylesheet" type="text/css">
	<!-- 引入分页下标 -->
<link href="./res/commonComponents/resizeTable/css/dividePage.css"
	rel="stylesheet" type="text/css" />
<!--end -->
<!-- 弹出登录注册对话框 -->
	<link rel="stylesheet" href="res/commonComponents/loginPopDialog/css/loginbox.css"  type="text/css"/>
	<script type="text/javascript" src="res/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="res/js/header.js"></script>
	<!-- 弹出框结束 -->
</head>

<body>
<s:url var="searchUrl" value="simpleSearch?condition.searchType=place" includeParams="none">
	
</s:url>
<div><iframe src="header" width="100%" height="190px" frameborder="0" scrolling="no"></iframe></div>
<div class="mainbody" style="height:auto">

<div class="sport_body" style="height:auto">

    <div class="sport_body_left">
		<div class="banner">
            <div class="banner-btn">
                <a href="javascript:;" class="prevBtn"><i></i></a>
                <a href="javascript:;" class="nextBtn"><i></i></a>
            </div>
            <ul class="banner-img">
            	<s:iterator value="discounts">            	
                <li>
                	<a href="discountanddiscountDetail?discount.id=<s:property value='id'/>"><img src=".<s:property value='preViewImg.pathName'/>"></a>
                </li>
               </s:iterator>
            </ul>
            <ul class="banner-circle"></ul>
       	</div>
        <div class="clearfix"></div>
        	<div class="left_nav">           

                <div class="type-box" >
                    <div id="selectList" class="retrieval" >               
                        <dl class="dlb listIndex" attr="地区选择">
                            <dt>地点</dt>
                            <dd>
                            	<s:if test="#session.currentCondition.address==null">
                            		<s:a class="selected" href="javascript:void(0);">不限</s:a> 
                            	</s:if>
                            	<s:else>
                            		<s:a  href="%{searchUrl}&condition.searchFlag=complex&condition.address.id=0">不限</s:a> 
                            	</s:else>                            	
	                            <s:iterator value="addrs">
	                            	<s:if test='#session.currentCondition.address.id==id'>
		                            	 <s:a class="selected" href="%{searchUrl}&condition.searchFlag=complex&condition.address.id=%{id}" 
		                            	 	addrId="<s:property value='id'/>">
		                            	 	<s:property value="addressName"/>
		                            	 </s:a>
	                            	 </s:if>
	                            	 <s:else>
	                            	 	 <s:a href="%{searchUrl}&condition.searchFlag=complex&condition.address.id=%{id}" 
		                            	 	addrId="<s:property value='id'/>">
		                            	 	<s:property value="addressName"/>
		                            	 </s:a>
	                            	 </s:else>
	                            </s:iterator>    
                            </dd>
                        </dl>
                        <dl class="dlb listIndex" attr="terminal_sellFeature_s">
                            <dt>项目</dt>
                            <dd>
                            	<s:iterator value="types">
                            		<s:if test="#session.currentCondition.type.id==id">
	                            		 <s:a class="selected" href="%{searchUrl}&condition.searchFlag=complex&condition.type.id=%{id}"
	                            		  typeId="<s:property value='id'/>">
	                            		 	<s:property value="typeName"/>
	                            		 </s:a> 
                            		</s:if>
                            		<s:else>
                            			<s:a href="%{searchUrl}&condition.searchFlag=complex&condition.type.id=%{id}"
	                            		  typeId="<s:property value='id'/>">
	                            		 	<s:property value="typeName"/>
	                            		 </s:a> 
                            		</s:else>
                            	</s:iterator>
                            </dd>
                        </dl>
           			</div>
                </div>
		</div>
        <!-- end selected -->
        <div class="seq">
                    <ul class="left">
                        <li class="curr"><a href="javascript:void(0);">搜索结果</a></li>
                        <li><a href="javascript:void(0);"><!-- 价格 --></a></li>
                        <li><a href="javascript:void(0);"><!-- 好评 --></a><a class="sjico2" href="javascript:void(0);"></a></li>
                    </ul>
            
                    <div class="right">
                        <span>共<s:property value='page.totalItemNumber'/>个场馆</span>
                        <span><I><s:property value='page.pageNumber'/></I>/<s:property value='page.totalPageNumber'/></span> 
                        <a class="fany" href="javascript:void(0);">&gt;</a> 
                    </div>
                </div>
        <div class="left_result" style="height:auto">
        <s:iterator value="placeProducts">
        	
	        <div class="left_result_info" >
		           <div class="left_result_info_img">
		           <a href="orderPlace?placeProduct.id=<s:property value='id'/>&site.id=<s:property value='site.id'/>">
		         		<img src=".<s:property value='currentImage.pathName'/>" />
		           </a>
		           </div>
		           <div class="left_result_info_bief">
		           	<strong><s:property value='site.siteName'/>&nbsp;(<s:property value='productName'/>)</strong>
		               <br /><br />
		               <p>地点：<s:property value='site.siteAddress'/></p>
		           </div>
		           <div class="left_result_info_cost">
		                <p>原价: <span><s:property value='normalPrice'/></span>&nbsp;元</p><br />
		                <a href="orderPlace?placeProduct.id=<s:property value='id'/>&site.id=<s:property value='site.id'/>" class="abutton"> 进入场馆 </a>
		         </div>
		       </div>
	      
        </s:iterator>
        	<!-- 分页选择部分 -->
			<div class="left_result_info">
				<div class="pagination">
				<s:if test="page.totalPageNumber>1">
					<ul>
						<!-- 如果当前页是第一页 -->
						<s:if test="page.pageNumber<=1">
							<li class="disablepage">首页</li>
							<li class="disablepage">上一页</li>
						</s:if>
						<!-- 否则 -->
						<s:else>
							<li><s:a href="%{searchUrl}&page.pageNumber=1">首页</s:a>
		
							</li>
							<li><s:a
								href="%{searchUrl}&page.pageNumber=%{page.pageNumber-1}">上一页</s:a>
							</li>
						</s:else>
						<!-- 如果总页码小于7页，就显示全部页码 -->
						<s:if test="page.totalPageNumber<=7">
							<s:iterator begin="1" var="i" end="page.totalPageNumber">
								<s:if test="#i==page.pageNumber">
									<li class="currentpage"><s:property /></li>
								</s:if>
								<s:else>
									<li><s:a
										href="%{searchUrl}&page.pageNumber=%{i}">
											<s:property /> </s:a>
									</li>
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
										<li class="currentpage"><s:property /></li>
									</s:if>
									<s:else>
										<li><s:a
											href="%{searchUrl}&page.pageNumber=%{i}">
												<s:property /> </s:a>
										</li>
									</s:else>
								</s:iterator>
								<li>...</li>
							</s:if>
							<s:elseif test="page.pageNumber<=4">
								<s:iterator begin="1" var="i" end="7">
									<s:if test="page.pageNumber==#i">
										<li class="currentpage"><s:property /></li>
									</s:if>
									<s:else>
										<li><s:a
											href="%{searchUrl}&page.pageNumber=%{i}">
												<s:property /> </s:a>
										</li>
									</s:else>
								</s:iterator>
								<li>...</li>
							</s:elseif>
							<s:elseif test="page.pageNumber+4>=page.totalPageNumber">
								<li>...</li>
								<s:iterator begin="page.pageNumber-3" var="i"
									end="page.totalPageNumber">
									<s:if test="page.pageNumber==#i">
										<li class="currentpage"><s:property /></li>
									</s:if>
									<s:else>
										<li><s:a
											href="%{searchUrl}&page.pageNumber=%{i}">
												<s:property /> </s:a>
										</li>
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
							<li class="nextpage"><s:a
								href="%{searchUrl}&page.pageNumber=%{page.pageNumber+1}">下一页</s:a>
							</li>
							<li class="nextpage"><s:a
								href="%{searchUrl}&page.pageNumber=%{page.totalPageNumber}">尾页</s:a>
							</li>
						</s:else>
					</ul>
					</s:if>
				</div>
			</div>
			<!-- 分页部分结束 -->
		    <div class="left_result_info" style="visibility:hidden;">
            <div class="left_result_info_img"><a href="javascript:void(0)"><img src="#" /></a></div>
            </div>
        </div>
     </div>
 <!--******************** end body  left -->
 <div class="sport_body_right">
  	 	<div class="right_recom_sport" style="height:110px; border-bottom-color:#FFF; border-right-color:#FFF; border-left-color:#FFF;"> 
    	<img src="res/images/weixin.jpg" width="105px" height="105px" style=" margin:1px; float:left;">
       	<div style="float:right; text-align:left; width:100px; padding-top:5px;margin-top:4px;"> 
        <b style="font-size:18px; font-weight:700; color:#36C;">&nbsp;&nbsp;享&nbsp;&nbsp;&nbsp;&nbsp;动</b>
        <p style="margin-top:5px;">&nbsp;&nbsp;&nbsp;官方微信号</p>
        <p style="margin-top:5px;">扫一扫关注即可有机会获取精美大奖</p></div>
    </div>

    <div class="clearfix"></div>
        <!-- end recom sport-->
        <div class="right_hot_sport">
       		<div class="right_hot_title"><p>热门场馆</p></div>
       		<s:iterator value="placeProducts" status="st">
       			<s:if test="#st.index<5">
				<div class="right_hot_list_div">
                  <div class="hot_list_img">
                  	<a href="orderPlace?placeProduct.id=<s:property value='id'/>&site.id=<s:property value='site.id'/>">
                  		<img src=".<s:property value='currentImage.pathName'/>"/>
                  	</a>
                  </div>
                  <div class="hot_list_para"><strong>
                  	<a href="orderPlace?placeProduct.id=<s:property value='id'/>&site.id=<s:property value='site.id'/>">
                  	<s:property value='site.siteName'/>&nbsp;(<s:property value='productName'/>)</a>
                  </strong><p>价格：&yen;<s:property value='normalPrice'/></p></div>
                </div>
               	</s:if>                
            </s:iterator>  		
       </div>
 
          <!-- end hot sport-->      
    </div>
<!--******************** end body  right -->   
</div>
</div>
 <div class="clearfix"> </div>
<div class="mainbody">
<iframe src="footer.jsp" width="100%" height="200px" frameborder="0" scrolling="no">
</iframe></div>


<script type="text/javascript">

		var dlNum  =$("#selectList").find("dl");
		for (i = 0; i < dlNum.length; i++) {
			$(".hasBeenSelected .clearList").append("<div class=\"selectedInfor selectedShow\" style=\"display:none\"><span></span><label></label><em></em></div>");
		}

		var refresh = "true";

		$(".listIndex a ").live("click",function(){
			var text =$(this).text();
			var selectedShow = $(".selectedShow");
			var textTypeIndex =$(this).parents("dl").index();
			var textType =$(this).parent("dd").siblings("dt").text();
			index = textTypeIndex -(2);
			$(".clearDd").show();
			$(".selectedShow").eq(index).show();
			$(this).addClass("selected").siblings().removeClass("selected");
			selectedShow.eq(index).find("span").text(textType);
			selectedShow.eq(index).find("label").text(text);
			var show = $(".selectedShow").length - $(".selectedShow:hidden").length;
			if (show > 1) {
				$(".eliminateCriteria").show();
			}
		   
		});
		$(".selectedShow em").live("click",function(){
			$(this).parents(".selectedShow").hide();
			var textTypeIndex =$(this).parents(".selectedShow").index();
			index = textTypeIndex;
			$(".listIndex").eq(index).find("a").removeClass("selected");
			
			if($(".listIndex .selected").length < 2){
				$(".eliminateCriteria").hide();
			}
		});

		$(".eliminateCriteria").live("click",function(){
			$(".selectedShow").hide();
			$(this).hide();
			$(".listIndex a ").removeClass("selected");
		}); 

	</script>
<script>
$(function(){
        var $banner=$('.banner');
        var $banner_ul=$('.banner-img');
        var $btn=$('.banner-btn');
        var $btn_a=$btn.find('a')
        var v_width=$banner.width();
        
        var page=1;
        
        var timer=null;
        var btnClass=null;

        var page_count=$banner_ul.find('li').length;//把这个值赋给小圆点的个数
        
        var banner_cir="<li class='selected' href='#'><a></a></li>";
        for(var i=1;i<page_count;i++){
                //动态添加小圆点
                banner_cir+="<li><a href='#'></a></li>";
                }
        $('.banner-circle').append(banner_cir);
        
        var cirLeft=$('.banner-circle').width()*(-0.5);
        $('.banner-circle').css({'marginLeft':cirLeft});
        
        $banner_ul.width(page_count*v_width);
        
        function move(obj,classname){
                //手动及自动播放
        if(!$banner_ul.is(':animated')){
                if(classname=='prevBtn'){
                        if(page==1){
                                        $banner_ul.animate({left:-v_width*(page_count-1)});
                                        page=page_count; 
                                        cirMove();
                        }
                        else{
                                        $banner_ul.animate({left:'+='+v_width},"slow");
                                        page--;
                                        cirMove();
                        }        
                }
                else{
                        if(page==page_count){
                                        $banner_ul.animate({left:0});
                                        page=1;
                                        cirMove();
                                }
                        else{
                                        $banner_ul.animate({left:'-='+v_width},"slow");
                                        page++;
                                        cirMove();
                                }
                        }
                }
        }
        
        function cirMove(){
                //检测page的值，使当前的page与selected的小圆点一致
                $('.banner-circle li').eq(page-1).addClass('selected')
                                                                                                .siblings().removeClass('selected');
        }
        
        $banner.mouseover(function(){
                $btn.css({'display':'block'});
                clearInterval(timer);
                                }).mouseout(function(){
                $btn.css({'display':'none'});                
                clearInterval(timer);
                timer=setInterval(move,3000);
                                }).trigger("mouseout");//激活自动播放

        $btn_a.mouseover(function(){
                //实现透明渐变，阻止冒泡
                        $(this).animate({opacity:0.6},'fast');
                        $btn.css({'display':'block'});
                         return false;
                }).mouseleave(function(){
                        $(this).animate({opacity:0.3},'fast');
                        $btn.css({'display':'none'});
                         return false;
                }).click(function(){
                        //手动点击清除计时器
                        btnClass=this.className;
                        clearInterval(timer);
                        timer=setInterval(move,3000);
                        move($(this),this.className);
                });
                
        $('.banner-circle li').live('click',function(){
                        var index=$('.banner-circle li').index(this);
                        $banner_ul.animate({left:-v_width*index},'slow');
                        page=index+1;
                        cirMove();
                });
});
</script>
<!--轮播 end-->
<!-- mainbanner select start -->
	<script type="text/javascript">
		$(".mainbannerNav ul li").hover(function(){
		$(this).addClass("mainbannerSelected").siblings().removeClass("mainbannerSelected");
		});
	</script>
    
<!-- mainbanner select end -->

</body>
</html>
