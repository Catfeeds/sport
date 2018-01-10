package com.sport.exception;
//该异常显示操作的提示信息
public class PromptException extends RootException {
	//用户相关的提示信息
	public final static String NEED_MORE_USER_UPDATE_INFO="您需要更多的信息才能更新用户信息！";
	public final static String PHONE_EXISTS="电话号码已经被别人绑定了！";
	public final static String WEIXIN_EXISTS="微信号已经被其它账号绑定了！";
	public final static String EMAIL_EXISTS="邮箱已经被别人绑定了！";
	public PromptException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}
	
}
