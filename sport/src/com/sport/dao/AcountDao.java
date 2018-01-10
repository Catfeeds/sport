package com.sport.dao;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Component;

import com.sport.entity.Acount;
import com.sport.entity.ProductType;
import com.sport.entity.User;
import com.sport.exception.PromptException;
import com.sport.util.DateFormatUtil;

@Component
public class AcountDao extends RootDao{
	private SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd");
	public void save(Acount acount){
		hibernateTemplate.save(acount);
	}
	
	public Acount load(int id){
		if(id<1)
			return null;
		return (Acount)hibernateTemplate.load(Acount.class, id);
	}
	//获取某条教练某个时间段的账单
	@SuppressWarnings("unchecked")
	public Acount loadCoachAcount(int coachId,Date beginDate,Date endDate) throws PromptException{
		List<Acount> acounts=(List<Acount>)hibernateTemplate.getSessionFactory().
		getCurrentSession().
		createCriteria(Acount.class).
		add(Restrictions.eq("coach.id", coachId))
		.add(Restrictions.eq("beginDate", DateFormatUtil.formatDay(beginDate)))
		.add(Restrictions.eq("endDate", DateFormatUtil.formatDay(endDate)))
		.list();
		if(acounts.isEmpty())
			return null;
		return (Acount)acounts.get(0);
	}
	//获取某条场馆某个时间段的账单
		@SuppressWarnings("unchecked")
		public Acount loadSiteAcount(long siteId,Date beginDate,Date endDate) throws PromptException{
			List<Acount> acounts=(List<Acount>)hibernateTemplate.getSessionFactory().
			getCurrentSession().
			createCriteria(Acount.class).
			add(Restrictions.eq("site.id", siteId))
			.add(Restrictions.eq("beginDate", DateFormatUtil.formatDay(beginDate)))
			.add(Restrictions.eq("endDate", DateFormatUtil.formatDay(endDate)))
			.list();
			if(acounts.isEmpty())
				return null;
			return (Acount)acounts.get(0);
		}
		//获取某个公司某个时间段的账单
		@SuppressWarnings("unchecked")
		public Acount loadCompanyAcount(int companyId,Date beginDate,Date endDate) throws PromptException{
			List<Acount> acounts=(List<Acount>)hibernateTemplate.getSessionFactory().
			getCurrentSession().
			createCriteria(Acount.class).
			add(Restrictions.eq("company.id", companyId))
			.add(Restrictions.eq("beginDate", DateFormatUtil.formatDay(beginDate)))
			.add(Restrictions.eq("endDate", DateFormatUtil.formatDay(endDate)))
			.list();
			if(acounts.isEmpty())
				return null;
			return (Acount)acounts.get(0);
		}
	public Acount load(Acount acount) throws PromptException{	
		if(acount.getAcountType()==Acount.TYPE_COACH)
			return loadCoachAcount(acount.getCoach().getId(),acount.getBeginDate(),acount.getEndDate());
		else if(acount.getAcountType()==Acount.TYPE_SITE)
			return loadSiteAcount(acount.getSite().getId(),acount.getBeginDate(),acount.getEndDate());
		else if(acount.getAcountType()==Acount.TYPE_COMPANY)
			return loadCompanyAcount(acount.getCompany().getId(),acount.getBeginDate(),acount.getEndDate());
		return load(acount.getId());
	}
	
	public void delete(int id){
		if(id<1)
			return ;
		delete(new Acount().setId(id));
	}
	
	public void delete(Acount acount){
		
		hibernateTemplate.delete(acount);
				
	}
	
	public void update(Acount acount){
		hibernateTemplate.update(acount);
	}
	//分页查询
	public  int findAll(List<Acount> acounts,Acount acount,
			int pageNumber,
			int pageSize,
			String groupByColumn,
			String orderByColumn,
			boolean isAsc){
		
		StringBuffer queryString=new StringBuffer("from Acount e where 1=1 ");
		if(acount!=null){
			if(acount.getCoach()!=null){
				queryString.append(" and e.coach.id="+acount.getCoach().getId()+"  ");
			}
			if(acount.getCompany()!=null){
				queryString.append(" and e.company.id="+acount.getCompany().getId()+"  ");
			}
			if(acount.getSite()!=null){
				queryString.append(" and e.site.id="+acount.getSite().getId()+"  ");
			}
			if(acount.getStatus()>0){
				queryString.append(" and e.status="+acount.getStatus()+"  ");
			}
			if(acount.getAcountBeginDate()!=null&&(acount.getAcountEndDate()!=null)){
				queryString.append(" and e.payedDate<'"+DateFormatUtil.formatDay(acount.getAcountEndDate())+"' and e.payedDate> '"+
									DateFormatUtil.formatDay(acount.getAcountBeginDate())+"' ");
			}else if(acount.getAcountBeginDate()!=null){
				queryString.append(" and e.payedDate>'"+DateFormatUtil.formatDay(acount.getAcountBeginDate())+"'  ");
			}else if(acount.getAcountEndDate()!=null){
				queryString.append(" and e.payedDate<'"+DateFormatUtil.formatDay(acount.getAcountEndDate())+"'");
			}
		}
		return find(queryString.toString(), acounts,pageNumber,pageSize,groupByColumn,orderByColumn,isAsc);
	}
	
	

	public void findAll(List<Acount> acounts, Acount acount, int pageNumber,
			int pageSize) {
		
		findAll(acounts,acount,pageNumber,pageSize,null,null,true);
	}
	//查找某教练、场馆、公司最近的订单结算时间
	public Acount findLastAcount(Acount acount){
		StringBuffer queryString=new StringBuffer("from Acount e where 1=1 ");
		if(acount!=null){
			if(acount.getCoach()!=null){
				queryString.append(" and e.coach.id="+acount.getCoach().getId()+"  ");
			}
			if(acount.getCompany()!=null){
				queryString.append(" and e.company.id="+acount.getCompany().getId()+"  ");
			}
			if(acount.getSite()!=null){
				queryString.append(" and e.site.id="+acount.getSite().getId()+"  ");
			}			
			queryString.append(" and e.status="+Acount.PAYED+"  ");//数据库中全是已经结算的账单
			
		}
		List<Acount> acounts=new ArrayList<Acount>();
		 find(queryString.toString(), acounts,1,50,null,"endDate",false);
		 if(acounts==null)
			 return null;
		 if(acounts.size()<1)
			 return null;
		 return acounts.get(0);
	}
}
