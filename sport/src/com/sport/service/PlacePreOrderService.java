package com.sport.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.sport.dao.PlacePreOrderDao;
import com.sport.entity.PlacePreOrder;
import com.sport.exception.RootException;


@Component
public class PlacePreOrderService  extends RootService{
	private static final String ENTITY_NAME="PlacePreOrder";
	private PlacePreOrderDao placePreOrderDao;

	public PlacePreOrderDao getPlacePreOrderDao() {
		return placePreOrderDao;
	}
	@Resource
	public PlacePreOrderService setPlacePreOrderDao(PlacePreOrderDao placePreOrderDao) {
		this.placePreOrderDao = placePreOrderDao;
		return this;
	}
	public void add(PlacePreOrder item) throws RootException{
		if(item==null)
			throw new RootException(RootException.NEED_MORE_ADD_INFO);	
		placePreOrderDao.save(item);
	}
	
	public void delete(PlacePreOrder item) throws RootException{		
		if(item==null||(item.getId()<=0))
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);	
		 placePreOrderDao.delete(item);
	}
	public void delete(int id) throws RootException{		
		if(id<=0)
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);	
		 placePreOrderDao.delete(id);
	}
	public void update(PlacePreOrder item) throws RootException{
		if(item==null||(item.getId()<=0))
			throw new RootException(RootException.NEED_MORE_UPDATE_INFO);	
		placePreOrderDao.update(item);
	}
	
	public PlacePreOrder load(PlacePreOrder item) throws RootException{
		if(item==null)
			throw new RootException(RootException.NEED_MORE_FIND_INFO);	
		return placePreOrderDao.load(item);			
	}
	public PlacePreOrder load(int id) throws RootException{
		if(id<=0)
			throw new RootException(RootException.NEED_MORE_FIND_INFO);	
		return placePreOrderDao.load(id);			
	}
	
	public  int findAll(List<PlacePreOrder> items,
			int pageNumber,
			int pageSize
			){
		return placePreOrderDao.findAll( items,pageNumber,pageSize);
	}
	//按某列排序查看会员信息
	public  int findAll(List<PlacePreOrder> items,
			int pageNumber,
			int pageSize,
			String orderByColumn,
			boolean isAsc){
		return placePreOrderDao.findAll( items,pageNumber,pageSize,null,orderByColumn,isAsc);
	}
	public int findAllCurrentPreOrder(List<PlacePreOrder> items, int pageNumber,
			int pageSize) {
		return placePreOrderDao.findAllCurrentPreOrder( items,pageNumber,pageSize);
	}
}
