package com.sport.smessage;

import java.util.HashMap;
import java.util.Set;

import org.springframework.stereotype.Component;

import com.cloopen.rest.sdk.CCPRestSmsSDK;
@Component
public class MessageUtil {
	/*****定义模板标识开始******/
	public final static String TEMPLATE_REGISTER="1";
	public final static String TEMPLATE_PLACE_PREORDER="2";
	public final static String TEMPLATE_COACH_PREORDER="3";
	/*****定义模板标识结束******/
	
	/********** 应用属性 ***********/
	/*private final static String SERVER_IP = "sandboxapp.cloopen.com";
	private final static String SERVER_PORT = "8883";
	private final static String ACCOUNT_SID = "8a48b5514fd49643014fe033e5682240";
	private final static String AUTH_TOKEN = "96125be553c34b4b877b9bcb74f6cdab";
	private final static String APP_ID = "8a48b5514fd49643014fe0352f262243";
	private final static String APP_TOKEN = "75e95238282f979b5939389f6fd134bd";
	private final static String TIME_LIMIT = "1";
	//private final static String MESSAGE_TEMPLATE="43735";
	//测试
	private final static String ACCOUNT_SID = "8a48b5514fa577af014fa7bb940209b5";
	private final static String AUTH_TOKEN = "4f20a38b28524b6e81abe2d35134192c";
	private final static String APP_ID = "aaf98f894fa5766f014fa7bea679036e";*/
	
	/*************企业账号属性*************/
	private final static String SERVER_IP = "app.cloopen.com";
	private final static String SERVER_PORT = "8883";
	private final static String ACCOUNT_SID = "8a48b5514fd49643014fef0d53d14139";
	private final static String AUTH_TOKEN = "95809a90fd004bf58f2a13fabfa4776d";
	private final static String APP_ID = "8a48b5514ff43a4e014ff43b40ee000b";
	private final static String APP_TOKEN = "083d609e3569e6caccb4778fbcc9beee";
	private final static String TIME_LIMIT = "2";
	//private final static String MESSAGE_TEMPLATE="1";
	/*****定义模板标识开始******/
	public final static String MESSAGE_TEMPLATE_REGISTER="44394";
	public final static String MESSAGE_TEMPLATE_PLACE_PREORDER="44445";
	public final static String MESSAGE_TEMPLATE_COACH_PREORDER="44446";
	/*****定义模板标识结束******/
	/********** 需要发送的信息 ***********/
	private String code;
	private String phone;

	/*********** 功能函数 *************/
	/*public static void main(String[] args){
		MessageUtil util=new MessageUtil().setCode("dfds").setPhone("15200292390");
		util.sendMessage();
	}*/
	//将模板标识转换为云讯通模板id
	public String getTemplateId(String id){
		if(TEMPLATE_REGISTER.equals(id))
			return MESSAGE_TEMPLATE_REGISTER;
		else if(TEMPLATE_PLACE_PREORDER.equals(id))
			return MESSAGE_TEMPLATE_PLACE_PREORDER;
		else if(TEMPLATE_COACH_PREORDER.equals(id))
			return MESSAGE_TEMPLATE_COACH_PREORDER;
		else
			return MESSAGE_TEMPLATE_REGISTER;//默认为注册模板
	}
	// 发送短信
	@SuppressWarnings("unchecked")
	public boolean sendMessage(String templateId) {
		templateId=getTemplateId(templateId);
		boolean re = false;
		HashMap<String, Object> result = null;
		result = restAPI.sendTemplateSMS(this.getPhone(), templateId, new String[] {
				this.getCode(), TIME_LIMIT});

		System.out.println("SDKTestGetSubAccounts result=" + result);
		if ("000000".equals(result.get("statusCode"))) {
			// 正常返回输出data包体信息（map）
			HashMap<String, Object> data = (HashMap<String, Object>) result
					.get("data");
			Set<String> keySet = data.keySet();
			for (String key : keySet) {
				Object object = data.get(key);
				System.out.println(key + " = " + object);
			}
			System.out.println("发送消息成功，号码："+this.getPhone()+"  验证码："+this.getCode());
			re=true;
		} else {
			// 异常返回输出错误码和错误信息
			System.out.println("错误码=" + result.get("statusCode") + "\n 错误信息= "
					+ result.get("statusMsg"));
		}
		return re;
	}

	/*********** 构造方法 ********/
	// 声明和初始化SDK
	public static CCPRestSmsSDK restAPI = new CCPRestSmsSDK();

	public MessageUtil() {

		// ******************************注释*********************************************
		// *初始化服务器地址和端口 *
		// *沙盒环境（用于应用开发调试）：restAPI.init("sandboxapp.cloopen.com", "8883");*
		// *生产环境（用户应用上线使用）：restAPI.init("app.cloopen.com", "8883"); *
		// *******************************************************************************
		restAPI.init(SERVER_IP, SERVER_PORT);

		// ******************************注释*********************************************
		// *初始化主帐号和主帐号令牌,对应官网开发者主账号下的ACCOUNT SID和AUTH TOKEN *
		// *ACOUNT SID和AUTH TOKEN在登陆官网后，在“应用-管理控制台”中查看开发者主账号获取*
		// *参数顺序：第一个参数是ACOUNT SID，第二个参数是AUTH TOKEN。 *
		// *******************************************************************************
		restAPI.setAccount(ACCOUNT_SID,AUTH_TOKEN);

		// ******************************注释*********************************************
		// *初始化应用ID *
		// *测试开发可使用“测试Demo”的APP ID，正式上线需要使用自己创建的应用的App ID *
		// *应用ID的获取：登陆官网，在“应用-应用列表”，点击应用名称，看应用详情获取APP ID*
		// *******************************************************************************
		restAPI.setAppId(APP_ID);

		// ******************************注释****************************************************************
		// *调用发送模板短信的接口发送短信 *
		// *参数顺序说明： *
		// *第一个参数:是要发送的手机号码，可以用逗号分隔，一次最多支持100个手机号 *
		// *第二个参数:是模板ID，在平台上创建的短信模板的ID值；测试的时候可以使用系统的默认模板，id为1。 *
		// *系统默认模板的内容为“【云通讯】您使用的是云通讯短信模板，您的验证码是{1}，请于{2}分钟内正确输入”*
		// *第三个参数是要替换的内容数组。 *
		// **************************************************************************************************

		// **************************************举例说明***********************************************************************
		// *假设您用测试Demo的APP ID，则需使用默认模板ID 1，发送手机号是13800000000，传入参数为6532和5，则调用方式为
		// *
		// *result = restAPI.sendTemplateSMS("13800000000","1" ,new
		// String[]{"6532","5"}); *
		// *则13800000000手机号收到的短信内容是：【云通讯】您使用的是云通讯短信模板，您的验证码是6532，请于5分钟内正确输入 *
		// *********************************************************************************************************************

	}

	/********* 注入代码 ************/
	public String getCode() {
		return code;
	}

	public MessageUtil setCode(String code) {
		this.code = code;
		return this;
	}

	public String getPhone() {
		return phone;
	}

	public MessageUtil setPhone(String phone) {
		this.phone = phone;
		return this;
	}

}
