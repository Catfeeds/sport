package com.sport.dao;

import java.util.List;

import org.springframework.stereotype.Component;

import com.sport.entity.Article;

@Component
public class ArticleDao extends RootDao{

	//社交圈帖子的增删改、获取
	public void save(Article article){
		hibernateTemplate.save(article);
	}
	
	public Article load(long id){
		if(id<1)
			return null;
		return (Article)hibernateTemplate.load(Article.class, id);
	}
	
	public Article load(Article article){
		Article typeTemp=null;
		if(article.getId()>0)
			typeTemp=load(article.getId());
		if(typeTemp!=null)
			hibernateTemplate.evict(article);
		return typeTemp;
	}
	
	public boolean delete(long id){
		boolean re=true;
		if(load(id)!=null)
			hibernateTemplate.delete(load(id));
		else
			re=false;		
		return re;
	}
	
	public boolean delete(Article article){
		boolean re=true;
		if((article=load(article))!=null)
		{			
			if(article.getParentArticle()!=null)
			{
				//先解除关系再删除
				article.getParentArticle().setChildrenArticles(null);
				hibernateTemplate.delete(article);
				return true;
			}
			hibernateTemplate.delete(article);
		}
		else
			re=false;
		return re;
	}
	
	public void update(Article article){
		//先清除缓存中多余的实体
		hibernateTemplate.evict(hibernateTemplate.get(Article.class, article.getId()));		
		//先解除联系再更新
		List<Article> list=article.getChildrenArticles();
		Article parentArticle=article.getParentArticle();
		article.setChildrenArticles(null);
		article.setParentArticle(null);
		System.out.println("此时article的值："+article.getId()+"  "+article.getTitle() );
		hibernateTemplate.update(article);
		article.setChildrenArticles(list);
		article.setParentArticle(parentArticle);		
		//重新加载入内存
		article=hibernateTemplate.load(Article.class, article.getId());
	}	

	public int findAll(List<Article> articles, Article article,
			int pageNumber, int pageSize, String orderByColumn, boolean isAsc) {
		StringBuffer queryString=new StringBuffer("from Article e where 1=1 ");
		if(article!=null){
			if(article.isHasReport()){//获取被举报的帖子
				queryString.append(" and e.hasReport="+1);
			}
			if(article.getArticleType()>0){//筛选某类型的帖子
				queryString.append(" and e.articleType="+article.getArticleType());
			}
			if(article.getForum()!=null&&(article.getForum().getId()>0)){//筛选某个社交圈的帖子
				queryString.append(" and e.forum.id="+article.getForum().getId());
			}
			if(article.isHasRoot()){//筛选根贴
				queryString.append(" and e.grade="+Article.ROOT_ARTICLE);
			}
			//获取子帖子
			if(article.getParentArticle()!=null&&(article.getParentArticle().getId()>0)){
				queryString.append(" and e.parentArticle.id="+article.getParentArticle().getId());
			}
			//获取某发起者的帖子
			if(article.getResponser()!=null&&(article.getResponser().getId()>0)){
				queryString.append(" and e.responser.id="+article.getResponser().getId());
			}
			//获取某根贴下的所有子贴
			if(article.getRootArticle()!=null&&(article.getRootArticle().getId()>0)){
				queryString.append(" and e.rootArticle.id="+article.getRootArticle().getId());
			}
			//获取某楼主的帖子
			if(article.getTalker()!=null&&(article.getTalker().getId()>0)){
				queryString.append(" and e.talker.id="+article.getTalker().getId());
			}
			
		}
		System.out.println("pageSize:"+pageSize);
		return find(queryString.toString(), articles,pageNumber,pageSize,null,orderByColumn,isAsc);
	}
	//模糊搜索
	public int findAllSearch(List<Article> articles, Article article,
			int pageNumber, int pageSize, String orderByColumn, boolean isAsc) {
		StringBuffer queryString=new StringBuffer("from Article e ");
		if(article!=null){
			if(article.getArticleType()>0){
				queryString.append(" where e.grade=0 and e.articleType="+article.getArticleType()+" and (1=2 ");
			}else{
				queryString.append(" where e.grade=0 and 1=2 ");
			}
			if(article.getTitle()!=null){
				queryString.append(" or e.title like '%"+article.getTitle()+"%' ")
							.append(" or e.talker.realName like '%"+article.getTitle()+"%' ")
							;
			}
			if(article.getArticleType()>0){
				queryString.append(")");
			}
		}
		return find(queryString.toString(), articles,pageNumber,pageSize,null,orderByColumn,isAsc);
	}
}
