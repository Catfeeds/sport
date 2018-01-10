package com.sport.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sport.dao.RootDao;
import com.sport.entity.Product;
import com.sport.exception.PromptException;

@Service
public class RootService {
	private RootDao rootDao;

	public RootDao getRootDao() {
		return rootDao;
	}
	@Resource
	public RootService setRootDao(RootDao rootDao) {
		this.rootDao = rootDao;
		return this;
	}
	
	
}
