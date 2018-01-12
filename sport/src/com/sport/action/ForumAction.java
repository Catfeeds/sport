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

import com.sport.entity.Article;
import com.sport.entity.Event;
import com.sport.entity.Forum;
import com.sport.entity.Image;
import com.sport.entity.Manager;
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

//社交圈子操作
@Component
@Scope("prototype")
public class ForumAction extends RootAction {
	private Forum forum;
	private ForumService forumService;
	private List<Forum> forums;
	private Person owner;// 社交圈圈主
	private Article article;
	private ArticleService articleService;
	private List<Article> articles;
	private PersonService personService;
	private List<ProductType> rootTypes;
	private List<ProductType> allTypes;// 所有具体的分类信息,调用本action任何方法后，都可以直接使用该分类集
	private ProductTypeService productTypeService;
	// 上传
	File file;
	String fileContentType;
	String fileFileName;
	private ImageService imageService;
	// 微信用户匿名登录
	private UserService userService;
	// 微信用户授权码
	private String code;
	
	// 到论坛添加页面
	public String toAddForum() {

		return "addForum";
	}
	public void loginWeixinUser() throws PromptException, Exception {/*// 模拟微信匿名登录
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
	// 获取当前登录用户关注的社交圈信息
	public String userCaredForum() throws PromptException, ServerErrorException {
		try {
			loginWeixinUser();
			Person owner = this.getCurrentUser();
			if (owner == null) {
				throw new PromptException("您还未登录，请登录后再操作！");
			}
			owner=personService.findPerson(owner);
			forums = owner.getCareForums();			
		} catch (RootException e) {
			e.printStackTrace();
			errorMsg = e.toString();
			throw new PromptException(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "userCaredForum";
	}

	// 添加一个社交圈,同时需要设置当前登录用户为社交圈圈主
	public String addForum() throws PromptException, ServerErrorException {
		try {
			Person owner = this.getCurrentPerson();
			if (owner == null)
				throw new PromptException("请先登录后再操作！");
			// 如果要上传朋友圈图片
			if (file != null) {
				if (file.canRead() && (file.isFile()) && (file.exists())) {
					String webDir = "/upload/img/forum";
					String savePath = ServletActionContext.getServletContext()
							.getRealPath(webDir);
					fileFileName = "forum" +fileFileName;
					Image image = imageService.saveFile(file, savePath, webDir,
							fileFileName);
					if (image != null)
						forum.setLogoImage(image);
				}
			}
			forum.setOwner(owner);
			forumService.add(forum);
			forum=forumService.load(forum);
		} catch (RootException e) {
			e.printStackTrace();
			errorMsg = e.toString();
			throw new PromptException(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "forumDetail";
	}

	// 查看某社交圈详情
	public String forumDetail() throws PromptException, ServerErrorException {
		try {
			forum = forumService.load(forum);
		} catch (RootException e) {
			e.printStackTrace();
			errorMsg = e.toString();
			throw new PromptException(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "forumDetail";
	}

	// 修改某社交圈基本信息
	public String alterForum() throws PromptException, ServerErrorException {
		try {
			// 如果要上传朋友圈图片
			if (file != null) {
				if (file.canRead() && (file.isFile()) && (file.exists())) {
					String webDir = "/upload/img/forum";
					String savePath = ServletActionContext.getServletContext()
							.getRealPath(webDir);
					fileFileName = "forum" + new Date().getTime() + fileFileName;
					Image image = imageService.saveFile(file, savePath, webDir,
							fileFileName);
					if (image != null)
						forum.setLogoImage(image);
				}
			}
			forumService.update(forum);
		} catch (RootException e) {
			e.printStackTrace();
			errorMsg = e.toString();
			throw new PromptException(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "forumDetail";
	}

	// 删除某社交圈
	public void deleteForum() throws PromptException, ServerErrorException {
		try {
			forumService.delete(forum);
		} catch (RootException e) {
			e.printStackTrace();
			errorMsg = e.toString();
			throw new PromptException(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
	}

	// 查看某种分类信息的社交圈
	public String forumList() throws ServerErrorException {
		try {
			forums = new ArrayList<Forum>();
			page.setTotalItemNumber(forumService.findAll(forums, forum,
					page.getPageNumber(), page.getPageSize()));
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "forumList";
	}

	// 关键字搜索社交圈
	public String searchForum() throws ServerErrorException {
		try {
			forums = new ArrayList<Forum>();
			// 只需要给forum.forumName赋值即可
			page.setTotalItemNumber(forumService.findAllSearch(forums, forum,
					page.getPageNumber(), page.getPageSize()));
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "forumList";
	}
	
	// 查看自己关注的论坛
	public String careForumList() throws PromptException, ServerErrorException {
		try {
			Person owner = (Person) session.get("currentPerson");
			if (owner == null)
				throw new RootException("对不起，您的登录信息已过期，请重新登录！");
			if (forum == null)
				forum = new Forum();
			forum.setOwner(owner);
			forums = new ArrayList<Forum>();
			page.setTotalItemNumber(forumService.findAll(forums, forum,
					page.getPageNumber(), page.getPageSize()));
		} catch (RootException e) {
			e.printStackTrace();
			errorMsg = e.toString();
			throw new PromptException(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "forumList";
	}

	// 关注某社交圈
	public void careForum() throws ServerErrorException {
		this.getResponseAndOut();
		JSONArray json = new JSONArray();
		try {
			Person owner = this.getCurrentPerson();
			if (owner == null)
				throw new RootException("对不起，您的登录信息已过期，请重新登录！");
			if (forum == null)
				throw new PromptException("对不起，您还未选择您需要关注的社交圈!");
			owner=personService.findPerson(owner);
			if (owner.getCareForums() == null) {
				List<Forum> careForums = new ArrayList<Forum>();
				owner.setCareForums(careForums);
			}
			boolean flag=false;
			for(Forum f:owner.getCareForums()){
				if(forum.getId()==f.getId())
					flag=true;
			}
			if(!flag)
				owner.getCareForums().add(forum);
			else
				throw new PromptException("您已经关注过该圈子了！");
			personService.alterPersonInformation(owner);
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
	//取消关注某圈子
	public void disCareForum() throws ServerErrorException {
			this.getResponseAndOut();
			JSONArray json = new JSONArray();
			try {
				Person owner = this.getCurrentPerson();
				if (owner == null)
					throw new RootException("对不起，您的登录信息已过期，请重新登录！");
				if (forum == null)
					throw new PromptException("对不起，您还未选择您需要取消关注的社交圈!");
				owner=personService.findPerson(owner);
				if (owner.getCareForums() == null) {
					List<Forum> careForums = new ArrayList<Forum>();
					owner.setCareForums(careForums);
				}
				boolean flag=false;
				List<Forum> careForums = new ArrayList<Forum>();
				for(Forum f:owner.getCareForums()){
					if(forum.getId()==f.getId())
						flag=true;
					else
						careForums.add(f);
				}
				owner.setCareForums(careForums);
				if(!flag)
					throw new PromptException("您还未关注该圈子呢,无法取消！");
				personService.alterPersonInformation(owner);
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
	public void deleteSelectedForum() throws ServerErrorException{
		this.getResponseAndOut();
		JSONArray json = new JSONArray();
		try {
			forumService.deleteSelectedForums(ids);
			json.add(true);
		} catch (Exception e) {
			e.printStackTrace();
			json.add(false);
			json.add(RootException.SYSTEM_ERROR);
		}
		out.println(json);
		this.closeOut();
	}
	/********** 注入代码 **********/
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

	public List<Forum> getForums() {
		return forums;
	}

	public void setForums(List<Forum> forums) {
		this.forums = forums;

	}

	public Person getOwner() {
		return owner;
	}

	public void setOwner(Person owner) {
		this.owner = owner;

	}

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
		try {
			allTypes = productTypeService.findTypes();
		} catch (RootException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public ProductTypeService getProductTypeService() {
		return productTypeService;
	}

	public List<ProductType> getAllTypes() {
		return allTypes;
	}

	public void setAllTypes(List<ProductType> allTypes) {
		this.allTypes = allTypes;
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
		this.fileFileName = new Date().getTime() + fileFileName;
	}

	public ImageService getImageService() {
		return imageService;
	}

	@Resource
	public void setImageService(ImageService imageService) {
		this.imageService = imageService;
	}
	public UserService getUserService() {
		return userService;
	}

	@Resource
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	

}
