<%@ page language="java"  contentType="text/html; charset=UTF-8" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	basePath+="admin/";
%>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="../res/admin/css/common.css" type="text/css" />
<title>管理导航区域</title>
<script src='../res/admin/js/jquery-1.8.3.js' type="text/javascript"></script>

</head>
<script  type="text/javascript">
/*
    function myerror(_message,_url,_line)
    {
       alert("错误信息：" + _message
            +"\n错误的URI：" + _url
            +"\n错误的行数：" + _line
       );
 
       return true; //屏蔽系统的事件
    }
    //绑定错误事件
    window.onerror = myerror;
 
 */
  
var preClassName = "man_nav_1";
function list_sub_nav(Id,sortname){
   if(preClassName != ""){
      $('\#'+preClassName).attr('class',"bg_image");
   }
   if($('\#'+Id).attr('class') == "bg_image"){
      $('\#'+Id).attr('class',"bg_image_onclick");
      preClassName = Id;
	  showInnerText(Id);
	
	  window.top.frames['leftFrame'].outlookbar.getbytitle(sortname);
	  window.top.frames['leftFrame'].outlookbar.getdefaultnav(sortname);
   }
}

function showInnerText(Id){
    var switchId = parseInt(Id.substring(8));
	var showText = "对不起没有信息！";
	switch(switchId){
	    case 1:
		   showText =  "管理该平台的管理员基本信息、权限信息、账户信息和会员的基本信息等！";
		   break;
		case 2:
		   showText =  "对一些通用信息的管理！";
		   break;
		case 3:
		   showText =  "对平台加盟商的场馆等信息的管理！";
		   break;   
	   	case 4:
		   showText =  "对场馆的教练信息的管理！";
		   break;
		case 5:
		   showText =  "管理公司的财务信息等！";
		   break;
		case 6:
		   showText =  "管理社交圈的相关信息等！";
		   break;
		case 7:
			showText="管理赛事的相关信息！";
			break;
	}
	$('#show_text').html(showText);
}
 
</script>
<body>
<div id="nav">
    <ul>
	<li id="man_nav_1" onclick="list_sub_nav(id,'系统设置管理')"  class="bg_image_onclick">系统设置管理</li>
		<s:if test="#session.currentCoach!=null">		
			
		</s:if>	
		<s:elseif test="!#session.currentManager.company.host"	>
			
		</s:elseif>
		<s:else>
			<li id="man_nav_2"  onclick="list_sub_nav(id,'通用信息管理')"  class="bg_image">通用信息管理</li>	
		</s:else>
		<shiro:hasPermission name="site:*">
		<li id="man_nav_3"  onclick="list_sub_nav(id,'场馆信息管理')"  class="bg_image">场馆信息管理</li>	
		</shiro:hasPermission>
		<shiro:hasPermission name="coach:*">
		<li id="man_nav_4"  onclick="list_sub_nav(id,'教练信息管理')"  class="bg_image">教练信息管理</li>
		</shiro:hasPermission>
		<li id="man_nav_5"  onclick="list_sub_nav(id,'财务信息管理')"  class="bg_image">财务信息管理</li>
		<shiro:hasPermission name="forum:*">
		<li id="man_nav_6"  onclick="list_sub_nav(id,'社交圈的管理')"  class="bg_image">社交圈的管理</li>
		</shiro:hasPermission>
		<shiro:hasPermission name="forum:*">
		<li id="man_nav_7"  onclick="list_sub_nav(id,'赛事管理')"  class="bg_image">赛事信息管理</li>
		</shiro:hasPermission>
	</ul>
</div>
<div id="sub_info">&nbsp;&nbsp;<img src="../res/admin/images/hi.gif" />&nbsp;<span id="show_text">欢迎使用享动后台管理系统!</span></div>
</body>
</html>
