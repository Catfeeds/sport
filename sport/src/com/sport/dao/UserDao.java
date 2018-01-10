package com.sport.dao;

import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Component;

import com.sport.entity.User;
import com.sport.exception.PromptException;

@Component
public class UserDao extends RootDao {
	public boolean save(User u){
		boolean re=false;
		try{
			if((Integer)hibernateTemplate.save(u)>0)
				re=true;
		}catch(Exception e){
			e.printStackTrace();
			re=false;
		}
		
		return re;
	}
	@SuppressWarnings("unchecked")
	public User load(String name) throws PromptException{
		if(name==null)
			return null;
		List<User> users=hibernateTemplate.getSessionFactory().
		getCurrentSession().
		createCriteria(User.class).
		add(Restrictions.eq("userName", name)).list();
		if(users.isEmpty())
			return null;
		return users.get(0);
	}
	@SuppressWarnings("unchecked")
	public User loadByWeixin(String weixin) throws PromptException{
		if(weixin==null)
			return null;
		List<User> users=hibernateTemplate.getSessionFactory().
		getCurrentSession().
		createCriteria(User.class).
		add(Restrictions.eq("weixin", weixin)).list();
		if(users.isEmpty())
			return null;
		return users.get(0);
	}
	@SuppressWarnings("unchecked")
	public User loadByPhone(String phone) throws PromptException{
		if(phone==null)
			return null;
		List<User> users=hibernateTemplate.getSessionFactory().
		getCurrentSession().
		createCriteria(User.class).
		add(Restrictions.eq("phone", phone)).list();
		if(users.isEmpty())
			return null;
		return users.get(0);
	}
	public User load(int id){
		if(id<1)
			return null;
		User u=null;
		u=hibernateTemplate.get(User.class, id);
		return u;
	}
	public User load(User u) throws PromptException{
		User tm=load(u.getUserName());
		if(tm==null)
			tm=loadByWeixin(u.getWeixin());
		if(tm==null)
			tm=loadByPhone(u.getPhone());
		if(tm==null)
			tm=load(u.getId());
		return tm;
	}
	public boolean delete(User u) throws PromptException{
		boolean re=true;
		try{
			if((u=load(u))!=null)
				hibernateTemplate.delete(u);
			else
				re=false;
			}catch(DataAccessException e){
			re=false;
		}
		return re;
	}
	
	public boolean update(User u){
		boolean re=true;
		try{
			hibernateTemplate.update(u);
		}catch( DataAccessException e){
			re=false;
		}
		return re;
	}
	public  int findAll(List<User> users,
			int pageNumber,
			int pageSize,
			String groupByColumn,
			String orderByColumn,
			boolean isAsc){
		String queryString="from User e ";
		return find(queryString, users,pageNumber,pageSize,groupByColumn,orderByColumn,isAsc);
	}
	public int findAll(List<User> users,
			int pageNumber,
			int pageSize
			){
		
		return findAll(users,pageNumber,pageSize,null,null,true);
	}	
	
}
