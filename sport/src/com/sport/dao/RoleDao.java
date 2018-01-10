package com.sport.dao;

import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Component;

import com.sport.entity.Role;

@Component
public class RoleDao extends RootDao{
	public void save(Role role){
		hibernateTemplate.persist(role);
	}
	
	public Role load(int id){
		if(id<1)
			return null;
		return (Role)hibernateTemplate.get(Role.class, id);
	}
	public Role load(String name){
		@SuppressWarnings("unchecked")
		List<Role> types=(List<Role>)hibernateTemplate.getSessionFactory()
				.getCurrentSession().createCriteria(Role.class)
				.add(Restrictions.eq("name", name)).list();
		if(types.isEmpty())
			return null;
		else
			return types.get(0);
	}		
	public Role load(Role role){	
		Role r=load(role.getName());
		if(r==null)
			r=load(role.getId());
		return r;
	}
	
	public void delete(int id){
		if(id<1)
			return ;
		delete(load(new Role().setId(id)));
	}
	public void delete(String name){
		delete(load(new Role().setName(name)));
	}
	public void delete(Role role){		
		hibernateTemplate.delete(role);				
	}
	
	public void update(Role role){
		hibernateTemplate.update(role);
	}
	//分页查询
	public  int findAll(List<Role> roles,
			int pageNumber,
			int pageSize,
			String groupByColumn,
			String orderByColumn,
			boolean isAsc){
		String queryString="from Role e ";
		return find(queryString, roles,pageNumber,pageSize,groupByColumn,orderByColumn,isAsc);
	}
	public int findAll(List<Role> roles,
			int pageNumber,
			int pageSize
			){
		
		return findAll(roles,pageNumber,pageSize,null,null,true);
	}
}
