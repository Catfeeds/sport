package com.sport.dao;

import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Component;

import com.sport.entity.Product;
import com.sport.entity.Right;

@Component
public class RightDao extends RootDao{
	public void save(Right right){
		hibernateTemplate.persist(right);
	}
	
	public Right load(int id){
		if(id<1)
			return null;
		return (Right)hibernateTemplate.get(Right.class, id);
	}
	public Right load(String rightName){
		@SuppressWarnings("unchecked")
		List<Right> types=(List<Right>)hibernateTemplate.getSessionFactory()
				.getCurrentSession().createCriteria(Right.class)
				.add(Restrictions.eq("rightName", rightName)).list();
		if(types.isEmpty())
			return null;
		else
			return types.get(0);
	}		
	public Right load(Right right){	
		Right r=load(right.getRightName());
		if(r==null)
			r=load(right.getId());
		return r;
	}
	
	public void delete(int id){
		if(id<1)
			return ;
		delete(load(new Right().setId(id)));
	}
	public void delete(String rightName){
		delete(load(new Right().setRightName(rightName)));
	}
	public void delete(Right right){		
		hibernateTemplate.delete(right);				
	}
	
	public void update(Right right){
		hibernateTemplate.update(right);
	}
	//分页查询
	public  int findAll(List<Right> rights,
			int pageNumber,
			int pageSize,
			String groupByColumn,
			String orderByColumn,
			boolean isAsc){
		String queryString="from Right e ";
		return find(queryString, rights,pageNumber,pageSize,groupByColumn,orderByColumn,isAsc);
	}
	public int findAll(List<Right> rights,
			int pageNumber,
			int pageSize
			){
		
		return findAll(rights,pageNumber,pageSize,null,null,true);
	}
}
