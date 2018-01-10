package com.sport.dao;

import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Component;

import com.sport.entity.ProductType;

@Component
public class ProductTypeDao extends RootDao{

	//产品分类的增删改、获取
	public void save(ProductType type){
		hibernateTemplate.save(type);		
	}
	
	public ProductType load(int id){
		if(id<1)
			return null;
		return (ProductType)hibernateTemplate.load(ProductType.class, id);
	}
	
	public ProductType load(String typeName){
		@SuppressWarnings("unchecked")
		List<ProductType> types=(List<ProductType>)hibernateTemplate.getSessionFactory()
				.getCurrentSession().createCriteria(ProductType.class)
				.add(Restrictions.eq("typeName", typeName)).list();
		if(types.isEmpty())
			return null;
		else
			return types.get(0);
	}
	
	public ProductType load(ProductType type){
		ProductType typeTemp=null;
		if(type.getId()>0)
			typeTemp=load(type.getId());
		if(typeTemp==null||(typeTemp.getId()<1))
			typeTemp=load(type.getTypeName());
		if(typeTemp!=null)
			hibernateTemplate.evict(type);
		return typeTemp;
	}
	
	public boolean delete(String typeName){
		ProductType type=load(typeName);
		return delete(type.getId());
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
	
	public boolean delete(ProductType type){
		boolean re=true;
		if((type=load(type))!=null)
		{			
			if(type.getParentProductType()!=null)
			{
				//先解除关系再删除
				type.getParentProductType().setChildrenProductTypes(null);
				hibernateTemplate.delete(type);
				return true;
			}
			hibernateTemplate.delete(type);
		}
		else
			re=false;
		return re;
	}
	
	public void update(ProductType type){
		//先清除缓存中多余的实体
		hibernateTemplate.evict(hibernateTemplate.get(ProductType.class, type.getId()));
		
		//先解除联系再更新
		List<ProductType> list=type.getChildrenProductTypes();
		ProductType parentType=type.getParentProductType();
		type.setChildrenProductTypes(null);
		type.setParentProductType(null);
		System.out.println("此时type的值："+type.getId()+"  "+type.getTypeName() );
		hibernateTemplate.update(type);
		type.setChildrenProductTypes(list);
		type.setParentProductType(parentType);		
		//重新加载入内存
		type=hibernateTemplate.load(ProductType.class, type.getId());
	}
	//批量查询操作
	@SuppressWarnings("unchecked")
	public List<ProductType> loadRootType(){
		String queryString="from ProductType e where e.grade=0";
		return (List<ProductType>)hibernateTemplate.find(queryString);
	}
	//获取所有常见分类
	public int findAll(List<ProductType> types,
			int pageNumber, int pageSize) {		
		return findAll(types,pageNumber,pageSize,null,true);
	}

	public int findAll(List<ProductType> types, 
			int pageNumber, int pageSize, String orderByColumn, boolean isAsc) {
		String queryString="from ProductType e where e.grade=1";
		return find(queryString, types,pageNumber,pageSize,null,orderByColumn,isAsc);
	}
	public int findAll(List<ProductType> types, ProductType type,
			int pageNumber, int pageSize) {
		String queryString="from ProductType e where e.parentProductType.id="+type.getId();
		return find(queryString, types,pageNumber,pageSize,null,null,true);
	}

	public int findAll(List<ProductType> types, ProductType type,
			int pageNumber, int pageSize, String orderByColumn, boolean isAsc) {
		String queryString="from ProductType e where e.parentProductType.id="+type.getId();
		return find(queryString, types,pageNumber,pageSize,null,orderByColumn,isAsc);
	}

	public int findRootType(List<ProductType> types, int pageNumber,
			int pageSize) {
		String queryString="from ProductType e where e.grade=0";
		return find(queryString, types,pageNumber,pageSize,null,null,true);
	}
}
