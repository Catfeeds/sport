package com.sport.timer;

import java.util.Calendar;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sport.entity.UpdateProgress;
import com.sport.exception.RootException;
import com.sport.service.HostConfigService;
import com.sport.service.OrderService;
import com.sport.service.QueryOrderService;
import com.sport.service.UpdateProgressService;

@Service
public class TimerTaskQueue {
	private final static int HOUR = 3;// 执行时的小时数
	private final static int MINUTE = 0;// 执行时的分钟数
	private final static int SECEND = 20;// 执行时的秒数
	public final static long CHECK_NOTPAY_ORDER = 1000 * 60 * 10;// 每10分钟检查是否有超过10分钟未支付的订单,如果有，就释放其预定的场地等信息
	public final static long UPDATE_PREORDER_SCHEDULE = 1000 * 60 * 60;// 每隔一个小时更新一次预定信息的场地预定情况,目的就是让已经过去的时间不能继续预定
	public final static long SCHEDULE = 1000 * 60 * 60 * 24;// 每隔一天执行一次预定信息更新
	private final static long QUERY_SCHEDULE = 1000 * 20;// 每隔20秒执行一次与微信订单的同步

	private Timer timer;
	private static TimerTask updateTask = null;// 执行更新预定信息的任务
	private static TimerTask queryOrderTask = null;// 查询订单支付状态的任务
	private static TimerTask checkOrderTimeOutTask = null;// 将付款未成功且超时的订单置为废单，释放资源
	private static TimerTask unablePreOrderTask = null;// 每隔一小时将过去的一小时的预定信息置为不可继续预定
	private UpdateProgressService updateProgressService;
	private QueryOrderService queryOrderService;
	private OrderService orderService;
	private HostConfigService hostConfigService;
	private boolean flag = false;

	public TimerTaskQueue() {
		timer = new Timer();
		updateTask = new TimerTask() {
			@Override
			public void run() {
				System.out.println("更新预定信息，此时的时间是：" + new Date());
				runUpdatePreOrderTask();// 调用任务处理函数
			}
		};
		queryOrderTask = new TimerTask() {
			@Override
			public void run() {
				System.out.println("查询微信订单状态，此时的时间是：" + new Date());
				// 调用查询微信订单的方法
				try {
					queryOrderService.batchQueryWeixinOrder();
				} catch (RootException e) {
					e.printStackTrace();
				}
			}
		};

		checkOrderTimeOutTask = new TimerTask() {
			@Override
			public void run() {
				System.out.println("调用释放订单资源的方法，此时的时间是：" + new Date());
				// 调用释放订单资源的方法
				try {
					orderService.checkTimeOutNewOrders();
				} catch (RootException e) {
					e.printStackTrace();
				}
			}
		};
		unablePreOrderTask = new TimerTask() {
			@Override
			public void run() {
				System.out.println("调用将当前时间之前的预订信息置为不可用的方法，此时的时间是："
						+ new Date());
				// 调用将当前时间之前的预订信息置为不可用的方法
				try {
					updateProgressService.unableCurrentPreOrders();
				} catch (RootException e) {
					e.printStackTrace();
				}
			}
		};
	}

	public void destroy() {
		updateTask.cancel();
		timer.cancel();
		System.out.println("释放定时器资源!");
	}

	// 需要执行的任务
	public void runUpdatePreOrderTask() {

		try {
			// 更新预定信息
			updateProgressService.updateCoachPreOrder();
			updateProgressService.updatePlacePreOrder();
		} catch (RootException e) {
			e.printStackTrace();
		}
		// 更新最新的预定信息更新时间
		updateRecordUpdateTime();
	}

	public void updateRecordUpdateTime() {
		UpdateProgress update = null;
		try {
			update = updateProgressService.load();
			if (update != null) {
				update.setDate(new Date()).setUpdateNumber(
						update.getUpdateNumber() + 1);
				updateProgressService.update(update);
			} else {
				update = new UpdateProgress();
				update.setDate(new Date());
				update.setUpdateNumber(1);
				updateProgressService.add(update);
			}
		} catch (RootException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void runTimeTask() {
		Calendar date = Calendar.getInstance();
		date.set(date.get(Calendar.YEAR), date.get(Calendar.MONTH),
				date.get(Calendar.DAY_OF_MONTH), HOUR, MINUTE, SECEND);
		date.setTimeInMillis(TimerTaskQueue.SCHEDULE + date.getTimeInMillis());// 今天启动web项目，明天再启动定时器
		Date time = date.getTime();
		System.out.println(time);

		// 每天按时执行一次,预定信息的更新
		timer.schedule(updateTask, time, SCHEDULE);
		//根据配置文件信息决定是否启动定时器
		if (hostConfigService.isTimerFlag()) {
			// 每隔15秒执行一次订单查询,与微信支付服务器进行同步
			/*timer.schedule(queryOrderTask, Calendar.getInstance().getTime(),
					QUERY_SCHEDULE);// 立即执行*/
			// 每个30分钟检查一次订单支付超时
			timer.schedule(checkOrderTimeOutTask, Calendar.getInstance()
					.getTime(), CHECK_NOTPAY_ORDER);// 立即执行

			Calendar date1 = Calendar.getInstance();
			date1.set(date1.get(Calendar.YEAR), date1.get(Calendar.MONTH),
					date1.get(Calendar.DAY_OF_MONTH),
					date1.get(Calendar.HOUR_OF_DAY), 0, 0);
			// 每小时重置一次时间已经过去的预定信息
			timer.schedule(unablePreOrderTask, date1.getTime(),
					UPDATE_PREORDER_SCHEDULE);// 立即执行
		}
	}

	@Override
	protected void finalize() throws Throwable {
		destroy();
		super.finalize();
	}

	public UpdateProgressService getUpdateProgressService() {
		return updateProgressService;
	}

	@Resource
	public void setUpdateProgressService(
			UpdateProgressService updateProgressService) {
		this.updateProgressService = updateProgressService;
		if (flag)
			return;
		flag = true;
		this.runUpdatePreOrderTask();// 启动服务器便第一次更新预定信息
	}

	public QueryOrderService getQueryOrderService() {
		return queryOrderService;
	}

	@Resource
	public void setQueryOrderService(QueryOrderService queryOrderService) {
		this.queryOrderService = queryOrderService;
	}

	public OrderService getOrderService() {
		return orderService;
	}

	@Resource
	public void setOrderService(OrderService orderService) {
		this.orderService = orderService;
	}

	public HostConfigService getHostConfigService() {
		return hostConfigService;
	}

	@Resource
	public void setHostConfigService(HostConfigService hostConfigService) {
		this.hostConfigService = hostConfigService;
	}
}
