package com.sport.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.sport.dao.DiscountDao;
import com.sport.entity.Discount;
import com.sport.exception.RootException;


@Component
public class DiscountService  extends RootService{
	private static final String ENTITY_NAME="Discount";
	private DiscountDao discountDao;

	public DiscountDao getDiscountDao() {
		return discountDao;
	}
	@Resource
	public DiscountService setDiscountDao(DiscountDao discountDao) {
		this.discountDao = discountDao;
		return this;
	}
	public void add(Discount discount) throws RootException{
		if(discount==null)
			throw new RootException(RootException.NEED_MORE_ADD_INFO);	
		discountDao.save(discount);
	}
	
	public void delete(Discount discount) throws RootException{
		
		if(discount==null||(discount.getId()<=0))
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);	
		 discountDao.delete(discount);
	}
	public void delete(int id) throws RootException{		
		if(id<=0)
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);	
		 discountDao.delete(id);
	}
	public void update(Discount d) throws RootException{
		if(d==null||(d.getId()<=0))
			throw new RootException(RootException.NEED_MORE_UPDATE_INFO);	
		Discount discount=discountDao.load(d);
		discount.setCoach(d.getCoach())
				.setDetail(d.getDetail())
				.setIntroduction(d.getIntroduction())
				.setTitle(d.getTitle())
				.setSite(d.getSite())
				.setType(d.getType());
		if(d.getPreViewImg()!=null)
			discount.setPreViewImg(d.getPreViewImg());
		discountDao.update(discount);
	}
	
	public Discount load(Discount discount) throws RootException{
		if(discount==null||(discount.getId()<=0))
			throw new RootException(RootException.NEED_MORE_FIND_INFO);	
		return discountDao.load(discount);			
	}
	public Discount load(int id) throws RootException{
		if(id<=0)
			throw new RootException(RootException.NEED_MORE_FIND_INFO);	
		return discountDao.load(id);			
	}
	public boolean deleteSelectedDiscounts(String ids){
		boolean re=false;
		re=discountDao.deleteEntitys(ENTITY_NAME, ids);
		return re;
	}
	public  int findAll(List<Discount> discounts,Discount discount,
			int pageNumber,
			int pageSize
			){
		return findAll( discounts,discount,pageNumber,pageSize,null,true);
	}
	//按某列排序查看会员信息
	public  int findAll(List<Discount> discounts,Discount discount,
			int pageNumber,
			int pageSize,
			String orderByColumn,
			boolean isAsc){
		return discountDao.findAll( discounts,discount,pageNumber,pageSize,null,orderByColumn,isAsc);
	}
		
}
