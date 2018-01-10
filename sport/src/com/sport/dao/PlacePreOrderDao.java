package com.sport.dao;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Component;

import com.sport.entity.PlacePreOrder;
import com.sport.timer.TimerTaskQueue;

@Component
public class PlacePreOrderDao extends RootDao{
	public void save(PlacePreOrder item){
		hibernateTemplate.save(item);
	}
	
	public PlacePreOrder load(int id){
		if(id<1)
			return null;
		return (PlacePreOrder)hibernateTemplate.load(PlacePreOrder.class, id);
	}
	
		
	public PlacePreOrder load(PlacePreOrder item){	
		if(item.getId()<1)
			return load(item.getDate(),item.getPlace().getId());
		return load(item.getId());
	}
	@SuppressWarnings("unchecked")
	public PlacePreOrder load(Date date,int id){			
		
		List<PlacePreOrder> orders=(List<PlacePreOrder>)hibernateTemplate.getSessionFactory().
				getCurrentSession().
				createCriteria(PlacePreOrder.class).
				add(Restrictions.eq("date", date))
				.add(Restrictions.eq("place.id", id))
				.list();
				if(orders==null)
					return null;
				if(orders.isEmpty())
					return null;
				System.out.println("date:"+date);
				System.out.println("取到的场地预定信息："+orders.size()+"  时间："+
				orders.get(0).getDate()+"\ndate2:");
				return (PlacePreOrder)orders.get(0);
	}
	public void delete(int id){
		if(id<1)
			return ;
		delete(new PlacePreOrder().setId(id));
	}
	
	public void delete(PlacePreOrder item){
		
		hibernateTemplate.delete(item);
				
	}
	
	public void update(PlacePreOrder item){
		hibernateTemplate.update(item);
	}
	//分页查询
	public  int findAll(List<PlacePreOrder> items,
			int pageNumber,
			int pageSize,
			String groupByColumn,
			String orderByColumn,
			boolean isAsc){
		String queryString="from PlacePreOrder e ";
		return find(queryString, items,pageNumber,pageSize,groupByColumn,orderByColumn,isAsc);
	}
	public int findAll(List<PlacePreOrder> items,
			int pageNumber,
			int pageSize
			){
		
		return findAll(items,pageNumber,pageSize,null,null,true);
	}

	public int findAllCurrentPreOrder(List<PlacePreOrder> items,
			int pageNumber, int pageSize) {
		SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd"); 
		Date date=new Date();
		String hql="from PlacePreOrder e where e.date ='"+f.format(date)+"'";
		return find(hql,items,pageNumber,pageSize,null,null,true);
	}
}
