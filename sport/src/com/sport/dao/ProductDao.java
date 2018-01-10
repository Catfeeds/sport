package com.sport.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Component;

import com.sport.dto.SearchCondition;
import com.sport.entity.Company;
import com.sport.entity.Product;
import com.sport.entity.ProductType;

@Component
public class ProductDao extends RootDao {
	//产品的增删改、获取
		public void save(Product product){
			hibernateTemplate.save(product);			
		}
		
		public Product load(int id){
			if(id<1)
				return null;
			return (Product)hibernateTemplate.get(Product.class, id);
		}
		
		public Product load(String productName){
			@SuppressWarnings("unchecked")
			List<Product> types=(List<Product>)hibernateTemplate.getSessionFactory()
					.getCurrentSession().createCriteria(Product.class)
					.add(Restrictions.eq("productName", productName)).list();
			if(types.isEmpty())
				return null;
			else
				return types.get(0);
		}
		
		public Product load(Product product){
			Product typeTemp=load(product.getProductName());
			if(typeTemp==null)
				typeTemp=load(product.getId());
			return typeTemp;
		}
		
		public boolean delete(String productName){
			Product product=load(productName);
			return delete(product.getId());
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
		
		public boolean delete(Product product){
			boolean re=true;
			if((product=load(product))!=null)
			{
				hibernateTemplate.delete(product);
			}
			else
				re=false;
			return re;
		}
		
		public void update(Product product){
				hibernateTemplate.update(product);
		}
		/*************加载某公司是否有某件产品************/
		public Product loadProductInCompany(String productName,int companyId){
			@SuppressWarnings("unchecked")
			List<Product> types=(List<Product>)hibernateTemplate.getSessionFactory()
					.getCurrentSession().createCriteria(Product.class)
					.add(Restrictions.eq("productName", productName))
					.add(Restrictions.eq("company.id", companyId)).list();
			if(types.isEmpty())
				return null;
			else
				return types.get(0);
		}
		public Product loadProductInCompany(int productId,int companyId){
			@SuppressWarnings("unchecked")
			List<Product> types=(List<Product>)hibernateTemplate.getSessionFactory()
					.getCurrentSession().createCriteria(Product.class)
					.add(Restrictions.eq("id", productId))
					.add(Restrictions.eq("company.id", companyId)).list();
			if(types.isEmpty())
				return null;
			else
				return types.get(0);
		}
		public Product loadProductInCompany(Product product){
			@SuppressWarnings("unchecked")
			List<Product> types=(List<Product>)hibernateTemplate.getSessionFactory()
					.getCurrentSession().createCriteria(Product.class)
					.add(Restrictions.eq("id", product.getId()))
					.list();
			if(types.isEmpty())
				return null;
			else
				return types.get(0);
		}
		/********************产品信息的查找***********************/
		//分页查询
		//查找所有产品信息
		public  int findAll(List<Product> products,
				int pageNumber,
				int pageSize,
				String groupByColumn,
				String orderByColumn,
				boolean isAsc){
			String queryString="from Product e ";
			return find(queryString, products,pageNumber,pageSize,groupByColumn,orderByColumn,isAsc);
		}
		public int findAll(List<Product> products,
				int pageNumber,
				int pageSize
				){
			
			return findAll(products,pageNumber,pageSize,null,null,true);
		}

		public int findProductsByType(List<Product> products, ProductType type,Company company,
				int pageNumber, int pageSize) {
			String queryString="from Product e where e.company.id="+
								company.getId()+" and e.productType.id="+type.getId();
			return find(queryString, products,pageNumber,pageSize,null,null,true);			
		}

		public int findProductsByCompany(List<Product> products, Company company,
				int pageNumber, int pageSize) {
			String queryString="from Product e where e.company.id="+company.getId();
			return find(queryString, products,pageNumber,pageSize,null,null,true);
		}

		public boolean deleteSelectedProducts(String ids) {
			String sql="delete Product e  where e.id in (";
			sql+=ids;
			sql+=")";
			Query query=hibernateTemplate.getSessionFactory().
					getCurrentSession().createQuery(sql);
			if(query.executeUpdate()>0)
				return true;
			return false;
		}
		/***********************产品搜索***********************/
		public int findProducts(List<Product> products,
				int pageNumber,
				int pageSize){
			String queryString="from Product e ";
			return find(queryString, products,pageNumber,pageSize,null,"productDate",false);
		}
		public  int findProducts(List<Product> products,
				SearchCondition condition,
				int pageNumber,
				int pageSize,
				String groupByColumn,
				String orderByColumn,
				boolean isAsc){
			
			StringBuffer queryString=new StringBuffer("from Product e where ");
			if(condition.isFlag()){//简单模糊搜索	
				//搜索所有产品
				queryString.append("e.company.companyName like '%"+condition.getSimpleInfo()+"%' or ")
						.append("e.productType.typeName like '%"+condition.getSimpleInfo()+"%' or ")
						.append("e.productName like '%"+condition.getSimpleInfo()+"%' or ")
						.append("e.introduction like '%"+condition.getSimpleInfo()+"%' ");
			}else{//复杂精确搜索
				if(condition.isHasCompanyName()){					
					queryString.append(" e.company.companyName like '%"+condition.getCompany().getCompanyName()+"%'  ");
					
				}else{//保证条件语句后面有至少一个值true
					queryString.append(" 1=1 ");
				}
				if(condition.isHasPriceRange()){
					queryString.append(" and e.normalPrice >= "+condition.getMinPrice()+" and e.normalPrice <= "+condition.getMaxPrice()+"  ");
				}
				if(condition.isHasProductName()){
					queryString.append(" and ( 1=1 and ");
					queryString.append(" e.productName like '%"+condition.getProduct().getProductName()+"%'  ");
					queryString.append(" or e.introduction like '%"+condition.getProduct().getProductName()+"%'  ");
					queryString.append(" ) "); 
				}
				if(condition.isChooseSearchFlag()){//如果是选择页面传递过来的参数
					if(condition.isHasTypeName()){
						if(condition.getType()!=null){
							queryString.append(" and ( 1=1 and ");
							queryString.append("  e.productType.typeName like '%"+condition.getType().getTypeName()+"%' ");
							queryString.append(" or e.productType.introduction like '%"+condition.getType().getTypeName()+"%' ");
							queryString.append(" ) "); 
						}else if(condition.getParentType()!=null){
							queryString.append(" and ( 1=1 and ");
							queryString.append("  e.productType.parentProductType.typeName like '%"+condition.getParentType().getTypeName()+"%' ");
							queryString.append(" or e.productType.parentProductType.introduction like '%"+condition.getParentType().getTypeName()+"%' ");
							queryString.append(" ) "); 
						}else if(condition.getRootType()!=null){
							queryString.append(" and ( 1=1 and ");
							queryString.append("  e.productType.parentProductType.parentProductType.typeName like '%"+condition.getRootType().getTypeName()+"%' ");
							queryString.append(" or e.productType.parentProductType.parentProductType.introduction like '%"+condition.getRootType().getTypeName()+"%' ");
							queryString.append(" ) "); 
						}					
					}
				}else{//否则
					if(condition.isHasTypeName()){
						queryString.append(" and ( 1=1 and ");
						if(condition.getType()!=null){
							queryString.append("  e.productType.typeName like '%"+condition.getType().getTypeName()+"%' ");		
							queryString.append(" or e.productType.introduction like '%"+condition.getType().getTypeName()+"%' ");
							queryString.append(" or e.productType.parentProductType.typeName like '%"+condition.getType().getTypeName()+"%' ");	
							queryString.append(" or e.productType.parentProductType.introduction like '%"+condition.getType().getTypeName()+"%' ");	
							queryString.append(" or e.productType.parentProductType.parentProductType.typeName like '%"+condition.getType().getTypeName()+"%' ");
							queryString.append(" or e.productType.parentProductType.parentProductType.introduction like '%"+condition.getType().getTypeName()+"%' ");
						}	
						queryString.append(" ) ");
					}
				}
			}
			System.out.println(queryString);
			return find(queryString.toString(), products,pageNumber,pageSize,groupByColumn,orderByColumn,isAsc);
		}
		public int findProducts(List<Product> products,
				SearchCondition condition,
				int pageNumber,
				int pageSize
				){
			System.out.println("columnName:"+condition.getSortColumnName());
			if(condition.isSortSearchFlag())
				return findProducts(products,condition,pageNumber,pageSize,null,condition.getSortColumnName(),true);
			else
				return findProducts(products,condition,pageNumber,pageSize,null,null,true);
		}

		public List<Product> findFavorProducts() {
			String queryString="from Product e ";
			List<Product> products=new ArrayList<Product>();
			find(queryString, products,1,40,null,"totalSoldNumber",true);
			return products;
		}

}
