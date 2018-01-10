package com.sport.dto;

import java.util.ArrayList;
import java.util.List;

import com.sport.entity.Forum;
import com.sport.entity.ProductType;
import com.sport.service.ForumService;
import com.sport.service.ProductTypeService;

public class TypeForumList {
	private ForumService forumService;
	private List<Forum> forums;
	private ProductType rootType;
	private ProductTypeService productTypeService;
	public void init(ProductType rootType,ForumService forumService,ProductTypeService productTypeService){
		this.rootType=rootType;
		this.forumService=forumService;
		this.productTypeService=productTypeService;
		forums=new ArrayList<Forum>();
		forumService.findAll(forums, new Forum().setType(new ProductType().setParentProductType(rootType)), 1, 20);//每种根分类最多只能20个社交圈		
	}
	
	/******注入代码******/
	public ForumService getForumService() {
		return forumService;
	}
	public void setForumService(ForumService forumService) {
		this.forumService = forumService;
	}
	public List<Forum> getForums() {
		return forums;
	}
	public void setForums(List<Forum> forums) {
		this.forums = forums;
	}
	public ProductType getRootType() {
		return rootType;
	}
	public void setRootType(ProductType rootType) {
		this.rootType = rootType;
	}
	public ProductTypeService getProductTypeService() {
		return productTypeService;
	}
	public void setProductTypeService(ProductTypeService productTypeService) {
		this.productTypeService = productTypeService;
	}
}
