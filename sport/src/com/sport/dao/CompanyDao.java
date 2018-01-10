package com.sport.dao;

import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Component;

import com.sport.entity.Company;

@Component
public class CompanyDao extends RootDao {
	//产品的增删改、获取
		public void save(Company company){
			hibernateTemplate.save(company);
		}
		
		public Company load(int id){
			if(id<1)
				return null;
			return (Company)hibernateTemplate.get(Company.class, id);
		}
		
		public Company load(Company company){		
				
			return load(company.getId());
		}
		
		@SuppressWarnings("unchecked")
		public Company getOwnerCompany() {
			String sql="from Company e where e.host="+1;
			List<Company> companys=(List<Company>)hibernateTemplate.find(sql);
			if(companys==null||companys.size()<1)
				return null;
			else
				return companys.get(0);
		}
				
		public boolean delete(int id){
			if(id<1)
				return false;
			boolean re=true;
			if(load(id)!=null)
				hibernateTemplate.delete(load(id));
			else
				re=false;		
			return re;
		}
		
		public boolean delete(Company company){
			boolean re=true;
			if((company=load(company))!=null)
			{
				hibernateTemplate.delete(company);
			}
			else
				re=false;
			return re;
		}
		
		public void update(Company company){
				hibernateTemplate.update(company);
		}
		/********************产品信息的查找***********************/
		//分页查询
		//查找所有产品信息
		public  int findAll(List<Company> companys,Company company,
				int pageNumber,
				int pageSize,
				String groupByColumn,
				String orderByColumn,
				boolean isAsc){
			StringBuffer queryString=new StringBuffer("from Company e where 1=1 ");
			if(company!=null){
				if(company.getId()>0){
					queryString.append(" and e.id="+company.getId());
				}
				if(company.getAddress()!=null&&(company.getAddress().getId()>0)){
					queryString.append(" and (e.address.id="+company.getAddress().getId()+" ");
					queryString.append(" or e.address.parentAddress.id="+company.getAddress().getId()+") ");
				}
				if(company.getPhone()!=null){
					queryString.append(" and e.phone='"+company.getPhone()+"' ");
				}
				if(company.getCompanyName()!=null){
					queryString.append(" and e.companyName='"+company.getCompanyName()+"' ");
				}
				
			}
			return find(queryString.toString(), companys,pageNumber,pageSize,groupByColumn,orderByColumn,isAsc);
		}
		public int findAll(List<Company> companys,Company company,
				int pageNumber,
				int pageSize
				){
			
			return findAll(companys,company,pageNumber,pageSize,null,null,true);
		}

		public int findCompanys(List<Company> companys, Company company,
				int pageNumber, int pageSize) {
			StringBuffer queryString=new StringBuffer("from Company e where ");
					queryString.append("e.companyName like '%"+company.getCompanyName()+"%' ")
								.append(" or e.introduction like '%"+company.getIntroduction()+"%'  ")
								.append(" or e.companyUrl like '%"+company.getCompanyUrl()+"%' ")
								.append(" or e.phone like '%"+company.getPhone()+"%' ")
								.append(" or e.email like '%" +company.getEmail()+"%' ")
								.append(" or e.address like '%"+company.getAddress()+"%' ");
					
			return find(queryString.toString(), companys,pageNumber,pageSize,null,null,true);
		}

		
}
