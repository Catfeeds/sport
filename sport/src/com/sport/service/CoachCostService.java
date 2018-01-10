package com.sport.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.sport.dao.CoachCostDao;
import com.sport.entity.CoachCost;
import com.sport.exception.RootException;


@Component
public class CoachCostService  extends RootService{
	private static final String ENTITY_NAME="CoachCost";
	private CoachCostDao coachCostDao;

	public CoachCostDao getCoachCostDao() {
		return coachCostDao;
	}
	@Resource
	public CoachCostService setCoachCostDao(CoachCostDao coachCostDao) {
		this.coachCostDao = coachCostDao;
		return this;
	}
	public void add(CoachCost cost) throws RootException{
		if(cost==null)
			throw new RootException(RootException.NEED_MORE_ADD_INFO);	
		coachCostDao.save(cost);
	}
	
	public void delete(CoachCost cost) throws RootException{
		
		if(cost==null||(cost.getId()<=0))
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);	
		 coachCostDao.delete(cost);
	}
	public void delete(int id) throws RootException{		
		if(id<=0)
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);	
		 coachCostDao.delete(id);
	}
	public void update(CoachCost cost) throws RootException{
		if(cost==null||(cost.getId()<=0))
			throw new RootException(RootException.NEED_MORE_UPDATE_INFO);	
		coachCostDao.update(cost);
	}
	
	public CoachCost load(CoachCost cost) throws RootException{
		if(cost==null)
			throw new RootException(RootException.NEED_MORE_FIND_INFO);	
		return coachCostDao.load(cost);			
	}
	public CoachCost load(int id) throws RootException{
		if(id<=0)
			throw new RootException(RootException.NEED_MORE_FIND_INFO);	
		return coachCostDao.load(id);			
	}
	
	public  int findAll(List<CoachCost> costs,
			int pageNumber,
			int pageSize
			){
		return coachCostDao.findAll( costs,pageNumber,pageSize);
	}
	//按某列排序查看会员信息
	public  int findAll(List<CoachCost> costs,
			int pageNumber,
			int pageSize,
			String orderByColumn,
			boolean isAsc){
		return coachCostDao.findAll( costs,pageNumber,pageSize,null,orderByColumn,isAsc);
	}
	//删除教练的多个收费标准
	public boolean deleteSelectedCosts(String ids){
		return coachCostDao.deleteEntitys(ENTITY_NAME, ids);
	}
}
