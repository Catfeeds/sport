package com.sport.action;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import net.sf.json.JSONArray;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.sport.dto.ArticleInfo;
import com.sport.dto.Page;
import com.sport.dto.PageArticleInfo;
import com.sport.dto.TypeForumList;
import com.sport.entity.Article;
import com.sport.entity.Event;
import com.sport.entity.Forum;
import com.sport.entity.Image;
import com.sport.entity.Person;
import com.sport.entity.ProductType;
import com.sport.entity.User;
import com.sport.exception.PromptException;
import com.sport.exception.RootException;
import com.sport.exception.ServerErrorException;
import com.sport.service.ArticleService;
import com.sport.service.EventService;
import com.sport.service.ForumService;
import com.sport.service.ImageService;
import com.sport.service.PersonService;
import com.sport.service.ProductTypeService;
import com.sport.service.UserService;

//帖子相关操作
@Component
@Scope("prototype")
public class ArticleAction extends RootAction {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Article article;
	private Article rootArticle;// 帖子详情页面的根贴
	private ArticleService articleService;
	private List<Article> noticeArticles;// 公告贴
	private List<Article> articles;// 普通根贴
	private List<Article> childArticles;// 某帖子下面的子贴
	private Forum forum;
	private ForumService forumService;
	private PersonService personService;
	private List<ProductType> rootTypes;
	private ProductTypeService productTypeService;
	private Page childPage;// 楼层中回复贴的分页对象
	private Page noticePage;// 公告贴分页对象
	private Person person;// 当前登录用户
	private UserService userService;
	// 上传
	File file;
	String fileContentType;
	String fileFileName;
	private ImageService imageService;
	// 微信用户匿名登录		
	// 微信用户授权码
	private String code;
	//赛事轮播图
	private List<Event> events;
	private EventService eventService;
	// 社交圈首页根据分类显示分类下的社交圈
	private List<TypeForumList> typeForums;
	
