$(function($){
	var $form_modal = $('.cd-user-modal'),
		$form_login = $form_modal.find('#cd-login'),
		$form_signup = $form_modal.find('#cd-signup'),
		$form_modal_tab = $('.cd-switcher'),
		$tab_login = $form_modal_tab.children('li').eq(0).children('a'),
		$tab_signup = $form_modal_tab.children('li').eq(1).children('a');

	//弹出窗口
	$(".ck").bind("click",function(){
		$form_modal.addClass('is-visible');	
		login_selected();
	});

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
	}

});
var sendingFlag=false;
var sends = {
	checked:1,
	send:function(){
			if(sendingFlag)
				return;
			sendingFlag=true;
			var numbers = /^1[3|4|5|7|8][0-9]\d{4,8}$/;
			var val = $(".phonenumber").val().replace(/\s+/g,""); //获取输入手机号码
			if(!numbers.test(val) || val.length ==0){
				alert("手机号码长度不对！");
				return false;
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
				var timer = setInterval(timeCountDown,1000);
			}
	}
}