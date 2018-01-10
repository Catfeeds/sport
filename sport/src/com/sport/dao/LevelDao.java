package com.sport.dao;

import java.util.List;

import org.springframework.stereotype.Component;

import com.sport.entity.Level;
import com.sport.entity.ProductType;

@Component
public class LevelDao extends RootDao{
	public void save(Level level){
		hibernateTemplate.save(level);
	}
	
	public Level load(int id){
		if(id<1)
			return null;
		return (Level)hibernateTemplate.load(Level.class, id);
	}
	
		
	public Level load(Level level){			
		return load(level.getId());
	}
	
	public void delete(int id){
		if(id<1)
			return ;
		delete(new Level().setId(id));
	}
	
	public void delete(Level level){
		
		hibernateTemplate.delete(level);
				
	}
	
	public void update(Level level){
		hibernateTemplate.update(level);
	}
	//分页查询
	public  int findAll(List<Level> levels,
			int pageNumber,
			int pageSize,
			String groupByColumn,
			String orderByColumn,
			boolean isAsc){
		String queryString="from Level e ";
		return find(queryString, levels,pageNumber,pageSize,groupByColumn,orderByColumn,isAsc);
	}
	public int findAll(List<Level> levels,
			int pageNumber,
			int pageSize
			){
		
		return findAll(levels,pageNumber,pageSize,null,null,true);
	}

	public void findAll(List<Level> levels, Level level, int pageNumber,
			int pageSize) {
		String queryString="from Level e where e.type.id="+level.getType().getId()+" and e.flag="+level.getFlag();
		find(queryString, levels,pageNumber,pageSize,null,null,true);
	}
}
