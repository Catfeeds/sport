package com.sport.dao;

import java.util.List;

import org.springframework.stereotype.Component;

import com.sport.entity.Event;

@Component
public class EventDao extends RootDao{
	public void save(Event event){
		hibernateTemplate.save(event);
	}
	
	public Event load(int id){
		if(id<1)
			return null;
		return (Event)hibernateTemplate.load(Event.class, id);
	}
	
		
	public Event load(Event event){			
		return load(event.getId());
	}
	
	public void delete(int id){
		if(id<1)
			return ;
		delete(new Event().setId(id));
	}
	
	public void delete(Event event){
		
		hibernateTemplate.delete(event);
				
	}
	
	public void update(Event event){
		hibernateTemplate.update(event);
	}
	//精确分页查询
	public  int findAll(List<Event> events,Event event,
			int pageNumber,
			int pageSize,
			String groupByColumn,
			String orderByColumn,
			boolean isAsc){
		StringBuffer queryString=new StringBuffer("from Event e where 1=1 ");
		
		return find(queryString.toString(), events,pageNumber,pageSize,groupByColumn,orderByColumn,isAsc);
	}
	//关键字分页查询
		public  int findAllSearch(List<Event> events,Event event,
				int pageNumber,
				int pageSize,
				String groupByColumn,
				String orderByColumn,
				boolean isAsc){
			StringBuffer queryString=new StringBuffer("from Event e where 1=2 ");
			if(event!=null){
							
				if(event.getTitle()!=null){
					queryString.append(" or e.event_title like'"+event.getTitle()+"'");
					queryString.append(" or e.event_content like '"+event.getTitle()+"' ");
					queryString.append(" or e.person.realName like '"+event.getTitle()+"' ");
				}
				
			
			}
			return find(queryString.toString(), events,pageNumber,pageSize,groupByColumn,orderByColumn,isAsc);
		}
}
