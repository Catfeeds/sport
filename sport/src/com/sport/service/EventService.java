package com.sport.service;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.sport.dao.EventDao;
import com.sport.entity.Event;
import com.sport.exception.RootException;


@Component
public class EventService  extends RootService{
	private static final String ENTITY_NAME="Event";
	private EventDao eventDao;

	public EventDao getEventDao() {
		return eventDao;
	}
	@Resource
	public EventService setEventDao(EventDao eventDao) {
		this.eventDao = eventDao;
		return this;
	}
	public void add(Event event) throws RootException{
		if(event==null)
			throw new RootException(RootException.NEED_MORE_ADD_INFO);	
		
		eventDao.save(event);
	}
	
	public void delete(Event event) throws RootException{
		
		if(event==null||(event.getId()<=0))
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);	
		 eventDao.delete(event);
	}
	public void delete(int id) throws RootException{		
		if(id<=0)
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);	
		 eventDao.delete(id);
	}
	public void update(Event event) throws RootException{
		if(event==null||(event.getId()<=0))
			throw new RootException(RootException.NEED_MORE_UPDATE_INFO);
		Event oldEvent=eventDao.load(event);
		
		oldEvent.setTitle(event.getTitle())
				.setContent(event.getContent());		
			
		if(event.getImage()!=null)
			oldEvent.setImage(event.getImage());
		eventDao.update(oldEvent);
	}
	
	public Event load(Event event) throws RootException{
		if(event==null||(event.getId()<=0))
			throw new RootException(RootException.NEED_MORE_FIND_INFO);	
		return eventDao.load(event);			
	}
	public Event load(int id) throws RootException{
		if(id<=0)
			throw new RootException(RootException.NEED_MORE_FIND_INFO);	
		return eventDao.load(id);			
	}
	
	public  int findAll(List<Event> events,Event event,
			int pageNumber,
			int pageSize
			){
		return findAll( events,event,pageNumber,pageSize,null,true);
	}
	//按某列排序查看论坛信息
	public  int findAll(List<Event> events,Event event,
			int pageNumber,
			int pageSize,
			String orderByColumn,
			boolean isAsc){
		return eventDao.findAll( events,event,pageNumber,pageSize,null,"time",false);
	}
	//关键字搜索论坛
	public  int findAllSearch(List<Event> events,Event event,
			int pageNumber,
			int pageSize
			){
		return findAllSearch( events,event,pageNumber,pageSize,null,true);
	}
	//按某列排序查看论坛信息
	public  int findAllSearch(List<Event> events,Event event,
			int pageNumber,
			int pageSize,
			String orderByColumn,
			boolean isAsc){
		return eventDao.findAllSearch( events,event,pageNumber,pageSize,null,"time",false);
	}
	public boolean deleteSelectedEvents(String ids) {
		return eventDao.deleteEntitys(ENTITY_NAME, ids);
	}
}
