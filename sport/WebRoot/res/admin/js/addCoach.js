$(function(){
	//产品分类联动教练产品
	var productId=0;
	bindEvent();
	function bindEvent(){
		$(".tbut").click(function(){
			productId=$(this).attr("productId");
			//alert(productId);
			if($("input[type=checkbox]#productItem"+productId).is(':checked')){//如果已经选中,说明已经设置了值
				$("#costs"+productId).attr("name","coach.costs");
				var costStr=$("#costs"+productId).val();
				var costArr=costStr.split(",");
				$("input[name=floatvalue0]").val(costArr[0]);
				$("input[name=floatvalue1]").val(costArr[1]);
				$("input[name=floatvalue2]").val(costArr[2]);
				$("input[name=floatvalue3]").val(costArr[3]);
				$(".tback").fadeIn(100);
				$(".tover").slideDown(200);
			}else{
				$("#costs"+productId).attr("name","");
			}
			
		});
		$(".productItem").click(function(){			
			productId=$(this).attr("productId");	
			
			if($("input[type=checkbox]#productItem"+productId).is(':checked')){//如果已经选中,说明已经设置了值
				$("#costs"+productId).attr("name","coach.costs");
				var costStr=$("#costs"+productId).val();
				var costArr=costStr.split(",");
				$("input[name=floatvalue0]").val(costArr[0]);
				$("input[name=floatvalue1]").val(costArr[1]);
				$("input[name=floatvalue2]").val(costArr[2]);
				$("input[name=floatvalue3]").val(costArr[3]);
				$(".tback").fadeIn(100);
				$(".tover").slideDown(200);
			}else{
				$("#costs"+productId).attr("name","");
			}
		});
		$('.tclose .close').click(function(){
			$('.tback').fadeOut(100);
			$('.tover').slideUp(200);
		});
	}
	$("#TypeSelect").change(function(){
		//alert();
		$.post("coachProductandgetProductByType", {"product.type.id":$(this).val()},
		   function(data){
		   	 	var items="";
					$.each(data, function(i, item) {
						items+="<li><input  class='weekItem productItem' type='checkbox'";
						items+=" id='productItem"+item.id+"' productId='"+item.id;
						items+="' value='"+item.id+"' name='coach.coachProductIds'/>&emsp;";
						items+="<input type='hidden' name='coach.costs' value='' id='costs"+item.id+"'/>";
						items+="<label class='tbut' productId='"+item.id+
								"'>"+item.productName+"</label>";
						items+="</li>";
									           
				});								
				$("#productsList").empty();
				$("#productsList").html(items);
				bindEvent();
		   },'json');
	});
	//所选择的教练添加产品
	$("#setCostBtn").click(function(){	
			if($("input[name=floatvalue0]").val()!=undefined&&($("input[name=floatvalue0]").val()!="")){
				if($("input[name=floatvalue1]").val()!=undefined&&($("input[name=floatvalue1]").val()!="")){
					if($("input[name=floatvalue2]").val()!=undefined&&($("input[name=floatvalue2]").val()!="")){
						if($("input[name=floatvalue3]").val()!=undefined&&($("input[name=floatvalue3]").val()!="")){
							var costStr=$("input[name=floatvalue0]").val();
							costStr+=","+$("input[name=floatvalue1]").val();
							costStr+=","+$("input[name=floatvalue2]").val();
							costStr+=","+$("input[name=floatvalue3]").val();
							//alert(costStr);
							$("#costs"+productId).val(costStr);
							$('.tback').fadeOut(100);
							$('.tover').slideUp(200);
							return ;
						}
					}
				}
			}
			alert("请设置上午、下午、晚上、全天的收费价格，再提交！");
	});
	//活动地区的添加
	var regionNumber=$("#regionNumber").html();
	var maxRegionNumber=$("#totalRegionNumber").html();
		
	//删除一个区域,添加事件
	$(".removeBtn a").click(function(){
		var addrItemId=$(this).attr("addrItemId");
		$("#addrItemId"+addrItemId).remove();
		regionNumber--;
		var addrId=$(this).attr("addrId");
		
		$("#regionNumber").html(regionNumber);
		$("#spareNumber").html(maxRegionNumber-regionNumber);
	});
	//添加一个区域
	$("#addRegionBtn").click(function(){
		var addrId=$("#region").val();
		var existsFlag=false;
		$(".addressItem input[type=hidden]").each(function(){
			if($(this).val()==addrId)
				existsFlag=true;
		});
		if(existsFlag){		
			$("#addressPromptWrapId").html("您已经添加过改地区了，您还可以继续添加其他地区！");
			return;
		}
		if(regionNumber>=maxRegionNumber){
			$("#addressPromptWrapId").html("您已经添加了"+maxRegionNumber+"个地区，无法再为您添加了！");
			return;
		}
		$("#addressPromptWrapId").html("");
		var provinceName=$("#province option:selected").html();
		var cityName=$("#city option:selected").html();
		var regionName=$("#region option:selected").html();		
		var itemHtml="<div class='addressItem' id='addrItemId"+addrId+"'><span class='selectedaddress'>"+provinceName+"->"+cityName+"->"+regionName+"</span>";
		itemHtml+="<span class='removeBtn'><a class='blue button' addrItemId='"+addrId+"' addrId='"+addrId+"' href='javascript:void(0);'>移除</a></span>";
		itemHtml+="<input type='hidden' name='coach.addrIds' value='"+addrId+"'/>";
		itemHtml+="</div>";
		$(".selectedAddressWrap").append(itemHtml);
		
		//删除一个区域,添加事件
		$("#addrItemId"+addrId+" .removeBtn a").click(function(){
			var addrItemId=$(this).attr("addrItemId");
			$("#addrItemId"+addrItemId).remove();
			regionNumber--;
			var addrId=$(this).attr("addrId");
			removeElement(addrId);
			$("#regionNumber").html(regionNumber);
			$("#spareNumber").html(maxRegionNumber-regionNumber);
		});
		
		regionNumber++;
		
		$("#regionNumber").html(regionNumber);
		$("#spareNumber").html(maxRegionNumber-regionNumber);
	});
/*	//删除一个区域
	$(".removeBtn a").click(function(){
		alert();
		var addrItemId=$(this).attr("addrItemId");
		$("#addrItemId"+addrItemId).remove();
		regionNumber--;
		var addrId=$(this).attr("addrId");
		removeElement(addrId);
	});*/
//地区的选择
//添加省份选择联动
	$("#province1").change(function(){	
		 getChildAddrs(this.value,"#city1","#region1");
	});
	$("#city1").change(function(){	
		getChildAddrs($("#city1 option:selected").val(),"#region1");
	});
	$("#province").change(function(){	
		 getChildAddrs(this.value,"#city","#region");
	});
	$("#city").change(function(){	
		getChildAddrs($("#city option:selected").val(),"#region");
	});
	function getChildAddrs(addressId,selectId,childSelectId){
		$.post("addressandgetChildAddrs",
			{ "address.id":addressId },
				function(data){
				 //解析数组,获取该类别下所有子项
				 	var options="";    	
					 $.each(data, function(i, item) {
					   options+="<option value='"+item.id+"'>"+item.addressName+"</option>";					           
					 });
					 if(options=="")
					 	options+="<option value='-1'>暂无子地区</option>";
					    //alert(options);
					    $(selectId).html(options);
					    //如果还有子地区继续初始化					    
						if(childSelectId){
							//alert($(selectId+" option:first").val());
							getChildAddrs($(selectId+" option:first").val(),childSelectId);
						}						
		},"json"); 	
	}
//营业时间(星期)

$(".selectWeek .week li .weekItem").click(function(){
		var week='';
		$(".selectWeek .week li .weekItem").each(function(index){
			if($(this).attr("checked")=="checked"){
				week+="1";
			}else{
				week+="0";
			}
			if(index!=6)
				week+=",";
		});
		
		$("#weekstring").val(week);//字符串赋值
});
	//时间选择控件 表格形式
	    $('.coach-time-optional ul li span.chooseItem').click(function(){//选择变色控件	
	    	var value=$(this).parent("li").find("input:hidden").val();
			if(value=="0"){				
				$(this).parent("li").find("input[type=hidden]").val("1");
			}else{				
				$(this).parent("li").find("input[type=hidden]").val("0");
			}
			
		});
		createUploadComponent("imageanduploadImages","bigpic","img",1);
	//创建上传文件组件
	function createUploadComponent(action,type,getName,productId){
		
		// 初始化插件
		$("#coachImgUpload").zyUpload({
			width            :   "500px",                 // 宽度
			height           :   "300px",                 // 高度
			itemWidth        :   "120px",                 // 文件项的宽度
			itemHeight       :   "100px",                 // 文件项的高度
			url              :   action,  // 上传文件的路径
			multiple         :   true,                    // 是否可以多个文件上传
			dragDrop         :   true,                    // 是否可以拖动上传文件
			del              :   true,                    // 是否可以删除文件
			finishDel        :   true,  				  // 是否在上传文件完成后删除预览
			imgType			 :	 type,				  //图片类型
			imgName			 :	 getName,							//上传后接收该文件的File名
			productId		 :	 productId,							//0代表是新添加的产品,这里只要随机生成一个就行了，只要该次按顺序添加就行了。
			/* 外部获得的回调接口 */
			onSelect: function(files, allFiles){                    // 选择文件的回调方法
				console.info("当前选择了以下文件：");
				console.info(files);
				console.info("之前没上传的文件：");
				console.info(allFiles);
			},
			onDelete: function(file, surplusFiles){                     // 删除一个文件的回调方法
				console.info("当前删除了此文件：");
				console.info(file);
				console.info("当前剩余的文件：");
				console.info(surplusFiles);
			},
			onSuccess: function(file,responseInfo,type){                    // 文件上传成功的回调方法
				//alert("此文件上传成功："+unescape(encodeURIComponent(file.name))+"  服务器上名字为："+responseInfo);
				/*
				 	<input type='checkbox' name='product.smallImageNames' checked='checked' value=''>
					<input type='checkbox' name='product.midImageNames' checked='checked' value=''>
					<input type='checkbox' name='product.bigImageNames' checked='checked' value=''>
				 * */
				var content;
					if(responseInfo)
						responseInfo= $.parseJSON(responseInfo); 
					//alert("child:"+responseInfo+"type");
				switch(type){
				case "bigpic":content="<input type='checkbox' name='coach.photoIds' checked='checked' value='"+responseInfo+"'>";
					break;
				case "midpic":content="<input type='checkbox' name='coach.photoIds' checked='checked' value='"+responseInfo+"'>";
					break;
				case "smallpic":content="<input type='checkbox' name='coach.photoIds' checked='checked' value='"+responseInfo+"'>";
					break;
				}
				$("#uploadImagesWrapId").append(content);
				//console.info(file);
			},
			onFailure: function(file,responseInfo){                    // 文件上传失败的回调方法
				//console.info("此文件上传失败：");
				//console.info(file);
				alert("此文件上传失败："+file.name+"  信息:"+responseInfo);
			},
			onComplete: function(file,responseInfo,type){           // 上传完成的回调方法
				//alert("文件上传完成");
				
			}
		});
		
	}
});
	