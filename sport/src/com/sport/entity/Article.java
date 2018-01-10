package com.sport.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Transient;

import com.sport.util.DateFormatUtil;

@Entity
public class Article  implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public static final int TYPE_NORMAL=1;//普通贴
	public static final int TYPE_NOTICE=2;//公告贴
	public static final int ROOT_ARTICLE=0;//根贴的度
	
	private long id;
	private String title;//帖子标题
	private String content;//帖子内容
	private Person talker;//发帖人
	private Person responser;//回复某人
	private Date date;//发帖日期
	private int supportNumber;//点赞数
	private int childArticleNumber;//子贴数目
	private Article rootArticle;//根贴
	private Article parentArticle;//父贴
	private List<Article> childrenArticles;//子贴
	private Image image;//帖子封面图
	private Forum forum;//哪个论坛的帖子
	private boolean leaf;//是否是叶子节点
	private int grade;//帖子的度
	private int articleType;//帖子类型,公告贴还是普通贴
	private boolean hasReport;//是否已举报
	private String reportCause;//举报原因
	
	//dto
	private boolean hasRoot;//是否是查找根贴
	private boolean hasSupport;//点赞或者取消
	@Id
	@GeneratedValue
	public long getId() {
		return id;
	}
	public Article setId(long id) {
		this.id = id;
		return this;
	}
	
	public String getTitle() {
		return title;
	}
	
	public Article setTitle(String title) {
		this.title = title;
		return this;
	}
	@Lob
	public String getContent() {
		return content;
	}
	public Article setContent(String content) {
		this.content = content;
		return this;
	}
	@ManyToOne(fetch=FetchType.EAGER)
	public Person getTalker() {
		return talker;
	}
	public Article setTalker(Person talker) {
		this.talker = talker;
		return this;
	}
	@ManyToOne(fetch=FetchType.EAGER)
	public Person getResponser() {
		return responser;
	}
	public Article setResponser(Person responser) {
		this.responser = responser;
		return this;
	}
	public Date getDate() {
		//date=DateFormatUtil.formatDayTime(date);
		return date;
	}
	public Article setDate(Date date) {
		//date=DateFormatUtil.formatDayTime(date);
		this.date = date;
		return this;
	}
	public int getSupportNumber() {
		return supportNumber;
	}
	public Article setSupportNumber(int supportNumber) {
		this.supportNumber = supportNumber;
		return this;
	}
	
	public int getChildArticleNumber() {
		return childArticleNumber;
	}

	public Article setChildArticleNumber(int childArticleNumber) {
		this.childArticleNumber = childArticleNumber;
		return this;
	}
	@ManyToOne(fetch=FetchType.LAZY)
	public Article getRootArticle() {
		return rootArticle;
	}
	public Article setRootArticle(Article rootArticle) {
		this.rootArticle = rootArticle;
		return this;
	}
	@ManyToOne(fetch=FetchType.LAZY)
	public Article getParentArticle() {
		return parentArticle;
	}
	public Article setParentArticle(Article parentArticle) {
		this.parentArticle = parentArticle;
		return this;
	}
	@OneToMany(fetch=FetchType.EAGER,mappedBy="parentArticle",cascade=CascadeType.ALL)
	public List<Article> getChildrenArticles() {
		return childrenArticles;
	}
	public Article setChildrenArticles(List<Article> childrenArticles) {
		this.childrenArticles = childrenArticles;
		return this;
	}
	public boolean isLeaf() {
		return leaf;
	}
	public Article setLeaf(boolean leaf) {
		this.leaf = leaf;
		return this;
	}
	public int getArticleType() {
		return articleType;
	}
	public Article setArticleType(int articleType) {
		this.articleType = articleType;
		return this;
	}
	public int getGrade() {
		return grade;
	}
	public Article setGrade(int grade) {
		this.grade = grade;
		return this;
	}
	
	@ManyToOne(fetch=FetchType.LAZY)
	public Forum getForum() {
		return forum;
	}
	public Article setForum(Forum forum) {
		this.forum = forum;
		return this;
	}
	@OneToOne(fetch=FetchType.LAZY)
	public Image getImage() {
		return image;
	}
	public Article setImage(Image image) {
		this.image = image;
		return this;
	}
	public boolean isHasReport() {
		return hasReport;
	}
	public Article setHasReport(boolean hasReport) {
		this.hasReport = hasReport;
		return this;
	}
	@Lob
	public String getReportCause() {
		return reportCause;
	}
	public Article setReportCause(String reportCause) {
		this.reportCause = reportCause;
		return this;
	}
	@Transient
	public boolean isHasRoot() {
		return hasRoot;
	}
	public Article setHasRoot(boolean hasRoot) {
		this.hasRoot = hasRoot;
		return this;
	}
	@Transient
	public boolean isHasSupport() {
		return hasSupport;
	}
	public Article setHasSupport(boolean hasSupport) {
		this.hasSupport = hasSupport;
		return this;
	}
	
}
