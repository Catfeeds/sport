package com.sport.service;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.sport.dao.UpdateProgressDao;
import com.sport.dto.Page;
import com.sport.entity.Coach;
import com.sport.entity.CoachPreOrder;
import com.sport.entity.Place;
import com.sport.entity.PlacePreOrder;
import com.sport.entity.UpdateProgress;
import com.sport.exception.RootException;
import com.sport.timer.TimerTaskQueue;

@Component
public class UpdateProgressService  extends RootService{
	private static final String ENTITY_NAME="UpdateProgress";
	private UpdateProgressDao updateProgressDao;
	private PlacePreOrderService placePreOrderService;
	private PlaceService placeService;
	private CoachPreOrderService coachPreOrderService;
	private CoachService coachService;
	
	public UpdateProgressDao getUpdateProgressDao() {
		return updateProgressDao;
	}
	@Resource
	public UpdateProgressService setUpdateProgressDao(UpdateProgressDao updateProgressDao) {
		this.updateProgressDao = updateProgressDao;
		return this;
	}
	public PlacePreOrderService getPlacePreOrderService() {
		return placePreOrderService;
	}
	@Resource
	public void setPlacePreOrderService(PlacePreOrderService placePreOrderService) {
		this.placePreOrderService = placePreOrderService;
	}
	public CoachPreOrderService getCoachPreOrderService() {
		return coachPreOrderService;
	}
	@Resource
	public void setCoachPreOrderService(CoachPreOrderService coachPreOrderService) {
		this.coachPreOrderService = coachPreOrderService;
	}
	public PlaceService getPlaceService() {
		return placeService;
	}
	@Resource
	public void setPlaceService(PlaceService placeService) {
		this.placeService = placeService;
	}
	public CoachService getCoachService() {
		return coachService;
	}
	@Resource
	public void setCoachService(CoachService coachService) {
		this.coachService = coachService;
	}
	/********处理一些预定处理的事务
	 * @throws RootException *********/
	//更新场地预定信息
	public void updatePlacePreOrder() throws RootException{
		UpdateProgress update=load();
		List<Place> places=new ArrayList<Place>();
		Page page=new Page().setPageSize(50);
		page.setTotalItemNumber(placeService.findAll(places, 1, page.getPageSize()));//获得场地信息的总页数
		for(int i=1;i<=page.getTotalPageNumber();i++){
			List<Place> ps=new ArrayList<Place>();
			placeService.findAll(ps, i, page.getPageSize());
			for(Place p:ps){							
				Calendar oldDate=Calendar.getInstance();				
				oldDate.setTime(update.getDate());
				int oldDay=(int)((oldDate.getTimeInMillis()-
									(oldDate.getTimeInMillis()%TimerTaskQueue.SCHEDULE))/TimerTaskQueue.SCHEDULE);		
				Calendar date=Calendar.getInstance();
				date.set(date.get(Calendar.YEAR), 
						date.get(Calendar.MONTH),
						date.get(Calendar.DAY_OF_MONTH),
						0,0,0);
				int newDay=(int)((date.getTimeInMillis()-
						(date.getTimeInMillis()%TimerTaskQueue.SCHEDULE))/TimerTaskQueue.SCHEDULE);
				int updateDayNumber=newDay-oldDay;//代表已经有几天没有更新了
				if(update.getUpdateNumber()<1){ 
					updateDayNumber=update.getUpdateDayNumber();
				}
				if(updateDayNumber<=0)
					return;//已经全部更新了，无需继续更新
				System.out.println("需要更新的天数:"+updateDayNumber);		
				long tempDate=date.getTimeInMillis();
				for(int k=(update.getUpdateDayNumber()-updateDayNumber);k<update.getUpdateDayNumber();k++){//
					PlacePreOrder pOrder=new PlacePreOrder();
					int[] orderInfos=new int[]{1,1,1,1,1,
							1,1,1,1,1,
							1,1,1,1,1,
							1,1,1,1,1,
							1,1,1,1
							};	
					date.set(date.get(Calendar.YEAR), 
							date.get(Calendar.MONTH),
							date.get(Calendar.DAY_OF_MONTH));
					
					long time=date.getTimeInMillis();
					System.out.println("time:"+time);
					time+=TimerTaskQueue.SCHEDULE*k;//定位到某天
					date.setTime(new Date(time));
					pOrder.setPlace(p).setOrderInfos(orderInfos)
							.setDate(date.getTime());
					placePreOrderService.add(pOrder);
					date.setTime(new Date(tempDate));
				}				
			}
		}
	}
	//更新教练预定信息
	public void updateCoachPreOrder() throws RootException{
		UpdateProgress update=load();
		List<Coach> coachs=new ArrayList<Coach>();
		Page page=new Page().setPageSize(50);
		page.setTotalItemNumber(coachService.findAll(coachs, 1, page.getPageSize()));//获得场地信息的总页数
		for(int i=1;i<=page.getTotalPageNumber();i++){
			List<Coach> cs=new ArrayList<Coach>();
			coachService.findAll(cs, i, page.getPageSize());
			for(Coach c:cs){						
				Calendar oldDate=Calendar.getInstance();	
				oldDate.setTime(update.getDate());
				int oldDay=(int)((oldDate.getTimeInMillis()-
						(oldDate.getTimeInMillis()%TimerTaskQueue.SCHEDULE))/TimerTaskQueue.SCHEDULE);		
				Calendar date=Calendar.getInstance();
				date.set(date.get(Calendar.YEAR), 
						date.get(Calendar.MONTH),
						date.get(Calendar.DAY_OF_MONTH),
						0,0,0);
				int newDay=(int)((date.getTimeInMillis()-
						(date.getTimeInMillis()%TimerTaskQueue.SCHEDULE))/TimerTaskQueue.SCHEDULE);
				int updateDayNumber=newDay-oldDay;//代表已经有几天没有更新了
				if(update.getUpdateNumber()<1){//如果只更新了一次
					updateDayNumber=update.getUpdateDayNumber();
				}
				if(updateDayNumber<=0)
					return;//已经全部更新了，无需继续更新
				System.out.println("需要更新的天数:"+updateDayNumber);
				long tempDate=date.getTimeInMillis();
				for(int k=(update.getUpdateDayNumber()-updateDayNumber);k<update.getUpdateDayNumber();k++){//
					CoachPreOrder cOrder=new CoachPreOrder();	
					date.set(date.get(Calendar.YEAR), 
							date.get(Calendar.MONTH),
							date.get(Calendar.DAY_OF_MONTH),0,0,0);
					long time=date.getTimeInMillis();
					System.out.println("time:"+time);
					time+=TimerTaskQueue.SCHEDULE*k;//定位到某天
					date.setTime(new Date(time));
					cOrder.setCoach(c)
					.setDate(date.getTime())
					.setUnionOrderInfos(c.getEmployNumber());
					coachPreOrderService.add(cOrder);
					date.setTime(new Date(tempDate));
				}				
			}
		}
	}
	//将当前小时的预订信息置为不可用
	public void unableCurrentPreOrders() throws RootException{
		unableCurrentCoachPreOrders();
		unableCurrentPlacePreOrders();
	}
	//
	public void unableCurrentCoachPreOrders() throws RootException{
		Calendar calendar=Calendar.getInstance(Locale.CHINA);
		long currentTime=calendar.get(Calendar.HOUR_OF_DAY);
		System.out.println("currentTime:"+currentTime);
		List<CoachPreOrder> preOrders=new ArrayList<CoachPreOrder>();
		Page page=new Page().setPageSize(30);
		page.setTotalItemNumber(coachPreOrderService.findAllCurrentPreOrder(preOrders,1, page.getPageSize()));
		for(int i=1;i<=page.getTotalPageNumber();i++){
			List<CoachPreOrder> ps=new ArrayList<CoachPreOrder>();
			coachPreOrderService.findAllCurrentPreOrder(ps,i, page.getPageSize());
			for(CoachPreOrder preOrder:ps){
				int[] orderInfos=preOrder.getOrderInfos();
				if(currentTime>=CoachPreOrder.TIME_AM_BEGIN_WORK)
					orderInfos[0]=0;
				if(currentTime>=CoachPreOrder.TIME_PM_BEGIN_WORK)
					orderInfos[1]=0;
				if(currentTime>=CoachPreOrder.TIME_NIGHT_BEGIN_WORK)
					orderInfos[2]=0;
				if(orderInfos[0]==0||(orderInfos[1]==0)||(orderInfos[2]==0))
					orderInfos[3]=0;
				preOrder.setOrderInfos(orderInfos);
				coachPreOrderService.update(preOrder);
			}
		}
	}
	//
	public void unableCurrentPlacePreOrders() throws RootException{
		Calendar calendar=Calendar.getInstance(Locale.CHINA);
		long currentTime=calendar.get(Calendar.HOUR_OF_DAY);
		List<PlacePreOrder> preOrders=new ArrayList<PlacePreOrder>();
		Page page=new Page().setPageSize(30);
		page.setTotalItemNumber(placePreOrderService.findAllCurrentPreOrder(preOrders,1, page.getPageSize()));
		for(int i=1;i<=page.getTotalPageNumber();i++){
			List<PlacePreOrder> ps=new ArrayList<PlacePreOrder>();
			placePreOrderService.findAllCurrentPreOrder(ps,i, page.getPageSize());
			for(PlacePreOrder preOrder:ps){
				int[] orderInfos=preOrder.getOrderInfos();
				for(int j=0;j<=currentTime;j++){
					orderInfos[j]=0;
				}
				preOrder.setOrderInfos(orderInfos);
				placePreOrderService.update(preOrder);
			}
		}
	}
	public void add(UpdateProgress update) throws RootException{
		if(update==null)
			throw new RootException(RootException.NEED_MORE_ADD_INFO);	
		if(update.getUpdateDayNumber()<=0)//默认更新7天的预定信息
			update.setUpdateDayNumber(UpdateProgress.DEFAUL_UPDATE_DAYS);
		updateProgressDao.save(update);
	}
	
