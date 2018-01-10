package com.sport.service;

import java.util.Date;

import javax.annotation.Resource;
import org.springframework.stereotype.Component;
import com.sport.dao.PersonDao;
import com.sport.entity.Person;
import com.sport.exception.PromptException;
import com.sport.exception.RootException;

@Component
public class PersonService extends RootService{
	private static final String ENTITY_NAME="Person";
	protected PersonDao personDao;

	public PersonDao getPersonDao() {
		return personDao;
	}

	@Resource
	public void setPersonDao(PersonDao personDao) {
		this.personDao = personDao;
	}

	// 判断该用户名是否已经被注册
	public boolean isExistsPersonName(String name) throws PromptException {
		Person m = personDao.load(name);
		if (m != null)
			return true;
		else
			return false;
	}

	// 注册用户
	public boolean register(Person m) {
		m.setRoles(null)
		.setImages(null)
		.setReplyArticles(null)
		.setTalkArticles(null)
		;
		return personDao.save(m);
	}

	// 更新用户信息
	public void alterPersonInformation(Person m) throws PromptException {
		if(m==null||(m.getId()<=0))
			throw new PromptException(PromptException.NEED_MORE_USER_UPDATE_INFO);
		personDao.update(m);
	}

	// 删除某用户
	public void deletePerson(Person m) throws PromptException {
		if (personDao.load(m) != null)
			personDao.delete(m);
		else
			throw new PromptException(RootException.NEED_MORE_DELETE_INFO);
	}

	// 加载某用户信息
	public Person findPerson(Person p) throws PromptException {
		if(p==null||(p.getId()<=0&&(p.getUserName()==null||p.getUserName().trim().equals(""))&&
				(p.getWeixin()==null||(p.getWeixin().trim().equals("")))))
			throw new PromptException(RootException.NEED_MORE_FIND_INFO);
		return personDao.load(p);
	}
	
	public Person findPerson(String p) throws PromptException {
		if(p==null||p.trim().equals(""))
			throw new PromptException(RootException.NEED_MORE_FIND_INFO);
		return personDao.load(p);
	}

	//用户登录验证
	public boolean login(String personName,String password) throws PromptException{
		if(personName==null||personName.trim().equals(""))
			throw new PromptException("请输入用户名！");
		if(password==null||password.trim().equals(""))
			throw new PromptException("请输入密码！");
		Person p=personDao.load(personName);
		if(p!=null&&(p.getPassword().equals(password)))
			return true;
		return false;
	}
	
	//管理员批量删除用户
	public boolean deleteSelectedPersons(String ids) {
		return personDao.deleteEntitys(ENTITY_NAME,ids);
	}
	//用户修改个人密码
	public boolean alterPassword(int id, String password) {
		return personDao.alterColString(ENTITY_NAME,id, "password", password);

	}
	//用户修改个人真实姓名
	public boolean alterRealName(int id, String realName) {
		return personDao.alterColString(ENTITY_NAME,id, "realName", realName);
	}
	//用户修改个人生日
	public boolean alterBirthday(int id, Date birthday) {
		return personDao.alterDate(ENTITY_NAME,id,"birthday", birthday);
	}
	//用户修改个人电话号码
	public boolean alterPhone(int id, String phone) {
		return personDao.alterColString(ENTITY_NAME,id, "phone", phone);
	}
	//用户修改个人电话号码
	public boolean alterTelephone(int id, String telephone) {
		return personDao.alterColString(ENTITY_NAME,id, "telephone", telephone);
	}
	//用户修改个人邮箱
	public boolean alterEmail(int id, String email) {
		return personDao.alterColString(ENTITY_NAME,id, "email", email);
	}
	//用户修改个人邮编号
	public boolean alterPostcode(int id, String postcode) {
		return personDao.alterColString(ENTITY_NAME,id, "postcode", postcode);
	}
	//用户修改个人性别
	public boolean alterSex(int id, String sex) {
		return personDao.alterColString(ENTITY_NAME,id, "sex", sex);
	}
	//用户修改个人介绍
	public boolean alterDetail(int id, String detail) {
		return personDao.alterColString(ENTITY_NAME,id, "detail", detail);
	}
	//修改用户的微信号绑定
	public boolean alterWeixin(int id,String weixin){
		return personDao.alterColString(ENTITY_NAME, id, "weixin", weixin);
	}
}
