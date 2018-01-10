package com.sport.service;

import java.util.List;
import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.sport.dao.ProductDao;
import com.sport.dao.ProductTypeDao;
import com.sport.dto.SearchCondition;
import com.sport.entity.Company;
import com.sport.entity.Product;
import com.sport.entity.ProductType;
import com.sport.exception.PromptException;
import com.sport.exception.RootException;

@Component
public class ProductService extends RootService{
	private static final String ENTITY_NAME="Product";
	private ProductDao productDao = null;
	private ProductTypeDao productTypeDao = null;
	private ProductTypeService productTypeService;
	private ImageService imageService;
	private CompanyService companyService;

	public ProductDao getProductDao() {
		return productDao;
	}

	@Resource
	public void setProductDao(ProductDao productDao) {
		this.productDao = productDao;
	}

	public ProductTypeDao getProductTypeDao() {
		return productTypeDao;
	}

	@Resource
	public void setProductTypeDao(ProductTypeDao productTypeDao) {
		this.productTypeDao = productTypeDao;
	}

	public ProductTypeService getProductTypeService() {
		return productTypeService;
	}

	@Resource
	public void setProductTypeService(ProductTypeService productTypeService) {
		this.productTypeService = productTypeService;
	}

	public CompanyService getCompanyService() {
		return companyService;
	}

	@Resource
	public void setCompanyService(CompanyService companyService) {
		this.companyService = companyService;
	}

	// 根据传输对象获得产品对象信息
	public ImageService getImageService() {
		return imageService;
	}

	@Resource
	public void setImageService(ImageService imageService) {
		this.imageService = imageService;
	}

	// 根据传输对象获取到产品信息及该产品与其他实体的映射关系
	public Product toProduct(Product p, Product product) throws Exception {
		// 设置基本属性
		product.setBargainPrice(p.getBargainPrice())
				.setDetail(p.getDetail()).setIntroduction(p.getIntroduction())
				.setNormalPrice(p.getNormalPrice())
				.setProductName(p.getProductName());
		// 设置对象关联
		ProductType type = productTypeService.load(p
				.getType());
		if (type != null)
			product.setType(type);
		System.out.println("typeId:" + p.getType().getId() + "typeName:"
				+ type.getTypeName());
				
		return product;
	}

	// 产品分类信息的增删改
	public void add(Product productNew) throws Exception {
		if (productNew == null
				|| (productNew.getProductName() == null || (productNew
						.getProductName().trim().equals(""))))
			throw new RootException(RootException.NEED_MORE_ADD_INFO);
		// 先保存产品信息
		Product product = null;
		Product p;
		if ((p = productDao.load(productNew.getProductName())) == null) {
			product = new Product();
			toProduct(productNew, product);
			addNew(product, productNew);
			productDao.save(product);
			
		} else {
			toProduct(productNew, p);			
			productDao.update(p);			
		}

	}


	// 添加一种新的产品
	public void addNew(Product product, Product pIntro)
			throws RootException {

		product.setComments(null)				
				.setTotalSoldNumber(0)
				;

	}

	public boolean delete(Product product) throws RootException {

		if (product == null
				|| (((product.getProductName() == null || product
						.getProductName().trim().equals("")) && (product
						.getId() <= 0)))) 
			throw new PromptException(RootException.NEED_MORE_DELETE_INFO);
		// 该公司的管理员只能删除自己公司的产品
		product = productDao.loadProductInCompany(product);
		if (product == null)
			throw new PromptException("您无法删除该商品，可能由于您的公司里没有该产品，请核实无误后再重试！");
		return productDao.delete(product);
	}

	public void update(Product product) throws Exception {
		if (product == null
				|| (product.getProductName() == null || (product
						.getProductName().trim().equals(""))))
			throw new RootException(RootException.NEED_MORE_UPDATE_INFO);
		Product p = productDao.load(new Product().setId(product.getId())
				.setProductName(product.getProductName()));
		toProduct(product, p);
		productDao.update(p);
	}

