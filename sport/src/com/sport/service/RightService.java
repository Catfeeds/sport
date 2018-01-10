package com.sport.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.sport.dao.RightDao;
import com.sport.entity.Right;
import com.sport.exception.RootException;

@Component
public class RightService  extends RootService{
	private static final String ENTITY_NAME="Right";
	private RightDao rightDao;

	public RightDao getRightDao() {
		return rightDao;
	}
	@Resource
	public RightService setRightDao(RightDao rightDao) {
		this.rightDao = rightDao;
		return this;
	}
	public void add(Right right) throws RootException{
		if(right==null)
			throw new RootException(RootException.NEED_MORE_ADD_INFO);	
		rightDao.save(right);
	}
	
	public void delete(Right right) throws RootException{
		
		if(right==null||(right.getId()<=0&&
				(right.getRightName()==null||right.getRightName().trim().equals(""))))
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);	
		 rightDao.delete(right);
	}
	public void delete(int id) throws RootException{		
		if(id<=0)
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);	
		 rightDao.delete(id);
	}
	public void update(Right right) throws RootException{
		if(right==null||(right.getId()<=0&&
				(right.getRightName()==null||right.getRightName().trim().equals(""))))
			throw new RootException(RootException.NEED_MORE_UPDATE_INFO);		
		rightDao.update(right);
	}
	
	public Right load(Right right) throws RootException{
		if(right==null||(right.getId()<=0&&
				(right.getRightName()==null||right.getRightName().trim().equals(""))))
			throw new RootException(RootException.NEED_MORE_FIND_INFO);	
		return rightDao.load(right);			
	}
	public Right load(int id) throws RootException{
		if(id<=0)
			throw new RootException(RootException.NEED_MORE_FIND_INFO);	
		return rightDao.load(id);			
	}
	
	public  int findAll(List<Right> rights,
			int pageNumber,
			int pageSize
			){
		return rightDao.findAll( rights,pageNumber,pageSize);
	}
	//按某列排序查看会员信息
	public  int findAll(List<Right> rights,
			int pageNumber,
			int pageSize,
			String orderByColumn,
			boolean isAsc){
		return rightDao.findAll( rights,pageNumber,pageSize,null,orderByColumn,isAsc);
	}
}
