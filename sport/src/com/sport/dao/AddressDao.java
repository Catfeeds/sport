package com.sport.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Component;

import com.sport.entity.Address;

@Component
public class AddressDao extends RootDao{

	//产品分类的增删改、获取
	public void save(Address addr){
		hibernateTemplate.save(addr);		
	}
	
	public Address load(int id){
		if(id<1)
			return null;
		return (Address)hibernateTemplate.load(Address.class, id);
	}
	
	public Address load(Address addr){
		Address typeTemp=null;
		if(addr.getId()>0)
			typeTemp=load(addr.getId());
		if(typeTemp!=null)
			hibernateTemplate.evict(addr);
		return typeTemp;
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
	
	public boolean delete(Address addr){
		boolean re=true;
		if((addr=load(addr))!=null)
		{			
			if(addr.getParentAddress()!=null)
			{
				//先解除关系再删除
				addr.getParentAddress().setChildrenAddress(null);
				hibernateTemplate.delete(addr);
				return true;
			}
			hibernateTemplate.delete(addr);
		}
		else
			re=false;
		return re;
	}
	
	public void update(Address addr){
		//先清除缓存中多余的实体
		hibernateTemplate.evict(hibernateTemplate.get(Address.class, addr.getId()));		
		//先解除联系再更新
		List<Address> list=addr.getChildrenAddress();
		Address parentAddr=addr.getParentAddress();
		addr.setChildrenAddress(null);
		addr.setParentAddress(null);
		System.out.println("此时type的值："+addr.getId()+"  "+addr.getAddressName() );
		hibernateTemplate.update(addr);
		addr.setChildrenAddress(list);
		addr.setParentAddress(parentAddr);		
		//重新加载入内存
		addr=hibernateTemplate.load(Address.class, addr.getId());
	}
	//批量查询操作
	@SuppressWarnings("unchecked")
	public List<Address> loadRootAddress(){
		String queryString="from Address e where e.grade=0";
		return (List<Address>)hibernateTemplate.find(queryString);
	}

	public int findAll(List<Address> addrs, Address addr,
			int pageNumber, int pageSize) {
		String queryString="from Address e where e.parentAddress.id="+addr.getId();
		return find(queryString, addrs,pageNumber,pageSize,null,null,true);
	}

	public int findAll(List<Address> addrs, Address addr,
			int pageNumber, int pageSize, String orderByColumn, boolean isAsc) {
		String queryString="from Address e where e.parentAddress.id="+addr.getId();
		return find(queryString, addrs,pageNumber,pageSize,null,orderByColumn,isAsc);
	}

	public int findRootAddrs(List<Address> addrs, int pageNumber,
			int pageSize) {
		String queryString="from Address e where e.grade=0";
		return find(queryString, addrs,pageNumber,pageSize,null,null,true);
	}

	public List<Address> findCityAddress() {
		String queryString="from Address e where e.grade=1";
		List<Address> addrs=new ArrayList<Address>();
		find(queryString, addrs,1,100,null,null,true);
		return addrs;
	}
}