	public void delete(UpdateProgress update) throws RootException{		
		if(update==null||(update.getId()<=0))
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);	
		 updateProgressDao.delete(update);
	}
	public void delete(int id) throws RootException{		
		if(id<=0)
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);	
		 updateProgressDao.delete(id);
	}
	public void update(UpdateProgress update) throws RootException{
		if(update==null||(update.getId()<=0))
			throw new RootException(RootException.NEED_MORE_UPDATE_INFO);		
		updateProgressDao.update(update);
	}
	
	public UpdateProgress load( ) throws RootException{
		List<UpdateProgress> updates=new ArrayList<UpdateProgress>();
		findAll(updates, 1, 2);
		if(updates.size()>0){
			return updates.get(0);
		}
		return null;
	}
	public UpdateProgress load(int id) throws RootException{
		if(id<=0)
			throw new RootException(RootException.NEED_MORE_FIND_INFO);	
		return updateProgressDao.load(id);			
	}
	
	public  int findAll(List<UpdateProgress> updates,
			int pageNumber,
			int pageSize
			){
		return updateProgressDao.findAll( updates,pageNumber,pageSize);
	}
	//按某列排序查看会员信息
	public  int findAll(List<UpdateProgress> updates,
			int pageNumber,
			int pageSize,
			String orderByColumn,
			boolean isAsc){
		return updateProgressDao.findAll( updates,pageNumber,pageSize,null,orderByColumn,isAsc);
	}
}
