package com.sport.dao;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Component;

import com.sport.entity.CoachPreOrder;
import com.sport.entity.PlacePreOrder;
import com.sport.timer.TimerTaskQueue;

@Component
public class CoachPreOrderDao extends RootDao{
	public void save(CoachPreOrder item){
		hibernateTemplate.save(item);
	}
	
	public CoachPreOrder load(int id){
		if(id<1)
			return null;
		return (CoachPreOrder)hibernateTemplate.load(CoachPreOrder.class, id);
	}
	@SuppressWarnings("unchecked")
	public CoachPreOrder load(Date date,int id){			
				
		List<CoachPreOrder> orders=(List<CoachPreOrder>)hibernateTemplate.getSessionFactory().
				getCurrentSession().
				createCriteria(CoachPreOrder.class).
				add(Restrictions.eq("date",date))
				.add(Restrictions.eq("coach.id", id))
				.list();
				if(orders==null)
					return null;
				if(orders.isEmpty())
					return null;
				System.out.println("date:"+date);
				System.out.println("取到的教练预定信息："+orders.size()+"  时间："+orders.get(0).getDate());
				return (CoachPreOrder)orders.get(0);
	}
		
	public CoachPreOrder load(CoachPreOrder item){	
		if(item.getId()<1)
			return load(item.getDate(),item.getCoach().getId());
		return load(item.getId());
	}
	
	public void delete(int id){
		if(id<1)
			return ;
		delete(new CoachPreOrder().setId(id));
	}
	
	public void delete(CoachPreOrder item){
		
		hibernateTemplate.delete(item);
				
	}
	
	public void update(CoachPreOrder item){
		hibernateTemplate.update(item);
	}
	//分页查询
	public  int findAll(List<CoachPreOrder> items,
			int pageNumber,
			int pageSize,
			String groupByColumn,
			String orderByColumn,
			boolean isAsc){
		String queryString="from CoachPreOrder e ";
		return find(queryString, items,pageNumber,pageSize,groupByColumn,orderByColumn,isAsc);
	}
	public  int findAll(List<CoachPreOrder> items,
			int pageNumber,
			int pageSize){
		return findAll( items,pageNumber,pageSize,null,null,true);
	}
	public int findAllCurrentPreOrder(List<CoachPreOrder> items,
			int pageNumber,
			int pageSize
			){
		SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd"); 
		Date date=new Date();
		String hql="from CoachPreOrder e where e.date ='"+f.format(date)+"'";
		return find(hql,items,pageNumber,pageSize,null,null,true);
	}
	
}
