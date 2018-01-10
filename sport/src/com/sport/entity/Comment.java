package com.sport.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Transient;


@Entity
public class Comment implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public static final int SCORE_HIGH=3;//超过这个点就是好评
	public static final int SCORE_LOW=2;//低于这个点就是差评
	private int id;
	private User user;//某用户评论的
	private Coach coach;//某教练的评论
	private Product product;//某产品的评论
	private OrderItem item;//某订单项的评论
	private Site site;//某场馆的评论
	private Company company;//属于某入驻公司的评论
	private String detail;//内容
	private String replyContent;//回复内容
	private boolean hasReply;//是否已回复
	private boolean hasReport;//是否已举报
	private String reportCause;//举报原因
	private int score;//1-5可以根据数值大小判断是否是差评、中评、好评
	private Date time;//评论时间
	//dto
	private int lowScore;
	private int highScore;
	public Comment(){}

	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}
	public Comment setId(int id) {
		this.id = id;
		return this;
	}
	@ManyToOne(fetch=FetchType.LAZY)
	public User getUser() {
		return user;
	}
	public Comment setUser(User user) {
		this.user = user;
		return this;
	}
	@ManyToOne(fetch=FetchType.LAZY)
	public Product getProduct() {
		return product;
	}
	public Comment setProduct(Product product) {
		this.product = product;
		return this;
	}
	@Lob
	public String getDetail() {
		return detail;
	}
	public Comment setDetail(String detail) {
		this.detail = detail;
		return this;
	}
	public int getScore() {
		return score;
	}
	public Comment setScore(int score) {
		this.score = score;
		return this;
	}
	public Date getTime() {
		//time=DateFormatUtil.formatDayTime(time);
		return time;
	}
	public Comment setTime(Date time) {
		//time=DateFormatUtil.formatDayTime(time);
		this.time = time;
		return this;
	}
	@Lob
	public String getReplyContent() {
		return replyContent;
	}

	public Comment setReplyContent(String replyContent) {
		this.replyContent = replyContent;
		return this;
	}

	public boolean isHasReply() {
		return hasReply;
	}

	public Comment setHasReply(boolean hasReply) {
		this.hasReply = hasReply;
		return this;
	}
	@Lob
	public String getReportCause() {
		return reportCause;
	}

	public Comment setReportCause(String reportCause) {
		this.reportCause = reportCause;
		return this;
	}

	public boolean isHasReport() {
		return hasReport;
	}

	public Comment setHasReport(boolean hasReport) {
		this.hasReport = hasReport;
		return this;
	}
	@OneToOne(fetch=FetchType.LAZY,mappedBy="comment")
	public OrderItem getItem() {
		return item;
	}

	public Comment setItem(OrderItem item) {
		this.item = item;
		return this;
	}
	@ManyToOne(fetch=FetchType.LAZY)
	public Company getCompany() {
		return company;
	}

	public Comment setCompany(Company company) {
		this.company = company;
		return this;
	}
	@ManyToOne(fetch=FetchType.LAZY)
	public Coach getCoach() {
		return coach;
	}

	public Comment setCoach(Coach coach) {
		this.coach = coach;
		return this;
	}
	@ManyToOne(fetch=FetchType.LAZY)
	public Site getSite() {
		return site;
	}

	public Comment setSite(Site site) {
		this.site = site;
		return this;
	}
	@Transient
	public int getLowScore() {
		return lowScore;
	}

	public Comment setLowScore(int lowScore) {
		this.lowScore = lowScore;
		return this;
	}
	@Transient
	public int getHighScore() {
		return highScore;
	}

	public Comment setHighScore(int highScore) {
		this.highScore = highScore;
		return this;
	}
}
