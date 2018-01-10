
 
        function selectTag(showContent,selfObj){
            // 操作标签
            var tag = document.getElementById("tags").getElementsByTagName("li");
            var taglength = tag.length;
            for(i=0; i<taglength; i++){
                tag[i].className = "";
            }
            selfObj.parentNode.className = "selectTag";
            // 操作内容
            for(i=0; j=document.getElementById("tagContent"+i); i++){
                j.style.display = "none";
            }
            document.getElementById(showContent).style.display = "block";
            
            
        }
         
 
	function getid(obj)//取对应id的元素
		  {
			return document.getElementById(obj);
		  }

	function getNames(obj,name,tij)//取obj元素下标签为tij的元素并要求满足name属性=name;返回一个数组
	{	
		var p = getid(obj);
		var plist = p.getElementsByTagName(tij);
		var rlist = new Array();
		for(i=0;i<plist.length;i++)
		{
			if(plist[i].getAttribute("name") == name)
			{
				rlist[rlist.length] = plist[i];
			}
		}
		return rlist;
	}

	function ri(obj)//取得对应的小图列表中当前元素对应的序号
	{
		var p = getid("simg").getElementsByTagName("td");
		for(i=0;i<p.length;i++)
		{
			if(obj == p[i])
			{
				return i;
			}
		}
	}

	function ci(obj)//小图选择框的处理函数
	{
		var p = getid("simg").getElementsByTagName("td");
		for(i=0;i<p.length;i++)
		{
			if(obj ==p[i])
			{
				p[i].className ="s";
			}
			else
			{
				p[i].className ="";
			}
		}
	}
	function fiterplay(obj,num,t,name)//类似页卡的函数.设置对应内容的隐藏和显示 obj:元素的id  name:元素对应的name属性的值, t:对应内容的标签 num:当前选择的元素的序号
	{
		var fitlist = getNames(obj,name,t);
		for(i=0;i<fitlist.length;i++)
		{

			if(i == num)
			{
				fitlist[i].className = "dis";
			}
			else
			{
				fitlist[i].className = "undis";
			}
		}
	}
		  
		  	
	function play(obj,n1)//播放的函数
	{
		var p = obj.parentNode.parentNode.getElementsByTagName("img");
		var au = getid(n1);
		var num = ri(obj);
		try	//ie下的处理部分
		{
			with(au)
			{
				filters[0].Apply();	//接收滤镜
				ci(obj); //变幻小图的选择.可以放在try以外.
				fiterplay(n1,num,"div","f");//设置滤镜中对应部分的显示和隐藏
				filters[0].play();	//播放滤镜
			}
		}
		catch(e)//ff下的处理部分
		{
				ci(obj);
				fiterplay(n1,num,"div","f");
		}
	}
	
	
