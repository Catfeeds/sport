package com.sport.dao;

import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.criterion.Restrictions;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Component;

import com.sport.entity.Manager;
import com.sport.exception.PromptException;

@Component
public class ManagerDao extends RootDao {
	public boolean save(Manager m){
		boolean re=false;
		try{
			if((Integer)hibernateTemplate.save(m)>0)
				re=true;
		}catch(DataAccessException e){
			e.printStackTrace();
			re=false;
		}
		return re;
	}
	@SuppressWarnings("unchecked")
	public Manager load(String userName) throws PromptException{
		if(userName==null)
			return null;
		List<Manager> managers=(List<Manager>)hibernateTemplate.getSessionFactory().
		getCurrentSession().
		createCriteria(Manager.class).
		add(Restrictions.eq("userName", userName)).list();
		if(managers.size()<1)
			return null;
		return managers.get(0);
	}
	@SuppressWarnings("unchecked")
	public Manager loadByWeixin(String weixin) throws PromptException{
		if(weixin==null)
			return null;
		List<Manager> managers=(List<Manager>)hibernateTemplate.getSessionFactory().
		getCurrentSession().
		createCriteria(Manager.class).
		add(Restrictions.eq("weixin", weixin)).list();
		if(managers.isEmpty())
			return null;
		return managers.get(0);
	}
	@SuppressWarnings("unchecked")
	public Manager loadByPhone(String phone) throws PromptException{
		if(phone==null)
			return null;
		List<Manager> managers=(List<Manager>)hibernateTemplate.getSessionFactory().
		getCurrentSession().
		createCriteria(Manager.class).
		add(Restrictions.eq("phone", phone)).list();
		if(managers.isEmpty())
			return null;
		return managers.get(0);
	}
	public Manager load(int id) throws PromptException{
		if(id<1)
			return null;
		Manager m=null;		
		m=(Manager)hibernateTemplate.load(Manager.class, id);
		return m;
	}
	public Manager load(Manager m) throws PromptException{
		
		Manager tm=null;
		try{
		tm=load(m.getUserName());
		if(tm==null)
			tm=loadByWeixin(m.getWeixin());
		if(tm==null)
			tm=loadByPhone(m.getPhone());
		if(tm==null)
			tm=load(m.getId());
		}catch(PromptException e){
			throw e;
		}catch(Exception e){
			e.printStackTrace();
			throw new PromptException("数据约束错误！");
		}
		return tm;
	}
	public boolean delete(Manager m) throws PromptException{
		boolean re=true;
		try{
			if((m=load(m))!=null)
				hibernateTemplate.delete(m);
			else
				re=false;
			}catch(DataAccessException e){
			re=false;
		}
		return re;
	}
	
	public boolean update(Manager m){
		boolean re=true;
		try{
			hibernateTemplate.update(m);
		}catch( DataAccessException e){
			re=false;
		}
		return re;
	}
	public  int findAll(List<Manager> managers,int companyId,
			int pageNumber,
			int pageSize,
			String groupByColumn,
			String orderByColumn,
			boolean isAsc){
		String queryString="from Manager e where e.company.id= "+companyId+" ";
		return find(queryString, managers,pageNumber,pageSize,groupByColumn,orderByColumn,isAsc);
	}
	public int findAll(List<Manager> managers,int companyId,
			int pageNumber,
			int pageSize
			){
		
		return findAll(managers,companyId,pageNumber,pageSize,null,null,true);
	}
	public boolean deleteSelectedManagers(String ids) {
		String sql="delete Manager e  where e.id in (";
		sql+=ids;
		sql+=")";
		//System.out.println(sql);
		
		Query query=hibernateTemplate.getSessionFactory().
				getCurrentSession().createQuery(sql);
		if(query.executeUpdate()>0)
			return true;
		return false;
	}
	public boolean alterManagerPassword(int id, String password) {
		String sql="update Manager e set e.password = '"+password+"' where e.id = "+id;
		Query query=hibernateTemplate.getSessionFactory().
				getCurrentSession().createQuery(sql);
		if(query.executeUpdate()>0)
			return true;
		return false;
	}
	
		public Manager loadCompanyManager(Manager m) {
			@SuppressWarnings("unchecked")
			List<Manager> managers=(List<Manager>)hibernateTemplate.getSessionFactory().
					getCurrentSession().
					createCriteria(Manager.class).
					add(Restrictions.eq("userName", m.getUserName()))
					.add(Restrictions.eq("company.id",m.getCompany().getId()))
					.list();
					if(managers.isEmpty())
						return null;
					return managers.get(0);
		}
}
