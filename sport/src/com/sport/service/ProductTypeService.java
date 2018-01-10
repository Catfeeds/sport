package com.sport.service;

import java.util.ArrayList;
import java.util.List;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.sport.dao.LevelDao;
import com.sport.dao.ProductTypeDao;
import com.sport.entity.Level;
import com.sport.entity.ProductType;
import com.sport.entity.User;
import com.sport.exception.RootException;

@Component
public class ProductTypeService extends RootService {
	private static final String ENTITY_NAME = "ProductType";
	private ProductTypeDao productTypeDao;
	private LevelDao levelDao;
	public ProductTypeDao getProductTypeDao() {
		return productTypeDao;
	}

	@Resource
	public void setProductTypeDao(ProductTypeDao productTypeDao) {
		this.productTypeDao = productTypeDao;
	}

	public LevelDao getLevelDao() {
		return levelDao;
	}
	@Resource
	public void setLevelDao(LevelDao levelDao) {
		this.levelDao = levelDao;
	}

	// 产品分类信息的增删改
	public void add(ProductType ptype) throws RootException, Exception {
		if (ptype == null
				|| (ptype.getTypeName() == null || (ptype.getTypeName().trim()
						.equals(""))))
			throw new RootException(RootException.NEED_MORE_ADD_INFO);
		productTypeDao.save(ptype);
		ptype=productTypeDao.load(ptype);
		levelDao.save(new Level().setFlag(Level.TYPE_COACH)
		.setType(ptype).setLevelName("普通"+ptype.getTypeName()+"教练"));
		levelDao.save(new Level().setFlag(Level.TYPE_PLACE)
		.setType(ptype).setLevelName("普通"+ptype.getTypeName()+"场地"));
	}

	public boolean delete(ProductType ptype) throws RootException, Exception {

		if (ptype == null
				|| (ptype.getTypeName() == null && (ptype.getId() == 0)))
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);
		// 先加载该类所有信息
		ptype = productTypeDao.load(ptype);
		if (ptype == null)
			throw new RootException("不存在该类型!");
		// 如果为根类,直接删除
		if (ptype.getParentProductType() == null)
			return productTypeDao.delete(ptype);
		// 先保存父节点信息
		ProductType pptype = ptype.getParentProductType();
		int size = pptype.getChildrenProductTypes().size();
		// 删除该节点
		boolean re = productTypeDao.delete(ptype);
		// 修改父节点状态
		if (size < 2) {
			pptype.setLeaf(true);
			productTypeDao.update(pptype);
		}
		return re;
	}

	public void update(ProductType ptype) throws RootException, Exception {
		if (ptype == null
				|| (ptype.getTypeName() == null || (ptype.getTypeName().trim()
						.equals(""))))
			throw new RootException(RootException.NEED_MORE_UPDATE_INFO);
		String oldTypeName;
		// 如果更新的是根分类,则直接更新
		if (productTypeDao.load(ptype).getParentProductType() == null) {
			productTypeDao.update(ptype);
			return;
		}
		// 先加载到内存
		ProductType oldptype = productTypeDao.load(ptype);
		// 先将参数加载到ptype中,因为后面调用evict后,无法加载ptype
		oldptype.setTypeName(ptype.getTypeName())
				.setIntroduction(ptype.getIntroduction());
		if(ptype.getImage()!=null)
			oldptype.setImage(ptype.getImage());
		// 否则，需要判断是否更新父类状态
		oldTypeName = oldptype.getParentProductType()
				.getTypeName();
		
		productTypeDao.update(oldptype);

		// 如果修改该分类关联的父类，就检查修改后对前后父类的属性影响
		if (!productTypeDao.load(oldptype.getParentProductType()).getTypeName()
				.equals((oldTypeName))) {
			ProductType oldPPtype = productTypeDao.load(oldTypeName);
			ProductType newPPtype = productTypeDao.load(oldptype.getParentProductType().getTypeName());
			if (oldPPtype.getChildrenProductTypes() == null
					|| oldPPtype.getChildrenProductTypes().isEmpty())
				oldPPtype.setLeaf(true);
			productTypeDao.update(oldPPtype);
			if (newPPtype == null)
				throw new RootException("不存在该父分类，请先添加！");
			newPPtype.setLeaf(false);
			productTypeDao.update(newPPtype);
		}
	}

	public ProductType load(ProductType ptype) throws RootException, Exception {
		if (ptype == null
				|| ((ptype.getTypeName() == null || ptype.getTypeName().trim()
						.equals("")) && (ptype.getId() <= 0)))
			throw new RootException(RootException.NEED_MORE_FIND_INFO);
		return productTypeDao.load(ptype);
	}

	// 查询操作
	// 查询所有根分类
	public List<ProductType> findRootTypes() {
		return productTypeDao.loadRootType();
	}

	// 查询某根分类下的所有子分类集
	public List<ProductType> findChildTypes(ProductType type)
			throws RootException, Exception {
		List<ProductType> types = new ArrayList<ProductType>();
		if ((types = findChildTypes(type.getId())) == null)
			types = findChildTypes(type.getTypeName());
		return types;
	}

	public List<ProductType> findChildTypes(String typeName)
			throws RootException, Exception {
		if (typeName == null || (typeName.trim().equals("")))
			throw new RootException(RootException.NEED_MORE_FIND_INFO);
		return productTypeDao.load(typeName).getChildrenProductTypes();
	}

	public List<ProductType> findChildTypes(int id) throws RootException,
			Exception {
		if (id == -1)
			return productTypeDao.loadRootType();
		return productTypeDao.load(id).getChildrenProductTypes();
	}
	//获取一些如：足球类、羽毛球之类的类别信息
	public List<ProductType> findTypes() throws RootException,
			Exception {
		List<ProductType> types=new ArrayList<ProductType>();
		productTypeDao.findAll(types, 1, 100);
		return types;
	}
	// 简化客服端编程操作
	// 设置父子结点之间的默认关联属性
	public void initRelation(ProductType parentType, ProductType type) {
		if (parentType == null) {
			type.setParentProductType(null);
			type.setGrade(0);
			type.setLeaf(true);
			type.setChildrenProductTypes(null);
		} else {
			parentType = productTypeDao.load(parentType);
			type.setParentProductType(parentType);
			type.setGrade(parentType.getGrade() + 1);
			type.setLeaf(true);
			parentType.setLeaf(false);
			type.setChildrenProductTypes(null);
		}
	}

	// 默认方式查询某产品分类的子类集信息，分页查看
	public int findByType(List<ProductType> types, ProductType type,
			int pageNumber, int pageSize) {
		return productTypeDao.findAll(types, type, pageNumber, pageSize);
	}

	// 按某列排序查看某产品分类的子类集信息
	public int findByType(List<ProductType> types, ProductType type,
			int pageNumber, int pageSize, String orderByColumn, boolean isAsc) {
		return productTypeDao.findAll(types, type, pageNumber, pageSize,
				orderByColumn, isAsc);
	}

	// 按某列排序查看某产品分类的子类集信息
	public int findRootType(List<ProductType> types, int pageNumber,
			int pageSize) {
		return productTypeDao.findRootType(types, pageNumber, pageSize);
	}

	public boolean deleteSelectedProductTypes(String ids) {
		return productTypeDao.deleteEntitys("ProductType", ids);
	}
}
