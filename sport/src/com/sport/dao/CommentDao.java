package com.sport.dao;

import java.util.List;

import org.springframework.stereotype.Component;

import com.sport.entity.Comment;

@Component
public class CommentDao extends RootDao{
	public void save(Comment comment){
		hibernateTemplate.save(comment);
	}
	
	public Comment load(int id){
		if(id<1)
			return null;
		return hibernateTemplate.load(Comment.class, id);
	}
	
		
	public Comment load(Comment comment){			
		return load(comment.getId());
	}
	
	public void delete(int id){
		if(id<1)
			return ;
		delete(new Comment().setId(id));
	}
	
	public void delete(Comment comment){
		comment=load(comment).setUser(null);
		hibernateTemplate.delete(comment);
				
	}
	
	public void update(Comment comment){
		hibernateTemplate.update(comment);
	}
	//分页查询
	public  int findAll(List<Comment> comments,
			int pageNumber,
			int pageSize,
			String groupByColumn,
			String orderByColumn,
			boolean isAsc){
		String queryString="from Comment e ";
		return find(queryString, comments,pageNumber,pageSize,groupByColumn,orderByColumn,isAsc);
	}
	public int findAll(List<Comment> comments,
			int pageNumber,
			int pageSize
			){
		
		return findAll(comments,pageNumber,pageSize,null,null,true);
	}
	//获取某产品的某页产品
		public  int findComments(List<Comment> comments,Comment comment,
				int pageNumber,
				int pageSize,
				String groupByColumn,
				String orderByColumn,
				boolean isAsc){
			StringBuffer queryString=new StringBuffer("from Comment e where 1=1 ");
			if(comment!=null){
				if(comment.getProduct()!=null){
					queryString.append(" and e.product.id="+comment.getProduct().getId());
				}
				if(comment.getCoach()!=null){
					queryString.append(" and e.coach.id="+comment.getCoach().getId());
				}
				if(comment.getCompany()!=null){
					queryString.append(" and e.company.id="+comment.getCompany().getId());
				}
				if(comment.getSite()!=null){
					queryString.append(" and e.site.id="+comment.getSite().getId());
				}
				if(comment.getLowScore()>0&&(comment.getHighScore()>0)){
					queryString.append(" and e.score<="+comment.getHighScore()+" and e.score>="+comment.getLowScore());
				}
				else if(comment.getLowScore()>0){
					queryString.append(" and e.score<"+comment.getLowScore());
				}
				else if(comment.getHighScore()>0){
					queryString.append(" and e.score>"+comment.getHighScore());
				}
			}
			
			return find(queryString.toString(), comments,pageNumber,pageSize,groupByColumn,orderByColumn,isAsc);
		}

		@SuppressWarnings("unchecked")
		public double getCommentNumber(Comment comment) {		
			StringBuffer queryString=new StringBuffer("select avg(e.score) from Comment as e where 1=1 ");
			if(comment!=null){
				if(comment.getProduct()!=null){
					queryString.append(" and e.product.id="+comment.getProduct().getId());
				}
				if(comment.getCoach()!=null){
					queryString.append(" and e.coach.id="+comment.getCoach().getId());
				}
				if(comment.getCompany()!=null){
					queryString.append(" and e.company.id="+comment.getCompany().getId());
				}
				if(comment.getSite()!=null){
					queryString.append(" and e.site.id="+comment.getSite().getId());
				}
			}
			List<Double> result=hibernateTemplate.find(queryString.toString());
			if(result==null||(result.size()<1))
				return 0;
			if(null==result.get(0))
				return 0;
			else
				return result.get(0);
		}
}
