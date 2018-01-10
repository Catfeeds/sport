package com.sport.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.sport.dao.PlaceProductDao;
import com.sport.dto.ComplexSearchCondition;
import com.sport.entity.Company;
import com.sport.entity.Image;
import com.sport.entity.PlaceProduct;
import com.sport.entity.Product;
import com.sport.entity.ProductType;
import com.sport.entity.Site;
import com.sport.exception.PromptException;
import com.sport.exception.RootException;


@Component
public class PlaceProductService  extends RootService{
	private static final String ENTITY_NAME="PlaceProduct";
	private PlaceProductDao placeProductDao;

	public PlaceProductDao getPlaceProductDao() {
		return placeProductDao;
	}
	@Resource
	public PlaceProductService setPlaceProductDao(PlaceProductDao placeProductDao) {
		this.placeProductDao = placeProductDao;
		return this;
	}
	public void add(PlaceProduct product) throws RootException{
		if(product==null)
			throw new RootException(RootException.NEED_MORE_ADD_INFO);	
		product.setComments(null)
				.setHasBargin(false)
				.setHasBegin(false)
				.setHasTop(true)
				.setScore(PlaceProduct.DEFAULT_SCORE)
				.setTotalSoldNumber(0);
		if(product.getLevel()!=null&&(product.getLevel().getId()>0))
			;
		else
			product.setLevel(null);
		if(product.getCurrentImage()!=null||(product.getMidImages()==null)||(product.getMidImages().size()<1));
		else{
			product.setCurrentImage(product.getMidImages().get(0));
		}			
		placeProductDao.save(product);
	}
	
	public void delete(PlaceProduct product) throws RootException{		
		if(product==null||(product.getId()<=0))
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);	
		 placeProductDao.delete(product);
	}
	public void delete(int id) throws RootException{		
		if(id<=0)
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);	
		 placeProductDao.delete(id);
	}
	//少量数据加载后再更新
	public void update(PlaceProduct p) throws RootException{
		if(p==null||(p.getId()<=0))
			throw new RootException(RootException.NEED_MORE_UPDATE_INFO);	
		placeProductDao.update(p);
	}
	//大量数据更新操作
	public PlaceProduct alter(PlaceProduct p) throws RootException{
		if(p==null||(p.getId()<=0))
			throw new RootException(RootException.NEED_MORE_UPDATE_INFO);	
		PlaceProduct product=placeProductDao.load(p);
		p.setId(0);
		product.setBargainPrice(p.getBargainPrice())
			.setNormalPrice(p.getNormalPrice())
			.setDetail(p.getDetail())
			.setIntroduction(p.getIntroduction())
			//.setLevel(p.getLevel())
			.setType(p.getType())				
			.setProductName(p.getProductName());
		if(p.getLevel()!=null)
			product.setLevel(p.getLevel());
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
		placeProductDao.update(product);
		return product;
	}
	
	public PlaceProduct load(PlaceProduct product) throws RootException{
		if(product==null||(product.getId()<=0))
			throw new RootException(RootException.NEED_MORE_FIND_INFO);	
		return placeProductDao.load(product);			
	}
	public PlaceProduct load(int id) throws RootException{
		if(id<=0)
			throw new RootException(RootException.NEED_MORE_FIND_INFO);	
		return placeProductDao.load(id);			
	}
	
	public  int findAll(List<PlaceProduct> products,PlaceProduct product,
			int pageNumber,
			int pageSize
			){
		return findAll( products,product,pageNumber,pageSize,null,true);
	}
	//按某列排序查看会员信息
	public  int findAll(List<PlaceProduct> products,PlaceProduct product,
			int pageNumber,
			int pageSize,
			String orderByColumn,
			boolean isAsc){
		return placeProductDao.findAll( products,product,pageNumber,pageSize,null,orderByColumn,isAsc);
	}
	public boolean deleteSelectedProducts(String ids) throws PromptException {
			int id=0;
			for(String idStr:ids.split(",")){
				try{
					if((id=Integer.parseInt(idStr))<=0)
						continue;
					PlaceProduct p=(PlaceProduct)new PlaceProduct().setId(id);
					delete(p);
				}catch(Exception e){
					e.printStackTrace();
					throw new PromptException("删除id为："+id+"的产品失败！请检查是否存在该商品，若存在，请重试！");
				}
			}
			return true;
	}
	public List<PlaceProduct> getProductsByType(ProductType type,Site site){
		List<PlaceProduct> products=new ArrayList<PlaceProduct>();
		placeProductDao.getProductsByType(products,site,type);
		return products;
	}
	public int simpleSearchedPlaceProducts(ComplexSearchCondition condition,
			List<PlaceProduct> placeProducts, int pageNumber, int pageSize) {
		return placeProductDao.simpleSearchedPlaceProducts(condition,placeProducts,pageNumber,pageSize);
	}
	public int searchedPlaceProducts(ComplexSearchCondition condition,
			List<PlaceProduct> placeProducts, int pageNumber, int pageSize) {
		return placeProductDao.searchedPlaceProducts(condition,placeProducts,pageNumber,pageSize);
	}
}
