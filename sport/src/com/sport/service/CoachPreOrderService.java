package com.sport.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.sport.dao.CoachPreOrderDao;
import com.sport.entity.CoachPreOrder;
import com.sport.exception.RootException;


@Component
public class CoachPreOrderService  extends RootService{
	private static final String ENTITY_NAME="CoachPreOrder";
	private CoachPreOrderDao coachPreOrderDao;

	public CoachPreOrderDao getCoachPreOrderDao() {
		return coachPreOrderDao;
	}
	@Resource
	public CoachPreOrderService setCoachPreOrderDao(CoachPreOrderDao coachPreOrderDao) {
		this.coachPreOrderDao = coachPreOrderDao;
		return this;
	}
	public void add(CoachPreOrder item) throws RootException{
		if(item==null)
			throw new RootException(RootException.NEED_MORE_ADD_INFO);	
		coachPreOrderDao.save(item);
	}
	
	public void delete(CoachPreOrder item) throws RootException{
		
		if(item==null||(item.getId()<=0))
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);	
		 coachPreOrderDao.delete(item);
	}
	public void delete(int id) throws RootException{		
		if(id<=0)
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);	
		 coachPreOrderDao.delete(id);
	}
	public void update(CoachPreOrder item) throws RootException{
		if(item==null||(item.getId()<=0))
			throw new RootException(RootException.NEED_MORE_UPDATE_INFO);	
		coachPreOrderDao.update(item);
	}
	
	public CoachPreOrder load(CoachPreOrder item) throws RootException{
		if(item==null)
			throw new RootException(RootException.NEED_MORE_FIND_INFO);	
		return coachPreOrderDao.load(item);			
	}
	public CoachPreOrder load(int id) throws RootException{
		if(id<=0)
			throw new RootException(RootException.NEED_MORE_FIND_INFO);	
		return coachPreOrderDao.load(id);			
	}
	
	public  int findAll(List<CoachPreOrder> items,
			int pageNumber,
			int pageSize
			){
		return coachPreOrderDao.findAll( items,pageNumber,pageSize);
	}
	//按某列排序查看会员信息
	public  int findAll(List<CoachPreOrder> items,
			int pageNumber,
			int pageSize,
			String orderByColumn,
			boolean isAsc){
		return coachPreOrderDao.findAll( items,pageNumber,pageSize,null,orderByColumn,isAsc);
	}
	public  int findAllCurrentPreOrder(List<CoachPreOrder> items,
			int pageNumber,
			int pageSize
			){
		return coachPreOrderDao.findAllCurrentPreOrder( items,pageNumber,pageSize);
	}
}
