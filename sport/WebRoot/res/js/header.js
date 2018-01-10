$(function(e) {
	/*****************弹出对话框开始*******************/
	/*******将对话框移动至顶层窗口*******/
	var innerContent=$("#popDialog").html();
	$(top.window.document.body).append(innerContent);
	
	/**************/
	var $topWindow=$(top.window.document.body);
	var $form_modal = $topWindow.find('.cd-user-modal'),
	$form_login = $form_modal.find('#cd-login'),
	$form_signup = $form_modal.find('#cd-signup'),
	$form_modal_tab = $topWindow.find('.cd-switcher'),
	$tab_login = $form_modal_tab.children('li').eq(0).children('a'),
	$tab_signup = $form_modal_tab.children('li').eq(1).children('a');
	installDialogEvent();
	//弹出窗口
	function popLoginDialog(){
		$form_modal.addClass('is-visible');	
		login_selected();
	}
	//关闭弹出窗口
	$topWindow.find('.cd-user-modal').on('click', function(event){
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
	$topWindow.find(".cd-switcher li a").click(function(){					
		$topWindow.find(".cd-switcher li a").css("color","black").css("background",$(this).css("background"));					
		$(this).css("color","red").css("background","rgb(222,222,222)");
	});
	//切换表单
	$form_modal_tab.on('click', function(event) {
		//alert();
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
	}
	/*****************弹出对话框结束*******************/
	   $(".mainbannerLogin").click(function(){
		  // alert();
		   popLoginDialog();
		   //$topWindow.find(".cd-switcher li a").css("color","black").css("background","#F1F1F1 none repeat scroll 0%");					
		  // $topWindow.find("#loginTab a").css("color","red").css("background","rgb(222,222,222)");
	   });
	   
	   $(".mainbannerRegister").click(function(){
		   $form_modal.addClass('is-visible');				
		   signup_selected();
		  
		   //$topWindow.find(".cd-switcher li a").css("color","black").css("background","#F1F1F1 none repeat scroll 0%");					
		  // $topWindow.find("#registerTab a").css("color","red").css("background","rgb(222,222,222)");
	   });
    var codeOkFlag=false;
    var imgCodeOkFlag=false;
    var confirmCode="";
    var confirmImgCode="";
    function installDialogEvent(){
    	$topWindow.find("input[name=confirmCodeTop]").keyup(function(){
        	var userInputCode=$topWindow.find("input[name=confirmCodeTop]").val();
        	if(userInputCode.length!=4)
        		return;
        	if(userInputCode==confirmCode)
        	{	
        		codeOkFlag=true;//验证成功！
        		//alert("手机号验证成功");
        		$(this).css({background:"url( res/images/code-right.png) no-repeat 90% center"});
        	}else{
        		codeOkFlag=false;//验证失败！
        		//alert("手机号验证失败！请重试！");
        		$(this).css({background:"url( res/images/code-wrong.png) no-repeat 90% center"});
        	}
        });
    	gainImageConfirm();//初始化验证码
    	$topWindow.find("#confirmImgTop").click(function(){
    		imgCodeOkFlag=false;
    		confirmImgCode="";
    		gainImageConfirm();//初始化验证码
    	});
    	//获取图像验证码
    	function gainImageConfirm(){
    		$topWindow.find("input[name=confirmImgCodeTop]").val("");//清空
    		var imgObj=$topWindow.find("#confirmImgTop");    		
    		//先获取图片
    		$(imgObj).attr("src","confirmCodeandgainImage?now="+new Date());
    		//延时1秒
    		var timer=setTimeout("getCode()",100);    		
    		window.getCode=function getCode(){    			
	    		$.post("confirmCodeandgainConfirmCode",
					function(data){
						if(data!=null){
						   confirmImgCode=new String(data).toLowerCase();//$.parseJSON(data);
						   $(imgObj).attr("confirmImgCode",confirmImgCode);
						   //alert("code:"+confirmImgCode);
						}  						
					},'json');	    		
    		}
    		
    	}
    	$topWindow.find("input[name=confirmImgCodeTop]").keyup(function(){
    		var val=new String($(this).val()).toLowerCase();
        	if(val.length!=6)
        		return;        	
        	if(confirmImgCode==val)
        	{	
        		imgCodeOkFlag=true;//验证成功！
        		//alert("图形验证码验证成功");
        		$(this).css({background:"url( res/images/code-right.png) no-repeat 90% center"});
        	}else{
        		imgCodeOkFlag=false;//验证失败！
        		//alert("图形验证码验证失败！请重试！");
        		$(this).css({background:"url( res/images/code-wrong.png) no-repeat 90% center"});
        	}
        	//alert("val:"+val+"  confirmImgCode:"+confirmImgCode+" flag:"+imgCodeOkFlag);
        });
    	//发送短信验证码
    	$topWindow.find("#sendMessageBtnTop").click(function(){
    		//先判断图形验证码是否验证成功    		
    		if(!imgCodeOkFlag){
    			alert("图形验证码验证成功后才能进行短信验证！");
    			return;
    		}
    		//再进行短信验证码验证
        	sends.send();
        });
        var sendingFlag=false;
        var sends = {
        	checked:1,
        	send:function(){
        			if(sendingFlag)
        				return;        			
        			var numbers = /^1[3|4|5|7|8][0-9]\d{4,8}$/;
        			var val = $topWindow.find("input[name=userNameTop1]").val().replace(/\s+/g,""); //获取输入手机号码
        			if(!numbers.test(val) || val.length ==0){
        				alert("手机号码格式不对！");        				
        				return false;
        			}
        			sendingFlag=true;
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
        				$topWindow.find('.div-phone a').addClass('darkblue').removeClass('blue').DISABLED;
        				function timeCountDown(){
        					if(time==0){
        						sendingFlag=false;
        						clearInterval(timer);
        						$topWindow.find('.div-phone a').addClass('blue').removeClass('darkblue').html("获取短信验证码");
        						sends.checked = 1;
        						return true;
        					}
        					$topWindow.find('.div-phone a').html(time+"S后再次发送");
        					time--;
        					return false;
        					sends.checked = 0;
        				}
        				$topWindow.find('.div-phone a').addClass('send0').removeClass('send1');
        				timeCountDown();
        				var timer = setInterval(timeCountDown,1000);
        			}
        	}
        }
        $topWindow.find("#loginBtnTop").click(function (){
        	var userName=$topWindow.find("input[name=userNameTop]").val();
        	var password=$topWindow.find("input[name=passwordTop]").val();
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
        $topWindow.find("#registerBtnTop").click(function(){
        	if(!codeOkFlag){
        		alert("您输入的验证码有误，请重新发送验证码再试！");
        		return false;
        	}
        	var userName=$topWindow.find("input[name=userNameTop1]").val();
        	var password=$topWindow.find("input[name=passwordTop1]").val();
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
        });
    }
    
});
