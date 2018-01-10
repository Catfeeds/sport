package com.sport.dto;

import java.util.ArrayList;
import java.util.List;

import com.sport.entity.Level;
import com.sport.entity.ProductType;

public class LevelInfo {
	private int id;
	private String levelName;//等级名
	private int flag;//目前区别是教练服务、或者是场地等级(0代表场地、1代表教练)
	private String introduction;//简介
	public static List<LevelInfo> fromLevels(List<Level> levels){
		List<LevelInfo> infos=new ArrayList<LevelInfo>();
		for(Level level:levels){
			infos.add(new LevelInfo().setId(level.getId())
							.setFlag(level.getFlag())
							.setLevelName(level.getLevelName())
							.setIntroduction(level.getIntroduction())
					);
		}
		return infos;
	}
	public int getId() {
		return id;
	}
	public LevelInfo setId(int id) {
		this.id = id;
		return this;
	}
	public String getLevelName() {
		return levelName;
	}
	public LevelInfo setLevelName(String levelName) {
		this.levelName = levelName;
		return this;
	}
	public int getFlag() {
		return flag;
	}
	public LevelInfo setFlag(int flag) {
		this.flag = flag;
		return this;
	}
	public String getIntroduction() {
		return introduction;
	}
	public LevelInfo setIntroduction(String introduction) {
		this.introduction = introduction;
		return this;
	}
	
}
