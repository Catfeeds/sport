package com.sport.action;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import net.sf.json.JSONArray;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.sport.entity.Company;
import com.sport.entity.Level;
import com.sport.entity.Place;
import com.sport.entity.PlaceProduct;
import com.sport.entity.ProductType;
import com.sport.entity.Site;
import com.sport.exception.PromptException;
import com.sport.exception.RootException;
import com.sport.exception.ServerErrorException;
import com.sport.service.LevelService;
import com.sport.service.PlaceProductService;
import com.sport.service.PlaceService;
import com.sport.service.ProductTypeService;
import com.sport.service.SiteService;

//场地信息处理
@Component
@Scope("prototype")
public class PlaceAction extends RootAction {
	private Place place;
	private PlaceService placeService;
	private List<Place> places;
	private Site site;// 场地是属于某个场馆的，所以会用到场馆信息的操作
	private SiteService siteService;
	private List<ProductType> allTypes;// 所有具体的分类信息,调用本action任何方法后，都可以直接使用该分类集
	private ProductType type;// 当前选中的分类
	private ProductTypeService productTypeService;
	private List<Level> levels;
	private LevelService levelService;
	private PlaceProduct placeProduct;
	private List<PlaceProduct> products;// 某分类下的
	private PlaceProductService placeProductService;

	/**** 获取后台数据再定向到某页面 ****/
	// 到修改场地信息的页面，需要获取场地的原始信息,并显示给用户
	public String toAlterPlace() {
		return "alterPlace";
	}

	/**********
	 * 功能函数
	 * 
	 * @throws PromptException
	 * @throws ServerErrorException
	 *********/
	// 为某个场馆添加一个场地
	public void addPlace() throws PromptException, ServerErrorException {
		System.out.println("场地添加方法");
		this.getResponseAndOut();
		JSONArray json = new JSONArray();
		try {
			//System.out.println(place.getSite().getId());
			placeProduct=placeProductService.load(place.getProduct());
			place.setSite(placeProduct.getSite());
			placeService.add(place);

			json.add(true);
		} catch (RootException e) {
			json.add(false);
			json.add(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			json.add(false);
			json.add("场地添加失败！");
		} finally {
			out.println(json);
			this.closeOut();
		}
	}

	// 某个场馆的某场地详细信息
	public String placeDetail() throws PromptException, ServerErrorException {
		try {
			site = siteService.load(site);
		} catch (RootException e) {
			e.printStackTrace();
			throw new PromptException(e.toString());
		}catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "placeDetail";
	}

	// 某场馆的场地列表
	public String placeList() throws ServerErrorException, PromptException {
		try {
			places = new ArrayList<Place>();			
			if(placeProduct!=null)
				placeProduct=placeProductService.load(placeProduct);
			page.setTotalItemNumber(placeService.findAll(places,placeProduct,
					page.getPageNumber(), page.getPageSize()));
			System.out.println(places.size());
		} catch(PromptException e){
			errorMsg=e.toString();
			throw e;
		}catch(RootException e){
			errorMsg=e.toString();
			throw new PromptException(e.toString());
		}catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "placeList";
	}

	// 修改某个场地的基本信息
	public String alterPlace() throws PromptException, ServerErrorException {
		try {
			site = (Site) session.get("currentSite");
			place.setSite(site);
			placeService.update(place);
			//加载场地分类信息
			place=placeService.load(place);
			placeProduct=place.getProduct();			
		} catch (RootException e) {
			errorMsg = e.toString();
			throw new PromptException(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		placeList();
		return "placeList";
	}


	// 删除一个场地
	public void deletePlace() throws ServerErrorException {
		this.getResponseAndOut();
		JSONArray json = new JSONArray();
		try {
			placeService.delete(place);
			json.add(true);
		} catch (Exception e) {
			e.printStackTrace();
			json.add(false);
			json.add(RootException.SYSTEM_ERROR);
		} finally {
			out.println(json);
			this.closeOut();
		}
	}

	// 批量删除场馆信息
	public void deleteSelectedPlace() {
		System.out.println("批量删除场地");
		JSONArray json = new JSONArray();
		try {
			this.getResponseAndOut();
			System.out.println(this.getIds());
			if (placeService.deleteSelectedPlaces(this.getIds())) {
				json.add(true);
			} else {
				json.add(false);
				json.add(errorMsg);
			}
		} catch (Exception e) {
			e.printStackTrace();
			json.add(false);
			json.add(RootException.SYSTEM_ERROR);

		} finally {
			out.println(json);
			this.closeOut();
		}
	}

	/*********** 注入代码 ***********/
	public Place getPlace() {
		return place;
	}

	public void setPlace(Place place) {
		this.place = place;

	}

	public PlaceService getPlaceService() {
		return placeService;
	}

	@Resource
	public void setPlaceService(PlaceService placeService) {
		this.placeService = placeService;

	}

	public List<Place> getPlaces() {
		return places;
	}

	public void setPlaces(List<Place> places) {
		this.places = places;

	}

	public Site getSite() {
		return site;
	}

	public void setSite(Site site) {
		this.site = site;

	}

	public SiteService getSiteService() {
		return siteService;
	}

	@Resource
	public void setSiteService(SiteService siteService) {
		this.siteService = siteService;
	}

	@Resource
	public void setProductTypeService(ProductTypeService productTypeService) {
		this.productTypeService = productTypeService;
		try {
			allTypes = productTypeService.findTypes();
		} catch (RootException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public ProductTypeService getProductTypeService() {
		return productTypeService;
	}

	public List<ProductType> getAllTypes() {
		return allTypes;
	}

	public void setAllTypes(List<ProductType> allTypes) {
		this.allTypes = allTypes;
	}

	public ProductType getType() {
		return type;
	}

	public void setType(ProductType type) {
		this.type = type;

	}

	public List<Level> getLevels() {
		return levels;
	}

	public void setLevels(List<Level> levels) {
		this.levels = levels;

	}

	public LevelService getLevelService() {
		return levelService;
	}

	@Resource
	public void setLevelService(LevelService levelService) {
		this.levelService = levelService;

	}

	public PlaceProduct getPlaceProduct() {
		return placeProduct;
	}

	public void setPlaceProduct(PlaceProduct placeProduct) {
		this.placeProduct = placeProduct;
	}

	public List<PlaceProduct> getProducts() {
		return products;
	}

	public void setProducts(List<PlaceProduct> products) {
		this.products = products;
	}

	public PlaceProductService getPlaceProductService() {
		return placeProductService;
	}

	@Resource
	public void setPlaceProductService(PlaceProductService placeProductService) {
		this.placeProductService = placeProductService;
	}

}
