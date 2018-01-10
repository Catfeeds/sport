package com.sport.service;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.sport.dao.CommentDao;
import com.sport.entity.Comment;
import com.sport.entity.Product;
import com.sport.exception.RootException;


@Component
public class CommentService  extends RootService{
	private static final String ENTITY_NAME="Comment";
	private CommentDao commentDao;

	public CommentDao getCommentDao() {
		return commentDao;
	}
	@Resource
	public CommentService setCommentDao(CommentDao commentDao) {
		this.commentDao = commentDao;
		return this;
	}
	public void add(Comment comment) throws RootException{
		if(comment==null)
			throw new RootException(RootException.NEED_MORE_ADD_INFO);	
		comment.setHasReply(false).setHasReport(false)
				.setTime(new Date());
		commentDao.save(comment);
	}
	
	public void delete(Comment comment) throws RootException{
		
		if(comment==null||(comment.getId()<=0))
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);	
		 commentDao.delete(comment);
	}
	public void delete(int id) throws RootException{		
		if(id<=0)
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);	
		 commentDao.delete(id);
	}
	public void update(Comment comment) throws RootException{
		if(comment==null||(comment.getId()<=0))
			throw new RootException(RootException.NEED_MORE_UPDATE_INFO);	
		commentDao.update(comment);
	}
	
	public Comment load(Comment comment) throws RootException{
		if(comment==null||(comment.getId()<=0))
			throw new RootException(RootException.NEED_MORE_FIND_INFO);	
		return commentDao.load(comment);			
	}
	public Comment load(int id) throws RootException{
		if(id<=0)
			throw new RootException(RootException.NEED_MORE_FIND_INFO);	
		return commentDao.load(id);			
	}
	
	public  int findAll(List<Comment> comments,
			int pageNumber,
			int pageSize
			){
		return commentDao.findAll( comments,pageNumber,pageSize);
	}
	//按某列排序查看会员信息
	public  int findAll(List<Comment> comments,
			int pageNumber,
			int pageSize,
			String orderByColumn,
			boolean isAsc){
		return commentDao.findAll( comments,pageNumber,pageSize,null,orderByColumn,isAsc);
	}
	public int findComments(List<Comment> comments,
			Comment comment, int pageNumber, int pageSize) {
		return commentDao.findComments( comments,comment,pageNumber,pageSize,null,"time",false);
	}
	public double getCommentNumber(Comment comment){
		return commentDao.getCommentNumber( comment);
	}
	public void deleteSelectedComments(String ids) {
		commentDao.deleteEntitys(ENTITY_NAME, ids);
	}
}
