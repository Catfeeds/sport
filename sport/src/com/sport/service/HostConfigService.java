package com.sport.service;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.springframework.stereotype.Component;

@Component
public class HostConfigService {
	private String companyName;
	private String hostSuperManagerName;
	private boolean timerFlag;
	public HostConfigService() throws FileNotFoundException{
		 Properties prop =  new  Properties();  
		 String pathName=this.getClass().getResource( "/host.properties" ).toString();
		 pathName = pathName.substring(pathName.indexOf("/") + 1);
	        InputStream in =new FileInputStream(pathName);    
	         try  {    
	            prop.load(in);    
	            setCompanyName(prop.getProperty( "host.companyName" ).trim());    
	            setHostSuperManagerName(prop.getProperty( "host.superManagerName" ).trim());
	            String timerFlagStr=prop.getProperty("host.timerFlag");
	            if("1".equals(timerFlagStr))
	            	timerFlag=true;
	            else
	            	timerFlag=false;
	        }  catch  (IOException e) {    
	            e.printStackTrace();    
	        }    
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getHostSuperManagerName() {
		return hostSuperManagerName;
	}
	public void setHostSuperManagerName(String hostSuperManagerName) {
		this.hostSuperManagerName = hostSuperManagerName;
	}
	public boolean isTimerFlag() {
		return timerFlag;
	}
	public void setTimerFlag(boolean timerFlag) {
		this.timerFlag = timerFlag;
	}
}
