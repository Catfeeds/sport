package com.sport.dao;

import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Component;

import com.sport.entity.Person;
import com.sport.exception.PromptException;

@Component
public class PersonDao extends RootDao {
	public boolean save(Person p){
		boolean re=false;
		try{
			if((Integer)hibernateTemplate.save(p)>0)
				re=true;
		}catch(DataAccessException e){
			re=false;
		}
		return re;
	}
	@SuppressWarnings("unchecked")
	public Person load(String name) throws PromptException{
		if(name==null)
			return null;
		List<Person> persons=(List<Person>)hibernateTemplate.getSessionFactory().
		getCurrentSession().
		createCriteria(Person.class).
		add(Restrictions.eq("userName", name)).list();
		if(persons==null||persons.isEmpty())
			return null;
		
		return (Person)persons.get(0);
	}
	@SuppressWarnings("unchecked")
	public Person loadByWeixin(String weixin) throws PromptException{
		if(weixin==null)
			return null;
		List<Person> persons=(List<Person>)hibernateTemplate.getSessionFactory().
		getCurrentSession().
		createCriteria(Person.class).
		add(Restrictions.eq("weixin", weixin)).list();
		if(persons==null||persons.isEmpty())
			return null;
		return (Person)persons.get(0);
	}
	@SuppressWarnings("unchecked")
	public Person loadByPhone(String phone) throws PromptException{
		if(phone==null)
			return null;
		List<Person> persons=(List<Person>)hibernateTemplate.getSessionFactory().
		getCurrentSession().
		createCriteria(Person.class).
		add(Restrictions.eq("phone", phone)).list();
		if(persons==null||persons.isEmpty())
			return null;
		return (Person)persons.get(0);
	}
	public Person load(int id){
		if(id<1)
			return null;
		Person p=null;
		p=(Person)hibernateTemplate.get(Person.class, id);
		return p;
	}
	public Person load(Person p) throws PromptException{
		Person tm=load(p.getUserName());
		if(tm==null)
			tm=loadByWeixin(p.getWeixin());
		if(tm==null)
			tm=loadByPhone(p.getPhone());
		if(tm==null)
			tm=load(p.getId());
		return tm;
	}
	public boolean delete(Person p) throws PromptException{
		boolean re=true;
		try{
			if((p=load(p))!=null)
				hibernateTemplate.delete(p);
			else
				re=false;
			}catch(DataAccessException e){
			re=false;
		}
		return re;
	}
	
	public boolean update(Person p){
		boolean re=true;
		try{
			hibernateTemplate.update(p);
		}catch( DataAccessException e){
			re=false;
		}
		return re;
	}
	public  int findAll(List<Person> persons,
			int pageNumber,
			int pageSize,
			String groupByColumn,
			String orderByColumn,
			boolean isAsc){
		String queryString="from Person e ";
		return find(queryString, persons,pageNumber,pageSize,groupByColumn,orderByColumn,isAsc);
	}
	public int findAll(List<Person> persons,
			int pageNumber,
			int pageSize
			){
		
		return findAll(persons,pageNumber,pageSize,null,null,true);
	}	
	
}
