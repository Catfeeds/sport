package com.sport.dao;

import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Component;

import com.sport.entity.Order;
import com.sport.entity.Refound;

@Component
public class RefoundDao extends RootDao{
	public void save(Refound refound){
		hibernateTemplate.save(refound);
	}
	
	public Refound load(int id){
		if(id<1)
			return null;
		return (Refound)hibernateTemplate.load(Refound.class, id);
	}
	@SuppressWarnings("unchecked")
	public Refound load(Order order) throws Exception{
		if(order==null)
			return null;
		if(order.getId()<1)
			return null;
		try{
		List<Refound> refounds=(List<Refound>)hibernateTemplate.getSessionFactory().
		getCurrentSession().
		createCriteria(Refound.class).
		add(Restrictions.eq("order.id", order.getId())).list();
		if(refounds.isEmpty())
			return null;
		return (Refound)refounds.get(0);
		}catch(Exception e){
			e.printStackTrace();
			throw e;
		}
	}
		
	public Refound load(Refound refound) throws Exception{	
		Refound re=null;
		if(refound.getOrder()!=null)
			re=load(refound.getOrder());
		if(re!=null)
			return re;
		return load(refound.getId());
	}
	
	public void delete(int id){
		if(id<1)
			return ;
		delete(new Refound().setId(id));
	}
	
	public void delete(Refound refound){
		
		hibernateTemplate.delete(refound);
				
	}
	
	public void update(Refound refound){
		hibernateTemplate.update(refound);
	}
	//分页查询
	public  int findAll(List<Refound> acounts,Refound refound,
			int pageNumber,
			int pageSize,
			String groupByColumn,
			String orderByColumn,
			boolean isAsc){
		StringBuffer queryString=new StringBuffer("from Refound e where 1=1 ");
		if(refound.getUser()!=null){
			queryString.append(" and e.user.id="+refound.getUser().getId()+"  ");
		}
		if(refound.getOrder()!=null){
			queryString.append(" and e.order.id="+refound.getOrder().getId()+"  ");
		}
		return find(queryString.toString(), acounts,pageNumber,pageSize,groupByColumn,orderByColumn,isAsc);
	}
	
	

	public void findAll(List<Refound> acounts, Refound refound, int pageNumber,
			int pageSize) {
		
		findAll(acounts,refound,pageNumber,pageSize,null,null,true);
	}
}
