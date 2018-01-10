package com.sport.service;

import java.io.File;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.sport.dao.ImageDao;
import com.sport.entity.Image;
import com.sport.exception.PromptException;
import com.sport.exception.RootException;
import com.sport.util.FileUtil;

@Component
public class ImageService  extends RootService{
	private static final String ENTITY_NAME="Image";
	private ImageDao imageDao = null;

	public ImageDao getImageDao() {
		return imageDao;
	}

	@Resource
	public void setImageDao(ImageDao imageDao) {
		this.imageDao = imageDao;
	}
	//保存某文件
	public Image saveFile(File file,String diskDir,String webDir,String fileName) throws PromptException,Exception{
		Image image=new Image();
		String diskName=FileUtil.saveFile(file, diskDir, "companyRegisterFile", fileName);
		String pathName=webDir+"/"+"companyRegisterFile"+"/"+fileName;
		image.setCompanyIdStr("companyRegisterFile")
				.setDiskName(diskName)
				.setPathName(pathName)
				.setName(fileName)
				.setType("file")
				.setParentDir(diskDir)
				.setFileExt(diskName.substring(diskName.lastIndexOf('.')));
		imageDao.save(image);
		return image;

	}
	//获取某图片全路径名
	// 产品分类信息的增删改
	public void add(Image image) throws RootException {
		if (image == null
				|| (image.getName() == null || (image.getName().trim()
						.equals("")))
				|| (image.getParentDir() == null || (image.getParentDir()
						.trim().equals(""))))
			throw new RootException(RootException.NEED_MORE_ADD_INFO);
		imageDao.save(image);
	}

	public boolean delete(Image image) throws Exception {

		if (image == null
				|| (image.getName() == null || (image.getName().trim()
						.equals("")))
				|| (image.getParentDir() == null || (image.getParentDir()
						.trim().equals(""))))
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);
		return imageDao.delete(image);
	}

	public void update(Image image) throws RootException {
		if (image == null
				|| (image.getName() == null || (image.getName().trim()
						.equals("")))
				|| (image.getParentDir() == null || (image.getParentDir()
						.trim().equals(""))) || (image.getId() == 0))
			throw new RootException(RootException.NEED_MORE_UPDATE_INFO);
		imageDao.update(image);
	}

	public Image load(Image image) throws RootException {
		if (image == null||((image.getId()==-1)
				&& (image.getPathName() == null || (image.getPathName().trim()
						.equals("")))))
			throw new RootException(RootException.NEED_MORE_FIND_INFO);
		return imageDao.load(image);
	}

	// 管理图片信息
	public int findAll(List<Image> images, int pageNumber, int pageSize) {
		return imageDao.findAll(images, pageNumber, pageSize);
	}

	// 按某列排序查看图片信息
	public int findAll(List<Image> images, int pageNumber, int pageSize,
			String orderByColumn, boolean isAsc) {
		return imageDao.findAll(images, pageNumber, pageSize, null,
				orderByColumn, isAsc);
	}
	
}
