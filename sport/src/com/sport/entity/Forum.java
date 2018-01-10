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


@Entity
public class Forum  implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public final static String TYPE_PERSONAL="1";//个人论坛
	public final static String TYPE_COMPANY_MANAGER="2";//入驻商家管理员创建的论坛
	public final static String TYPE_HOST_MANAGER="3";//平台管理员创建的论坛
	public final static String TYPE_ELSE="4";//其它类型的论坛
	private int id;
	private String forumName;//论坛名
	private Image logoImage;//论坛图标
	private String introduction;//论坛简介
	private String classType;//什么类型的论坛，是个人、平台、还是其他、默认平台和入驻商家的论坛里有的帖子会置顶
	private Date createDate;//创建时间
	private ProductType type;//论坛隶属于的分类
	private Person owner;//论坛管理员
	private List<Article> articles;//该论坛的帖子
	private long articleNumber;//帖子数目
	
	//dto
	private String classTypeStr;
	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}
	public Forum setId(int id) {
		this.id = id;
		return this;
	}
	public String getForumName() {
		return forumName;
	}
	public Forum setForumName(String forumName) {
		this.forumName = forumName;
		return this;
	}
	@OneToOne(fetch=FetchType.EAGER,cascade=CascadeType.ALL)
	public Image getLogoImage() {
		return logoImage;
	}
	public Forum setLogoImage(Image logoImage) {
		this.logoImage = logoImage;
		return this;
	}
	@ManyToOne(fetch=FetchType.EAGER)
	public ProductType getType() {
		return type;
	}
	public Forum setType(ProductType type) {
		this.type = type;
		return this;
	}
	@ManyToOne(fetch=FetchType.EAGER)
	public Person getOwner() {
		return owner;
	}
	public Forum setOwner(Person owner) {
		this.owner = owner;
		return this;
	}
	@OneToMany(fetch=FetchType.LAZY,cascade=CascadeType.ALL,mappedBy="forum")
	public List<Article> getArticles() {
		return articles;
	}
	public Forum setArticles(List<Article> articles) {
		this.articles = articles;
		return this;
	}
	@Lob
	public String getIntroduction() {
		return introduction;
	}
	public Forum setIntroduction(String introduction) {
		this.introduction = introduction;
		return this;
	}
	public String getClassType() {
		return classType;
	}
	public Forum setClassType(String classType) {
		this.classType = classType;
		return this;
	}
	public Date getCreateDate() {
		//createDate=DateFormatUtil.formatDay(createDate);
		return createDate;
	}
	public Forum setCreateDate(Date createDate) {
		//createDate=DateFormatUtil.formatDay(createDate);
		this.createDate = createDate;
		return this;
	}
	public long getArticleNumber() {
		return articleNumber;
	}
	public Forum setArticleNumber(long articleNumber) {
		this.articleNumber = articleNumber;
		return this;
	}
	@Transient
	public String getClassTypeStr() {
		if(classType!=null){
			if(classType.equals(TYPE_PERSONAL))
				classTypeStr="个人";
			if(classType.equals(TYPE_COMPANY_MANAGER))
				classTypeStr="入驻商家";
			if(classType.equals(TYPE_HOST_MANAGER))
				classTypeStr="平台拥有者";
			if(classType.equals(TYPE_ELSE))
				classTypeStr="其它类型";
		}
		return classTypeStr;
	}
	public Forum setClassTypeStr(String classTypeStr) {
		this.classTypeStr = classTypeStr;
		return this;
	}

}
