package com.sport.action;

import java.io.OutputStream;


import net.sf.json.JSONArray;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.sport.exception.ServerErrorException;
import com.sport.util.ConfirmCode;

@Component
@Scope("prototype")
public class ConfirmCodeAction extends RootAction {
	// 获取验证码图片，并将验证码的值写入session中
	public void gainImage() throws ServerErrorException {
		
		try {
			response=ServletActionContext.getResponse();
			response.setHeader("Pragma", "No-cache");
			response.setHeader("Cache-Control", "no-cache");
			response.setDateHeader("Expires", 0);
			response.setContentType("image/jpeg");
			OutputStream outStream;
			outStream = response.getOutputStream();
			// 输出图片
			String confirmCode = new ConfirmCode().createImage(outStream);
			outStream.flush();
			outStream.close();
			// 保存验证码，以供检测用户输入验证码是否正确
			session.put("confirmCode", confirmCode);
			System.out.println("confirmCodeImg:"+confirmCode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	//获取验证码的值
	public void gainConfirmCode() throws ServerErrorException{
		this.getResponseAndOut();
		JSONArray json=new JSONArray();
		String confirmCode=(String)session.get("confirmCode");
		json.add(confirmCode);
		System.out.println("confirmCode:"+confirmCode);
		out.print(json);
		this.closeOut();
	}
	
	

}
