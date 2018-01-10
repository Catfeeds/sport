package com.sport.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.sport.dao.LevelDao;
import com.sport.entity.Level;
import com.sport.exception.RootException;


@Component
public class LevelService  extends RootService{
	private static final String ENTITY_NAME="Level";
	private LevelDao levelDao;

	public LevelDao getLevelDao() {
		return levelDao;
	}
	@Resource
	public LevelService setLevelDao(LevelDao levelDao) {
		this.levelDao = levelDao;
		return this;
	}
	public void add(Level level) throws RootException{
		if(level==null)
			throw new RootException(RootException.NEED_MORE_ADD_INFO);	
		levelDao.save(level);
	}
	
	public void delete(Level level) throws RootException{
		
		if(level==null||(level.getId()<=0))
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);	
		 levelDao.delete(level);
	}
	public void delete(int id) throws RootException{		
		if(id<=0)
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);	
		 levelDao.delete(id);
	}
	public void update(Level level) throws RootException{
		if(level==null||(level.getId()<=0))
			throw new RootException(RootException.NEED_MORE_UPDATE_INFO);	
		levelDao.update(level);
	}
	
	public Level load(Level level) throws RootException{
		if(level==null||(level.getId()<=0))
			throw new RootException(RootException.NEED_MORE_FIND_INFO);	
		return levelDao.load(level);			
	}
	public Level load(int id) throws RootException{
		if(id<=0)
			throw new RootException(RootException.NEED_MORE_FIND_INFO);	
		return levelDao.load(id);			
	}
	public boolean deleteSelectedLevels(String ids){
		boolean re=false;
		re=levelDao.deleteEntitys(ENTITY_NAME, ids);
		return re;
	}
	public  int findAll(List<Level> levels,
			int pageNumber,
			int pageSize
			){
		return levelDao.findAll( levels,pageNumber,pageSize);
	}
	//按某列排序查看会员信息
	public  int findAll(List<Level> levels,
			int pageNumber,
			int pageSize,
			String orderByColumn,
			boolean isAsc){
		return levelDao.findAll( levels,pageNumber,pageSize,null,orderByColumn,isAsc);
	}
	public  List<Level> findByType( Level level){
		List<Level> levels=new ArrayList<Level>();
		 levelDao.findAll( levels,level,1,20);
		 return levels;
	}
	
}
