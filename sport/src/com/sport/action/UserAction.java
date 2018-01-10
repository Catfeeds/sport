package com.sport.action;

import java.lang.reflect.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.apache.struts2.ServletActionContext;
import org.hibernate.Hibernate;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.sport.entity.Image;
import com.sport.entity.Manager;
import com.sport.entity.Person;
import com.sport.entity.User;
import com.sport.exception.PromptException;
import com.sport.exception.RootException;
import com.sport.exception.ServerErrorException;
import com.sport.service.ImageService;
import com.sport.service.UserService;
import com.sport.util.EncryptUtils;

@Component
@Scope("prototype")
public class UserAction extends RootAction {
	private ImageService imageService;
	private UserService userService;
	private User user;

	File file;
	String fileContentType;
	String fileFileName;

	// 用户登录
	public String login() throws ServerErrorException, PromptException {
		System.out.println("user login !");
		try {
			Subject currentUser = SecurityUtils.getSubject();
			UsernamePasswordToken token = new UsernamePasswordToken(
					user.getUserName(), EncryptUtils.encryptMD5(user
							.getPassword()));
			token.setRememberMe(true);
			try {
				currentUser.login(token);
			} catch (AuthenticationException e) {
				errorMsg = "错误，用户名或密码不匹配！";
				throw new PromptException(errorMsg);
			}
			// 验证是否是会员登录
			user.setPhone(user.getUserName()).setWeixin(user.getUserName());
			user = userService.findUser(user);
			session.put("currentUser", user);
			session.remove("currentManager");
			session.remove("currentCoach");
			System.out.println("用户（" + user.getUserName() + "）登录成功！");
		} catch (PromptException e) {
			errorMsg = e.toString();
			throw new PromptException(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "index";
	}

	// 异步登录
	public void asynLogin() throws ServerErrorException {
		System.out.println("user login !");
		this.getResponseAndOut();
		JSONArray json = new JSONArray();
		try {
			Subject currentUser = SecurityUtils.getSubject();
			UsernamePasswordToken token = new UsernamePasswordToken(
					user.getUserName(), EncryptUtils.encryptMD5(user
							.getPassword()));
			token.setRememberMe(true);
			currentUser.login(token);
			// 验证是否是会员登录
			user.setPhone(user.getUserName()).setWeixin(user.getUserName());
			user = userService.findUser(user);
			session.put("currentUser", user);
			json.add(true);
			System.out.println("用户（" + user.getUserName() + "）登录成功！");
		} catch (AuthenticationException e) {
			errorMsg = "错误，用户名或密码不匹配！";
			json.add(false);
		} catch (PromptException e) {
			errorMsg = e.toString();
			json.add(false);
		} catch (Exception e) {
			e.printStackTrace();
			json.add(false);
			errorMsg = RootException.SYSTEM_ERROR;
		}
		json.add(errorMsg);
		out.println(json);
		this.closeOut();
	}

	public void loginByPhone() throws ServerErrorException {
		System.out.println("user login !");
		this.getResponseAndOut();
		JSONArray json = new JSONArray();
		try {
			Subject currentUser = SecurityUtils.getSubject();
			UsernamePasswordToken token = new UsernamePasswordToken(
					user.getUserName(), EncryptUtils.encryptMD5(user
							.getPassword()));
			token.setRememberMe(true);
			currentUser.login(token);
			// 验证是否是会员登录
			user = userService.findUser(user);
			if (user == null)
				throw new PromptException("不存在该用户账号！");
			session.put("currentUser", user);
			json.add(true);
			System.out.println("用户（" + user.getUserName() + "）登录成功！");
		} catch (AuthenticationException e) {
			errorMsg = "错误，用户名或密码不匹配！";
			json.add(false);
		} catch (PromptException e) {
			errorMsg = e.toString();
			json.add(false);
		} catch (Exception e) {
			e.printStackTrace();
			json.add(false);
			errorMsg = RootException.SYSTEM_ERROR;
		}
		json.add(errorMsg);
		out.println(json);
		this.closeOut();
	}

	// 用户注销登录
	public String logout() {
		session.remove("currentUser");
		return "index";
	}

	// 用户注册
	public String register() throws Exception {
		System.out.println(user);
		try {
			if (userService.register(user))
				errorMsg = "注册成功！";
		} catch (RootException e) {
			errorMsg = e.toString();
			throw new PromptException(errorMsg);
		} catch (Exception e) {
			errorMsg = "该用户名不可用，请更改！";
			e.printStackTrace();
			throw e;
		}

		throw new PromptException(errorMsg);
	}

	// 异步注册
	public void asynRegister() throws ServerErrorException {
		this.getResponseAndOut();
		JSONArray json = new JSONArray();
		try {
			// 系统自动分配用户名
			user.setUserName("u" + new Date().getTime());
			if (userService.register(user)) {
				errorMsg = "注册成功！";
				json.add(true);

			}
		} catch (RootException e) {
			errorMsg = e.toString();
			json.add(false);
		} catch (Exception e) {
			e.printStackTrace();
			json.add(false);
			errorMsg = "该电话号码已经被绑定了，请更改！";
		}
		json.add(errorMsg);
		out.println(json);
		this.closeOut();
		if (json.getBoolean(0)) {
			loginByPhone();// 如果注册成功，则同时进行登录
		}
	}

	// 检测用户名是否可用
	public void isExistsUserName() throws ServerErrorException {
		this.getResponseAndOut();
		JSONArray json = new JSONArray();
		try {
			System.out.println("userName:" + user.getUserName());
			if (userService.findUser(user.getUserName().trim()) != null) {
				json.add(false);
				json.add("该用户名已经被注册，请更改用户名！");
			} else {
				json.add(true);
				json.add("该用户名可用!");
			}

		} catch (PromptException e) {
			errorMsg = e.toString();
			json.add(false);
			json.add(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			json.add(false);
			json.add(RootException.SYSTEM_ERROR);
		}
		out.println(json);
		System.out.println(json);
		this.closeOut();
	}

	/**************
	 * 修改当前登录用户个人信息,动态修改各个字段
	 * 
	 * @throws ServerErrorException
	 * @throws PromptException
	 * @throws Exception
	 **************/
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public String alterUserSelfInfo() throws ServerErrorException,
			PromptException {
		User u = (User) session.get("currentUser");
		if (u == null) {
			errorMsg = "您还未登录，无法进行信息的修改！";
			throw new PromptException(errorMsg);
		}
		user.setId(u.getId());
		alterUserInfoById();
		return null;
	}

	public String alterUser() throws PromptException, ServerErrorException {
		try {
			if (file == null || (!file.isFile()) || (!file.exists()))
				;
			else {
				// 先保存凭证
				String webDir = "/upload/img/photoes";
				String savePath = ServletActionContext.getServletContext()
						.getRealPath(webDir);
				fileFileName = "headImg" + new Date().getTime() + fileFileName;
				Image image = imageService.saveFile(file, savePath, webDir,
						fileFileName);
				if (image != null)
					user.setImage(image);
			}
			user=userService.update(user);
			session.put("currentUser", user);
		} catch (RootException e) {
			errorMsg = e.toString();
			throw new PromptException(errorMsg);
		} catch (Exception e) {
			throw new ServerErrorException();
		}
		return "userDetail";
	}

	// 管理员修改某用户个人信息
	public void alterUserInfo() throws ServerErrorException {
		alterUserInfoById();
	}

	// 修改某用户的个人信息
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void alterUserInfoById() throws ServerErrorException {
		try {
			this.getResponseAndOut();
			JSONArray json = new JSONArray();
			User u = userService
					.findUser((User) new User().setId(user.getId()));// 这里需要前台传递id即可
			if (u == null) {
				errorMsg = "对不起，该用户账号不存在，无法修改其信息！请核实后再重试！";
				json.add(false);
				json.add(errorMsg);
			}
			/************* 反射动态调用实现代码开始 ***********/
			// 获取到用户管理器类和用户类的class
			Class servicecla = userService.getClass();
			Class usercla = user.getClass();
			// 获取到user需要修改的成员变量的get方法
			Method userGetMethod = usercla.getMethod(
					"get" + alterFlag.substring(0, 1).toUpperCase()
							+ alterFlag.substring(1), null);
			Class retClassType = userGetMethod.getReturnType();
			// 设置需要调用的函数的参数类型
			Class[] parameterTypes = new Class[] { int.class, retClassType };
			// 获取需要调用的函数
			Method method = servicecla.getMethod(
					"alter" + alterFlag.substring(0, 1).toUpperCase()
							+ alterFlag.substring(1), parameterTypes);
			// 调用该函数需要传递的参数数组
			Object[] args = new Object[] { user.getId(),
					userGetMethod.invoke(user, null) };
			// 调用该对象的该函数
			if ((Boolean) method.invoke(userService, args)) {
				json.add(true);
			} else {
				json.add(false);
			}
			/************* 反射动态调用实现代码结束 ***********/
			out.println(json);
			this.closeOut();
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
	}

	/********** 管理员管理用户信息 ************/
	// @RequiresPermissions("user:view")
	public String userList() {
		System.out.println("进入到方法");
		List<User> users = new ArrayList<User>();
		if (page.getPageNumber() != 0)
			page.setTotalItemNumber(userService.findAll(users,
					page.getPageNumber(), page.getPageSize()));
		else
			page.setTotalItemNumber(userService.findAll(users, 1,
					page.getPageSize()));
		System.out.println(users.size());
		session.put("users", users);
		return "userList";
	}

	// 加载某会员个人信息
	public String userDetail() throws PromptException, ServerErrorException {
		try {
			System.out.println("查看用户详细信息！");
			if(user==null)
				user = this.getCurrentUser();
			user=userService.findUser(user);
			return "userDetail";
		} catch (PromptException e) {
			errorMsg = e.toString();
			throw new PromptException(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
	}

	public void alterSelfHeadImg() throws ServerErrorException {
		this.getResponseAndOut();
		JSONArray json = new JSONArray();
		User u = (User) session.get("currentUser");
		if (u == null) {
			errorMsg = "您还未登录，无法进行信息的修改！";
			out.println(errorMsg);
		}
		try {
			u = userService.findUser(u);
			// 先保存凭证
			String webDir = "/upload/img/photoes";
			String savePath = ServletActionContext.getServletContext()
					.getRealPath(webDir);
			fileFileName = "headImg" + new Date().getTime() + fileFileName;
			Image image = imageService.saveFile(file, savePath, webDir,
					fileFileName);
			if (image != null)
				u.setImage(image);
			userService.alterUserInformation(u);
			json.add(true);
			json.add(image.getPathName());// 将新头像地址返回
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

	// 管理员更新用户头像,异步上传
	public void alterHeadImg() throws PromptException, ServerErrorException {
		this.getResponseAndOut();
		JSONArray json = new JSONArray();
		User u = (User) session.get("currentManager");
		if (u == null) {
			errorMsg = "您还未登录，无法进行信息的修改！";
			out.println(errorMsg);
		}
		try {

			user = userService.findUser(user);
			// 先保存凭证
			String webDir = "/upload/img/photoes";
			String savePath = ServletActionContext.getServletContext()
					.getRealPath(webDir);
			fileFileName = "headImg" + new Date().getTime() + fileFileName;
			Image image = imageService.saveFile(file, savePath, webDir,
					fileFileName);
			if (image != null)
				user.setImage(image);
			userService.alterUserInformation(u);
			json.add(true);
			json.add(image.getPathName());// 将新头像地址返回
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

	// 批量删除用户
	public void deleteUsers() throws PromptException, ServerErrorException {
		this.getResponseAndOut();
		JSONArray json = new JSONArray();
		System.out.println(this.getIds());
		try {
			if (userService.deleteSelectedUsers(this.getIds())) {
				json.add(true);
				json.add("删除选中用户成功！");
			} else {
				json.add(false);
				json.add("删除选中用户失败!");
			}
		} catch (Exception e) {
			json.add(false);
			json.add(RootException.SYSTEM_ERROR);
		}
		out.println(json);
		this.closeOut();

	}

	/********** 注入代码 ********/
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Resource
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public UserService getUserService() {
		return userService;
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

	public UserAction() {
		// System.out.println("RegisterAction创建成功！");
	}
}
