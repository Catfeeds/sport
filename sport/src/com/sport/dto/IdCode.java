package com.sport.dto;

public class IdCode {
	private String phone;
	private String code;
	private String templateId;
	public String getPhone() {
		return phone;
	}

	public IdCode setPhone(String phone) {
		this.phone = phone;
		return this;
	}

	public String getCode() {
		return code;
	}

	public IdCode setCode(String code) {
		this.code = code;
		return this;
	}

	public String getTemplateId() {
		return templateId;
	}

	public IdCode setTemplateId(String templateId) {
		this.templateId = templateId;
		return this;
	}

	// 系统随机生成验证码
	public void produceCode(int number) {
		StringBuffer buffer=new StringBuffer();
		for(int i=0;i<number;i++){
			buffer.append(getNumberChar());
		}
		code=buffer.toString();
	}

	public void produceCode() {
		produceCode(4);
	}
	//生成一个随机数字
	private String getNumberChar(){
		long itmp = Math.round(Math.random() * 9);  
        return String.valueOf(itmp);
	}
	// 随机生成一个字符  、可生成大写、小写、数字字符
    private String getRandomChar() {  
        int rand = (int) Math.round(Math.random() * 2);// 将0～2的小数四舍五入生成整数  
        long itmp = 0;  
        char ctmp = '\u0000';  
        // 根据rand的值来决定是生成一个大写字母、小写字母和数字  
        switch (rand) {  
        // 生成大写字母的情形  
        case 1:  
            itmp = Math.round(Math.random() * 25 + 65);  
            ctmp = (char) itmp;  
            return String.valueOf(ctmp);  
            // 生成小写字母  
        case 2:  
            itmp = Math.round(Math.random() * 25 + 97);  
            ctmp = (char) itmp;  
            return String.valueOf(ctmp);  
            // 生成数字  
        default:  
            itmp = Math.round(Math.random() * 9);  
            return String.valueOf(itmp);  
        }  
    }  
}
