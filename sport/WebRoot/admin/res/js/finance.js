$(document).ready(function(){
			//自动编号
			/*
			var noid=0;
			$(".finance-tbody-No").each(function(){
				noid++;
				$(this).empty();
				$(this).append(noid);
			});
			
			//统计记录
			$(".finance-title-allrecord").empty()
			$(".finance-title-allrecord").append(noid);
			*/
			//每行换色
			var colorflag=true;
			$("tbody tr").each(function(){
				if(colorflag){
					$(this).css("background-color","#fff");
					colorflag=false;
				}
				else{
					$(this).css("background-color","#EFEFEF");
					colorflag=true;
				}
			});
			//日历控件
			$("input.jcDate").jcDate({					       
						IcoClass : "jcDateIco",
						Event : "click",
						Speed : 100,
						Left : 0,
						Top : 28,
						format : "-",
						Timeout : 100
				});
		
			
		});