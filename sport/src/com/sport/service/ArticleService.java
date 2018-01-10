package com.sport.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.sport.dao.ArticleDao;
import com.sport.dao.ForumDao;
import com.sport.entity.Article;
import com.sport.entity.Forum;
import com.sport.exception.PromptException;
import com.sport.exception.RootException;

@Component
public class ArticleService extends RootService{
	private static final String ENTITY_NAME="Article";
	private ArticleDao articleDao;
	private ForumDao forumDao;
	public ArticleDao getArticleDao() {
		return articleDao;
	}

	@Resource
	public void setArticleDao(ArticleDao articleDao) {
		this.articleDao = articleDao;
	}

	public ForumDao getForumDao() {
		return forumDao;
	}
	@Resource
	public void setForumDao(ForumDao forumDao) {
		this.forumDao = forumDao;
	}

	// 社交圈信息的增删改
	public void add(Article article) throws RootException, Exception {
		if (article == null)
			throw new RootException(RootException.NEED_MORE_ADD_INFO);
		article.setDate(new Date());
		articleDao.save(article);
	}

	public boolean delete(Article article) throws RootException, Exception {
		if (article == null|| (article.getId() <= 0))
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);
		// 先加载该帖子所有信息
		article = articleDao.load(article);
		if (article == null)
			throw new RootException("不存在该贴子!");
		// 如果为根帖子,直接删除
		if (article.getParentArticle() == null)
			return articleDao.delete(article);
		// 先保存父节点信息
		Article particle = article.getParentArticle();
		int size = particle.getChildrenArticles().size();
		particle.getChildrenArticles().remove(article);//先解除关系
		// 删除该节点
		boolean re = articleDao.delete(article);
		//修改根贴状态
		if(particle.getRootArticle()!=null)
			articleDao.update(particle.getRootArticle().setChildArticleNumber(
						particle.getRootArticle().getChildArticleNumber()-1
					));
		else
			articleDao.update(particle.setChildArticleNumber(particle.getChildArticleNumber()-1));
		// 修改父节点状态 
		if (size < 2) {
			particle.setLeaf(true);
			articleDao.update(particle);
		}
		return re;
	}
	/**帖子的更新只有更改点赞数
	 * @throws RootException */
	public void support(Article article) throws RootException{
		if (article == null|| (article.getId() <= 0))
			throw new RootException(RootException.NEED_MORE_UPDATE_INFO);
		Article oldArticle=articleDao.load(article);
		oldArticle.setSupportNumber(oldArticle.getSupportNumber()+(article.isHasSupport()?1:-1));
		articleDao.update(oldArticle);
	}
	/*public void update(Article article) throws RootException, Exception {
		if (article == null|| (article.getId() <= 0))
			throw new RootException(RootException.NEED_MORE_UPDATE_INFO);
		
		long oldArticleId;
		// 如果更新的是根,则直接更新
		if (articleDao.load(article).getParentArticle() == null) {
			articleDao.update(article);
			return;
		}
		// 先加载到内存
		Article oldptype = articleDao.load(article);
		// 先将参数加载到ptype中,因为后面调用evict后,无法加载ptype
		article.setChildrenArticles(oldptype.getChildrenArticles())
				.setParentArticle(oldptype.getParentArticle())
				.setLeaf(oldptype.isLeaf()).setGrade(oldptype.getGrade());
		// 否则，需要判断是否更新父状态
		oldArticleId = articleDao.load(article).getParentArticle()
				.getId();
		articleDao.update(article);

		// 如果修改该关联的父，就检查修改后对前后父的属性影响
		if (!(articleDao.load(article.getParentArticle()).getId()
				==(oldArticleId))) {
			Article oldPPtype = articleDao.load(oldArticleId);
			Article newPPtype = articleDao.load(article.getParentArticle().getId());
			if (oldPPtype.getChildrenArticles() == null
					|| oldPPtype.getChildrenArticles().isEmpty())
				oldPPtype.setLeaf(true);
			articleDao.update(oldPPtype);
			if (newPPtype == null)
				throw new RootException("不存在该父，请先添加！");
			newPPtype.setLeaf(false);
			articleDao.update(newPPtype);
		}
	}*/

	public Article load(Article article) throws RootException, Exception {
		if (article == null|| (article.getId() <= 0))
			throw new RootException(RootException.NEED_MORE_FIND_INFO);
		return articleDao.load(article);
	}

	
	// 简化客服端编程操作
	// 设置父子结点之间的默认关联属性
	public void initRelation(Article parentArticle, Article article) throws PromptException {
		if(article.getForum()==null&&(parentArticle==null))
			throw new PromptException("请不要使用非法途径发帖！");
		Forum forum=null;
		if(parentArticle!=null&&(parentArticle.getId()>0))
			parentArticle=articleDao.load(parentArticle);//先加载父贴信息
		if(parentArticle!=null&&(parentArticle.getForum()!=null))
			forum=forumDao.load(parentArticle.getForum());
		else
			forum=forumDao.load(article.getForum());
		if(forum!=null)
			forum.setArticleNumber(forum.getArticleNumber()+1);
		forumDao.update(forum);
		if (parentArticle == null) {
			article.setParentArticle(null);
			article.setGrade(0);
			article.setLeaf(true);
			article.setChildrenArticles(null)
					.setRootArticle(null);
		} else {
			parentArticle = articleDao.load(parentArticle);
			article.setParentArticle(parentArticle);
			article.setGrade(parentArticle.getGrade() + 1);
			article.setLeaf(true);
			article.setForum(parentArticle.getForum());
			parentArticle.setLeaf(false);
			article.setChildrenArticles(null);
			//设置根贴，并改变其子贴数
			if(article.getRootArticle()==null)
				article.setRootArticle(parentArticle);
			else
				article.setRootArticle(parentArticle.getRootArticle());
			article.getRootArticle().setChildArticleNumber(
					article.getRootArticle().getChildArticleNumber()+1);
			//同步到数据库
			articleDao.update(article.getRootArticle());
			articleDao.update(article.getParentArticle());
		}
	}
	public int findAll(List<Article> articles, Article article,
			int pageNumber, int pageSize) {
		return findAll(articles, article, pageNumber, pageSize,"date", false);
	}
	// 所有条件都可以通过article传递
	public int findAll(List<Article> articles, Article article,
			int pageNumber, int pageSize,boolean isAsc) {
		return findAll(articles, article, pageNumber, pageSize,"date", isAsc);
	}

	public int findAll(List<Article> articles, Article article,
			int pageNumber, int pageSize, String orderByColumn, boolean isAsc) {
		return articleDao.findAll(articles, article, pageNumber, pageSize,
				orderByColumn,isAsc	);
	}
	
	// 所有条件都可以通过article传递
		public int findAllSearch(List<Article> articles, Article article,
				int pageNumber, int pageSize) {
			return findAllSearch(articles, article, pageNumber, pageSize,"date", false);
		}

		public int findAllSearch(List<Article> articles, Article article,
				int pageNumber, int pageSize, String orderByColumn, boolean isAsc) {
			int totalItemNumber=articleDao.findAllSearch(articles, article, pageNumber, pageSize,
					orderByColumn,isAsc	);
			return totalItemNumber;
		}

	public boolean deleteSelectedArticles(String ids) {
		return articleDao.deleteEntitys(ENTITY_NAME, ids);
	}
}
