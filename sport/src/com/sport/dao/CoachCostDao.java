package com.sport.dao;

import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Component;

import com.sport.entity.CoachCost;

@Component
public class CoachCostDao extends RootDao{
	public void save(CoachCost cost){
		hibernateTemplate.save(cost);
	}
	
	public CoachCost load(int id){
		if(id<1)
			return null;
		return (CoachCost)hibernateTemplate.load(CoachCost.class, id);
	}
	
		
	public CoachCost load(CoachCost cost){	
		if(cost.getId()<1)
			return load(cost.getCoach().getId(),cost.getProduct().getId());
		return load(cost.getId());
	}
	@SuppressWarnings("unchecked")
	public CoachCost load(int coachId,int productId){			
		
		List<CoachCost> costs=(List<CoachCost>)hibernateTemplate.getSessionFactory().
				getCurrentSession().
				createCriteria(CoachCost.class).
				add(Restrictions.eq("coach.id", coachId))
				.add(Restrictions.eq("product.id", productId))
				.list();
				if(costs.isEmpty())
					return null;
				return (CoachCost)costs.get(0);
	}
	public void delete(int id){
		if(id<1)
			return ;
		delete(new CoachCost().setId(id));
	}
	
	public void delete(CoachCost cost){
		
		hibernateTemplate.delete(cost);
				
	}
	
	public void update(CoachCost cost){
		hibernateTemplate.update(cost);
	}
	//分页查询
	public  int findAll(List<CoachCost> costs,
			int pageNumber,
			int pageSize,
			String groupByColumn,
			String orderByColumn,
			boolean isAsc){
		String queryString="from CoachCost e ";
		return find(queryString, costs,pageNumber,pageSize,groupByColumn,orderByColumn,isAsc);
	}
	public int findAll(List<CoachCost> costs,
			int pageNumber,
			int pageSize
			){
		
		return findAll(costs,pageNumber,pageSize,null,null,true);
	}
}
