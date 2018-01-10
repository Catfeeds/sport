package com.sport.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.sport.dao.CoachProductDao;
import com.sport.entity.Company;
import com.sport.entity.Image;
import com.sport.entity.CoachProduct;
import com.sport.exception.PromptException;
import com.sport.exception.RootException;


@Component
public class CoachProductService  extends RootService{
	private static final String ENTITY_NAME="CoachProduct";
	private CoachProductDao coachProductDao;

	public CoachProductDao getCoachProductDao() {
		return coachProductDao;
	}
	@Resource
	public CoachProductService setCoachProductDao(CoachProductDao coachProductDao) {
		this.coachProductDao = coachProductDao;
		return this;
	}
	public void add(CoachProduct product) throws RootException{
		if(product==null)
			throw new RootException(RootException.NEED_MORE_ADD_INFO);	
		product.setComments(null)
				.setHasBargin(false)
				.setHasBegin(false)
				.setHasTop(true)
				.setScore(CoachProduct.DEFAULT_SCORE)
				.setTotalSoldNumber(0);
		if(product.getLevel()!=null&&(product.getLevel().getId()>0));
		else
			product.setLevel(null);
		if(product.getCurrentImage()!=null||(product.getMidImages()==null)||(product.getMidImages().size()<1));
		else{
			product.setCurrentImage(product.getMidImages().get(0));
		}			
		coachProductDao.save(product);
	}
	
	public void delete(CoachProduct product) throws RootException{		
		if(product==null||(product.getId()<=0))
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);	
		 coachProductDao.delete(product);
	}
	public void delete(int id) throws RootException{		
		if(id<=0)
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);	
		 coachProductDao.delete(id);
	}
	//少量数据加载后再更新
	public void update(CoachProduct p) throws RootException{
		if(p==null||(p.getId()<=0))
			throw new RootException(RootException.NEED_MORE_UPDATE_INFO);	
		coachProductDao.update(p);
	}
	//大量数据更新操作
	public CoachProduct alter(CoachProduct p) throws RootException{
		if(p==null||(p.getId()<=0))
			throw new RootException(RootException.NEED_MORE_UPDATE_INFO);	
		CoachProduct product=coachProductDao.load(p);
		p.setId(0);
		product.setEmployNumber(p.getEmployNumber())
			.setBargainPrice(p.getBargainPrice())
			.setNormalPrice(p.getNormalPrice())
			.setDetail(p.getDetail())
			.setIntroduction(p.getIntroduction())
			.setLevel(p.getLevel())
			.setType(p.getType())			
			.setProductName(p.getProductName());
		List<Image> bigImages = new ArrayList<Image>();
		List<Image> midImages = new ArrayList<Image>();
		List<Image> smallImages = new ArrayList<Image>();
		// 设置产品与图片的映射关系
		if (product.getBigImages() != null) {
			if (p.getBigImages() != null) {
				for (Image image : p.getBigImages()) {					
					product.getBigImages().add(image);
				}
			}
		} else {
			if (p.getBigImages() != null) {
				for (Image image : p.getBigImages()) {
					bigImages.add(image);
				}
				product.setBigImages(bigImages);
			}
		}
		if (product.getMidImages() != null) {
			if (p.getMidImages() != null)
				for (Image image : p.getMidImages()) {
					product.getMidImages().add(image);
				}
		} else {
			if (p.getMidImages() != null) {
				for (Image image : p.getMidImages()) {
					midImages.add(image);
				}
				product.setMidImages(midImages);
			}

		}
		if (product.getSmallImages() != null) {
			if (p.getSmallImages() != null) {
				for (Image image : p.getSmallImages()) {					
					product.getSmallImages().add(image);
				}
			}
		} else {
			if (p.getSmallImages() != null) {
				for (Image image : p.getSmallImages()) {
					smallImages.add(image);
				}
				product.setSmallImages(smallImages);
			}

		}
		if (product.getCurrentImage() == null
				&& (product.getMidImages() != null && (product.getMidImages()
						.size() > 0)))
			product.setCurrentImage(product.getMidImages().get(0));
		coachProductDao.update(product);
		return product;
	}
	
	public CoachProduct load(CoachProduct product) throws RootException{
		if(product==null||(product.getId()<=0))
			throw new RootException(RootException.NEED_MORE_FIND_INFO);	
		return coachProductDao.load(product);			
	}
	public CoachProduct load(int id) throws RootException{
		if(id<=0)
			throw new RootException(RootException.NEED_MORE_FIND_INFO);	
		return coachProductDao.load(id);			
	}
	
	public  int findAll(List<CoachProduct> products,CoachProduct product,
			int pageNumber,
			int pageSize
			){
		return findAll( products,product,pageNumber,pageSize,null,true);
	}
	//按某列排序查看会员信息
	public  int findAll(List<CoachProduct> products,CoachProduct product,
			int pageNumber,
			int pageSize,
			String orderByColumn,
			boolean isAsc){
		return coachProductDao.findAll( products,product,pageNumber,pageSize,null,orderByColumn,isAsc);
	}
	public boolean deleteSelectedProducts(String ids) throws PromptException {
			int id=0;
			for(String idStr:ids.split(",")){
				try{
					if((id=Integer.parseInt(idStr))<=0)
						continue;
					CoachProduct p=(CoachProduct)new CoachProduct().setId(id);
					delete(p);
				}catch(Exception e){
					e.printStackTrace();
					throw new PromptException("删除id为："+id+"的产品失败！请检查是否存在该商品，若存在，请重试！");
				}
			}
			return true;
	}
	
}
