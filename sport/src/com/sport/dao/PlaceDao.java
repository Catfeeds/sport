package com.sport.dao;

import java.util.List;

import org.springframework.stereotype.Component;

import com.sport.dto.ComplexSearchCondition;
import com.sport.entity.Place;
import com.sport.entity.PlaceProduct;
import com.sport.entity.ProductType;
import com.sport.entity.Site;

@Component
public class PlaceDao extends RootDao{
	public void save(Place place){
		hibernateTemplate.save(place);
	}
	
	public Place load(int id){
		if(id<1)
			return null;
		return (Place)hibernateTemplate.load(Place.class, id);
	}
	
		
	public Place load(Place place){			
		return load(place.getId());
	}
	
	public void delete(int id){
		if(id<1)
			return ;
		delete(new Place().setId(id));
	}
	
	public void delete(Place place){
		
		hibernateTemplate.delete(place);
				
	}
	
	public void update(Place place){
		hibernateTemplate.update(place);
	}
	//分页查询
	public  int findAll(List<Place> places,
			int pageNumber,
			int pageSize,
			String groupByColumn,
			String orderByColumn,
			boolean isAsc){
		String queryString="from Place e ";
		return find(queryString, places,pageNumber,pageSize,groupByColumn,orderByColumn,isAsc);
	}
	public int findAll(List<Place> places,
			int pageNumber,
			int pageSize
			){
		
		return findAll(places,pageNumber,pageSize,null,null,true);
	}
	//简单搜索，按或查询
	public int simpleSearchedPlaces(ComplexSearchCondition condition,
			List<Place> places, int pageNumber, int pageSize) {
		StringBuffer buffer=new StringBuffer("from Place e where  ");
		if(condition.getAddress()!=null){
			buffer.append(" or e.site.address.addressName like '%"+condition.getAddress().getAddressName()+"%' ");
		}
		if(condition.getType()!=null){
			buffer.append(" or e.product.type.typeName like '%"+condition.getType().getTypeName()+"%' ");
		}
		if(condition.getProduct()!=null){
			buffer.append(" or e.product.productName like '%"+condition.getProduct().getProductName()+"%' ");
		}		
		System.out.println(buffer);
		return find(buffer.toString(),places,pageNumber,pageSize,null,null,true);
	}
	//复杂搜索，按与查询
	public int searchedPlaces(ComplexSearchCondition condition,
			List<Place> places, int pageNumber, int pageSize) {
		StringBuffer buffer=new StringBuffer("from Place e where 1=1 ");
		if(condition.getAddress()!=null){
			buffer.append(" and e.site.address.id="+condition.getAddress().getId()+"  ");
		}
		if(condition.getType()!=null){
			buffer.append(" and e.product.type.id="+condition.getType().getId()+" ");
		}
		if(condition.getProduct()!=null){
			buffer.append(" and e.product.id="+condition.getProduct().getId()+" ");
		}
		System.out.println(buffer);
		return find(buffer.toString(),places,pageNumber,pageSize,null,"placeNumber",true);
	}

	public int findAll(List<Place> places,PlaceProduct product,int pageNumber,
			int pageSize) {
		StringBuffer queryString=new StringBuffer("from Place e where 1=1");
		if(product!=null)
			queryString.append(" and e.product.id="+product.getId());
		return find(queryString.toString(), places,pageNumber,pageSize,null,"placeNumber",true);
	}
	public int findAll(List<Place> places, ProductType type, Site site,int pageNumber,
			int pageSize) {
		StringBuffer queryString=new StringBuffer("from Place e where e.product.type.id="+type.getId()+" and e.site.id="+site.getId());
		
		return find(queryString.toString(), places,pageNumber,pageSize,null,"placeNumber",true);
	}
}
