package com.sport.dao;

import java.util.List;

import org.springframework.stereotype.Component;

import com.sport.entity.Forum;

@Component
public class ForumDao extends RootDao{
	public void save(Forum forum){
		hibernateTemplate.save(forum);
	}
	
	public Forum load(int id){
		if(id<1)
			return null;
		return (Forum)hibernateTemplate.load(Forum.class, id);
	}
	
		
	public Forum load(Forum forum){			
		return load(forum.getId());
	}
	
	public void delete(int id){
		if(id<1)
			return ;
		delete(new Forum().setId(id));
	}
	
	public void delete(Forum forum){
		
		hibernateTemplate.delete(forum);
				
	}
	
	public void update(Forum forum){
		hibernateTemplate.update(forum);
	}
	//精确分页查询
	public  int findAll(List<Forum> forums,Forum forum,
			int pageNumber,
			int pageSize,
			String groupByColumn,
			String orderByColumn,
			boolean isAsc){
		StringBuffer queryString=new StringBuffer("from Forum e where 1=1 ");
		if(forum!=null){
			if(forum.getForumName()!=null)
			queryString.append(" and e.forumName='"+forum.getForumName()+"'");
			if(forum.getClassType()!=null){
				queryString.append(" and e.classType='"+forum.getClassType()+"' ");
			}
			if(forum.getOwner()!=null&&(forum.getOwner().getId()>0)){
				queryString.append(" and e.owner.id="+forum.getOwner().getId());
			}
			if(forum.getType()!=null&&(forum.getType().getId()>0)){
				queryString.append(" and e.type.id="+forum.getType().getId());
			}
			if(forum.getType()!=null&&((forum.getType().getParentProductType()!=null)&&forum.getType().getParentProductType().getId()>0)){
				queryString.append(" and e.type.parentProductType.id="+forum.getType().getParentProductType().getId());
			}
		}
		return find(queryString.toString(), forums,pageNumber,pageSize,groupByColumn,orderByColumn,isAsc);
	}
	//关键字分页查询
		public  int findAllSearch(List<Forum> forums,Forum forum,
				int pageNumber,
				int pageSize,
				String groupByColumn,
				String orderByColumn,
				boolean isAsc){
			StringBuffer queryString=new StringBuffer("from Forum e where 1=2 ");
			if(forum!=null){
				if(forum.getClassType()!=null){
					queryString.append(" and e.classType='"+forum.getClassType()+"' ");
					queryString.append(" (");
				}				
				if(forum.getForumName()!=null){
					queryString.append(" or e.forumName like'"+forum.getForumName()+"'");
					queryString.append(" or e.owner.realName like '"+forum.getForumName()+"' ");
					queryString.append(" or e.type.typeName like '"+forum.getForumName()+"' ");
					queryString.append(" or e.introduction like '"+forum.getForumName()+"' ");
				}
				if(forum.getClassType()!=null){					
					queryString.append(" )");
				}
			}
			return find(queryString.toString(), forums,pageNumber,pageSize,groupByColumn,orderByColumn,isAsc);
		}
}
