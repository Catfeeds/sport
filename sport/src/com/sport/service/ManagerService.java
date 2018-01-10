package com.sport.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.sport.dao.ManagerDao;
import com.sport.entity.Company;
import com.sport.entity.Manager;
import com.sport.exception.PromptException;
import com.sport.exception.RootException;

@Component
public class ManagerService extends PersonService {
	private static final String ENTITY_NAME = "Manager";
	private ManagerDao managerDao;
	private HostConfigService hostConfigService;
	public ManagerDao getManagerDao() {
		return managerDao;
	}

	@Resource
	public void setManagerDao(ManagerDao managerDao) {
		this.managerDao = managerDao;
	}

	public HostConfigService getHostConfigService() {
		return hostConfigService;
	}
	@Resource
	public void setHostConfigService(HostConfigService hostConfigService) {
		this.hostConfigService = hostConfigService;
	}

	// 添加管理员
	public boolean add(Manager m) throws PromptException {
		if (m == null)
			throw new PromptException(RootException.NEED_MORE_ADD_INFO);
		if (null != personDao.loadByPhone(m.getPhone()))
			throw new PromptException(PromptException.PHONE_EXISTS);
		if (null != personDao.loadByWeixin(m.getWeixin()))
			throw new PromptException(PromptException.WEIXIN_EXISTS);
		return managerDao.save(m);
	}

	// 更新管理员信息
	public void alterManager(Manager m) throws PromptException {
		if (m == null || m.getId() <= 0)
			throw new PromptException(RootException.NEED_MORE_UPDATE_INFO);
		managerDao.update(m);
	}

	// 删除某管理员
	public boolean deleteManager(Manager m) throws PromptException {
		if (m == null
				|| (m.getId() <= 0
						&& (m.getUserName() == null || m.getUserName().trim()
								.equals("")) && (m.getWeixin() == null || (m
						.getWeixin().trim().equals("")))))
			throw new PromptException(RootException.NEED_MORE_DELETE_INFO);
		if (managerDao.load(m) != null)
			managerDao.delete(m);
		else
			return false;
		return true;
	}

	// 加载某管理员信息
	public Manager findManager(Manager m) throws PromptException {
		if (m == null
				|| (m.getId() <= 0
						&& (m.getUserName() == null || m.getUserName().trim()
								.equals(""))
						&& (m.getWeixin() == null || (m.getWeixin().trim()
								.equals(""))) && (m.getPhone() == null || (m
						.getPhone().trim().equals("")))))
			throw new PromptException(RootException.NEED_MORE_FIND_INFO);
		m = managerDao.load(m);
		return m;
	}

	public Manager findManager(String userName) throws PromptException {
		if (userName == null || userName.trim().equals(""))
			throw new PromptException(RootException.NEED_MORE_FIND_INFO);
		return managerDao.load(userName);
	}

	/************** 管理员管理会员信息 **********************/
	// 默认方式查询所有管理员信息，分页查看
	public int findAll(List<Manager> managers, Company company, int pageNumber,
			int pageSize) {
		return managerDao.findAll(managers, company.getId(), pageNumber,
				pageSize);
	}

	// 按某列排序查看管理员信息
	public int findAll(List<Manager> managers, Company company, int pageNumber,
			int pageSize, String orderByColumn, boolean isAsc) {
		return managerDao.findAll(managers, company.getId(), pageNumber,
				pageSize, null, orderByColumn, isAsc);
	}

	public boolean deleteSelectedManagers(String ids, Company company)
			throws PromptException {
		// return managerDao.deleteEntitys(ENTITY_NAME,ids);
		String idStrArr[] = ids.split("\\W");
		int id = 0;
		for (String str : idStrArr) {
			if (str.equals("1") || (str.trim().equals("")))
				continue;
			try {
				id = Integer.valueOf(str);
				System.out.println("产品Id：" + id);
				Manager m = managerDao.load(id);
				if (null == managerDao.loadCompanyManager(m))
					throw new PromptException("你的公司不存在该管理员，无法删除！");
				deleteManager(m);
			} catch (Exception e) {
				e.printStackTrace();
				throw new PromptException("删除管理员失败！请检查您公司是否存在该管理员，若存在，请重试！");
			}
		}
		return true;
	}

}
