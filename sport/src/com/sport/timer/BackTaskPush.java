package com.sport.timer;
import javax.annotation.Resource;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.stereotype.Service;
@Service
public class BackTaskPush {
	private TimerTaskQueue timerTaskQueue;
	public BackTaskPush() {
		System.out.println("push open application!");
		
	}

	public TimerTaskQueue getTimerTaskQueue() {
		return timerTaskQueue;
	}
	@Resource
	public void setTimerTaskQueue(TimerTaskQueue timerTaskQueue) {
		this.timerTaskQueue = timerTaskQueue;
		timerTaskQueue.runTimeTask();
	}

}
