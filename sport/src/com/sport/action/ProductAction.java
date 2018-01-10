package com.sport.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.sport.entity.Company;
import com.sport.entity.Image;
import com.sport.entity.Manager;
import com.sport.entity.Product;
import com.sport.entity.ProductType;
import com.sport.exception.PromptException;
import com.sport.exception.RootException;
import com.sport.exception.ServerErrorException;
import com.sport.service.CompanyService;
import com.sport.service.ImageService;
import com.sport.service.ProductService;
import com.sport.service.ProductTypeService;

@Component
@Scope("prototype")
public class ProductAction extends RootAction {

	private ProductService productService;
	private ProductTypeService productTypeService;
	private Product product;
	private Product productInfo;
	private ProductType productType;
	private CompanyService companyService;
	private ImageService imageService;
	private List<ProductType> rootTypes;
	private List<Product> products;
	
	/****** 操作逻辑代码 ******/
	// 产品添加首页,包括添加新产品、旧产品上架，以商品名标识
	//@RequiresPermissions("product:add")
	public String toAddProductPage() {
		return "addProducts";
	}
	
	//已有商品加货
	//@RequiresPermissions("product:add")
	public String toProductAdd() throws PromptException{
		try {
			productInfo=productService.load(productInfo);
			productType=productInfo.getType();
		} catch (RootException e) {
			errorMsg=e.toString();
			e.printStackTrace();
			throw new PromptException(errorMsg);
		}
		return "toProductAdd";
	}
	// 控制逻辑
	// 添加产品
	//@RequiresPermissions("product:add")
	public String addProduct() throws Exception {
		try {
			Manager m = (Manager) session.get("currentManager");
			if (m == null) {
				errorMsg = "您还未登录，无法添加商品！";
				throw new PromptException("您还未登录，无法添加商品！");
			}
			m = managerService.findManager(m);
			Company company = companyService.load(m.getCompany());
			if (company == null) {
				errorMsg = "不存在该加盟公司，无法添加产品！";
				throw new PromptException("不存在该加盟公司，无法添加产品！");
			}
			productService.add(product);
		} catch (Exception e) {
			e.printStackTrace();
			errorMsg = e.toString();
			throw e;
		}
		System.out.println("productInro Id:" + product.getId());
		return "addProductOk";
	}

	// 删除产品,异步操作	
	public void deleteProduct() throws IOException, ServerErrorException, PromptException {
		this.getResponseAndOut();
		JSONArray json=new JSONArray();
		try{	
			Manager m=(Manager)session.get("currentManager");
			if(m==null){
				errorMsg="您还未登录，或者长时间未操作，请重新登录！";
				throw new PromptException(errorMsg);
			}
			m=managerService.findManager(m);
			Company company=companyService.load(m.getCompany());
			productService.delete(new Product().setId(product.getId())
					.setProductName(product.getProductName()));
			json.add(true);
			json.add("删除产品成功！");
			
		}catch(PromptException e){
			errorMsg=e.toString();
			json.add(false);
			json.add(errorMsg);
		}catch(Exception e){
			e.printStackTrace();
			json.add(false);
			json.add(RootException.SYSTEM_ERROR);
		}
		out.println(json);
		this.closeOut();		
	}

	// 修改产品基本信息
	public String alterProductBaseInfo() throws PromptException {
		try {
			Manager m=(Manager)session.get("currentManager");
			if(m==null){
				errorMsg="您还未登录，或者长时间未操作，请重新登录！";
				throw new PromptException(errorMsg);
			}
			m=managerService.findManager(m);
			Company company=companyService.load(m.getCompany());
			productService.update(product);
		} catch (Exception e) {
			e.printStackTrace();
			errorMsg="更新产品失败,请重试！";
			throw new PromptException(errorMsg);
		}
		return "productDetail";
	}
	//修改产品所属分类,异步操作
	public void alterProductType() throws IOException, PromptException, ServerErrorException{
		this.getResponseAndOut();
		JSONArray json=new JSONArray();
		try{	
			Manager m=(Manager)session.get("currentManager");
			if(m==null){
				errorMsg="您还未登录，或者长时间未操作，请重新登录！";
				throw new PromptException(errorMsg);
			}
			m=managerService.findManager(m);
			Company company=companyService.load(m.getCompany());
			productService.alterProductType(new Product().setId(product.getId())
					.setProductName(product.getProductName())
					.setType(productType));
			json.add(true);
			json.add("修改产品所属分类成功,请刷新页面查看结果！");
			
		}catch(PromptException e){
			errorMsg=e.toString();
			json.add(false);
			json.add(errorMsg+"修改产品所属分类失败，请重试！");			
		}catch(Exception e){
			e.printStackTrace();
			json.add(false);
			json.add(RootException.SYSTEM_ERROR);
		}
		out.println(json);
		this.closeOut();		
	}
	// 获取某产品信息
	public String productDetail() throws PromptException {
		try {
			productInfo=productService.load(new Product().setId(productInfo.getId())
					.setProductName(productInfo.getProductName()));
			productType=productInfo.getType();
		} catch (RootException e) {
			e.printStackTrace();
			errorMsg="获取产品："+productInfo.getProductName()+"的详细信息失败！";
			throw new PromptException(errorMsg);
		}
		products=new ArrayList<Product>();
		productService.load(productInfo,products);
		return "productDetail";
	}

