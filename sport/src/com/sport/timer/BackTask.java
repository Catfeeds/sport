package com.sport.timer;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;



public class BackTask implements ServletContextListener {
	public void contextDestroyed(ServletContextEvent arg0) {
		System.out.println("close application！");
	}

	public void contextInitialized(ServletContextEvent arg0) {//启动项目的时候先执行一次预定信息的更新
		System.out.println("open application!");
	}

	

}
