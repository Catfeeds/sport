package com.sport.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.Lob;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Transient;

import com.sport.exception.RootException;
import com.sport.service.ImageService;
/*
 * 每个公司都有自己的一套产品，以产品名区分所有的产品，当然id也可以，产品分类则是所有公司共有的
 */
@Entity
@Inheritance(strategy=InheritanceType.JOINED)
public class Product  implements Serializable{
/**
	 * 
	 */
	protected static final long serialVersionUID = 1L;
	public static final int DEFAULT_SCORE=5;
	@Resource
	@Transient
	protected  ImageService imageService;
	/*
 * Id;
 *  productName；产品名；
	normalPrice；普通价格(每小时)；
	bargainPrice；促销价；
	hasBargain;是否促销	
	totalSoldNumber;总销售量
	score;用户评分	
	hasTop;//是否置顶商品
	hasBegin;//是否可以预定
	productType；种类分类(品种)；（多对一）双向关联
	Introduction；简介；
	detail;详细说明	
	comments;评论
*/
	protected int id;
	//通用属性
	protected String productName;//产品名
	protected Level level;//教练服务的等级
	protected float normalPrice;//普通价格（每小时）
	protected float bargainPrice;//促销价
	protected boolean hasBargin;//是否促销
	protected int totalSoldNumber;//该产品的总销售量
	protected int score;//用户对该产品的评论
	protected boolean hasTop;//是否置顶商品
	protected boolean hasBegin;//是否可以预定
	protected ProductType type;//该产品所属的分类
	protected Company company;//该产品所属的公司
	protected String introduction;//该种产品的简介
	protected String detail;//该种产品的详细说明
	protected List<Comment> comments;//用户对该种产品的评论
	protected Image currentImage;//当前显示的图片
	protected List<Image> bigImages;//产品的大图
	protected List<Image> midImages;//产品的中图
	protected List<Image> smallImages;// 产品小图
	
	//dto变量
	protected int[] bigImageIds;
	protected int[] midImageIds;
	protected int[] smallImageIds;
	@Id
	@GeneratedValue
	@Column(name="product_id")
	public int getId() {
		return id;
	}
	public Product setId(int id) {
		this.id = id;
		return this;
	}
	public String getProductName() {
		return productName;
	}
	public Product setProductName(String productName) {
		this.productName = productName;
		return this;
	}
	public float getNormalPrice() {
		return normalPrice;
	}
	public Product setNormalPrice(float normalPrice) {
		this.normalPrice = normalPrice;
		return this;
	}
	public float getBargainPrice() {
		return bargainPrice;
	}
	public Product setBargainPrice(float bargainPrice) {
		this.bargainPrice = bargainPrice;
		return this;
	}
	public boolean isHasBargin() {
		return hasBargin;
	}
	public Product setHasBargin(boolean hasBargin) {
		this.hasBargin = hasBargin;
		return this;
	}
	public int getTotalSoldNumber() {
		return totalSoldNumber;
	}
	public Product setTotalSoldNumber(int totalSoldNumber) {
		this.totalSoldNumber = totalSoldNumber;
		return this;
	}
	public int getScore() {
		return score;
	}
	public Product setScore(int score) {
		this.score = score;
		return this;
	}
	public boolean isHasTop() {
		return hasTop;
	}
	public Product setHasTop(boolean hasTop) {
		this.hasTop = hasTop;
		return this;
	}
	public boolean isHasBegin() {
		return hasBegin;
	}
	public Product setHasBegin(boolean hasBegin) {
		this.hasBegin = hasBegin;
		return this;
	}
	@ManyToOne(fetch=FetchType.LAZY)
	public ProductType getType() {
		return type;
	}
	public Product setType(ProductType type) {
		this.type = type;
		return this;
	}
	public String getIntroduction() {
		return introduction;
	}
	public Product setIntroduction(String introduction) {
		this.introduction = introduction;
		return this;
	}
	@Lob
	public String getDetail() {
		return detail;
	}
	public Product setDetail(String detail) {
		this.detail = detail;
		return this;
	}
	@OneToMany(mappedBy="product",fetch=FetchType.LAZY,cascade=CascadeType.REMOVE)
	public List<Comment> getComments() {
		return comments;
	}
	public Product setComments(List<Comment> comments) {
		this.comments = comments;
		return this;
	}
	@ManyToOne(fetch=FetchType.LAZY)
	public Level getLevel() {
		return level;
	}
	public Product setLevel(Level level) {
		this.level = level;
		return this;
	}
	@ManyToOne(cascade={CascadeType.MERGE,CascadeType.REMOVE},fetch=FetchType.LAZY)
	public Image getCurrentImage() {
		return currentImage;
	}
	public Product setCurrentImage(Image currentImage) {
		this.currentImage = currentImage;
		return this;
	}
	@ManyToMany(cascade={CascadeType.MERGE,CascadeType.REMOVE},fetch=FetchType.LAZY)
	public List<Image> getBigImages() {
		return bigImages;
	}
	public Product setBigImages(List<Image> bigImages) {
		this.bigImages = bigImages;
		return this;
	}
	@ManyToMany(cascade={CascadeType.MERGE,CascadeType.REMOVE},fetch=FetchType.LAZY)
	public List<Image> getMidImages() {
		return midImages;
	}
	public Product setMidImages(List<Image> midImages) {
		this.midImages = midImages;
		return this;
	}
	@ManyToMany(cascade={CascadeType.MERGE,CascadeType.REMOVE},fetch=FetchType.LAZY)
	public List<Image> getSmallImages() {
		return smallImages;
	}
	public Product setSmallImages(List<Image> smallImages) {
		this.smallImages = smallImages;
		return this;
	}
	@ManyToOne(fetch=FetchType.LAZY)
	public Company getCompany() {
		return company;
	}
	public Product setCompany(Company company) {
		this.company = company;
		return this;
	}
	//dto
	@Transient
	public int[] getBigImageIds() {
		return bigImageIds;
	}
	public Product setBigImageIds(int[] bigImageIds) {
		this.bigImageIds = bigImageIds;
		//设置产品与图片的关联
		bigImages=new ArrayList<Image>();
		for(int id:bigImageIds){
			try {
				bigImages.add(imageService.load(new Image().setId(id)));
			} catch (RootException e) {
				e.printStackTrace();
			}
			System.out.println("bigImg:"+id);
		}
		return this;
	}
	@Transient
	public int[] getMidImageIds() {
		return midImageIds;
	}
	public Product setMidImageIds(int[] midImageIds) {
		this.midImageIds = midImageIds;
		//设置产品与图片的关联
		midImages=new ArrayList<Image>();
		for(int id:midImageIds){
			try {
				midImages.add(imageService.load(new Image().setId(id)));
			} catch (RootException e) {
				e.printStackTrace();
			}
			System.out.println("midImg:"+id);
		}
		return this;
	}
	@Transient
	public int[] getSmallImageIds() {
		return smallImageIds;
	}
	public Product setSmallImageIds(int[] smallImageIds) {
		this.smallImageIds = smallImageIds;
		//设置产品与图片的关联
		System.out.println("关联产品小图!");
		smallImages=new ArrayList<Image>();
		for(int id:smallImageIds){
			try {
				smallImages.add(imageService.load(new Image().setId(id)));
			} catch (RootException e) {
				e.printStackTrace();
			}
			System.out.println("smallImg:"+id);
		}
		return this;
	}
}
