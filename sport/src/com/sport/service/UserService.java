package com.sport.service;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import org.springframework.stereotype.Component;

import com.sport.dao.PersonDao;
import com.sport.dao.UserDao;
import com.sport.entity.User;
import com.sport.exception.PromptException;
import com.sport.exception.RootException;

@Component
public class UserService extends PersonService{
	private static final String ENTITY_NAME="User";
	private UserDao userDao;
	
	public UserDao getUserDao() {
		return userDao;
	}

	@Resource
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	// 注册用户
	public boolean register(User m) throws PromptException {
		if(m==null)
			throw new PromptException(PromptException.NEED_MORE_ADD_INFO);
		if(m.getPhone()!=null)
		if(null!=personDao.loadByPhone(m.getPhone()))
				throw new PromptException(PromptException.PHONE_EXISTS);
		if(m.getWeixin()!=null)
		if(null!=personDao.loadByWeixin(m.getWeixin()))
			throw new PromptException(PromptException.WEIXIN_EXISTS);
		m.setIntegration(0)
		.setLevel(1)		
		.setExperience(0)
		.setCareProducts(null)
		.setTypes(null)
		.setComments(null)
		.setRegisterDate(new Date())
		.setRoles(null)
		.setImages(null)
		.setReplyArticles(null)
		.setTalkArticles(null)
		;
		return userDao.save(m);
	}

	// 更新用户信息
	public void alterUserInformation(User m) throws PromptException {
		if(m==null||(m.getId()<=0))
			throw new PromptException(PromptException.NEED_MORE_USER_UPDATE_INFO);
		userDao.update(m);
	}

	// 删除某用户
	public void deleteUser(User m) throws PromptException {
		if (userDao.load(m) != null)
			userDao.delete(m);
		else
			throw new PromptException(RootException.NEED_MORE_DELETE_INFO);
	}

	// 加载某用户信息
	public User findUser(User u) throws PromptException {
		if(u==null||(u.getId()<=0&&(u.getUserName()==null||u.getUserName().trim().equals(""))&&
				(u.getWeixin()==null||(u.getWeixin().trim().equals("")))))
			throw new PromptException(RootException.NEED_MORE_FIND_INFO);
		return userDao.load(u);
	}
	
	public User findUser(String u) throws PromptException {
		if(u==null||u.trim().equals(""))
			throw new PromptException(RootException.NEED_MORE_FIND_INFO);
		return userDao.load(u);
	}

	/************** 管理员管理会员信息 **********************/
	// 默认方式查询所有会员信息，分页查看
	public int findAll(List<User> users, int pageNumber, int pageSize) {
		return userDao.findAll(users, pageNumber, pageSize);
	}

	// 按某列排序查看会员信息
	public int findAll(List<User> users, int pageNumber, int pageSize,
			String orderByColumn, boolean isAsc) {
		return userDao.findAll(users, pageNumber, pageSize, null,
				orderByColumn, isAsc);
	}
	//用户登录验证
	public boolean login(String userName,String password) throws PromptException{
		if(userName==null||userName.trim().equals(""))
			throw new PromptException("请输入用户名！");
		if(password==null||password.trim().equals(""))
			throw new PromptException("请输入密码！");
		User u=userDao.load(userName);
		if(u!=null&&(u.getPassword().equals(password)))
			return true;
		return false;
	}
	
	//管理员批量删除用户
	public boolean deleteSelectedUsers(String ids) {
		return userDao.deleteEntitys(ENTITY_NAME,ids);
	}
	//同步修改用户个人信息
	public User update(User user) throws PromptException {
		if(user==null)
			throw new PromptException(PromptException.NEED_MORE_USER_UPDATE_INFO);
		User u=userDao.load(user);
		u.setBirthday(user.getBirthday())
			.setDetail(user.getDetail())
			.setEmail(user.getEmail())
			.setPassword(user.getPassword())
			.setPhone(user.getPhone())
			.setPostcode(user.getPostcode())
			.setRealName(user.getRealName())
			.setSex(user.getSex())
			.setTelephone(user.getTelephone())
			.setUserName(user.getUserName())
			.setWeixin(user.getWeixin());
		if(user.getImage()!=null)
			u.setImage(user.getImage());
		userDao.update(u);
		return u;
	}
	
}
