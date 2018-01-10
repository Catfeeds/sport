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

import com.sport.entity.Company;
import com.sport.entity.Image;
import com.sport.entity.Manager;
import com.sport.entity.Right;
import com.sport.exception.PromptException;
import com.sport.exception.RootException;
import com.sport.exception.ServerErrorException;
import com.sport.service.ImageService;
import com.sport.service.ManagerService;
import com.sport.service.RightService;
import com.sport.service.RoleService;
import com.sport.util.EncryptUtils;

@Component
@Scope("prototype")
public class ManagerAction extends RootAction {
	private ImageService imageService;
	private ManagerService managerService;
	private Manager manager;
	private int[] rights;
	private RoleService roleService;
	private RightService rightService;
	// 上传
	File file;
	String fileContentType;
	String fileFileName;

	// 管理员登录
	public String login() throws PromptException, ServerErrorException {
		Subject currentUser = SecurityUtils.getSubject();
		UsernamePasswordToken token = new UsernamePasswordToken(
				manager.getUserName(), EncryptUtils.encryptMD5(manager
						.getPassword()));
		token.setRememberMe(true);
		Manager m = null;
		try {
			try {
				// 登录
				currentUser.login(token);
			} catch (AuthenticationException e) {
				errorMsg = "错误，用户名或密码不匹配！";
				throw new PromptException(errorMsg);
			}
			// 验证是否是管理员
			manager.setPhone(manager.getUserName()).setWeixin(
					manager.getWeixin());
			m = managerService.findManager(manager);
			if (m == null) {
				throw new RootException("不存在此管理员账号！");
			}
			session.put("currentManager", m);
			session.put("currentPerson", m);
			session.remove("currentUser");
			session.remove("currentCoach");
			System.out.println(m.getUserName() + "登录成功！");
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

	// 管理员注销
	public String logout() throws PromptException, ServerErrorException {
		System.out.println("管理员将要注销登陆！");
		String managerName = "";
		try {
			if (session.get("currentManager") == null) {
				errorMsg = "您还未登录！无法注销！";
				throw new PromptException(errorMsg);
			}
			managerName = ((Manager) session.get("currentManager"))
					.getUserName();
			Subject currentUser = SecurityUtils.getSubject();
			currentUser.logout();
		} catch (PromptException e) {
			throw e;
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		System.out.println("管理员（" + managerName + ") 注销成功！");
		return "login";
	}

	// 到管理员添加页面
	public String toaddManager() throws ServerErrorException, PromptException {
		manager = (Manager) session.get("currentManager");
		try {
			manager = managerService.findManager(manager);
		} catch (RootException e) {
			e.printStackTrace();
			errorMsg = e.toString();
			throw new PromptException(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "addManager";
	}

	// 添加管理员
	// @RequiresPermissions("manager:add")
	public String addManager() throws PromptException {
		try {
			Manager m = (Manager) session.get("currentManager");
			if (m == null) {
				errorMsg = "请登录后才能添加管理员！";
				throw new PromptException(errorMsg);
			}
			System.out.println(manager.getRealName());
			m = managerService.findManager(m);
			manager.setId(0);// 防止被赋值
			manager.setCompany(m.getCompany());
			/*********** 权限的分配 *********/
			/*
			 * if(m.getCompany().getCompanyName().trim().equals("二维码防伪工作室")){
			 * List<Role> roles=new ArrayList<Role>(); Role
			 * role=roleService.load(new Role().setName("ownerLooker"));
			 * roles.add(role); manager.setRoles(roles); }
			 */
			System.out.println("ids:"+ids);
			if (ids != null&&(ids!="")) {
				List<Right> managerRights = new ArrayList<Right>();
				String idArr[]=ids.split(",");
				for (String id : idArr) {
					Right right = rightService.load(Integer.parseInt(id));
					managerRights.add(right);
					System.out.println("right:"+id);
				}
				manager.setRights(managerRights);
			}
			if (managerService.add(manager)) {
				System.out.println(manager.getRealName());	
				errorMsg = "添加管理员成功！";
				throw new PromptException(errorMsg);
			}
		} catch (PromptException e) {
			errorMsg = e.toString();
			throw e;
		} catch (RootException e) {
			errorMsg = e.toString();
			throw new PromptException(errorMsg);
		} catch (Exception e) {
			errorMsg = "添加管理员失败,请重试！";
			e.printStackTrace();
			throw new PromptException(errorMsg);
		}
		return ERROR;
	}

	// 加载某管理员个人信息
	public String managerDetail() {
		if (manager == null || (manager.getId() <= 0))
			manager = (Manager) session.get("currentManager");
		try {
			manager = managerService.findManager(manager);
		} catch (RootException e) {
			e.printStackTrace();
		}
		return "managerDetail";
	}

	// 查看自己公司的所有成员
	// @RequiresPermissions("manager:view")
	public String managerList() throws PromptException, ServerErrorException {
		Manager m = (Manager) session.get("currentManager");
		if (m == null) {
			errorMsg = "您还未登录，无法查看管理员信息！";
			throw new PromptException(errorMsg);
		}
		try {
			m = managerService.findManager(m);
			Company company = companyService.load(m.getCompany());
			if (company == null) {
				errorMsg = "不存在该加盟公司，无法查看管理员信息！";
				throw new PromptException(errorMsg);
			}
			List<Manager> managers = new ArrayList<Manager>();
			if (page.getPageNumber() != 0)
				page.setTotalItemNumber(managerService.findAll(managers,
						company, page.getPageNumber(), page.getPageSize()));
			else
				page.setTotalItemNumber(managerService.findAll(managers,
						company, 1, page.getPageSize()));
			System.out.println(managers.size());
			session.put("managers", managers);
		} catch (RootException e) {
			errorMsg = e.toString();
			throw new PromptException(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "managerList";
	}

	// 管理所有管理员信息
	// 删除选中管理员
	// @RequiresRoles("companySuperManager")
	public void deleteManagers() throws ServerErrorException {
		this.getResponseAndOut();
		JSONArray json = new JSONArray();
		try {
			/*
			 * Subject currentUser = SecurityUtils.getSubject(); if
			 * (!currentUser.isPermitted("manager:delete")) {
			 * out.println("对不起您没有删除管理员的权限,请联系您公司的高级管理员获取该权限！"); }
			 */
			Manager m = (Manager) session.get("currentManager");
			if (m == null) {
				errorMsg = "您还未登录，或者长时间未操作，请重新登录！";
				json.add(false);
				json.add(errorMsg);
				out.println(json);
				this.closeOut();
				return;
			}
			m = managerService.findManager(m);
			Company company = companyService.load(m.getCompany());
			System.out.println(this.getIds());
			if (managerService.deleteSelectedManagers(this.getIds(), company)) {
				json.add(true);
				json.add("删除选中管理员成功！");
			} else {
				json.add(false);
				json.add("删除选中管理员失败!");
			}
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
		 * int id = mtemp.getId(); if (id == manager.getId())// 代表是当前登录账号 { if
		 * (!currentUser.isAuthenticated()) {
		 * 
		 * json.add(false); json.add("您的登录信息已过期，请重新登录！"); out.println(json);
		 * this.closeOut(); return; } } else { if
		 * (!currentUser.isPermitted("manager:*")) { json.add(false);
		 * json.add("您没有修改其它管理员信息的权限，请联系公司超级管理员进行申请该权限，或者用其他账户登录！");
		 * out.println(json); this.closeOut(); return; } }
		 */
		Manager m = null;
		try {
			m = managerService.findManager((Manager) new Manager()
					.setId(manager.getId()));
			if (m == null) {
				errorMsg = "该管理员不存在，无法修改！";
				json.add(false);
				json.add(errorMsg);
				this.closeOut();
			}
			m = managerService.findManager(m);
			// 先保存凭证
			String webDir = "/upload/img/photoes";
			String savePath = ServletActionContext.getServletContext()
					.getRealPath(webDir);
			fileFileName = "headImg" + new Date().getTime() + fileFileName;
			Image image = imageService.saveFile(file, savePath, webDir,
					fileFileName);
			if (image != null)
				m.setImage(image);
			managerService.alterManager(m);
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
	public void alterManagerInfo() throws ServerErrorException {
		JSONArray json = new JSONArray();
		this.getResponseAndOut();
		try {
			/*
			 * Subject currentUser = SecurityUtils.getSubject(); Manager mtemp =
			 * (Manager) session.get("currentManager"); if (mtemp == null) {
			 * json.add(false); json.add("您的登录信息已过期，请重新登录！"); } int id =
			 * mtemp.getId(); if (id == manager.getId())// 代表是当前登录账号 { if
			 * (!currentUser.isAuthenticated()) { json.add(false);
			 * json.add("您的登录信息已过期，请重新登录！"); } } else { if
			 * (!currentUser.isPermitted("manager:*")) { json.add(false);
			 * json.add("您没有修改其它管理员信息的权限，请联系公司超级管理员进行申请该权限，或者用其他账户登录！"); } }
			 */

			Manager m = managerService.findManager((Manager) new Manager()
					.setId(manager.getId()));// 这里前台传递id即可
			if (m == null) {
				errorMsg = "对不起，该管理员账号不存在，无法修改其信息！请核实后再重试！";
				json.add(false);
				json.add(errorMsg);
			}
			/************* 反射动态调用实现代码开始 ***********/
			// 获取到用户管理器类和用户类的class
			Class servicecla = managerService.getClass();
			Class managercla = manager.getClass();
			// 获取到user需要修改的成员变量的get方法
			Method managerGetMethod = managercla.getMethod(
					"get" + alterFlag.substring(0, 1).toUpperCase()
							+ alterFlag.substring(1), null);
			Class retClassType = managerGetMethod.getReturnType();
			// 设置需要调用的函数的参数类型
			Class[] parameterTypes = new Class[] { int.class, retClassType };
			// 获取需要调用的函数
			Method method = servicecla.getMethod(
					"alter" + alterFlag.substring(0, 1).toUpperCase()
							+ alterFlag.substring(1), parameterTypes);
			// 调用该函数需要传递的参数数组
			Object[] args = new Object[] { manager.getId(),
					managerGetMethod.invoke(manager, null) };
			// 调用该对象的该函数
			if ((Boolean) method.invoke(managerService, args)) {
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

	/*************** spring注入 *****************/
	public Manager getManager() {
		return manager;
	}

	@Resource
	public void setManager(Manager manager) {
		this.manager = manager;
	}

	@Override
	public ManagerService getManagerService() {
		return managerService;
	}

	@Override
	@Resource
	public void setManagerService(ManagerService managerService) {
		this.managerService = managerService;
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
		this.fileFileName = fileFileName;
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

}
