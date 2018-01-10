package com.sport.dto;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.sport.entity.Article;
import com.sport.entity.Forum;
import com.sport.entity.Person;
import com.sport.util.DateFormatUtil;

public class ArticleInfo {
	private long id;//帖子id
	private String title;//帖子标题
	private String content;//帖子内容
	private int talkerId;//发帖人
	private String talkerName;//发帖人名字
	private String headImgPathName;//发帖人头像
	private int responserId;//回复某人
	private String responseName;//回复人名字
	private String date;//发帖日期
	private int supportNumber;//点赞数
	
	
	public static List<ArticleInfo> fromArticles(List<Article> articles){
		List<ArticleInfo> infos=new ArrayList<ArticleInfo>();
		for(Article article:articles){
			ArticleInfo info=fromArticle(article);
			infos.add(info);
		}
		return infos;
	}
	public static ArticleInfo fromArticle(Article article){
		ArticleInfo info=new ArticleInfo()
		.setContent(article.getContent())
		.setDate(DateFormatUtil.formatDayTimeStr(article.getDate()))
		.setId(article.getId())
		.setHeadImgPathName(article.getTalker().getImage().getPathName())
		.setResponserId((article.getResponser()==null ? 0:article.getResponser().getId()))
		.setResponseName((article.getResponser()==null? null:article.getResponser().getRealName()))
		.setSupportNumber(article.getSupportNumber())
		.setTalkerId((article.getTalker()==null?0:article.getTalker().getId()))
		.setTalkerName((article.getTalker()==null?null:article.getTalker().getRealName()))
		.setTitle(article.getTitle());
		return info;
	}
	public long getId() {
		return id;
	}
	public ArticleInfo setId(long id) {
		this.id = id;
		return this;
	}
	public String getTitle() {
		return title;
	}
	public ArticleInfo setTitle(String title) {
		this.title = title;
		return this;
	}
	public String getContent() {
		return content;
	}
	public ArticleInfo setContent(String content) {
		this.content = content;
		return this;
	}
	

	public int getSupportNumber() {
		return supportNumber;
	}
	public ArticleInfo setSupportNumber(int supportNumber) {
		this.supportNumber = supportNumber;
		return this;
	}

	public int getTalkerId() {
		return talkerId;
	}

	public ArticleInfo setTalkerId(int talkerId) {
		this.talkerId = talkerId;
		return this;
	}

	public String getTalkerName() {
		return talkerName;
	}

	public ArticleInfo setTalkerName(String talkerName) {
		this.talkerName = talkerName;
		return this;
	}

	public int getResponserId() {
		return responserId;
	}

	public ArticleInfo setResponserId(int responserId) {
		this.responserId = responserId;
		return this;
	}

	public String getResponseName() {
		return responseName;
	}

	public ArticleInfo setResponseName(String responseName) {
		this.responseName = responseName;
		return this;
	}

	public String getHeadImgPathName() {
		return headImgPathName;
	}

	public ArticleInfo setHeadImgPathName(String headImgPathName) {
		this.headImgPathName = headImgPathName;
		return this;
	}
	public String getDate() {
		return date;
	}
	public ArticleInfo setDate(String date) {
		this.date = date;
		return this;
	}
	
}
