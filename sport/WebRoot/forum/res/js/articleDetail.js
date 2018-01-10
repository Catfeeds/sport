$(function(){
		$(".deleteBtn").click(function(){
			if(!confirm("删除是不可恢复的，确定要删除？"))
				return;
			//删除帖子
			var articleId=$(this).attr("articleId");
			$.post("articleanddeleteArticle", {"article.id":articleId},function(data){
			   		var arr=new Array();
					$.each(data, function(i, item) {
						arr.push(item);					           
					});					
					if(arr[0]){//true时表示操作成功，更改界面元素状态							
						alert("删帖成功！");
						document.location=document.location;
					}else{
						alert(arr[1]);	
					}	
		 	},'json'); 
		});
		//展开回复贴，从数据库中获取信息
		$(".expandReplyBtn").click(
				function(){
					var parentArticleId=$(this).attr("ref");
					if($(this).html()=="收起回复"){						
						$("#replyItemsWrap"+parentArticleId).hide();
						$(this).html($(this).attr("content"));
					}else{						
						$("#replyItemsWrap"+parentArticleId).show();
						$(this).html("收起回复");						
						$.post("articleandgetChildArticleList",
								{"article.parentArticle.id":parentArticleId,"childPage.pageNumber":1,"childPage.pageSize":5}
								,function(data){										
							   		var arr=new Array();
									$.each(data, function(i, item) {
										if(item.page==undefined){
											arr.push(item);
										}else{
											arr.push(true);
											arr.push(item.page);
											arr.push(item.infos);
										}
									});										
									if(arr[0]){//true时表示操作成功，更改界面元素状态	
										var itemHtml='';
										$.each(arr[2], function(i, item) {
											itemHtml+=assembleHTML(item,parentArticleId);					           
										});
										//alert(itemHtml);
										$("#replyItems"+parentArticleId).html(itemHtml);
										//插入分页
										var pageHtml=assemblePageHTML(arr[1],parentArticleId);
										$(".pageItem").remove();
										$("#replayOwnerBtn"+parentArticleId).before(pageHtml);
										$("#expandReplyBtn"+parentArticleId+" b").html(arr[1].totalItemNumber);
										$("#expandReplyBtn"+parentArticleId).attr("content","回复("+arr[1].totalItemNumber+")");
										$("#totalPageNumberWrap"+parentArticleId).html("共"+arr[1].totalPageNumber+"页");
										bindEvent();
									}else{
										alert(arr[1]);	
									}	
							},'json'); 
					}				
				}
			);
			
			$(".replayOwnerBtn").click(function (){
				if($(this).html()=="我也说一句"){
						$("#replyUserEditorWrap"+$(this).attr("ref")).show();
						$(this).html("收起回复框");
					}else{
						$("#replyUserEditorWrap"+$(this).attr("ref")).hide();
						$(this).html("我也说一句");
					}
			});
			bindEvent();//初始化绑定事件
			function bindEvent(){
				//回复某人
				$(".replayBtn").click(function(){
					$("#replyUserEditorWrap"+$(this).attr("rootId")).show();
					$("#replyUserEditor"+$(this).attr("rootId")).attr("replyerId",$(this).attr("talkerId"));
					$("#replyUserEditor"+$(this).attr("rootId")).val("回复:"+$("#user"+$(this).attr("ref")).html());
				});
				$(".enablePageItem").click(function(){
					var parentArticleId=$(this).attr("parentArticleId");
					var pageNumber=$(this).attr("pageNumber");
					$.post("articleandgetChildArticleList",
							{"article.parentArticle.id":parentArticleId,"childPage.pageNumber":pageNumber,"childPage.pageSize":5}
							,function(data){										
						   		var arr=new Array();
								$.each(data, function(i, item) {
									if(item.page==undefined){
										arr.push(item);
									}else{
										arr.push(true);
										arr.push(item.page);
										arr.push(item.infos);
									}
								});										
								if(arr[0]){//true时表示操作成功，更改界面元素状态	
									var itemHtml='';
									$.each(arr[2], function(i, item) {
										itemHtml+=assembleHTML(item,parentArticleId);					           
									});
									//alert(itemHtml);
									$("#replyItems"+parentArticleId).html(itemHtml);
									//插入分页
									var pageHtml=assemblePageHTML(arr[1],parentArticleId);
									$(".pageItem").remove();
									$("#replayOwnerBtn"+parentArticleId).before(pageHtml);
									$("#expandReplyBtn"+parentArticleId+" b").html(arr[1].totalItemNumber);
									$("#expandReplyBtn"+parentArticleId).attr("content","回复("+arr[1].totalItemNumber+")");
									$("#totalPageNumberWrap"+parentArticleId).html("共"+arr[1].totalPageNumber+"页");
									bindEvent();
								}else{
									alert(arr[1]);	
								}	
						},'json'); 
				});
			}
			$(".replyBtn").click(function(){
				var parentArticleId=$(this).attr("parentArticleId");
				var content=$("#replyUserEditor"+parentArticleId).val();
				var replyerId=$("#replyUserEditor"+parentArticleId).attr("replyerId");
				$.post("articleandaddSubArticle",
					{"article.parentArticle.id":parentArticleId,"article.content":content,"article.responser.id":replyerId}
					,function(data){
				   		var arr=new Array();
						$.each(data, function(i, item) {
							if(item.id==undefined){
								arr.push(item);
							}else{
								arr.push(true);
								arr.push(item);
							}
						});	
						var itemHtml='';
						//$.each(arr[1], function(i, item) {
							itemHtml+=assembleHTML(arr[1],parentArticleId);					           
						//});
						//alert(itemHtml);
						if(arr[0]){//true时表示操作成功，更改界面元素状态							
							$("#replyItems"+parentArticleId).append(itemHtml);
							bindEvent();
						}else{
							alert(arr[1]);	
						}	
				},'json'); 
			});
			//拼装一个分页html
			function assemblePageHTML(page,parentArticleId){
				var html='';
				if(page.pageNumber<=1){
					html+='<a href="javascript:void(0);" class="disablepage pageItem">首页</a>';
					html+='<a href="javascript:void(0);" class="disablepage pageItem">上一页</a>';
				}else{
					html+='<a class="pageItem enablePageItem" href="javascript:void(0);" pageNumber="1" '+' parentArticleId="'+parentArticleId+'">首页</a>';
					html+='<a class="pageItem enablePageItem" href="javascript:void(0);" pageNumber="'+(page.pageNumber-1)+'" parentArticleId="'+parentArticleId+'">上一页</a>';
				}
				html+='<a href="javascript:void(0);"  class="currentpage pageItem">'+page.pageNumber+'</a>';
				if(page.pageNumber>=page.totalPageNumber){
					html+='<a href="javascript:void(0);" class="disablepage pageItem">下一页</a>';
					html+='<a href="javascript:void(0);" class="disablepage pageItem">尾页</a>';
				}else{
					html+='<a class="pageItem enablePageItem" href="javascript:void(0);" pageNumber="'+(page.pageNumber+1)+'" parentArticleId="'+parentArticleId+'">下一页</a>';
					html+='<a class="pageItem enablePageItem" href="javascript:void(0);" pageNumber="'+page.totalPageNumber+'" parentArticleId="'+parentArticleId+'">尾页</a>';
				}
				return html;
			}
			//拼装一个子项html
			function assembleHTML(item,rootId){
				var replayItemHtml='';
				replayItemHtml='<div class="replyItem">';
				replayItemHtml+='<div class="replyItemInnerWrap">';
				replayItemHtml+='<div class="replyUserImg">';
				replayItemHtml+='<img src="..'+item.headImgPathName+'"/>';
				replayItemHtml+='</div>';
				replayItemHtml+='<div class="replayContentWrap">';
				replayItemHtml+='<div class="userName" id="user'+item.id+'">'+item.talkerName+'：</div>';
				replayItemHtml+='<div class="replyContent">';
				replayItemHtml+=item.content;
				replayItemHtml+='</div>';
				replayItemHtml+='</div>'; 
				replayItemHtml+='</div>';
				replayItemHtml+='<div class="replayBtnWrap">';
				replayItemHtml+='<span >';
				replayItemHtml+=item.date+'  ';
				replayItemHtml+='</span>';
				replayItemHtml+='<span><a href="javascript:void(0);"';
				replayItemHtml+='ref="'+item.id+'"'; 
				replayItemHtml+=' talkerId="'+item.talkerId+'" ';
				replayItemHtml+='rootId="'+rootId+'"';
				replayItemHtml+='class="replayBtn button">回复</a>';
				replayItemHtml+='</span>';
				replayItemHtml+='</div>';
				replayItemHtml+='</div>';
				return replayItemHtml;
			}
	});