	// 查看某分类下所有产品信息
	public String productList() throws PromptException {
		try{
		products = new ArrayList<Product>();	
		Manager m=(Manager)session.get("currentManager");
		if(m==null){
			errorMsg="您还未登录，或者长时间未操作，请重新登录！";
			throw new PromptException(errorMsg);
		}
		m=managerService.findManager(m);
		if(m==null){
			errorMsg="您还未登录，或者长时间未操作，请重新登录！";
			throw new PromptException(errorMsg);
		}
		Company company=m.getCompany();
		if(productType==null||(productType.getId()<=0))//第一次展现该页面默认出现的公司所有产品列表
		{
			page.setTotalItemNumber(productService.findProductsByCompany(products,company,
					page.getPageNumber(), page.getPageSize()));
		}else{
			productType=productTypeService.load(productType);
			if (page.getPageNumber() != 0)
				page.setTotalItemNumber(productService.findProductsByType(products,productType,company,
						page.getPageNumber(), page.getPageSize()));
			else
				page.setTotalItemNumber(productService.findProductsByType(products,productType, company,1,
						page.getPageSize()));			
		}		
		 System.out.println(products.size());
		}catch(Exception e){
			errorMsg="获取产品列表失败！";
			e.printStackTrace();
			throw new PromptException(errorMsg);
		}	
		return "productList";
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
			m=managerService.findManager(m);
			Company company=companyService.load(m.getCompany());
			productService.disableProduct(new Product().setId(product.getId())
					.setProductName(product.getProductName())
					.setHasBegin(product.isHasBegin()));
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
			m=managerService.findManager(m);
			Company company=companyService.load(m.getCompany());
			productService.topProduct(new Product().setId(product.getId())
					.setProductName(product.getProductName())
					.setHasTop(product.isHasTop())
					);
			
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

	// 批量删除选中产品,异步操作
	public void deleteProducts() throws PromptException, ServerErrorException {
		this.getResponseAndOut();
		JSONArray json=new JSONArray();
		try{
			Manager m=(Manager)session.get("currentManager");
			if(m==null){
				errorMsg="您还未登录，或者长时间未操作，请重新登录！";
				throw new PromptException(errorMsg);
			}
			m=managerService.findManager(m);
			Company company=companyService.load(m.getCompany());
			System.out.println(this.getIds());
			if (productService.deleteSelectedProducts(this.getIds(),company)){
				json.add(true);
				json.add("删除选中产品成功！");
			}
			else{
				json.add(false);
				json.add("删除选中产品失败!");
			}
		}catch(RootException e){
			e.printStackTrace();
			errorMsg=e.toString();
			json.add(true);
			json.add(errorMsg);
		}catch(Exception e){
			e.printStackTrace();
			json.add( false);
			json.add(RootException.SYSTEM_ERROR);
		}
		out.println(json);
		this.closeOut();
	}

	/******* 注入代码 *******/
	public ProductService getProductService() {
		return productService;
	}

	@Resource
	public void setProductService(ProductService productService) {
		this.productService = productService;
	}

	public Product getProduct() {
		return product;
	}

	@Resource
	public void setProduct(Product product) {
		this.product = product;
	}

	public ProductTypeService getProductTypeService() {
		return productTypeService;
	}

	@Resource
	public void setProductTypeService(ProductTypeService productTypeService) {
		this.productTypeService = productTypeService;
		rootTypes = productTypeService.findRootTypes();
	}

	public CompanyService getCompanyService() {
		return companyService;
	}

	@Resource
	public void setCompanyService(CompanyService companyService) {
		this.companyService = companyService;
	}

	/**
	 * @return the imageService
	 */
	public ImageService getImageService() {
		return imageService;
	}

	@Resource
	public void setImageService(ImageService imageService) {
		this.imageService = imageService;
	}

	public List<ProductType> getRootTypes() {
		return rootTypes;
	}

	public void setRootTypes(List<ProductType> rootTypes) {
		this.rootTypes = rootTypes;
	}

	public Product getProductInfo() {
		return productInfo;
	}

	public void setProductInfo(Product productInfo) {
		this.productInfo = productInfo;
	}

	public List<Product> getProducts() {
		return products;
	}

	public void setProducts(List<Product> products) {
		this.products = products;
	}

	public ProductType getProductType() {
		return productType;
	}

	public void setProductType(ProductType productType) {
		this.productType = productType;
	}

}
