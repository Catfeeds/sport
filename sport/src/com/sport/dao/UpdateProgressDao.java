package com.sport.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;
import com.sport.entity.UpdateProgress;

@Component
public class UpdateProgressDao extends RootDao{
	public void save(UpdateProgress update){
		hibernateTemplate.persist(update);
	}
	
	public UpdateProgress load(int id){
		if(id<1)
			return null;
		return (UpdateProgress)hibernateTemplate.get(UpdateProgress.class, id);
	}
	
	public UpdateProgress load(UpdateProgress update){			
		return load(update.getId());
	}
	
	public void delete(int id){
		if(id<1)
			return ;
		delete(load(new UpdateProgress().setId(id)));
	}

	public void delete(UpdateProgress update){		
		hibernateTemplate.delete(update);				
	}
	
	public void update(UpdateProgress update){
		hibernateTemplate.update(update);
	}
	//分页查询
	public  int findAll(List<UpdateProgress> updates,
			int pageNumber,
			int pageSize,
			String groupByColumn,
			String orderByColumn,
			boolean isAsc){
		String queryString="from UpdateProgress e ";
		return find(queryString, updates,pageNumber,pageSize,groupByColumn,orderByColumn,isAsc);
	}
	public int findAll(List<UpdateProgress> updates,
			int pageNumber,
			int pageSize
			){
		
		return findAll(updates,pageNumber,pageSize,null,null,true);
	}

	public UpdateProgress load() {
		List<UpdateProgress> updates=new ArrayList<UpdateProgress>();
		findAll(updates,1,1);
		if(updates==null||updates.size()<1)
			return null;
		else
			return updates.get(0);
	}
}
