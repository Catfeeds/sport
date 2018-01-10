package com.sport.dto;

import java.util.List;

public class PageArticleInfo {
	private Page page;
	private List<ArticleInfo> infos;
	public List<ArticleInfo> getInfos() {
		return infos;
	}
	public PageArticleInfo setInfos(List<ArticleInfo> infos) {
		this.infos = infos;
		return this;
	}
	public Page getPage() {
		return page;
	}
	public PageArticleInfo setPage(Page page) {
		this.page = page;
		return this;
	}
}
