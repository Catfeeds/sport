
$(function(){
	var productId=1;
	//添加省份选择联动
	$("#productTypeRoot").change(function(){	
		 getChildTypes(this.value,"#productTypeParent");
		 
	});
	$("#productTypeParent").change(function(){	//更改等级信息
		getlevelsByType(this.value,"#productLevel");
		//getChildTypes($("#rootType option:selected").val(),"#region");
	});
	function getlevelsByType(typeId,selectId){
		$.post("levelandgetLevelByType",
			{ "level.type.id":typeId ,"level.flag":1},
				function(data){
				 //解析数组,获取该类别下所有子项
				 	var options="";    	
					 $.each(data, function(i, item) {
						 if(item.id==null)
							 return;
					   options+="<option value='"+item.id+"'>"+item.levelName+"</option>";					           
					 });
					 if(options=="")
					 	options+="<option value='-1'>该分类暂无等级划分</option>";
					    //alert(options);
					    $(selectId).html(options);
										
		},"json"); 	
	}
	function getChildTypes(typeId,selectId,childSelectId){
		$.post("productTypeandgetChildTypes",
			{ "productType.id":typeId },
				function(data){
				 //解析数组,获取该类别下所有子项
				 	var options="";    	
					 $.each(data, function(i, item) {
						 if(item.id==null)
							 return;
					   options+="<option value='"+item.id+"'>"+item.typeName+"</option>";					           
					 });
					 if(options=="")
					 	options+="<option value='-1'>该分类暂无子分类</option>";
					    //alert(options);
					    $(selectId).html(options);
					    getlevelsByType($("#productTypeParent option:first").val(),"#productLevel");
					    //如果还有子地区继续初始化					    
						if(childSelectId){
							//alert($(selectId+" option:first").val());
							getChildTypes($(selectId+" option:first").val(),childSelectId);
						}						
		},"json"); 	
	}
	$("#uploadNormalImgs,#uploadSmallImgs,#uploadBigImgs").click(
		function(){
			if(this.id=="uploadNormalImgs"){
				//alert("上传中等大小图片！");
				createUploadComponent("imageanduploadImages","midpic","img",productId);
				$("#uploadShowInfo").html("现在您可以上传该产品的<span style='color:red;font-size:24px;font-weight:bolder;'>中等大小图片</span>了，该图片将在首页里展示！");
			}else if(this.id=="uploadBigImgs"){
				//alert("上传大图！");
				createUploadComponent("imageanduploadImages","bigpic","img",productId);
				$("#uploadShowInfo").html("现在您可以上传该产品的<span style='color:red;font-size:24px;font-weight:bolder;'>大图</span>了，该图片将在产品详情中，用户进行选择查看！");
			}else{
				//alert("上传小图！");
				createUploadComponent("imageanduploadImages","smallpic","img",productId);
				$("#uploadShowInfo").html("现在您可以上传该产品的<span style='color:red;font-size:24px;font-weight:bolder;'>小图</span>了，，该图片将在产品详情中，用户进行选择查看！");
			}
		}
	);
	//创建上传文件组件
	function createUploadComponent(action,type,getName,productId){
		//先删除插件
		$("#productImgUpload").empty();
		// 初始化插件
		$("#productImgUpload").zyUpload({
			width            :   "650px",                 // 宽度
			height           :   "200px",                 // 高度
			itemWidth        :   "120px",                 // 文件项的宽度
			itemHeight       :   "100px",                 // 文件项的高度
			url              :   action,  // 上传文件的路径
			multiple         :   true,                    // 是否可以多个文件上传
			dragDrop         :   true,                    // 是否可以拖动上传文件
			del              :   true,                    // 是否可以删除文件
			finishDel        :   false,  				  // 是否在上传文件完成后删除预览
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
				case "bigpic":content="<input type='checkbox' name='product.bigImageIds' checked='checked' value='"+responseInfo+"'>";
					break;
				case "midpic":content="<input type='checkbox' name='product.midImageIds' checked='checked' value='"+responseInfo+"'>";
					break;
				case "smallpic":content="<input type='checkbox' name='product.smallImageIds' checked='checked' value='"+responseInfo+"'>";
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
		$("#productImgUpload").fadeOut(1000);
		$("#productImgUpload").fadeIn(2000);
	}
});    
	
