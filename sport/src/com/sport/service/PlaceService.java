package com.sport.service;

import java.util.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.sport.dao.PlaceDao;
import com.sport.dao.PlaceProductDao;
import com.sport.dao.UpdateProgressDao;
import com.sport.dto.ComplexSearchCondition;
import com.sport.dto.Page;
import com.sport.entity.Place;
import com.sport.entity.PlacePreOrder;
import com.sport.entity.PlaceProduct;
import com.sport.entity.ProductType;
import com.sport.entity.Site;
import com.sport.entity.UpdateProgress;
import com.sport.exception.PromptException;
import com.sport.exception.RootException;
import com.sport.timer.TimerTaskQueue;

@Component
public class PlaceService extends RootService {
	private static final String ENTITY_NAME = "Place";
	private PlaceDao placeDao;
	private PlaceProductDao placeProductDao;
	private PlacePreOrderService placePreOrderService;
	private UpdateProgressDao updateProgressDao;
	public PlaceDao getPlaceDao() {
		return placeDao;
	}

	@Resource
	public PlaceService setPlaceDao(PlaceDao placeDao) {
		this.placeDao = placeDao;
		return this;
	}

	public void add(Place place) throws RootException {
		if (place == null)
			throw new RootException(RootException.NEED_MORE_ADD_INFO);
		
		placeDao.save(place);
		String number="";
		PlaceProduct product= placeProductDao.load(place.getProduct());
		if(product.getPlaces()!=null)
			number+=product.getPlaces().size();
		else
			number+="1";
		place.setPlaceNumber(number);	
		initPreOrder(place);
	}
	//更新改场地的预定信息
	public void initPreOrder(Place place) throws RootException{
		UpdateProgress update = updateProgressDao.load();
		if(update==null)//如果还从未更新过预定信息，则本次也不用更新，等系统统一更新
			return;
		
		Calendar date = Calendar.getInstance();		
		int updateDayNumber = update.getUpdateDayNumber();// 需要初始化更新该场地的预定信息		
		long tempDate = date.getTimeInMillis();
		for (int k = (update.getUpdateDayNumber() - updateDayNumber); k < update
				.getUpdateDayNumber(); k++) {//
			PlacePreOrder pOrder = new PlacePreOrder();
			int[] orderInfos = new int[]{
										1,1,1,1,1,
										1,1,1,1,1,
										1,1,1,1,1,
										1,1,1,1,1,
										1,1,1,1
			};
			date.set(date.get(Calendar.YEAR), date.get(Calendar.MONTH),
					date.get(Calendar.DAY_OF_MONTH));

			long time = date.getTimeInMillis();
			System.out.println("time:" + time);
			time += TimerTaskQueue.SCHEDULE * k;// 定位到某天
			date.setTime(new Date(time));
			pOrder.setPlace(place).setOrderInfos(orderInfos)
					.setDate(date.getTime());
			placePreOrderService.add(pOrder);
			date.setTime(new Date(tempDate));
		}
			
	}
	public void delete(Place place) throws RootException {

		if (place == null || (place.getId() <= 0))
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);
		placeDao.delete(place);
	}

	public void delete(int id) throws RootException {
		if (id <= 0)
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);
		placeDao.delete(id);
	}

	public void update(Place p) throws RootException {
		if (p == null || (p.getId() <= 0))
			throw new RootException(RootException.NEED_MORE_UPDATE_INFO);
		Place place=placeDao.load(p);
		place.setIntroduction(p.getIntroduction())
				.setPlaceName(p.getPlaceName())
				.setPlaceNumber(p.getPlaceNumber())
				.setTimePrice(p.getTimePrice());
		if(p.getProduct()!=null&&(p.getProduct().getId()>0))
			place.setProduct(p.getProduct());
		if(p.getSite()!=null&&(p.getSite().getId()>0))
			place.setSite(p.getSite());
		placeDao.update(place);
	}

	public Place load(Place place) throws RootException {
		if (place == null || (place.getId() <= 0))
			throw new RootException(RootException.NEED_MORE_FIND_INFO);
		return placeDao.load(place);
	}

	public Place load(int id) throws RootException {
		if (id <= 0)
			throw new RootException(RootException.NEED_MORE_FIND_INFO);
		return placeDao.load(id);
	}

	public int findAll(List<Place> places, int pageNumber, int pageSize) {
		return placeDao.findAll(places, pageNumber, pageSize);
	}

	// 按某列排序查看会员信息
	public int findAll(List<Place> places, int pageNumber, int pageSize,
			String orderByColumn, boolean isAsc) {
		return placeDao.findAll(places, pageNumber, pageSize, null,
				orderByColumn, isAsc);
	}

	public boolean deleteSelectedPlaces(String ids) throws PromptException {
		int id = 0;
		for (String idStr : ids.split(",")) {
			try {
				if ((id = Integer.parseInt(idStr)) <= 0)
					continue;
				Place p = (Place) new Place().setId(id);
				delete(p);
			} catch (Exception e) {
				e.printStackTrace();
				throw new PromptException("删除id为：" + id
						+ "的场地失败！请检查是否存在该场地，若存在，请重试！");
			}
		}
		return true;
	}
	//简单搜索，按或查询
	public int simpleSearchedPlaces(ComplexSearchCondition condition,
			List<Place> places, int pageNumber, int pageSize)
			throws PromptException {
		if (condition == null)
			throw new PromptException("搜索条件不能为空！");
		return placeDao.searchedPlaces(condition, places, pageNumber, pageSize);
	}
	//复杂搜索，按与查询
	public int searchedPlaces(ComplexSearchCondition condition,
			List<Place> places, int pageNumber, int pageSize)
			throws PromptException {
		if (condition == null)
			throw new PromptException("搜索条件不能为空！");
		return placeDao.searchedPlaces(condition, places, pageNumber, pageSize);
	}

	public int findAll(List<Place> places,PlaceProduct product, int pageNumber,
			int pageSize) throws RootException {
		
		return placeDao.findAll(places, product,pageNumber, pageSize);
	}
	public int findAll(List<Place> places, ProductType type,Site site, int pageNumber,
			int pageSize) throws RootException {
		if(type==null)
			throw new RootException(RootException.NEED_MORE_FIND_INFO);
		return placeDao.findAll(places,type,site,pageNumber, pageSize);
	}
	public PlacePreOrderService getPlacePreOrderService() {
		return placePreOrderService;
	}
	@Resource
	public void setPlacePreOrderService(PlacePreOrderService placePreOrderService) {
		this.placePreOrderService = placePreOrderService;
}

	public UpdateProgressDao getUpdateProgressDao() {
		return updateProgressDao;
	}
	@Resource
	public void setUpdateProgressDao(UpdateProgressDao updateProgressDao) {
		this.updateProgressDao = updateProgressDao;
	}

	public PlaceProductDao getPlaceProductDao() {
		return placeProductDao;
	}
	@Resource
	public void setPlaceProductDao(PlaceProductDao placeProductDao) {
		this.placeProductDao = placeProductDao;
		
	}
}
