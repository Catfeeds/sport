package com.sport.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.sport.dao.SiteDao;
import com.sport.entity.Company;
import com.sport.entity.Image;
import com.sport.entity.PlaceProduct;
import com.sport.entity.Site;
import com.sport.exception.PromptException;
import com.sport.exception.RootException;


@Component
public class SiteService  extends RootService{
	private static final String ENTITY_NAME="Site";
	private SiteDao siteDao;
	private ImageService imageService;
	public SiteDao getSiteDao() {
		return siteDao;
	}
	@Resource
	public SiteService setSiteDao(SiteDao siteDao) {
		this.siteDao = siteDao;
		return this;
	}
	public ImageService getImageService() {
		return imageService;
	}
	@Resource
	public void setImageService(ImageService imageService) {
		this.imageService = imageService;
	}
	public void add(Site site) throws RootException{
		if(site==null)
			throw new RootException(RootException.NEED_MORE_ADD_INFO);	
		//先设置场馆的关联信息
		/*if(site.getImageIds()!=null){//设置场馆图片
			List<Image> images=new ArrayList<Image>();
			for(int id:site.getImageIds()){
				Image image=imageService.load(new Image().setId(id));
				images.add(image);
			}
			site.setImages(images);
		}*/
		siteDao.save(site);
	}
	
	public void delete(Site site) throws RootException{		
		if(site==null||(site.getId()<=0))
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);	
		 siteDao.delete(site);
	}
	public void delete(int id) throws RootException{		
		if(id<=0)
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);	
		 siteDao.delete(id);
	}
	/**更新少量信息*/
	public void alter(Site site) throws RootException{
		if(site==null||(site.getId()<=0))
			throw new RootException(RootException.NEED_MORE_UPDATE_INFO);	
		siteDao.update(site);
	}
	public void update(Site site) throws RootException{
		if(site==null||(site.getId()<=0))
			throw new RootException(RootException.NEED_MORE_UPDATE_INFO);	
		Site oldSite=siteDao.load(site);
		//获取修改后的普通属性
		oldSite.setDayJobTime(site.getDayJobTime())
				.setDetail(site.getDetail())
				.setRoute(site.getRoute())
				.setSellProducts(site.getSellProducts())
				.setService(site.getService())
				.setSiteAddress(site.getSiteAddress())
				.setSiteName(site.getSiteName())
				.setSitePhone(site.getSitePhone())
				.setWeekJobTime(site.getWeekJobTime())
				.setXAddr(site.getXAddr())
				.setYAddr(site.getYAddr())
				.setAddress(site.getAddress())
				;
		System.out.println("address:"+site.getAddress());
		//修改其它关联
		// 设置场地与图片的映射关系
		if (oldSite.getImages() != null) {
			if (site.getImages() != null) {
				oldSite.getImages().addAll(site.getImages());
			}
		} else {
			if (site.getImages() != null) {
				oldSite.setImages(site.getImages());
			}
		}		
		site.setId(0);//清除临时对象,避免冲突
		siteDao.update(oldSite);
	}
	
	public Site load(Site site) throws RootException{
		if(site==null||(site.getId()<=0))
			throw new RootException(RootException.NEED_MORE_FIND_INFO);	
		return siteDao.load(site);			
	}
	public Site load(long id) throws RootException{
		if(id<=0)
			throw new RootException(RootException.NEED_MORE_FIND_INFO);	
		return siteDao.load(id);			
	}
	
	public  int findAll(List<Site> sites,Site site,
			int pageNumber,
			int pageSize
			){
		return findAll( sites,site,pageNumber,pageSize,null,true);
	}
	//按某列排序查看会员信息
	public  int findAll(List<Site> sites,Site site,
			int pageNumber,
			int pageSize,
			String orderByColumn,
			boolean isAsc){
		//按推荐置顶排序
		return siteDao.findAll( sites,site,pageNumber,pageSize,null,"topValue",false);
	}
	public boolean deleteSelectedSites(String ids) throws PromptException {
		int id=0;
		for(String idStr:ids.split(",")){
			try{
				if((id=Integer.parseInt(idStr))<=0)
					continue;
				Site s=(Site)new Site().setId(id);
				delete(s);
			}catch(Exception e){
				e.printStackTrace();
				throw new PromptException("删除id为："+id+"的场馆失败！请检查是否存在该场馆，若存在，请重试！");
			}
		}
		return true;
	}
}
