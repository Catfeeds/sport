package com.sport.dao;

import java.util.List;

import org.springframework.stereotype.Component;

import com.sport.entity.Company;
import com.sport.entity.Site;

@Component
public class SiteDao extends RootDao{
	public void save(Site site){
		hibernateTemplate.save(site);
	}
	
	public Site load(long id){
		if(id<1)
			return null;
		return (Site)hibernateTemplate.load(Site.class, id);
	}
	
		
	public Site load(Site site){			
		return load(site.getId());
	}
	
	public void delete(int id){
		if(id<1)
			return ;
		delete((Site)new Site().setId(id));
	}
	
	public void delete(Site site){
		
		hibernateTemplate.delete(site);
				
	}
	
	public void update(Site site){
		hibernateTemplate.update(site);
	}
	public  int findAll(List<Site> sites,Site site,
			int pageNumber,
			int pageSize){
		return findAll(sites,site,pageNumber,pageSize,null,null,true);
	}
	//分页查询
	public  int findAll(List<Site> sites,Site site,
			int pageNumber,
			int pageSize,
			String groupByColumn,
			String orderByColumn,
			boolean isAsc){
		StringBuffer queryString=new StringBuffer("from Site e where 1=1");
		if(site.getId()>0){
			queryString.append(" and e.id="+site.getId());
		}
		if(site.getCompany()!=null&&(site.getCompany().getId()>0)){
			queryString.append(" and e.company.id="+site.getCompany().getId());
		}
		if(site.getAddress()!=null&&(site.getAddress().getId()>0)){
			queryString.append(" and (e.address.id="+site.getAddress().getId());
			queryString.append(" or e.address.parentAddress.id="+site.getAddress().getId()+")");
		}
		return find(queryString.toString(), sites,pageNumber,pageSize,groupByColumn,orderByColumn,isAsc);
	}

}
