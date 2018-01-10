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

import com.sport.entity.Company;
import com.sport.entity.Discount;
import com.sport.entity.Image;
import com.sport.entity.User;
import com.sport.exception.PromptException;
import com.sport.exception.RootException;
import com.sport.exception.ServerErrorException;
import com.sport.service.DiscountService;
import com.sport.service.ImageService;
import com.sport.service.UserService;
import com.sport.util.DateFormatUtil;

@Component
@Scope("prototype")
public class DiscountAction extends RootAction {
	private Discount discount;
	private List<Discount> discounts;
	private DiscountService discountService;
	private ImageService imageService;
	//文件上传
	File file;
	String fileContentType;
	String fileFileName;
	// 微信用户匿名登录
		private UserService userService;
		// 微信用户授权码
		private String code;
	/**添加优惠信息
	 * @throws PromptException 
	 * @throws ServerErrorException */
	public String addDiscount() throws PromptException, ServerErrorException{
		try {
			if(discount.getBeginDate().getTime()<DateFormatUtil.formatDay(new Date()).getTime())
				throw new PromptException("活动开始时间不能早于今天！");
			if(discount.getEndDate().getTime()<DateFormatUtil.formatDay(new Date()).getTime())
				throw new PromptException("活动结束时间不能早于今天!");
			// 先保存凭证
			String webDir = "/upload/file/companyInfo";
			String savePath = ServletActionContext.getServletContext()
					.getRealPath(webDir);
			if (file == null || file.length() < 1 || !file.canRead()
					|| !file.exists()) {
				
			}else{
				Image image = imageService.saveFile(file, savePath, webDir,
						fileFileName);
				// 再添加优惠信息
				discount.setPreViewImg(image);
			}	
			
			discountService.add(discount);
		} catch (RootException e) {
			errorMsg = e.toString();
			e.printStackTrace();
			throw new PromptException(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		discountList();
		return "discountList";
	}
	/**更新优惠信息
	 * @throws PromptException 
	 * @throws ServerErrorException */
	public String alterDiscount() throws PromptException, ServerErrorException{
		try {
			// 先保存凭证
			String webDir = "/upload/file/companyInfo";
			String savePath = ServletActionContext.getServletContext()
					.getRealPath(webDir);
			if (file == null || file.length() < 1 || !file.canRead()
					|| !file.exists()) {
				
			}else{
				Image image = imageService.saveFile(file, savePath, webDir,
						fileFileName);
				discount.setPreViewImg(image);
			}			
			discountService.update(discount);
		} catch (RootException e) {
			errorMsg = e.toString();
			e.printStackTrace();
			throw new PromptException(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		discountList();
		return "discountList";
	}
	/**优惠信息查看
	 * @throws PromptException 
	 * @throws ServerErrorException */
	public String discountDetail() throws PromptException, ServerErrorException{
		System.out.println("asdfasdfas");
		try{
			discount=discountService.load(discount);
		} catch (RootException e) {
			errorMsg = e.toString();
			e.printStackTrace();
			throw new PromptException(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "alterDiscount";
	}
	/**优惠信息删除
	 * @throws PromptException 
	 * @throws ServerErrorException */
	public void deleteDiscount() throws ServerErrorException{
		this.getResponseAndOut();
		JSONArray json=new JSONArray();
		try{
			discountService.delete(discount);
			json.add(true);
		} catch (RootException e) {
			errorMsg = e.toString();
			json.add(false);
			json.add(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			json.add(false);
			json.add(RootException.SYSTEM_ERROR);
		}
		out.println(json);
		this.closeOut();
	}
	/**优惠信息批量删除
	 * @throws PromptException 
	 * @throws ServerErrorException */
	public void deleteSelectedDiscounts() throws ServerErrorException{
		this.getResponseAndOut();
		JSONArray json=new JSONArray();
		try{
			discountService.deleteSelectedDiscounts(ids);
			json.add(true);
		}catch (Exception e) {
			e.printStackTrace();
			json.add(false);
			json.add(RootException.SYSTEM_ERROR);
		}
		out.println(json);
		this.closeOut();
	}
	public void loginWeixinUser() throws PromptException, Exception {/*// 微信自动注册并登录
		try {
			if(null!=session.get("currentUser"))
				return;
			User u = new User();
			//u.setUserName("weixinUser").setRealName("微信匿名登录用户");
			UserDetailInfo detailInfo = UserAuthManager.getUserDetail(code);
			u.setUserName("wxu" + new Date().getTime())
					.setRealName(detailInfo.getNickname())
					.setWeixin(detailInfo.getOpenId())
					.setNationality(detailInfo.getCuntry())
					.setSex(detailInfo.getSex());
			
			if (null == userService.findUser(u)) {
				userService.register(u);
			}
			u = userService.findUser(u);
			session.put("currentUser", u);
		} catch (PromptException e) {
			throw e;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

	*/}
	//教练优惠信息
	public String coachDiscounts() throws PromptException, ServerErrorException{
		discount=new Discount().setType(Discount.TYPE_COACH);
		discountList();
		return "discountList";
	}
	//场馆优惠信息
	public String siteDiscounts() throws PromptException, ServerErrorException{
		discount=new Discount().setType(Discount.TYPE_SITE);
		discountList();
		return "discountList";
	}
	/**优惠信息列表
	 * @throws PromptException 
	 * @throws ServerErrorException */
	public String discountList() throws PromptException, ServerErrorException{
		try {
			String path=ServletActionContext.getRequest().getServletPath();
			System.out.println("path:"+path);
			if(path.contains("weixin"))//如果是从微信端进来的需要自动登录注册
				loginWeixinUser();
			if(null==session.get("currentUser")&&(null==session.get("currentManager")))
				throw new PromptException("您还未登录,请登录后再操作!");
			if(discount==null)
				discount=new Discount();
			Company company=null;
			try{
					company=this.getCurrentCompany();
				}catch(Exception e){
					e.printStackTrace();
				}
			if(company!=null){
				if(discount.getCoach()!=null)
					discount.getCoach().setCompany(company);
				if(discount.getSite()!=null)
					discount.getSite().setCompany(company);
			}
			discounts=new ArrayList<Discount>();
			page.setTotalItemNumber(discountService.findAll(discounts, discount, page.getPageNumber(), page.getPageSize()));
		} catch(RootException e){
			errorMsg=e.toString();
			throw new PromptException(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "discountList";
	}
	/*******自动注入代码******/
	public Discount getDiscount() {
		return discount;
	}
	public void setDiscount(Discount discount) {
		this.discount = discount;
	}
	public List<Discount> getDiscounts() {
		return discounts;
	}
	public void setDiscounts(List<Discount> discounts) {
		this.discounts = discounts;
	}
	public DiscountService getDiscountService() {
		return discountService;
	}
	@Resource
	public void setDiscountService(DiscountService discountService) {
		this.discountService = discountService;
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
	public UserService getUserService() {
		return userService;
	}

	@Resource
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

}
