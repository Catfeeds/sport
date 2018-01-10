package com.sport.action;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import net.sf.json.JSONArray;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.sport.entity.Image;
import com.sport.entity.Manager;
import com.sport.exception.PromptException;
import com.sport.exception.ServerErrorException;
import com.sport.service.ImageService;
import com.sport.util.FileUtil;
/*************
 * 
 * @author danyuan
 * 此action只允许上传图片，可以多图同时上传
 *
 */
@Component
@Scope("prototype")
public class ImageAction extends RootAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/***** 业务逻辑操作类注入 *******/
	private ImageService imageService;
	/** 图片上传的三个属性 */

	private File[] img;

	private String[] imgFileName;

	private String[] imgContentType;
	private int picNumber;
	private String type;// bigpic,midpic,smallpic,other
	private int companyId;
	private long productId;

	// 多图片上传
	//@RequiresPermissions("image:add")
	public void uploadImages() throws ServerErrorException {
		int index = 0;
		List<String> imgNames = new ArrayList<String>();
		List<Integer> imgIds = new ArrayList<Integer>();
		this.getResponseAndOut();
		try {			
			Manager m = (Manager) session.get("currentManager");
			
			m = managerService.findManager(m);

			// 设定图片存储在服务器的路径
			String parentDir = "/upload/img/products/";
			String companyIdStr = "" + (m.getCompany()==null? "common":m.getCompany().getId());
			String typeName = type;
			String realPath = parentDir + typeName;
			String savePath = ServletActionContext.getServletContext()
					.getRealPath(realPath);
			String fileExt = "";
			String diskName = "";
			System.err.println("项目存储上传产品图片的路径：" + savePath);

			for (File file : img) {
				fileExt = imgFileName[index].substring(imgFileName[index]
						.lastIndexOf('.'));
				String fileName = "" + productId + new Date().getTime() + fileExt;

				if (this.filterTypes(imgContentType)) {
					try {
						diskName = FileUtil.saveFile(file, savePath,
								companyIdStr, fileName);
					} catch (PromptException e) {
						errorMsg = e.toString();
						throw e;
					}
					// 图片路径
					String picPath = realPath + "/" + companyIdStr + "/"
							+ fileName;// 这里为了大、小、中
										// 图之间保持图片名字一致，故而改名不用imgFileName[index];
					System.out.println("图片服务器路径：" + picPath);
					System.out.println("图片物理本机路径：" + diskName);
					imgNames.add(picPath);
					Image tempImage = new Image().setName(fileName)
							.setParentDir(parentDir).setPathName(picPath)
							.setType(type).setCompanyIdStr(companyIdStr)
							.setDiskName(diskName).setPicNumber(picNumber)
							.setFileExt(fileExt);
					imageService.add(tempImage);
					imgIds.add(tempImage.getId());// 设置需要传回的图片ID
					index++;
				} else {
					errorMsg = "您上传的图片格式不正确，请修正后再上传！";
					out.println(errorMsg);
					out.flush();
					out.close();
				}
			}
			JSONArray json = JSONArray.fromObject(imgIds);//利用json格式传回所有ID
			System.out.println(json);
			out.println(json);
			
		} catch (Exception e) {
			if (errorMsg == null)
				errorMsg = "上传" + index + "张图片成功，" + "上传"
						+ (img.length - index) + "张图片失败";
			out.println(errorMsg);			
			e.printStackTrace();
			
		}finally{
			this.closeOut();
		}
		 return ;

	}

	/**
	 * 
	 * 判断图片格式是否符合要求
	 * 
	 * @param types
	 *            图片格式
	 * 
	 * @return
	 * @throws PromptException
	 */

	public boolean filterTypes(String[] types) throws PromptException {

		// imgTypes是一个数组，存放允许上传的图片格式{"image/png","image/jpeg"...}

		String[] imgTypes = new String[] { "image/png", "image/jpeg",
				"image/jpg", "image/bmp", "image/gif", "image/tiff",
				"image/dxf", "image/cgm", "image/cdr", "image/wmf",
				"image/eps", "image/emf", "image/pict" };

		Boolean flag = true;

		for (String type : types) {

			for (String imgType : imgTypes) {

				if (type.equals(imgType)) {
					System.out.println("type:" + type + "  allowType:"
							+ imgType);
					flag = true;// 只要是允许格式之一，就可以上传
					break;
				} else {
					flag = false;
				}
			}
			if (flag)
				return flag;
			else {
				System.out.println("上传的该类：" + type + "格式图片不允许!");
				errorMsg = "上传的该类：" + type + "格式图片不允许!";
				throw new PromptException(errorMsg);
			}
		}

		return flag;

	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public File[] getImg() {
		return img;
	}

	public void setImg(File[] img) {
		this.img = img;
	}

	public String[] getImgFileName() {
		return imgFileName;
	}

	public void setImgFileName(String[] imgFileName) {
		this.imgFileName = imgFileName;
	}

	public String[] getImgContentType() {
		return imgContentType;
	}

	public void setImgContentType(String[] imgContentType) {
		this.imgContentType = imgContentType;
	}

	public int getCompanyId() {
		return companyId;
	}

	public void setCompanyId(int companyId) {
		this.companyId = companyId;
	}

	public ImageService getImageService() {
		return imageService;
	}

	@Resource
	public void setImageService(ImageService imageService) {
		this.imageService = imageService;
	}

	public int getPicNumber() {
		return picNumber;
	}

	public void setPicNumber(int picNumber) {
		this.picNumber = picNumber;
	}

	public long getProductId() {
		return productId;
	}

	public void setProductId(long productId) {
		this.productId = productId;
	}

	
}
