package com.sport.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import net.sf.json.JSONArray;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.sport.dto.CoachProductInfo;
import com.sport.dto.Page;
import com.sport.entity.Company;
import com.sport.entity.Manager;
import com.sport.entity.CoachProduct;
import com.sport.entity.Level;
import com.sport.entity.Product;
import com.sport.entity.ProductType;
import com.sport.entity.Site;
import com.sport.exception.PromptException;
import com.sport.exception.RootException;
import com.sport.exception.ServerErrorException;
import com.sport.service.CoachProductService;
import com.sport.service.LevelService;
import com.sport.service.ProductTypeService;

@Component
@Scope("prototype")
public class CoachProductAction extends RootAction {
	private CoachProduct product;
	private CoachProductService coachProductService;
	private List<CoachProduct> products;
	// 添加获取修改运动场地时,需要用到运动场地等级和产品分类,同步获取时需要
	private ProductType type;
	private ProductTypeService productTypeService;
	private Level level;
	private LevelService levelService;
	private List<ProductType> types;
	private List<Level> levels;// 有哪些等级
	private Site site;
	// 到添加场地产品页面
	public String toAddProduct() {
		levels=levelService.findByType(new Level().setType(types.get(0)).setFlag(Level.TYPE_COACH) );
		return "addCoachProduct";
	}
	//异步获取某分类下的教练产品
	public void getProductByType() throws ServerErrorException, PromptException{
		this.getResponseAndOut();
		JSONArray json =new JSONArray();
		try{
			products=new ArrayList<CoachProduct>();
			coachProductService.findAll(products, product, 1,30);
			json=JSONArray.fromObject(CoachProductInfo.formCoachProducts(products));
		}catch(Exception e){
			e.printStackTrace();
			json.add(ServerErrorException.SERVER_ERROR);
		}
		out.println(json);
		this.closeOut();
	}
	// 上传运动场地产品相关信息
	public void uploadCoachProduct() throws PromptException,
			ServerErrorException {
		try {
			Company company=this.getCurrentCompany();
			product.setCompany(company);
			coachProductService.add(product);
		} catch (RootException e) {
			errorMsg = e.toString();
			throw new PromptException(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		errorMsg="上传产品信息成功！";
		throw new PromptException(errorMsg);
	}

	// 删除某种运动场地，一般只是平台超级管理员才能删
	public void deleteCoachProduct() throws ServerErrorException {
		this.getResponseAndOut();
		JSONArray json = new JSONArray();
		try {
			coachProductService.delete(product);
			json.add(true);
			json.add("删除该产品成功！");
		} catch (RootException e) {
			json.add(false);
			json.add(e.toString());
		} catch (Exception e) {
			e.printStackTrace();
			json.add(false);
			json.add(RootException.SYSTEM_ERROR);
		}
		out.println(json);
		this.closeOut();
	}

	// 查看某种运动场地详情
	public String coachProductDetail() throws PromptException,
			ServerErrorException {
		try {
			product = coachProductService.load(product);
		} catch (RootException e) {
			errorMsg = e.toString();
			throw new PromptException(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "coachProductDetail";
	}

	// 修改某种运动场地产品的基本信息(反射实现)，一般只是超级管理员才能修改
	public void updateCoachProduct() throws PromptException,
			ServerErrorException {
		try {			
			coachProductService.alter(product);
		} catch (RootException e) {
			errorMsg = e.toString();
			throw new PromptException(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		errorMsg="修改产品信息成功！";
		throw new PromptException(errorMsg);
	}

	// 获取所有运动场地产品(分页显示)
	public String coachProductList() throws PromptException {
		System.out.println("进入到教练列表方法！");
		try {
			products = new ArrayList<CoachProduct>();
			Company company = this.getCurrentCompany();
			if(product==null)
				product=new CoachProduct();
			
			product.setCompany(company);
			if (type == null || (type.getId() <= 0))// 第一次展现该页面默认出现的公司所有产品列表
			{
				page.setTotalItemNumber(coachProductService.findAll(products,product,
						page.getPageNumber(), page.getPageSize()));
			} else {
				type = productTypeService.load(type);
				page.setTotalItemNumber(coachProductService.findAll(
							products,product, page.getPageNumber(), page.getPageSize()));
			}
			if(product.getType()==null){
				product.setType(types.get(0));				
			}
			type=productTypeService.load(product.getType());
			System.out.println(products.size());
		} catch (Exception e) {
			errorMsg = "获取产品列表失败！";
			e.printStackTrace();
			throw new PromptException(errorMsg);
		}
		return "coachProductList";
	}

	// 批量删除选中产品,异步操作
	public void deleteSelectedProducts() throws PromptException,
			ServerErrorException {
		System.out.println(this.getIds());
		this.getResponseAndOut();
		JSONArray json = new JSONArray();
		try {
			Manager m = (Manager) session.get("currentManager");
			if (m == null) {
				errorMsg = "您还未登录，或者长时间未操作，请重新登录！";
				throw new PromptException(errorMsg);
			}
			if (coachProductService.deleteSelectedProducts(this.getIds())) {
				json.add(true);
				json.add("删除选中产品成功！");
			} else {
				json.add(false);
				json.add("删除选中产品失败!");
			}
		} catch (RootException e) {
			e.printStackTrace();
			errorMsg = e.toString();
			json.add(true);
			json.add(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			json.add(false);
			json.add(RootException.SYSTEM_ERROR);
		}
		out.println(json);
		this.closeOut();
	}
	// 将该公司某产品下架,修改产品状态，用户可查看，但无法购买,异步操作
		public void disableProduct() throws IOException, PromptException, ServerErrorException {
			this.getResponseAndOut();
			JSONArray json=new JSONArray();
			try{	
				Manager m=(Manager)session.get("currentManager");
				if(m==null){
					errorMsg="您还未登录，或者长时间未操作，请重新登录！";
					throw new PromptException(errorMsg);
				}
				product=coachProductService.load(product);
				product.setHasBegin(!product.isHasBegin());
				coachProductService.update(product);
				json.add(true);
				if(product.isHasBegin())
					json.add("产品上架成功！");
				else
					json.add("产品下架成功！");
			}catch(PromptException e){
				errorMsg=e.toString();
				json.add( false);
				json.add(errorMsg);
			}catch(Exception e){
				e.printStackTrace();
				json.add( false);
				json.add(RootException.SYSTEM_ERROR);
			}
			out.println(json);
			this.closeOut();
		}
		//将商品置顶，首页推荐商品
		public void topProduct() throws PromptException, IOException, ServerErrorException{
			this.getResponseAndOut();
			JSONArray json=new JSONArray();
			try{	
				Manager m=(Manager)session.get("currentManager");
				if(m==null){
					errorMsg="您还未登录，或者长时间未操作，请重新登录！";
					throw new PromptException(errorMsg);
				}
				System.out.println(product.getId());
				product=coachProductService.load(product);
				product.setHasTop(!product.isHasTop());
				coachProductService.update(product);
				json.add(true);
				if(product.isHasTop())
					json.add("产品置顶成功！");
				else
					json.add("产品取消置顶成功！");
			}catch(PromptException e){
				errorMsg=e.toString();
				json.add( false);
				json.add(errorMsg);			
			}catch(Exception e){
				e.printStackTrace();
				json.add( false);
				json.add(RootException.SYSTEM_ERROR);
			}
			out.println(json);
			this.closeOut();
		}
	/********** 注入代码 **********/

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
		types = productTypeService.findRootTypes();
	}

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
		levels = new ArrayList<Level>();
		levelService.findAll(levels, 1, 20);
	}

	public List<ProductType> getTypes() {
		return types;
	}

	public void setTypes(List<ProductType> types) {
		this.types = types;

	}

	public List<Level> getLevels() {
		return levels;
	}

	public void setLevels(List<Level> levels) {
		this.levels = levels;

	}

	public CoachProductService getCoachProductService() {
		return coachProductService;
	}

	@Resource
	public void setCoachProductService(CoachProductService coachProductService) {
		this.coachProductService = coachProductService;

	}

	public CoachProduct getProduct() {
		return product;
	}

	public void setProduct(CoachProduct product) {
		this.product = product;
	}

	public List<CoachProduct> getProducts() {
		return products;
	}

	public void setProducts(List<CoachProduct> products) {
		this.products = products;
	}

	public Site getSite() {
		return site;
	}

	public void setSite(Site site) {
		this.site = site;
		
	}

}
