package com.sport.action;

import javax.annotation.Resource;

import net.sf.json.JSONArray;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.sport.dto.IdCode;
import com.sport.exception.ServerErrorException;
import com.sport.smessage.MessageUtil;

@Component
@Scope("prototype")
public class CommonAction extends RootAction{
	//验证信息
		private MessageUtil messageUtil;
		private IdCode code;
		//验证手机号为本人的
		public void sendMessage() throws ServerErrorException{		
			this.getResponseAndOut();
			JSONArray json=new JSONArray();
			code.produceCode();
			messageUtil.setPhone(code.getPhone()).setCode(code.getCode());
			System.out.println("电话号码："+code.getPhone()+"\n验证码："+code.getCode());
			if(messageUtil.sendMessage(code.getTemplateId())){
				json.add(true);
				json.add("发送验证码成功！");
				json.add(code.getCode());
			}else{
				json.add(false);
				json.add("发送验证码失败!");
			}
			out.println(json);
			this.closeOut();
		}
		
		/*********注入代码********/
		public MessageUtil getMessageUtil() {
			return messageUtil;
		}
		@Resource
		public void setMessageUtil(MessageUtil messageUtil) {
			this.messageUtil = messageUtil;
		}
		public IdCode getCode() {
			return code;
		}
		public void setCode(IdCode code) {
			this.code = code;
			
		}
}
