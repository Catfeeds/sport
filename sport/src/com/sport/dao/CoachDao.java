package com.sport.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.criterion.Restrictions;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Component;

import com.sport.dto.ComplexSearchCondition;
import com.sport.entity.Coach;

@Component
public class CoachDao extends RootDao {
	public boolean save(Coach c){
		boolean re=false;
		try{
			if((Integer)hibernateTemplate.save(c)>0)
				re=true;
		}catch(DataAccessException e){
			re=false;
		}
		return re;
	}
	@SuppressWarnings("unchecked")
	public Coach load(String userName){
		if(userName==null)
			return null;
		List<Coach> coachs=(List<Coach>)hibernateTemplate.getSessionFactory().
		getCurrentSession().
		createCriteria(Coach.class).
		add(Restrictions.eq("userName", userName)).list();
		if(coachs.isEmpty())
			return null;
		return coachs.get(0);
	}
	@SuppressWarnings("unchecked")
	public Coach loadByWeixin(String weixin){
		if(weixin==null)
			return null;
		List<Coach> coachs=(List<Coach>)hibernateTemplate.getSessionFactory().
		getCurrentSession().
		createCriteria(Coach.class).
		add(Restrictions.eq("weixin", weixin)).list();
		if(coachs.isEmpty())
			return null;
		return coachs.get(0);
	}
	@SuppressWarnings("unchecked")
	public Coach loadByPhone(String phone){
		if(phone==null)
			return null;
		List<Coach> coachs=(List<Coach>)hibernateTemplate.getSessionFactory().
		getCurrentSession().
		createCriteria(Coach.class).
		add(Restrictions.eq("phone", phone)).list();
		if(coachs.isEmpty())
			return null;
		return coachs.get(0);
	}
	public Coach load(int id){
		if(id<1)
			return null;
		Coach c=null;
		c=(Coach)hibernateTemplate.load(Coach.class, id);
		return c;
	}
	public Coach load(Coach c){
		Coach tm=load(c.getUserName());
		if(tm==null)
			tm=loadByWeixin(c.getWeixin());
		if(tm==null)
			tm=loadByPhone(c.getPhone());
		if(tm==null)
			tm=load(c.getId());
		return tm;
	}
	public boolean delete(Coach c){
		boolean re=true;
		try{
			if((c=load(c))!=null)
				hibernateTemplate.delete(c);
			else
				re=false;
			}catch(DataAccessException e){
			re=false;
		}
		return re;
	}
	
	public boolean update(Coach c){
		boolean re=true;
		try{
			hibernateTemplate.update(c);
		}catch( DataAccessException e){
			re=false;
		}
		return re;
	}
	public  int findAll(List<Coach> coachs,Coach coach,
			int pageNumber,
			int pageSize,
			String groupByColumn,
			String orderByColumn,
			boolean isAsc){
		StringBuffer queryString=new StringBuffer("from Coach e where 1=1 ");
		if(coach.getId()>0){
			queryString.append(" and e.id="+coach.getId()+" ");
		}
		if(coach.getCompany()!=null){
			queryString.append(" and e.company.id="+coach.getCompany().getId()+"  ");
		}		
		if(coach.getSkillType()!=null&&(coach.getSkillType().getId()>0)){
			queryString.append(" and e.skillType.id="+coach.getSkillType().getId());
		}
		if(coach.getHomeAddress()!=null&&(coach.getHomeAddress().getId()>0)){
			queryString.append(" and (e.homeAddress.id="+coach.getHomeAddress().getId());
			queryString.append(" or e.homeAddress.parentAddress.id="+coach.getHomeAddress().getId()+")");
		}
		return find(queryString.toString(), coachs,pageNumber,pageSize,groupByColumn,"topValue",false);
	}
	public int findAll(List<Coach> coachs,Coach coach,
			int pageNumber,
			int pageSize
			){
		
		return findAll(coachs,coach,pageNumber,pageSize,null,null,true);
	}
	public  int findAll(List<Coach> coachs,
			int pageNumber,
			int pageSize,
			String groupByColumn,
			String orderByColumn,
			boolean isAsc){
		String queryString="from Coach e ";
		return find(queryString, coachs,pageNumber,pageSize,groupByColumn,orderByColumn,isAsc);
	}
	public int findAll(List<Coach> coachs,
			int pageNumber,
			int pageSize
			){
		
		return findAll(coachs,pageNumber,pageSize,null,null,true);
	}
	public boolean deleteSelectedCoachs(String ids) {
		String sql="delete Coach e  where e.id in (";
		sql+=ids;
		sql+=")";
		//System.out.println(sql);
		
		Query query=hibernateTemplate.getSessionFactory().
				getCurrentSession().createQuery(sql);
		if(query.executeUpdate()>0)
			return true;
		return false;
	}
	public boolean alterCoachPassword(int id, String password) {
		String sql="update Coach e set e.password = '"+password+"' where e.id = "+id;
		Query query=hibernateTemplate.getSessionFactory().
				getCurrentSession().createQuery(sql);
		if(query.executeUpdate()>0)
			return true;
		return false;
	}
	
		public Coach loadCompanyCoach(Coach c) {
			@SuppressWarnings("unchecked")
			List<Coach> coachs=(List<Coach>)hibernateTemplate.getSessionFactory().
					getCurrentSession().
					createCriteria(Coach.class).
					add(Restrictions.eq("userName", c.getUserName()))
					.add(Restrictions.eq("company.id",c.getCompany().getId()))
					.list();
					if(coachs.isEmpty())
						return null;
					return coachs.get(0);
		}
		public int simpleSearchedPlaceProducts(
				ComplexSearchCondition condition, List<Coach> coachs,
				int pageNumber, int pageSize) {
			StringBuffer buffer=new StringBuffer("from Coach e where  1=2 ");
			if(condition.getAddress()!=null){
				buffer.append(" or e.homeAddress.addressName like '%"+condition.getAddress().getAddressName()+"%' ");
				buffer.append(" or e.addressName like '%"+condition.getAddress().getAddressName()+"%' ");
			}
		
			if(condition.getType()!=null){
				buffer.append(" or e.skillType.typeName like '%"+condition.getType().getTypeName()+"%' ");
			}
			
			if(condition.getProduct()!=null){
				buffer.append(" or e.realName like '%"+condition.getProduct().getProductName()+"%' ");
			}	
			
			System.out.println(buffer);
			return find(buffer.toString(),coachs,pageNumber,pageSize,null,"topValue",false);
		}
		public int searchedPlaceProducts(ComplexSearchCondition condition,
				List<Coach> coachs, int pageNumber, int pageSize) {
			StringBuffer buffer=new StringBuffer("from Coach e where 1=1 ");
			if(condition.getAddress()!=null){
				buffer.append(" and e.homeAddress.id="+condition.getAddress().getId()+"  ");
			}
			if(condition.getCityAddress()!=null){
				buffer.append(" and e.homeAddress.parentAddress.id="+condition.getCityAddress().getId()+"  ");
			}
			if(condition.getType()!=null){
				buffer.append(" and e.skillType.id="+condition.getType().getId()+" ");
			}
		/*	if(condition.getProduct()!=null){
				buffer.append(" and e.id="+condition.getProduct().getId()+" ");
			}*/
			System.out.println(buffer);
			return find(buffer.toString(),coachs,pageNumber,pageSize,null,"topValue",false);
		}
}
