package com.sport.dao;

import java.util.List;

import org.springframework.stereotype.Component;

import com.sport.dto.ComplexSearchCondition;
import com.sport.entity.PlaceProduct;
import com.sport.entity.ProductType;
import com.sport.entity.Site;

@Component
public class PlaceProductDao extends RootDao{
	public void save(PlaceProduct product){
		hibernateTemplate.save(product);
	}
	
	public PlaceProduct load(int id){
		if(id<1)
			return null;
		return (PlaceProduct)hibernateTemplate.load(PlaceProduct.class, id);
	}
	
		
	public PlaceProduct load(PlaceProduct product){			
		return load(product.getId());
	}
	
	public void delete(int id){
		if(id<1)
			return ;
		delete((PlaceProduct)new PlaceProduct().setId(id));
	}
	
	public void delete(PlaceProduct product){
		
		hibernateTemplate.delete(product);
				
	}
	
	public void update(PlaceProduct product){
		hibernateTemplate.update(product);
	}
	//分页查询
	public  int findAll(List<PlaceProduct> products,PlaceProduct product,
			int pageNumber,
			int pageSize,
			String groupByColumn,
			String orderByColumn,
			boolean isAsc){
		StringBuffer queryString=new StringBuffer("from PlaceProduct e where 1=1 ");
		if(product.isHasBargin())
			queryString.append(" and e.hasBargin=1");
		if(product.isHasTop())
			queryString.append(" and e.hasTop=1");
		if(product.isHasBegin())
			queryString.append(" and e.hasBegin=1");
		if(product.getCompany()!=null){
			queryString.append(" and e.company.id="+product.getCompany().getId());
		}
		if(product.getType()!=null){
			queryString.append(" and e.type.id="+product.getType().getId());
		}
		return find(queryString.toString(), products,pageNumber,pageSize,groupByColumn,orderByColumn,isAsc);
	}
	

	public void getProductsByType(List<PlaceProduct> products, Site site, ProductType type) {
		String queryString="from PlaceProduct e where e.type.id="+type.getId()+"and e.site.id="+site.getId();
		find(queryString, products,1,20,null,null,true);
	}

	public int simpleSearchedPlaceProducts(ComplexSearchCondition condition,
			List<PlaceProduct> products, int pageNumber, int pageSize) {
		StringBuffer buffer=new StringBuffer("from PlaceProduct e where e.hasBegin=1 and ( 1=2 ");
		if(condition.getAddress()!=null){
			buffer.append(" or e.site.address.addressName like '%"+condition.getAddress().getAddressName()+"%' ");
			buffer.append(" or e.site.siteAddress like '%"+condition.getAddress().getAddressName()+"%' ");
		}
	
		if(condition.getType()!=null){
			buffer.append(" or e.type.typeName like '%"+condition.getType().getTypeName()+"%' ");
		}
		if(condition.getProduct()!=null){
			buffer.append(" or e.productName like '%"+condition.getProduct().getProductName()+"%' ");
		}	
		buffer.append(" ) ");
		System.out.println(buffer);
		return find(buffer.toString(),products,pageNumber,pageSize,null,"site.topValue",false);
	}

	public int searchedPlaceProducts(ComplexSearchCondition condition,
			List<PlaceProduct> products, int pageNumber, int pageSize) {
		StringBuffer buffer=new StringBuffer("from PlaceProduct e where e.hasBegin="+1+" ");
		if(condition.getAddress()!=null){
			buffer.append(" and e.site.address.id="+condition.getAddress().getId()+"  ");
		}
		if(condition.getCityAddress()!=null){
			buffer.append(" and e.site.address.parentAddress.id="+condition.getCityAddress().getId()+"  ");
		}
		if(condition.getType()!=null){
			buffer.append(" and e.type.id="+condition.getType().getId()+" ");
		}
		if(condition.getProduct()!=null){
			buffer.append(" and e.id="+condition.getProduct().getId()+" ");
		}
		System.out.println(buffer);
		return find(buffer.toString(),products,pageNumber,pageSize,null,"site.topValue",false);
	}


}
