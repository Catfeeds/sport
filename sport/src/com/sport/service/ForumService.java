package com.sport.service;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.sport.dao.ForumDao;
import com.sport.entity.Forum;
import com.sport.exception.RootException;


@Component
public class ForumService  extends RootService{
	private static final String ENTITY_NAME="Forum";
	private ForumDao forumDao;

	public ForumDao getForumDao() {
		return forumDao;
	}
	@Resource
	public ForumService setForumDao(ForumDao forumDao) {
		this.forumDao = forumDao;
		return this;
	}
	public void add(Forum forum) throws RootException{
		if(forum==null)
			throw new RootException(RootException.NEED_MORE_ADD_INFO);	
		forum.setCreateDate(new Date());
		forumDao.save(forum);
	}
	
	public void delete(Forum forum) throws RootException{
		
		if(forum==null||(forum.getId()<=0))
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);	
		 forumDao.delete(forum);
	}
	public void delete(int id) throws RootException{		
		if(id<=0)
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);	
		 forumDao.delete(id);
	}
	public void update(Forum forum) throws RootException{
		if(forum==null||(forum.getId()<=0))
			throw new RootException(RootException.NEED_MORE_UPDATE_INFO);
		Forum oldForum=forumDao.load(forum);
		oldForum.setClassType(forum.getClassType())
				.setForumName(forum.getForumName())
				.setIntroduction(forum.getIntroduction())
				.setType(forum.getType());
		if(forum.getLogoImage()!=null)
			oldForum.setLogoImage(forum.getLogoImage());
		if(forum.getOwner()!=null)
			oldForum.setOwner(forum.getOwner());
		forumDao.update(oldForum);
	}
	
	public Forum load(Forum forum) throws RootException{
		if(forum==null||(forum.getId()<=0))
			throw new RootException(RootException.NEED_MORE_FIND_INFO);	
		return forumDao.load(forum);			
	}
	public Forum load(int id) throws RootException{
		if(id<=0)
			throw new RootException(RootException.NEED_MORE_FIND_INFO);	
		return forumDao.load(id);			
	}
	
	public  int findAll(List<Forum> forums,Forum forum,
			int pageNumber,
			int pageSize
			){
		return findAll( forums,forum,pageNumber,pageSize,null,true);
	}
	//按某列排序查看论坛信息
	public  int findAll(List<Forum> forums,Forum forum,
			int pageNumber,
			int pageSize,
			String orderByColumn,
			boolean isAsc){
		return forumDao.findAll( forums,forum,pageNumber,pageSize,null,"createDate",false);
	}
	//关键字搜索论坛
	public  int findAllSearch(List<Forum> forums,Forum forum,
			int pageNumber,
			int pageSize
			){
		return findAllSearch( forums,forum,pageNumber,pageSize,null,true);
	}
	//按某列排序查看论坛信息
	public  int findAllSearch(List<Forum> forums,Forum forum,
			int pageNumber,
			int pageSize,
			String orderByColumn,
			boolean isAsc){
		return forumDao.findAllSearch( forums,forum,pageNumber,pageSize,null,"createDate",false);
	}
	public boolean deleteSelectedForums(String ids) {
		return forumDao.deleteEntitys(ENTITY_NAME, ids);
	}
}