	public Product load(Product product) throws RootException {
		if (product == null
				|| ((product.getProductName() == null || product
						.getProductName().trim().equals("")) && product.getId() == 0))
			throw new RootException(RootException.NEED_MORE_FIND_INFO);
		return productDao.load(product);
	}

	/******************** 产品信息的查找 ***********************/
	// 默认方式查询所有产品信息，分页查看
	public int findAll(List<Product> products, int pageNumber, int pageSize) {
		return productDao.findAll(products, pageNumber, pageSize);
	}

	// 按某列排序查看产品信息
	public int findAll(List<Product> products, int pageNumber, int pageSize,
			String orderByColumn, boolean isAsc) {
		return productDao.findAll(products, pageNumber, pageSize, null,
				orderByColumn, isAsc);
	}

	// 某公司所有的产品
	public int findProductsByCompany(List<Product> products, Company company,
			int pageNumber, int pageSize) {
		return productDao.findProductsByCompany(products, company, pageNumber,
				pageSize);
	}

	// 某分类下的所有产品
	public int findProductsByType(List<Product> products, ProductType type,
			Company company, int pageNumber, int pageSize) {
		return productDao.findProductsByType(products, type, company,
				pageNumber, pageSize);
	}

	// 将数据取出后再进行一次分页,考虑到网站规模不是很大可以这样用，效率较低
	public int getProductsByPageNumber(List<Product> products,
			List<Product> pageProducts, int pageNumber, int pageSize) {
		for (Product p : products.subList(0, pageNumber * pageSize))
			pageProducts.add(p);
		// 返回总页码数
		return products.size() / pageSize
				+ ((products.size() % pageSize) == 0 ? 0 : 1);
	}

	// 修改产品所属分类
	public void alterProductType(Product product) throws RootException,
			Exception {
		ProductType productType = productTypeService.load(product
				.getType());
		product = productDao.load(product);
		product.setType(productType);
	}

	// 修改产品是否上架
	public void disableProduct(Product product) {
		productDao.load(product).setHasBegin(product.isHasBegin());

	}

	// 将商品置顶或取消置顶
	public void topProduct(Product product) {
		productDao.load(product).setHasTop(product.isHasTop());
	}
	//批量删除产品
	public boolean deleteSelectedProducts(String ids, Company company) throws RootException {
		int id=0;
		for(String idStr:ids.split(",")){
			try{
				if((id=Integer.parseInt(idStr))<=0)
					continue;
				Product p=new Product().setId(id);
				// 判断该产品是否属于该公司
				if(null==productDao.loadProductInCompany(p))
					throw new PromptException("你的公司不存在该商品，无法删除！");
				delete(p);
			}catch(Exception e){
				e.printStackTrace();
				throw new PromptException("删除id为："+id+"的产品失败！请检查是否存在该商品，若存在，请重试！");
			}
		}
		return true;
	}

	/******************* 最受欢迎的前40种产品 ****************/
	public List<Product> findFavorProducts() {
		return productDao.findFavorProducts();
	}

	/*********** 产品搜索 *************/
	// 默认按时间排序出现产品
	public int findProducts(List<Product> products, int pageNumber, int pageSize) {
		return productDao.findProducts(products, pageNumber, pageSize);
	}

	public int findProducts(List<Product> products, SearchCondition condition,
			int pageNumber, int pageSize, String groupByColumn,
			String orderByColumn, boolean isAsc) {

		return productDao.findProducts(products, condition, pageNumber,
				pageSize, groupByColumn, orderByColumn, isAsc);
	}

	public int findProducts(List<Product> products, SearchCondition condition,
			int pageNumber, int pageSize) {

		return productDao.findProducts(products, condition, pageNumber,
				pageSize);
	}

	
	public void load(Product product, List<Product> products) {
		product=productDao.load(product.getId());
		List<Product> ps=product.getType().getProducts();
		for(Product p:ps)
			products.add(p);
	}

}