var n=0;
function clearAuto() {clearInterval(autoStart);};
function setAuto(){autoStart=setInterval("auto(n)", 4000)}
function auto()
{
	var x = getid("simg").getElementsByTagName("td");
	n++;
	if(n>3)n=0;
	play(x[n],"au");
}
function tabs_z(o,n){
			var m_n = document.getElementById(o).getElementsByTagName("em");
			var c_n = document.getElementById(o).getElementsByTagName("ol");
			for(i=0;i<m_n.length;i++){
				 m_n[i].className=i==n?"tab_on":"";
 				 c_n[i].style.display=i==n?"block":"none";
				 }
		}
 
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
 

		$(".mainbannerNav ul li").hover(function(){
		$(this).addClass("mainbannerSelected").siblings().removeClass("mainbannerSelected");
		});
	 
    
			$(document).ready(function(){
			
			/*************选运动子项**************************/
	$("input[type='radio']").click(function(){
		
		var producttype=$(this).val()
		var producttype="运动项目： "+producttype
		
		$(".prodcut-type-p").empty()
		$(".prodcut-type-p").append(producttype);
		
	})
			
			
				$(".coach-week-optional li").click(function(){//每日切换
					if($(this).is(".coach-week-selected")){
					return;
				}
			
					var idclass=$(this).attr("class");
					var classid="#"+idclass;//当日所对应标签
					
					$(".coach-week-optional li").each(function(){
						$(this).removeClass("coach-week-selected");
					});
					$(this).addClass("coach-week-selected");//点击日期变色
					
					
					$(".coach-time-optional").each(function(){//隐藏所有
						$(this).addClass("displaycss");
					});
					$(classid).removeClass("displaycss");//显示当日所对应标签
				});
				/************************************************************/
	//删除订单项
	function deleteSelfItem(thisObj){
		var coachId=$(thisObj).parent().parent().attr("coachId");//教练Id
		var pOrderId=$(thisObj).parent().parent().attr("pOrderId");//预定信息id
		var timeId=$(thisObj).attr("timeId");//时间段id
		var orderItemWrapId=String(coachId)+pOrderId+timeId;
		//alert(coachId+"  "+pOrderId+"   "+timeId);
		$.post("orderanddeleteItem",
    			{"item.id":$("#"+orderItemWrapId).attr("orderItemId")},
    			function(data){
    				var arr=new Array();
    				$.each(data, function(i, item) {
						arr.push(item);					           
					});
    				if(arr[0]){
    					//删除该订单项界面
    					$("#"+orderItemWrapId).remove();
    					$(thisObj).removeClass("coach-time-selected");
    					countTotalPrice();
    				}else{
    					alert(arr[1]);
    				}
    	},"json");
	}
	
	function countTotalPrice(){
		var allvalue=0;
		$(".coach-list").each(function(){
			var valuestr=$(this).children("b").text();
			allvalue += Number(valuestr);
			//allvalue=allvalue.toFixed(2);
		});
		var allvalues=allvalue.toFixed(2);
		$(".contpric").html(allvalues);//总价	
	}
				//删除当前预定的信息
				$("#deletecurrentOrder").click(function(){
					$.post("orderanddeleteCurrentOrder",
			    			{},
			    			function(data){
			    				var arr=new Array();
			    				$.each(data, function(i, item) {
									arr.push(item);					           
								});
			    				if(arr[0]){	  
			    					window.top.location=window.top.location;
			    				}else{
			    					alert(arr[1]);
			    				}
			    	},"json");
				});
				//预定或者取消预定教练
				$(".coach-time-optional li").click(function(){
					if($(this).attr("class")=="coach-time-unable")
					{
						return;					
					}
					var orderlength=$(".coach-list").length;
					if(orderlength==8&&(!$(this).hasClass("coach-time-selected"))){
						alert("只能选8个");
						return;
					}
					var thisObj=this;
					var coachId=$(this).parent().parent().attr("coachId");//教练Id
					var pOrderId=$(this).parent().parent().attr("pOrderId");//预定信息id
					var timeId=$(this).attr("timeId");//时间段id
					var productId=$(this).parent().parent().attr("productId");
					
					var orderItemWrapId=String(coachId)+pOrderId+timeId;
					
					if($(this).hasClass("coach-time-selected")){
						
						deleteSelfItem(this);						
					}else{
						/*if(Number(timeId)==3){//如果是全天，先将本天已经预定的信息删除
							$(this).parent().children().each(function(){
								if($(this).hasClass("coach-time-selected")){
									deleteSelfItem(this);
								}
							});							
						}else{
							$(this).parent().children().each(function(){
								if($(this).hasClass("coach-time-selected")&&($(this).hasClass("allday"))){
									deleteSelfItem(this);
								}
							});
						}*/
						
						$.post("orderandaddItem",
				    			{"item.coachPreOrder.id":pOrderId,
								 "coachProduct.id":productId,
				    			 "item.time":timeId
				    			},
				    			function(data){
				    				var arr=new Array();
				    				$.each(data, function(i, item) {
										arr.push(item);					           
									});
				    				if(arr[0]){	  
				    					addItem(thisObj,orderItemWrapId,arr[1]);
				    					$(thisObj).addClass("coach-time-selected");
				    					countTotalPrice();
				    					
				    				}else{
				    					//popLoginDialog();
				    					alert(arr[1]);
				    				}
				    	},"json");
						
					}			
					
					function addItem(thisObj,orderItemWrapId,orderItemId){
						var weekid=$(thisObj).parent().parent().attr("id");
						weekclass="."+weekid;
						var weekstr=$(weekclass).text();
						var timestr=$(thisObj).children("span").text();
						var valuestr=$(thisObj).children("b").text();
						var orderId=$(thisObj).attr("orderId");
						var dom="<span class='coach-list' id='"+orderItemWrapId+
								"' orderItemId='"+orderItemId+"' >"+weekstr+timestr+"<b>"+valuestr+"</b></span>"
						$(".coach-time").append(dom);
					}					
				
				});
				/*******************************************************/
				/**************************/
				/*****************弹出对话框开始*******************/
				/*var $form_modal = $('.cd-user-modal'),
				$form_login = $form_modal.find('#cd-login'),
				$form_signup = $form_modal.find('#cd-signup'),
				$form_modal_tab = $('.cd-switcher'),
				$tab_login = $form_modal_tab.children('li').eq(0).children('a'),
				$tab_signup = $form_modal_tab.children('li').eq(1).children('a');
				
				//弹出窗口
				function popLoginDialog(){
					$form_modal.addClass('is-visible');	
					login_selected();
				}
				//关闭弹出窗口
				$('.cd-user-modal').on('click', function(event){
					if( $(event.target).is($form_modal) || $(event.target).is('.cd-close-form') ) {
						$form_modal.removeClass('is-visible');
					}	
				});
				//使用Esc键关闭弹出窗口
				$(document).keyup(function(event){
			    	if(event.which=='27'){
			    		$form_modal.removeClass('is-visible');
				    }
			    });
				//切换表单变色
				$(".cd-switcher li a").click(function(){					
					$(".cd-switcher li a").css("color","black").css("background",$(this).css("background"));					
					$(this).css("color","red").css("background","rgb(222,222,222)");
				});
				//切换表单
				$form_modal_tab.on('click', function(event) {					
					
					event.preventDefault();
					( $(event.target).is( $tab_login ) ) ? login_selected() : signup_selected();
				});
				
				function login_selected(){
					$form_login.addClass('is-selected');
					$form_signup.removeClass('is-selected');
					$form_forgot_password.removeClass('is-selected');
					$tab_login.addClass('selected');
					$tab_signup.removeClass('selected');
				}
				
				function signup_selected(){
					$form_login.removeClass('is-selected');
					$form_signup.addClass('is-selected');
					$form_forgot_password.removeClass('is-selected');
					$tab_login.removeClass('selected');
					$tab_signup.addClass('selected');
				}*/
				/*****************弹出对话框结束*******************/
				/* var codeOkFlag=false;
				    var confirmCode="";
				    $("input[name=confirmCode]").keyup(function(){
				    	var userInputCode=$("input[name=confirmCode]").attr("value");
				    	if(userInputCode.length!=4)
				    		return;
				    	if(userInputCode==confirmCode)
				    	{	
				    		codeOkFlag=true;//验证成功！
				    		alert("手机号验证成功");
				    	}else{
				    		codeOkFlag=false;//验证失败！
				    		alert("手机号验证失败！请重试！");
				    	}
				    });
				    $("#sendMessageBtn").click(function(){
				    	sends.send();
				    });
				    var sendingFlag=false;
				    var sends = {
				    	checked:1,
				    	send:function(){
				    			if(sendingFlag)
				    				return;
				    			
				    			var numbers = /^1[3|4|5|7|8][0-9]\d{4,8}$/;
				    			var val = $(".phonenumber").val().replace(/\s+/g,""); //获取输入手机号码
				    			if(!numbers.test(val) || val.length ==0){
				    				alert("手机号码长度不对！");
				    				return false;
				    			}
				    			
				    			if(val!=""&&(val.length==11)){
				    				$.post("commonandsendMessage", { "code.phone":val},
				    				   function(data){
				    				   		 var arr=new Array();
				    						$.each(data, function(i, item) {
				    							arr.push(item);					           
				    						});						
				    						if(arr[0]){//true时表示操作成功，更改界面元素状态	
				    							confirmCode=arr[2];		
				    						}else{
				    							alert(arr[1]);
				    						}					   
				    				   },"json");
				    			}else{
				    				data="电话号码为11个数字!";
				    				alert(data);
				    			}				
				    			if(numbers.test(val)){
				    				var time = 60;
				    				$('.div-phone a').addClass('darkblue').removeClass('blue').DISABLED;
				    				function timeCountDown(){
				    					if(time==0){
				    						sendingFlag=false;
				    						clearInterval(timer);
				    						$('.div-phone a').addClass('blue').removeClass('darkblue').html("获取短信验证码");
				    						sends.checked = 1;
				    						return true;
				    					}
				    					$('.div-phone a').html(time+"S后再次发送");
				    					time--;
				    					return false;
				    					sends.checked = 0;
				    				}
				    				$('.div-phone a').addClass('send0').removeClass('send1');
				    				timeCountDown();
				    				sendingFlag=true;
				    				var timer = setInterval(timeCountDown,1000);
				    			}
				    	}
				    }
				    $("#loginBtn").click(function (){
				    	var userName=$("input[name=userName]").val();
				    	var password=$("input[name=password]").val();
				    	$.post("userandasynLogin", { "user.userName":userName,
				    								 "user.password":password
				    								},
				    			   function(data){
				    			   		 var arr=new Array();
				    					$.each(data, function(i, item) {
				    						arr.push(item);					           
				    					});						
				    					if(arr[0]){//true时表示操作成功，更改页面元素	
				    						//这里刷新整个页面
				    					   	window.top.location=window.top.location;	
				    					}else{
				    						alert(arr[1]);
				    					}					   
				    			   },"json");
				    });
				    //异步注册
				    function asynLogin(){
				    	
				    	//form[0].submit();
				    	
				    } 
				    $("#registerBtn").click(function(){
				    	if(!codeOkFlag){
				    		alert("您输入的验证码有误，请重新发送验证码再试！");
				    		return false;
				    	}
				    	var userName=$("input[name=userName1]").val();
				    	var password=$("input[name=password1]").val();
				    	$.post("userandasynRegister", { "user.phone":userName,
				    								 "user.password":password
				    								},
				    			   function(data){
				    			   		 var arr=new Array();
				    					$.each(data, function(i, item) {
				    						arr.push(item);					           
				    					});						
				    					if(arr[0]){//true时表示操作成功，更改页面元素	
				    						//这里刷新整个页面
				    					   	window.top.location=window.top.location;	
				    					}else{
				    						alert(arr[1]);
				    					}					   
				    			   },"json");
				    });*/
			    /***************************/
				
			});
				function resetall(){
					$(".coach-time-selected").removeClass("coach-time-selected")
					$(".coach-list").remove();
					$(".contpric").empty();
					$(".contpric").html("0");
				}
		 
	 
		$(document).ready(function(e) {
			countTotalPrice();
			function countTotalPrice(){
				var allvalue=0;
				$(".coach-list").each(function(){
					var valuestr=$(this).children("b").text();
					allvalue += Number(valuestr);
					//allvalue=allvalue.toFixed(2);
				});
				var allvalues=allvalue.toFixed(2);
				$(".contpric").html(allvalues);//总价	
			}
    $(".tipsli").click(function(){
		var thisdom=$(this).attr('id');
		var uldom=$(".titul > li");
		uldom.each(function(index, element) {
			$(this).remove("detailli");
        });
		for(i=0;i<uldom.length;i++){
			if(thisdom==uldom.eq(i).attr('id')){
				j=i+1;
				uldom.eq(j).toggleClass("detailli");
				return;}
			i++;}
	});
   
});
