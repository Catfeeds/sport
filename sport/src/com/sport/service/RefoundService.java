package com.sport.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.sport.dao.RefoundDao;
import com.sport.entity.Refound;
import com.sport.exception.RootException;


@Component
public class RefoundService  extends RootService{
	private static final String ENTITY_NAME="Refound";
	private RefoundDao refoundDao;

	public RefoundDao getRefoundDao() {
		return refoundDao;
	}
	@Resource
	public RefoundService setRefoundDao(RefoundDao refoundDao) {
		this.refoundDao = refoundDao;
		return this;
	}
	public void add(Refound refound) throws RootException{
		if(refound==null)
			throw new RootException(RootException.NEED_MORE_ADD_INFO);	
		refoundDao.save(refound);
	}
	
	public void delete(Refound refound) throws RootException{
		
		if(refound==null||(refound.getId()<=0))
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);	
		 refoundDao.delete(refound);
	}
	public void delete(int id) throws RootException{		
		if(id<=0)
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);	
		 refoundDao.delete(id);
	}
	public void update(Refound refound) throws RootException{
		if(refound==null||(refound.getId()<=0))
			throw new RootException(RootException.NEED_MORE_UPDATE_INFO);	
		refoundDao.update(refound);
	}
	
	public Refound load(Refound refound) throws Exception{
		if(refound==null||(refound.getId()<=0&&(refound.getOrder()==null)))
			throw new RootException(RootException.NEED_MORE_FIND_INFO);	
		return refoundDao.load(refound);			
	}
	public Refound load(int id) throws RootException{
		if(id<=0)
			throw new RootException(RootException.NEED_MORE_FIND_INFO);	
		return refoundDao.load(id);			
	}
	public boolean deleteSelectedRefounds(String ids){
		boolean re=false;
		re=refoundDao.deleteEntitys(ENTITY_NAME, ids);
		return re;
	}
	public  int findAll(List<Refound> refounds,Refound refound,
			int pageNumber,
			int pageSize
			){
		return findAll( refounds,refound,pageNumber,pageSize,null,true);
	}
	//按某列排序查看会员信息
	public  int findAll(List<Refound> refounds,Refound refound,
			int pageNumber,
			int pageSize,
			String orderByColumn,
			boolean isAsc){
		return refoundDao.findAll( refounds,refound,pageNumber,pageSize,null,"applyTime",true);
	}
		
}
