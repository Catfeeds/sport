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
<title>左侧导航栏</title>
<script src='../res/admin/js/jquery-1.8.3.js' type="text/javascript"></script>
<script src='../res/admin/js/nav.js' charset='utf-8' type="text/javascript"></script>
<script type="text/javascript">	
// 导航栏配置文件
var outlookbar=new outlook();
var t;
var preClassName = "";
/******************系统设置管理***********************/
</script>
<s:if test="#session.currentCoach==null">
<script type="text/javascript">
t=outlookbar.addtitle('个人资料','系统设置管理',1)
outlookbar.additem('查看或修改个人资料',t,'managerandmanagerDetail')
</script>
</s:if>
<s:else>
<script type="text/javascript">
t=outlookbar.addtitle('个人资料','系统设置管理',1)
outlookbar.additem('查看或修改个人资料',t,'coachandcoachDetail')
</script>
</s:else>
<shiro:hasPermission name="manager:*">
<script type="text/javascript">
t=outlookbar.addtitle('管理员管理','系统设置管理',1)
outlookbar.additem('添加管理员',t,'managerandtoaddManager')
outlookbar.additem('所有管理员',t,'managerandmanagerList')
</script>
</shiro:hasPermission>

<s:if test="#session.currentCoach==null">
<script type="text/javascript">
t=outlookbar.addtitle('公司信息管理','系统设置管理',1)
outlookbar.additem('公司信息',t,'companyandcompanyDetail')
</script>
</s:if>

<shiro:hasPermission name="user:*">
<script type="text/javascript">
t=outlookbar.addtitle('会员管理','系统设置管理',1)
outlookbar.additem('管理会员',t,'useranduserList')
</script>
</shiro:hasPermission>

<shiro:hasPermission name="company:*">
<script type="text/javascript">
t=outlookbar.addtitle('加盟管理','系统设置管理',1)
outlookbar.additem('管理商家',t,'companyandcompanyList')
</script>
</shiro:hasPermission>

<shiro:hasPermission name="productType:*">
<script type="text/javascript">
t=outlookbar.addtitle('分类管理','通用信息管理',1)
outlookbar.additem('管理分类',t,'productTypeandproductTypes')
</script>
</shiro:hasPermission>

<shiro:hasPermission name="address:*">
<script type="text/javascript">
/*****************地区信息管理******************/
t=outlookbar.addtitle('地区信息','通用信息管理',1)
outlookbar.additem('管理地区信息',t,'addressandaddressList')
</script>
</shiro:hasPermission>
<shiro:hasPermission name="level:*">
<script type="text/javascript">
/*****************产品等级信息管理******************/
t=outlookbar.addtitle('等级信息','通用信息管理',1)
outlookbar.additem('管理产品等级信息',t,'levelandlevelList')
</script>
</shiro:hasPermission>

<shiro:hasPermission name="discount:*">
<script type="text/javascript">
/*****************产品类型信息管理******************/
t=outlookbar.addtitle('优惠活动','通用信息管理',1)
outlookbar.additem('添加优惠活动信息',t,'addDiscount.jsp')
outlookbar.additem('所有优惠活动信息',t,'discountanddiscountList')
</script>
</shiro:hasPermission>
<shiro:hasPermission name="site:*">
<script type="text/javascript">
/*****************场馆的管理******************/
t=outlookbar.addtitle('管理场馆','场馆信息管理',1)
outlookbar.additem('添加场馆信息',t,'siteandtoAddSite')
outlookbar.additem('公司场馆信息',t,'siteandsiteList')
</script>

<script type="text/javascript">
/*****************产品类型信息管理******************/
t=outlookbar.addtitle('场地产品','场馆信息管理',1)
outlookbar.additem('所有场地产品信息',t,'placeProductandplaceProductList')
</script>
</shiro:hasPermission>

<shiro:hasPermission name="coach:*">
<script type="text/javascript">
/*****************留言信息管理******************/
t=outlookbar.addtitle('私人教练','教练信息管理',1)
outlookbar.additem('添加私人教练',t,'coachandtoaddCoach')
outlookbar.additem('公司私人教练信息',t,'coachandcoachList')
</script>


<script type="text/javascript">
/*****************产品类型信息管理******************/
t=outlookbar.addtitle('教练产品','教练信息管理',1)
outlookbar.additem('添加教练产品信息',t,'coachProductandtoAddProduct')
outlookbar.additem('所有教练产品信息',t,'coachProductandcoachProductList')
</script>
</shiro:hasPermission>
<shiro:hasPermission name="order:*">
<script type="text/javascript">
/*****************平台管理员对所有的订单信息管理******************/
t=outlookbar.addtitle('订单管理','财务信息管理',1)
outlookbar.additem('管理订单',t,'orderandorderList')
</script>
</shiro:hasPermission>

<shiro:hasPermission name="refound:*">
<script type="text/javascript">
/*****************商家管理员对所有的订单信息管理******************/
t=outlookbar.addtitle('退款管理','财务信息管理',1)
outlookbar.additem('管理退款单',t,'refoundandrefoundList')
</script>
</shiro:hasPermission>
<shiro:hasPermission name="acount:view">
<script type="text/javascript">
/*****************商家管理员对所有的订单信息管理******************/
t=outlookbar.addtitle('账单管理','财务信息管理',1)
outlookbar.additem('管理账单',t,'acountandacountList?acount.clearFlag=1')
</script>
</shiro:hasPermission>
<shiro:hasPermission name="forum:*">
<script type="text/javascript">
/*****************社交圈的管理******************/
t=outlookbar.addtitle('社交圈','社交圈的管理',1)
outlookbar.additem('添加圈子',t,'forumandtoAddForum')
outlookbar.additem('所有圈子',t,'forumandforumList')
</script>
</shiro:hasPermission>

<shiro:hasPermission name="match:*">
<script type="text/javascript">
/*****************社交圈的管理******************/
t=outlookbar.addtitle('赛事管理','赛事管理',1)
outlookbar.additem('添加赛事',t,'addEvent.jsp')
outlookbar.additem('管理赛事',t,'eventandeventList')
</script>
</shiro:hasPermission>

<script type="text/javascript">

$('body').ready(
	function(sortname) {
		sortname='系统设置管理';
		outlookbar.getdefaultnav(sortname);
		outlookbar.getbytitle(sortname);
		
		//默认为欢迎界面
		//window.top.frames['manFrame'].location = "aboutUs.jsp"
		window.top.frames['manFrame'].location = "notice.jsp";
	}
);
</script>
</head>

<body >
<div id="left_content">
     <div id="user_info">欢迎您，
     	<s:if test="#session.currentCoach==null">
	     	<strong><s:property value="#session.currentManager.realName"/></strong>
	     	<br />[<a href="managerandmanagerDetail" target="manFrame">系统管理员</a>&nbsp;
	     	|&nbsp;<a href="managerandlogout" target="_top">注销</a>]
     	</s:if>
     	<s:else>
	     	<strong><s:property value="#session.currentCoach.realName"/></strong>
	     	<br />[<a href="coachandcoachDetail?coach.id=<s:property value='#session.currentCoach.id'/>" target="manFrame">平台教练</a>&nbsp;
	     	|&nbsp;<a href="coachandlogout" target="_top">注销</a>]
     	</s:else>
     </div>
	 <div id="main_nav">
	     <div id="left_main_nav"></div>
		 <div id="right_main_nav"></div>
	 </div>
</div>
</body>
</html>
