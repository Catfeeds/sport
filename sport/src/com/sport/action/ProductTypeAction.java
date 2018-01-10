package com.sport.action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
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

import com.sport.dto.ProductTypeInfo;
import com.sport.entity.Image;
import com.sport.entity.Product;
import com.sport.entity.ProductType;
import com.sport.entity.User;
import com.sport.exception.PromptException;
import com.sport.exception.RootException;
import com.sport.exception.ServerErrorException;
import com.sport.service.ImageService;
import com.sport.service.ProductTypeService;

@Component
@Scope("prototype")
public class ProductTypeAction extends RootAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private ProductTypeService productTypeService;
	private ProductType productType;// 需要添加或修改的类别
	private ProductType parentType;// 父类别
	private List<ProductType> types;
	private List<ProductType> rootTypes;
	private List<ProductType> allTypes;// 所有具体的分类信息,调用本action任何方法后，都可以直接使用该分类集
	// 产品分类图标上传
	ImageService imageService;
	File file;
	String fileContentType;
	String fileFileName;

	// 获取需要修改的分类原始信息
	public String alterProductType() throws RootException, Exception {
		productType = productTypeService.load(productType);
		return "alterProductType";
	}

	// 添加产品分类
	// @RequiresPermissions("productType:add")
	public void addProductType() throws RootException, IOException {
		this.getResponseAndOut();
		JSONArray json = new JSONArray();
		try {
			// 先将父子结点之间的关系关联上
			if (parentType == null || (parentType.getId() == -1))
				productTypeService.initRelation(null, productType);
			else {
				productTypeService.initRelation(parentType, productType);
			}
			// 再保存结点信息
			productTypeService.add(productType);
			json.add(true);
			json.add("添加产品分类信息成功（分类名：" + productType.getTypeName() + "）");
		} catch (Exception e) {
			e.printStackTrace();
			json.add(false);
			json.add("添加产品分类信息失败，请重试！");
		} finally {
			out.println(json);
			this.closeOut();
		}
	}

	// 删除产品分类,异步
	// @RequiresPermissions("productType:delete")
	public void deleteProductType() throws RootException {
		this.getResponseAndOut();
		JSONArray json = new JSONArray();
		try {
			productTypeService.delete(productType);
			errorMsg = "删除产品分类成功！";
			json.add(true);
		} catch (Exception e) {
			errorMsg = ProductType.DELETE_FAIL_INFO;
			e.printStackTrace();
			json.add(false);
		}
		json.add(errorMsg);
		out.println(json);
		this.closeOut();
	}

	// 修改产品分类
	// @RequiresPermissions("productType:update")
	public String updateProductType() throws RootException {
		try {
			// 如果要修改公司logo
			if (file != null) {
				if (file.canRead() && (file.isFile()) && (file.exists())) {
					String webDir = "/upload/file/companyInfo";
					String savePath = ServletActionContext.getServletContext()
							.getRealPath(webDir);
					fileFileName = "logo" + new Date().getTime() + fileFileName;
					Image image = imageService.saveFile(file, savePath, webDir,
							fileFileName);
					if (image != null)
						productType.setImage(image);
				}
			}
			productTypeService.update(productType);
		} catch (Exception e) {
			errorMsg = "更新产品分类失败!";
			e.printStackTrace();
			throw new RootException(errorMsg);
		}
		errorMsg = "更新产品分类成功！";
		return "prompt";
	}

	// 获取某产品分类的子分类同步获取
	public String productTypes() throws RootException, Exception {
		System.out.println("进入到方法");
		types = new ArrayList<ProductType>();
		if (productType == null || (productType.getId() == -1)
				|| (productType.getId() == 0)) {
			productType = new ProductType();
			productType.setId(-1);
			productType.setTypeName("根类别");
			page.setTotalItemNumber(productTypeService.findRootType(types,
					page.getPageNumber(), page.getPageSize()));
		} else {
			if (page.getPageNumber() != 0)
				page.setTotalItemNumber(productTypeService.findByType(types,
						productType, page.getPageNumber(), page.getPageSize()));
			else
				page.setTotalItemNumber(productTypeService.findByType(types,
						productType, 1, page.getPageSize()));
			productType = productTypeService.load(productType);
		}
		System.out.println(types.size());
		session.put("types", types);
		return "productTypes";
	}

	// 获取某产品分类的子分类异步获取
	public void getChildTypes() throws RootException, Exception {
		this.getResponseAndOut();
		try {
			types = new ArrayList<ProductType>();
			if (productType == null || (productType.getId() == -1)) {
				types = productTypeService.findRootTypes();
				System.out.println("获取跟类别成功！");
			} else {
				types = productTypeService.findChildTypes(productType);
				System.out.println("获取子类成功！");
			}
			System.out.println(types.size());
			try {
				List<ProductTypeInfo> infos = new ArrayList<ProductTypeInfo>();
				infos = ProductTypeInfo.fromTypes(types);
				JSONArray json = JSONArray.fromObject(infos);
				out.println(json);
				System.out.println(json);
			} catch (Exception e) {
				e.printStackTrace();
				JSONArray json = new JSONArray();
				json.add("获取信息失败，请稍后重试!");
				out.println(json);
			}
		} catch (Exception e1) {
			e1.printStackTrace();
			JSONArray json = new JSONArray();
			json.add("获取信息失败，请稍后重试!");
			out.println(json);
		} finally {
			this.closeOut();
		}
	}

	// 批量删除分类
	// @RequiresPermissions("productType:delete")
	public void deleteTypes() throws PromptException, ServerErrorException {
		this.getResponseAndOut();
		JSONArray json = new JSONArray();
		try {
			if (productTypeService.deleteSelectedProductTypes(this.getIds())) {
				json.add(true);
				json.add("删除选中分类成功！");
			} else {
				json.add(false);
				json.add(ProductType.DELETE_FAIL_INFO);
			}
		} catch (Exception e) {
			e.printStackTrace();
			json.add(false);
			json.add(ProductType.DELETE_FAIL_INFO);
		}
		out.println(json);
		this.closeOut();
	}

	/************* 注入代码 *************/
	public ProductTypeAction() {

	}

	public List<ProductType> getTypes() {
		return types;
	}

	public void setTypes(List<ProductType> types) {
		this.types = types;
	}

	public List<ProductType> getRootTypes() {
		return rootTypes;
	}

	public void setRootTypes(List<ProductType> rootTypes) {
		this.rootTypes = rootTypes;
	}

	public ProductType getProductType() {
		return productType;
	}

	public void setProductType(ProductType productType) {
		this.productType = productType;
	}

	public ProductType getParentType() {
		return parentType;
	}

	public void setParentType(ProductType parentType) {
		this.parentType = parentType;
	}

	@Resource
	public void setProductTypeService(ProductTypeService productTypeService) {
		this.productTypeService = productTypeService;
		rootTypes = productTypeService.findRootTypes();
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

	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
	}

	public String getFileContentType() {
		return fileContentType;
	}

	public void setFileContentType(String fileContentType) {
		this.fileContentType = fileContentType;
	}

	public String getFileFileName() {
		return fileFileName;
	}

	public void setFileFileName(String fileFileName) {
		this.fileFileName = (new Date().getTime())+fileFileName;// 避免同名冲突
	}
	public ImageService getImageService() {
		return imageService;
	}

	@Resource
	public void setImageService(ImageService imageService) {
		this.imageService = imageService;
	}
}
