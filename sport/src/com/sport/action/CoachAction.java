package com.sport.action;

import java.io.File;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import net.sf.json.JSONArray;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.sport.entity.Address;
import com.sport.entity.CoachProduct;
import com.sport.entity.Company;
import com.sport.entity.Image;
import com.sport.entity.Coach;
import com.sport.entity.Manager;
import com.sport.entity.ProductType;
import com.sport.entity.Role;
import com.sport.exception.PromptException;
import com.sport.exception.RootException;
import com.sport.exception.ServerErrorException;
import com.sport.service.CoachProductService;
import com.sport.service.ImageService;
import com.sport.service.CoachService;
import com.sport.service.ProductTypeService;
import com.sport.service.RightService;
import com.sport.service.RoleService;
import com.sport.util.EncryptUtils;

@Component
@Scope("prototype")
public class CoachAction extends RootAction {
	private ImageService imageService;
	private CoachService coachService;
	private Coach coach;
	private int[] rights;
	private RoleService roleService;
	private RightService rightService;
	// 上传
	File file;
	String fileContentType;
	String fileFileName;
	//产品分类
	private List<ProductType> types;// 跟类别，用来按分类检索产品
	private ProductTypeService productTypeService;
	//某产品分类下的教练产品
	private List<CoachProduct> products;
	private CoachProductService coachProductService;
	private List<Address> cityAddrs;//所有市级地区

	
	/**设置教练的推荐级别1-10
	 * @throws ServerErrorException */
	public void topCoach() throws ServerErrorException{
		this.getResponseAndOut();
		JSONArray json=new JSONArray();
		try{
			int topValue=coach.getTopValue();
			coach=coachService.findCoach(coach);
			coach.setTopValue(topValue);
			coachService.updateCoach(coach);
			json.add(true);
		}catch(RootException e){
			json.add(false);
			json.add(e.toString());
		}catch(Exception e){
			json.add(false);
			json.add(RootException.SYSTEM_ERROR);
		}
		out.println(json);
		this.closeOut();
	}
	//到教练添加页面
	public String toaddCoach() throws PromptException, ServerErrorException{
		try {
			types=productTypeService.findTypes();
			products=new ArrayList<CoachProduct>();
			coachProductService.findAll(products,(CoachProduct) new CoachProduct().setType(types.get(0)), 1, 30);
		} catch (RootException e) {
			errorMsg=e.toString();
			throw new PromptException(e.toString());
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "addCoach";
	}
	// 教练登录
	public String login() throws PromptException, ServerErrorException {
		Subject currentUser = SecurityUtils.getSubject();
		UsernamePasswordToken token = new UsernamePasswordToken(
				coach.getUserName(), EncryptUtils.encryptMD5(coach
						.getPassword()));
		token.setRememberMe(true);
		try {
			currentUser.login(token);
		} catch (AuthenticationException e) {
			errorMsg = "错误，用户名或密码不匹配！";
			throw new PromptException(errorMsg);
		}
		Coach c = null;
		try {
			coach.setPhone(coach.getUserName()).setWeixin(coach.getUserName());
			c = coachService.findCoach(coach);
			if(c==null)
				throw new PromptException("不存在该教练用户！");
			session.put("currentCoach", c);
			session.put("currentPerson", c);
			session.remove("currentManager");
			session.remove("currentUser");
			System.out.println(c.getUserName() + "登录成功！");
		} catch (RootException e) {
			e.printStackTrace();
			errorMsg = e.toString();
			throw new PromptException(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "index";
	}

	// 教练注销
	public String logout() throws PromptException, ServerErrorException {
		System.out.println("教练将要注销登陆！");
		String coachName = "";
		try {
			if (session.get("currentCoach") == null) {
				errorMsg = "您还未登录！无法注销！";
				throw new PromptException(errorMsg);
			}
			coachName = ((Coach) session.get("currentCoach")).getUserName();
			Subject currentUser = SecurityUtils.getSubject();
			currentUser.logout();
			//session.remove("currentCoach");
		}catch(RootException e){
			errorMsg=e.toString();
			throw new PromptException(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		System.out.println("教练（" + coachName + ") 注销成功！");
		return "coachLogin";
	}



	// 个人教练注册
	public String coachRegister() throws PromptException, ServerErrorException {
		try {
			// 个人教练均属于平台拥有者公司所有
			Company company = companyService.getOwnerCompany();
			coach.setCompany(company);
			List<Role> roles = new ArrayList<Role>();
			roles.add(roleService.load(new Role().setName("coachRole")));
			coach.setRoles(roles);
			if (coachService.add(coach)) {
				errorMsg = "添加教练成功！";
			} else {
				errorMsg = "添加教练失败！";
			}
			
		}  catch (RootException e) {
			e.printStackTrace();
			errorMsg=e.toString();
			throw new PromptException(errorMsg);
		}catch(Exception e){
			e.printStackTrace();
			throw new ServerErrorException();
		}		
		throw new PromptException(errorMsg);
	}

	// 管理员添加公司教练
	// @RequiresPermissions("coach:add")
	public String addCoach() throws PromptException {
		try {
			Manager m=this.getCurrentManager();
			m = managerService.findManager(m);
			coach.setCompany(m.getCompany());
			List<Role> roles = new ArrayList<Role>();
			roles.add(roleService.load(new Role().setName("coachRole")));
			coach.setRoles(roles);
			if (coachService.add(coach)) {
				errorMsg = "添加教练成功！";
			}
		} catch (PromptException e) {
			errorMsg=e.toString();
			throw e;
		} catch (Exception e) {
			errorMsg = "添加教练失败,请重试！";
			e.printStackTrace();
		}
		throw new PromptException(errorMsg);
	}
	//修改教练信息
	public String alterCoach() throws PromptException, ServerErrorException{
		try{
			coachService.alterCoach(coach);
		}catch(RootException e){
			errorMsg=e.toString();
			throw new PromptException(e.toString());
		}catch(Exception e){
			e.printStackTrace();
			throw new ServerErrorException();
		}
		errorMsg="修改教练信息成功！";
		throw new PromptException(errorMsg);
	}
	// 教练自己查看个人信息
	public String coachSelfDetail() throws PromptException, ServerErrorException {
		coach = (Coach) session.get("currentCoach");
		try {
			coach = coachService.findCoach(coach);
		} catch (RootException e) {
			e.printStackTrace();
			errorMsg=e.toString();
			throw new PromptException(errorMsg);
		}catch(Exception e){
			e.printStackTrace();
			throw new ServerErrorException();
		}		
		return "coachDetail";
	}

	// 管理员查看某教练个人信息
	public String coachDetail() throws PromptException, ServerErrorException {
		try {
			if(coach==null)
				coach=this.getCurrentCoach();
			if(coach==null)
				throw new PromptException("对不起，您还未登录，请先登录！");
			coach = coachService.findCoach(coach);
			types=productTypeService.findTypes();
		}  catch (RootException e) {
			e.printStackTrace();
			errorMsg=e.toString();
			throw new PromptException(errorMsg);
		}catch(Exception e){
			e.printStackTrace();
			throw new ServerErrorException();
		}		
		return "coachDetail";
	}

	// 查看自己公司的所有成员
	// @RequiresPermissions("coach:view")
	public String coachList() throws PromptException, ServerErrorException {
		Manager c = (Manager) session.get("currentManager");
		if (c == null) {
			errorMsg = "您还未登录，无法查看教练信息！";
			throw new PromptException(errorMsg);
		}
		try {
			types=productTypeService.findTypes();
			cityAddrs=addressService.findCityAddress();
			c = managerService.findManager(c);
			Company company = companyService.load(c.getCompany());
			if (company == null) {
				errorMsg = "不存在该加盟公司，无法查看教练信息！";
				throw new PromptException(errorMsg);
			}
			List<Coach> coachs = new ArrayList<Coach>();
			if(coach==null)
				coach=new Coach();
			if(!company.isHost())//如果不是平台管理员则只能查看自己公司的教练
				coach.setCompany(company);			
			page.setTotalItemNumber(coachService.findAll(coachs, coach,
						page.getPageNumber(), page.getPageSize()));
			
			System.out.println(coachs.size());
			session.put("coachs", coachs);
		} catch (RootException e) {
			errorMsg = e.toString();
			throw new PromptException(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "coachList";
	}

	// 管理所有教练信息
	// 删除选中教练
	// @RequiresRoles("companySuperCoach")
	public void deleteCoachs() throws ServerErrorException {
		this.getResponseAndOut();
		try {
			Manager m = (Manager) session.get("currentManager");
			if (m == null) {
				errorMsg = "您还未登录，或者长时间未操作，请重新登录！";
				out.println(errorMsg);
			}
			m = managerService.findManager(m);
			Company company = companyService.load(m.getCompany());
			if (coachService.deleteSelectedCoachs(this.getIds(), company))
				out.println("删除选中教练成功！");
			else
				out.println("删除选中教练失败!");
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		this.closeOut();
	}

	// 更新管理员头像,异步上传
	// @RequiresAuthentication
	public void alterHeadImg() throws PromptException, ServerErrorException {
		this.getResponseAndOut();
		JSONArray json = new JSONArray();

		Manager mtemp = (Manager) session.get("currentManager");
		if (mtemp == null) {
			json.add(false);
			json.add("您的登录信息已过期，请重新登录！");
			this.closeOut();
			return;
		}
		/*
		 * int id = mtemp.getId(); if (id == coach.getId())// 代表是当前登录账号 { if
		 * (!currentUser.isAuthenticated()) {
		 * 
		 * json.add(false); json.add("您的登录信息已过期，请重新登录！"); out.println(json);
		 * this.closeOut(); return; } } else { if
		 * (!currentUser.isPermitted("coach:*")) { json.add(false);
		 * json.add("您没有修改其它管理员信息的权限，请联系公司超级管理员进行申请该权限，或者用其他账户登录！");
		 * out.println(json); this.closeOut(); return; } }
		 */
		Coach m = null;
		try {
			m = coachService
					.findCoach((Coach) new Coach().setId(coach.getId()));
			if (m == null) {
				errorMsg = "该管理员不存在，无法修改！";
				json.add(false);
				json.add(errorMsg);
				this.closeOut();
			}
			m = coachService.findCoach(m);
			// 先保存凭证
			String webDir = "/upload/img/photoes";
			String savePath = ServletActionContext.getServletContext()
					.getRealPath(webDir);
			fileFileName = "headImg" + new Date().getTime() + fileFileName;
			Image image = imageService.saveFile(file, savePath, webDir,
					fileFileName);
			if (image != null)
				m.setImage(image);
			coachService.alterCoach(m);
			json.add(true);
			json.add(image.getPathName());// 将新头像地址返回
			System.out.println("头像已经修改!");
		} catch (RootException e) {
			e.printStackTrace();
			errorMsg = "上传头像失败，请重试！";
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

	// 修改管理员信息
	/**************
	 * 修改管理员个人信息,动态修改各个字段
	 * 
	 * @throws ServerErrorException
	 * @throws Exception
	 **************/
	@SuppressWarnings({ "unchecked", "rawtypes" })
	// @RequiresAuthentication
	public void alterCoachInfo() throws ServerErrorException {
		JSONArray json = new JSONArray();
		this.getResponseAndOut();
		try {
			/*
			 * Subject currentUser = SecurityUtils.getSubject(); Coach mtemp =
			 * (Coach) session.get("currentCoach"); if (mtemp == null) {
			 * json.add(false); json.add("您的登录信息已过期，请重新登录！"); } int id =
			 * mtemp.getId(); if (id == coach.getId())// 代表是当前登录账号 { if
			 * (!currentUser.isAuthenticated()) { json.add(false);
			 * json.add("您的登录信息已过期，请重新登录！"); } } else { if
			 * (!currentUser.isPermitted("coach:*")) { json.add(false);
			 * json.add("您没有修改其它管理员信息的权限，请联系公司超级管理员进行申请该权限，或者用其他账户登录！"); } }
			 */

			Coach m = coachService.findCoach((Coach) new Coach().setId(coach
					.getId()));// 这里前台传递id即可
			if (m == null) {
				errorMsg = "对不起，该管理员账号不存在，无法修改其信息！请核实后再重试！";
				json.add(false);
				json.add(errorMsg);
			}
			/************* 反射动态调用实现代码开始 ***********/
			// 获取到用户管理器类和用户类的class
			Class servicecla = coachService.getClass();
			Class coachcla = coach.getClass();
			// 获取到user需要修改的成员变量的get方法
			Method coachGetMethod = coachcla.getMethod(
					"get" + alterFlag.substring(0, 1).toUpperCase()
							+ alterFlag.substring(1), null);
			Class retClassType = coachGetMethod.getReturnType();
			// 设置需要调用的函数的参数类型
			Class[] parameterTypes = new Class[] { int.class, retClassType };
			// 获取需要调用的函数
			Method method = servicecla.getMethod(
					"alter" + alterFlag.substring(0, 1).toUpperCase()
							+ alterFlag.substring(1), parameterTypes);
			// 调用该函数需要传递的参数数组
			Object[] args = new Object[] { coach.getId(),
					coachGetMethod.invoke(coach, null) };
			// 调用该对象的该函数
			if ((Boolean) method.invoke(coachService, args)) {
				json.add(true);
				json.add("修改管理员信息成功！");
			} else {
				json.add(false);
				json.add("修改管理员信息失败！");
			}
			/************* 反射动态调用实现代码结束 ***********/
			out.println(json);
			this.closeOut();
		} catch (Exception e) {
			e.printStackTrace();
			json.add(false);
			json.add("修改管理员信息失败！");
		}
		out.print(json);
		this.closeOut();
	}

	// 增加或减少一项教练服务
	public void addOrDeleteCoachProduct() {

	}

	// 增加或减少一个教练工作的体育场馆
	public void addOrDeleteSite() {

	}

	// 增加或减少教练的一个证书凭据照片
	public void addOrDeleteCertificate() {

	}

	// 增加或减少教练的一张照片
	public void addOrDeletePhoto() {

	}

	/*************** spring注入 *****************/
	public Coach getCoach() {
		return coach;
	}

	public void setCoach(Coach coach) {
		this.coach = coach;
	}

	public CoachService getCoachService() {
		return coachService;
	}

	@Resource
	public void setCoachService(CoachService coachService) {
		this.coachService = coachService;
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
		this.fileFileName = new Date().getTime()+fileFileName;
	}

	public ImageService getImageService() {
		return imageService;
	}

	@Resource
	public void setImageService(ImageService imageService) {
		this.imageService = imageService;
	}

	public int[] getRights() {
		return rights;
	}

	public void setRights(int[] rights) {
		this.rights = rights;
	}

	public RoleService getRoleService() {
		return roleService;
	}

	@Resource
	public void setRoleService(RoleService roleService) {
		this.roleService = roleService;
	}

	public RightService getRightService() {
		return rightService;
	}

	@Resource
	public void setRightService(RightService rightService) {
		this.rightService = rightService;
	}
	public List<ProductType> getTypes() {
		return types;
	}

	public void setTypes(List<ProductType> types) {
		this.types = types;
	}

	public ProductTypeService getProductTypeService() {
		return productTypeService;
	}

	@Resource
	public void setProductTypeService(ProductTypeService productTypeService) {
		this.productTypeService = productTypeService;
		//types = productTypeService.findRootTypes();
	}
	public List<CoachProduct> getProducts() {
		return products;
	}
	public void setProducts(List<CoachProduct> products) {
		this.products = products;
	}
	public CoachProductService getCoachProductService() {
		return coachProductService;
	}
	@Resource
	public void setCoachProductService(CoachProductService coachProductService) {
		this.coachProductService = coachProductService;
	}
	public List<Address> getCityAddrs() {
		return cityAddrs;
	}
	public void setCityAddrs(List<Address> cityAddrs) {
		this.cityAddrs = cityAddrs;
		
	}
	

}
