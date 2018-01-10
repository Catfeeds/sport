// JavaScript Document
$(function() {
	//wordStrong();
	$("#content ul").width($("#content ul li:first").width()*$("#content ul li").length);
	$("#header .top_right .vote").hover(function() {
		$(this).children(".hover-tip").css("display", "block");
		$(this).children(".num").css("display", "none");	
	}, function() {
		$(this).children(".hover-tip").css("display", "none");
		$(this).children(".num").css("display", "block");	
	});
	
	
	$("#content .left, #content .right").width(($(document).width()-$("#content").width())/4);
	$("#content .left").css("left", -$("#content .left").width());
	$("#content .right").css("right", -$("#content .right").width());
	
	var showId = 0;
	$("#content span.left").hover(function() {
		if ( checkFirst() ) return ;
		$(this).css("cursor", "pointer");
		$(this).siblings(".sl").stop().animate({
			opacity:0.5	
		});	
	}, function() {
		$(this).siblings(".sl").stop().animate({
			opacity:0
		});	
	}).click(function() {
		if ( checkFirst() ) return ;
		showId --;
		$("#content").attr("showId", showId);
		$("#footer li").children().removeClass("active").end().children().eq(showId).addClass("active");
		center(showId);
	});
	
	$("#content span.right").hover(function() {
		if ( checkLast() )	return ;
		$(this).css("cursor", "pointer");
		$(this).siblings(".sr").stop().animate({
			opacity:0.5
		});	
	}, function() {
		$(this).siblings(".sr").stop().animate({
			opacity:0
		});	
	}).click(function() {
		if ( checkLast() )	return ;	
		showId ++;		
		$("#content").attr("showId", showId);
		$("#footer li").children().removeClass("active").end().children().eq(showId).addClass("active");
		center(showId);	
	});
	
	function checkFirst() {
		if ( $("#content").attr("showId") == 0 ) {
			$("#content span.left").css("cursor", "default");
			return true;		
		}
		return false;
	}
	
	function checkLast() {
		if ( $("#content").attr("showId") == $("#content ul li").length-1 ) {
			$("#content span.right").css("cursor", "default");
			return true;		
		}
		return false;	
	}
		
	/* 首字母大写 */
	function wordStrong() {
		var liList = $("#content ul li");
		for (var j = 0; j < liList.length; j ++) {
			var pList = $("#content .cont_"+(j+1)+" .cont_word p");
			for (var i = 0; i < pList.length; i ++) {
				var p = pList.get(i);
				var pCont = $(p).html();		
				var s = $("<b>"+(i+1)+"</b>");
				s.css("font-size", "24px");		
				$(p).html('');
				s.appendTo(p);
				$(p).append(pCont.substring(1));		
			}
		}
	}	
	
	center(0);
	
	//相对li居中
	function center(liIndex) {
		var li = $("#content ul li").css("opacity", 0.3).eq(liIndex).css("opacity", 1);
		$("#content ul").animate({
			left: (-li.width()*liIndex)
		});
	}
	
	var footLen = $("#content ul li").length;
	var foots = $("#footer ul");
	for (var i = 1; i < footLen-1; i ++) {
		var childA = $("<a>").html(i);
		childA.attr("href", "#");
		$("<li>").append(childA).insertBefore(foots.children("[step=last]")).attr("step", i);		
	}
	foots.children(":last").attr("step", footLen-1);
	foots.css("left", ($(window).width()-foots.width())/2);	
	$("#footer li").click(function() {
		$("#footer ul li").children().removeClass("active");
		$(this).children().addClass("active");
		center($(this).attr("step"));
	});
	
	function myAddEvent(obj, e, fn) {
		if ( obj.attachEvent ) {
			obj.attachEvent('on'+e, fn);
		}else obj.addEventListener(e, fn, false);
	}
	
	function onMouseWheel(ev) { 
		var ev = ev||event;		
		//IE
		//wheelDelta	下滚：负， 上滚：下
		//alert(oEvent.wheelDelta);
		//FF
		//detail:	下滚:正, 上滚: 负
		//alert(oEvent.detail)		
		var bDown = true;
		if ( ev.wheelDelta ) {
			bDown = ev.wheelDelta<0;
		}else {
			bDown = ev.detail>0;
		}		
		if ( !bDown ) {
			if ( checkFirst() ) return ;
			showId --;			
		}
		else {
			if ( checkLast() )	return ;
			showId ++;			
		}
		$("#content").attr("showId", showId);
		$("#footer ul li").children().removeClass("active").end().eq(showId).children().addClass("active");
		center(showId);
		if ( oEvent.preventDefault )  {
			oEvent.preventDefault();
		}
		return false;
	}
	
	myAddEvent(window, 'mousewheel', onMouseWheel);
	myAddEvent(window, 'DOMMouseScroll', onMouseWheel);
});