	public void loginWeixinUser() throws PromptException, Exception {/*// 微信自动注册并登录
		try {
			if(null!=session.get("currentUser"))
				return;
			User u = new User();
			//u.setUserName("weixinUser").setRealName("微信匿名登录用户");
			UserDetailInfo detailInfo = UserAuthManager.getUserDetail(code);
			u.setUserName("wxu" + new Date().getTime())
					.setRealName(detailInfo.getNickname())
					.setWeixin(detailInfo.getOpenId())
					.setNationality(detailInfo.getCuntry())
					.setSex(detailInfo.getSex());
			
			if (null == userService.findUser(u)) {
				userService.register(u);
			}
			u = userService.findUser(u);
			session.put("currentUser", u);
		} catch (PromptException e) {
			throw e;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

	*/}
	// 社交圈首页
	public String forumIndex() throws PromptException, ServerErrorException {		
		try {
			String path = ServletActionContext.getRequest().getServletPath();
			System.out.println("path:" + path);
			if (path.contains("weixin"))// 如果是从微信端进来的需要自动登录注册
				loginWeixinUser();
			// 获取当前登录用户的信息,如果没有登录，则视为游客
			try {
				person = this.getCurrentPerson();
			} catch (RootException e) {
				e.printStackTrace();
			}
			// 获取所有社交圈，按根分类获取
			typeForums = new ArrayList<TypeForumList>();
			for (ProductType rootType : rootTypes) {
				TypeForumList typeForum = new TypeForumList();
				typeForum.init(rootType, forumService, productTypeService);
				typeForums.add(typeForum);
			}
			// 获取系统公告贴
			noticeArticles = new ArrayList<Article>();
			if (noticePage == null)
				noticePage = new Page();
			noticePage.setTotalItemNumber(articleService.findAll(
					noticeArticles,
					new Article().setArticleType(Article.TYPE_NOTICE)
							.setHasRoot(true), noticePage.getPageNumber(),
					noticePage.getPageSize(), "supportNumber", false));
			// 获取热门动态贴
			articles = new ArrayList<Article>();
			page.setTotalItemNumber(articleService.findAll(articles,
					new Article().setArticleType(Article.TYPE_NORMAL)
							.setHasRoot(true), page.getPageNumber(), page
							.getPageSize(), "supportNumber", false));
			//赛事信息
			events=new ArrayList<Event>();
			eventService.findAll(events, null, 1, 8);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "forumIndex";
	}

	public String typeForum() throws ServerErrorException {
		try {
			// 获取当前登录用户的信息,如果没有登录，则视为游客
			try {
				person = this.getCurrentPerson();

			} catch (RootException e) {
				e.printStackTrace();
			}
			if (forum == null)
				throw new PromptException("您还未选择需要进入哪一个圈子呢？");
			forum = forumService.load(forum);
			if (article == null)
				article = new Article();
			Article tempArticle = new Article()
					.setArticleType(Article.TYPE_NORMAL).setHasRoot(true)
					.setForum(forum);
			// 获取第一页最新动态贴
			articles = new ArrayList<Article>();
			page.setTotalItemNumber(articleService.findAll(articles,
					tempArticle, page.getPageNumber(), page.getPageSize()));
			// 获取系统公告贴
			noticeArticles = new ArrayList<Article>();			
			articleService.findAll(
					noticeArticles,
					new Article().setArticleType(Article.TYPE_NOTICE).setForum(forum)
							.setHasRoot(true), 1,
					5,true);
			//赛事信息
			events=new ArrayList<Event>();
			eventService.findAll(events, null, 1, 8);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "typeForum";
	}

	// 获取当前登录用的所有社交圈的发帖信息
	public String userArticleList() throws PromptException,
			ServerErrorException {
		try {
			person = this.getCurrentPerson();
			article = new Article().setTalker(person);
			articles = new ArrayList<Article>();
			page.setTotalItemNumber(articleService.findAll(articles, article,
					page.getPageNumber(), page.getPageSize()));
		} catch (RootException e) {
			errorMsg = e.toString();
			throw new PromptException(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "userArticleList";
	}

	// 到发帖页面
	public String toAddArticle() {

		return "addArticle";
	}

	// 发帖（管理员、教练、用户均可以发帖，并且根据参数需要分为根贴还是回复贴）
	public String addArticle() throws PromptException, ServerErrorException {
		String result = "toTypeForum";
		try {
			if (article.getParentArticle() != null)
				result = "toArticleDetail";
			if (rootArticle != null && (rootArticle.getParentArticle() != null)
					&& (rootArticle.getParentArticle().getId() > 0))
				result = "toReplyArticleList";
			else if (rootArticle != null)
				rootArticle = articleService.load(rootArticle);
			else
				forum = forumService.load(article.getForum());
			person = this.getCurrentPerson();// 只能登陆后才能发帖
			article.setTalker(person);
			// 如果要上传公司logo
			if (file != null) {
				if (file.canRead() && (file.isFile()) && (file.exists())) {
					String webDir = "/upload/img/forum";
					String savePath = ServletActionContext.getServletContext()
							.getRealPath(webDir);
					fileFileName = "article" + fileFileName;
					Image image = imageService.saveFile(file, savePath, webDir,
							fileFileName);
					if (image != null)
						article.setImage(image);
				}
			}
			articleService.initRelation(article.getParentArticle(), article);
			articleService.add(article);

		} catch (RootException e) {
			errorMsg = e.toString();
			throw new PromptException(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}

		return result;
	}

	// 发帖（回复贴）异步
	public void addSubArticle() throws PromptException, ServerErrorException {
		this.getResponseAndOut();
		JSONArray json = new JSONArray();
		try {
			person = this.getCurrentPerson();// 只能登陆后才能发帖
			article.setTalker(person);
			articleService.initRelation(article.getParentArticle(), article);
			articleService.add(article);
			article = articleService.load(article);
			json = JSONArray.fromObject(ArticleInfo.fromArticle(article));
			System.out.println(json);
		} catch (RootException e) {
			json.add(false);
			json.add(e.toString());
		} catch (Exception e) {
			e.printStackTrace();
			json.add(false);
			json.add(RootException.SYSTEM_ERROR);
		}
		out.println(json);
		this.closeOut();
	}

	// 查看帖子详情
	public String articleDetail() throws PromptException, ServerErrorException {
		try {
			rootArticle = articleService.load(rootArticle);
			forum = forumService.load(rootArticle.getForum());
			childArticles = new ArrayList<Article>();
			// 获取该根贴下面的所有子贴,按时间顺序排序
			page.setTotalItemNumber(articleService.findAll(childArticles,
					new Article().setParentArticle(rootArticle),
					page.getPageNumber(), page.getPageSize(), true));
		} catch (RootException e) {
			errorMsg = e.toString();
			throw new PromptException(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "articleDetail";
	}

	// 查看层主回复贴，异步分页获取
	public void getChildArticleList() throws ServerErrorException {
		this.getResponseAndOut();
		JSONArray json = new JSONArray();
		try {
			articles = new ArrayList<Article>();
			if (childPage == null)
				childPage = new Page();
			childPage.setTotalItemNumber(articleService.findAll(articles,
					article, childPage.getPageNumber(),
					childPage.getPageSize(), true));
			PageArticleInfo info = new PageArticleInfo().setPage(childPage)
					.setInfos(ArticleInfo.fromArticles(articles));
			json = JSONArray.fromObject(info);
			System.out.println(json);
		} catch (Exception e) {
			e.printStackTrace();
			json.add(false);
			json.add(RootException.SYSTEM_ERROR);
		}
		out.println(json);
		this.closeOut();
	}

	// 查看层主回复贴，同步分页获取
	public String replyArticleList() throws ServerErrorException {
		try {
			articles = new ArrayList<Article>();
			if (page == null)
				page = new Page();
			page.setTotalItemNumber(articleService.findAll(articles,
					rootArticle, page.getPageNumber(), page.getPageSize(), true));
			rootArticle = articleService.load(rootArticle.setId(rootArticle
					.getParentArticle().getId()));
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "replyArticleList";
	}

	public String searchForumIndex() throws PromptException,
			ServerErrorException {
		try {
			// 获取当前登录用户的信息,如果没有登录，则视为游客
			try {
				person = this.getCurrentPerson();

			} catch (RootException e) {
				e.printStackTrace();
			}
			// 获取所有社交圈，按根分类获取
			typeForums = new ArrayList<TypeForumList>();
			for (ProductType rootType : rootTypes) {
				TypeForumList typeForum = new TypeForumList();
				typeForum.init(rootType, forumService, productTypeService);
				typeForums.add(typeForum);
			}
			noticeArticles = new ArrayList<Article>();
			if (noticePage == null)
				noticePage = new Page();
			// 获取搜索到的根贴
			if (article.getArticleType() == Article.TYPE_NOTICE) {
				noticePage.setTotalItemNumber(articleService.findAllSearch(
						noticeArticles, article, noticePage.getPageNumber(),
						noticePage.getPageSize()));
			} else {
				noticePage.setTotalItemNumber(articleService.findAll(
						noticeArticles,
						new Article().setArticleType(Article.TYPE_NOTICE),
						noticePage.getPageNumber(), noticePage.getPageSize()));
			}
			// 获取热门动态贴
			articles = new ArrayList<Article>();
			if (article.getArticleType() == Article.TYPE_NORMAL) {
				page.setTotalItemNumber(articleService.findAllSearch(articles,
						article, page.getPageNumber(), page.getPageSize()));
			} else {
				page.setTotalItemNumber(articleService.findAll(articles,
						new Article().setArticleType(Article.TYPE_NORMAL),
						page.getPageNumber(), page.getPageSize(),
						"supportNumber", false));
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}

		return "forumIndex";
	}

	public String searchTypeForum() throws PromptException,
			ServerErrorException {
		try {
			person = this.getCurrentPerson();
			articles = new ArrayList<Article>();
			// 获取该根贴下面的所有子贴
			page.setTotalItemNumber(articleService.findAllSearch(articles,
					article, page.getPageNumber(), page.getPageSize()));
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "typeForum";
	}

	// 删除帖子，论坛管理员才能删帖
	public void deleteArticle() throws ServerErrorException {
		this.getResponseAndOut();
		JSONArray json = new JSONArray();
		try {
			articleService.delete(article);
			json.add(true);
		} catch (RootException e) {
			json.add(false);
			json.add(e.toString());
		} catch (Exception e) {
			e.printStackTrace();
			json.add(false);
			json.add(RootException.SYSTEM_ERROR);

		}
		out.println(json);
		this.closeOut();
	}

	// 为帖子点赞,点赞总数需要归入到根贴下
	public void supprortArticle() throws ServerErrorException {
		this.getResponseAndOut();
		JSONArray json = new JSONArray();
		try {
			articleService.support(article);
			json.add(true);
		} catch (RootException e) {
			json.add(false);
			json.add(e.toString());
		} catch (Exception e) {
			e.printStackTrace();
			json.add(false);
			json.add(RootException.SYSTEM_ERROR);
		}
		out.println(json);
		this.closeOut();
	}

	// 社交圈签到
	public void userSignIn() throws ServerErrorException {
		this.getResponseAndOut();
		JSONArray json = new JSONArray();
		try {
			User user = this.getCurrentUser();
			if (user.isHasSign())
				throw new PromptException("您已经签过了，等下次吧！");
			user = userService.findUser(user);
			userService.update(user.setExperience(user.getExperience() + 1)
					.setHasSign(true));
			session.put("currentUser", user);
			json.add(true);
		} catch (RootException e) {
			json.add(false);
			json.add(e.toString());
		} catch (Exception e) {
			e.printStackTrace();
			json.add(false);
			json.add(RootException.SYSTEM_ERROR);
		}
		out.println(json);
		this.closeOut();
	}

	/********* 注入代码 *******/
	public Article getArticle() {
		return article;
	}

	public void setArticle(Article article) {
		this.article = article;

	}

	public ArticleService getArticleService() {
		return articleService;
	}

	@Resource
	public void setArticleService(ArticleService articleService) {
		this.articleService = articleService;

	}

	public List<Article> getArticles() {
		return articles;
	}

	public void setArticles(List<Article> articles) {
		this.articles = articles;

	}

	public void setChildArticles(List<Article> childArticles) {
		this.childArticles = childArticles;
	}

	public Forum getForum() {
		return forum;
	}

	public void setForum(Forum forum) {
		this.forum = forum;

	}

	public ForumService getForumService() {
		return forumService;
	}

	@Resource
	public void setForumService(ForumService forumService) {
		this.forumService = forumService;

	}

	public PersonService getPersonService() {
		return personService;
	}

	@Resource
	public void setPersonService(PersonService personService) {
		this.personService = personService;

	}

	@Resource
	public void setProductTypeService(ProductTypeService productTypeService) {
		this.productTypeService = productTypeService;
		setRootTypes(productTypeService.findRootTypes());
	}

	public ProductTypeService getProductTypeService() {
		return productTypeService;
	}

	public UserService getUserService() {
		return userService;
	}

	@Resource
	public void setUserService(UserService userService) {
		this.userService = userService;

	}

	public List<ProductType> getRootTypes() {
		return rootTypes;
	}

	public void setRootTypes(List<ProductType> rootTypes) {
		this.rootTypes = rootTypes;
	}

	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
	}

	public String getFileContentType() {
		return fileContentType;
	}

	public void setFileContentType(String fileContentType) {
		this.fileContentType = fileContentType;
	}

	public String getFileFileName() {
		return fileFileName;
	}

	public void setFileFileName(String fileFileName) {
		this.fileFileName =new Date().getTime()+fileFileName;
	}

	public ImageService getImageService() {
		return imageService;
	}

	@Resource
	public void setImageService(ImageService imageService) {
		this.imageService = imageService;
	}

	/**
	 * @return the childPage
	 */
	public Page getChildPage() {
		return childPage;
	}

	/**
	 * @param childPage
	 *            the childPage to set
	 */
	/**
	 * @return the ArticleAction.java
	 */
	public void setChildPage(Page childPage) {
		this.childPage = childPage;

	}

	/**
	 * @return the typeForums
	 */
	public List<TypeForumList> getTypeForums() {
		return typeForums;
	}

	/**
	 * @param typeForums
	 *            the typeForums to set
	 */
	/**
	 * @return the ArticleAction.java
	 */
	public void setTypeForums(List<TypeForumList> typeForums) {
		this.typeForums = typeForums;

	}

	/**
	 * @return the noticeArticles
	 */
	public List<Article> getNoticeArticles() {
		return noticeArticles;
	}

	public void setNoticeArticles(List<Article> noticeArticles) {
		this.noticeArticles = noticeArticles;

	}

	public Page getNoticePage() {
		return noticePage;
	}

	public void setNoticePage(Page noticePage) {
		this.noticePage = noticePage;

	}

	/**
	 * @return the person
	 */
	public Person getPerson() {
		return person;
	}

	public void setPerson(Person person) {
		this.person = person;
	}

	public List<Article> getChildArticles() {
		return childArticles;
	}

	public Article getRootArticle() {
		return rootArticle;
	}

	public void setRootArticle(Article rootArticle) {
		this.rootArticle = rootArticle;

	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	public List<Event> getEvents() {
		return events;
	}
	public void setEvents(List<Event> events) {
		this.events = events;
		
	}
	public EventService getEventService() {
		return eventService;
	}
	@Resource
	public void setEventService(EventService eventService) {
		this.eventService = eventService;
	}
}
