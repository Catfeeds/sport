package com.sport.action;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import net.sf.json.JSONArray;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.sport.dto.LevelInfo;
import com.sport.entity.Level;
import com.sport.entity.ProductType;
import com.sport.exception.PromptException;
import com.sport.exception.RootException;
import com.sport.exception.ServerErrorException;
import com.sport.service.LevelService;
import com.sport.service.ProductTypeService;
@Component
@Scope("prototype")
public class LevelAction extends RootAction{
/*
 * 产品或服务的等级增删改查操作
 */
	private Level level;
	private LevelService levelService;
	private List<Level> levels;
	private ProductType type;
	private ProductTypeService productTypeService;
	private List<ProductType> types;
	public void getLevelByType() throws ServerErrorException{
		this.getResponseAndOut();
		JSONArray json=new JSONArray();
		try {
			levels=levelService.findByType(level);
			json=JSONArray.fromObject(LevelInfo.fromLevels(levels));
		} catch(Exception e){
			e.printStackTrace();
			json.add(false);
			json.add(RootException.SYSTEM_ERROR);
		}	
		System.out.println(json);
		out.println(json);
		this.closeOut();
	}
	public String toAlterLevel() throws PromptException, ServerErrorException{
		try {
			level=levelService.load(level);
		} catch (RootException e) {
			errorMsg=e.toString();
			throw new PromptException(errorMsg);
		}catch(Exception e){
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "alterLevel";
	}
	//增加一个级别
	public String addLevel() throws ServerErrorException, PromptException{
		System.out.println("typeId:"+type);		
		try {
			type=productTypeService.load(type);
			level.setType(type);
			levelService.add(level);			
		} catch (RootException e) {
			errorMsg=e.toString();
			throw new PromptException(errorMsg);
		}catch(Exception e){
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return levelList();
	}
	//删除一个级别
	public void deleteLevel() throws ServerErrorException{
		this.getResponseAndOut();
		JSONArray json=new JSONArray();
		try {
			levelService.delete(level);
			json.add(true);
			json.add("删除等级成功！");
		} catch (RootException e) {
			json.add(false);
			json.add(e.toString());
		}catch(Exception e){
			json.add(true);
			json.add(RootException.SYSTEM_ERROR);
		}		
		out.println(json);
		this.closeOut();
	}
	//批量删除等级信息
	public void deleteSelectedLevels() throws ServerErrorException{
		this.getResponseAndOut();
		JSONArray json=new JSONArray();
		if(levelService.deleteSelectedLevels(ids)){
			json.add(true);
			json.add("删除选中的等级信息成功！");
		}else{
			json.add(false);
			json.add("删除失败，请重试！");
		}	
		out.println(json);
		this.closeOut();
	}
	//修改等级信息
	public String alterLevel() throws ServerErrorException, PromptException{		
		try {
			levelService.update(level);
			return levelList();
		} catch (RootException e) {
			errorMsg=e.toString();			
		}catch(Exception e){
			e.printStackTrace();
			errorMsg=RootException.SYSTEM_ERROR;
		}
		throw new PromptException(errorMsg);
	}
	
	//分页查看分类信息
	public String levelList(){
		//获取一页等级信息
		levels = new ArrayList<Level>();
		if (page.getPageNumber() != 0)
			page.setTotalItemNumber(levelService.findAll(levels,
					page.getPageNumber(), page.getPageSize()));
		else
			page.setTotalItemNumber(levelService.findAll(levels, 1,
					page.getPageSize()));
		System.out.println("levels:"+levels.size());
		return "levelList";
	}
	/*********注入代码*********/
	public Level getLevel() {
		return level;
	}
	public void setLevel(Level level) {
		this.level = level;
	}
	public LevelService getLevelService() {
		return levelService;
	}
	@Resource
	public void setLevelService(LevelService levelService) {
		this.levelService = levelService;
	}
	public List<Level> getLevels() {
		return levels;
	}
	public void setLevels(List<Level> levels) {
		this.levels = levels;
	}
	public ProductType getType() {
		return type;
	}
	public void setType(ProductType type) {
		this.type = type;
	}
	public ProductTypeService getProductTypeService() {
		return productTypeService;
	}
	@Resource
	public void setProductTypeService(ProductTypeService productTypeService) {
		this.productTypeService = productTypeService;
		types=productTypeService.findRootTypes();
	}
	public List<ProductType> getTypes() {
		return types;
	}
	public void setTypes(List<ProductType> types) {
		this.types = types;
	}
	
}
