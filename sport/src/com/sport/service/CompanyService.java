package com.sport.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.sport.dao.CompanyDao;
import com.sport.entity.Company;
import com.sport.entity.Image;
import com.sport.entity.Manager;
import com.sport.entity.Role;
import com.sport.exception.RootException;

@Component
public class CompanyService  extends RootService{
	private static final String ENTITY_NAME = "Company";
	private CompanyDao companyDao;
	private ManagerService managerService;
	private RoleService roleService;
	private HostConfigService hostConfigService;
	public HostConfigService getHostConfigService() {
		return hostConfigService;
	}
	@Resource
	public void setHostConfigService(HostConfigService hostConfigService) {
		this.hostConfigService = hostConfigService;
	}

	public RoleService getRoleService() {
		return roleService;
	}

	@Resource
	public void setRoleService(RoleService roleService) {
		this.roleService = roleService;
	}

	public CompanyDao getCompanyDao() {
		return companyDao;
	}

	@Resource
	public void setCompanyDao(CompanyDao companyDao) {
		this.companyDao = companyDao;
	}

	public ManagerService getManagerService() {
		return managerService;
	}

	@Resource
	public void setManagerService(ManagerService managerService) {
		this.managerService = managerService;
	}

	// 产品分类信息的增删改
	public void add(Company company, Manager manager, Image image)
			throws RootException {
		if (company == null
				|| (company.getCompanyName() == null || company
						.getCompanyName().trim().equals("")))
			throw new RootException(RootException.NEED_MORE_ADD_INFO);
		List<Manager> managers=new ArrayList<Manager>();
		managers.add(manager);				
		company.setFlag(false).setProofFile(image)
				.setRegisterDate(new Date()).setManagers(managers);
		manager.setCompany(company).setHasSuper(true);
		/*List<Role> roles = new ArrayList<Role>();
		roles.add(roleService.load(new Role().setName("joinedSuperManager")));
		manager.setRoles(roles);*/
		managerService.add(manager);
		companyDao.save(company);
		image.setCompanyIdStr("" + company.getId());
	}

	public boolean delete(Company company) throws RootException {

		if (company == null || (company.getId() <= 0))
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);
		return companyDao.delete(company);
	}
	public void activeCompany(Company company) throws RootException {
		Company c=companyDao.load(company);
		Manager manager=c.getManagers().get(0);
		if(company.isFlag()){
			List<Role> roles = new ArrayList<Role>();
			roles.add(roleService.load(new Role().setName("joinedSuperManager")));
			manager.setRoles(roles);
		}else{
			manager.setRoles(null);
		}
		companyDao.evict(c);
		companyDao.update(company);
	}

	public void update(Company company) throws RootException {
		if (company == null
				|| (company.getCompanyName() == null || company
						.getCompanyName().trim().equals("")))
			throw new RootException(RootException.NEED_MORE_UPDATE_INFO);
		Company c=companyDao.load(company);
		if(company.getLogoImage()==null)
			company.setLogoImage(c.getLogoImage());
		if(company.getProofFile()==null)
			company.setProofFile(c.getProofFile());
		companyDao.evict(c);
		companyDao.update(company);
	}

	public Company load(Company company) throws RootException {
		if (company == null || (company.getId() == 0))
			throw new RootException(RootException.NEED_MORE_FIND_INFO);
		return companyDao.load(company);
	}

	// 管理所有合作厂商信息
	public int findAll(List<Company> companys,Company company, int pageNumber, int pageSize) {
		return companyDao.findAll(companys,company, pageNumber, pageSize);
	}

	// 按某列排序查看合作厂商信息
	public int findAll(List<Company> companys,Company company, int pageNumber, int pageSize,
			String orderByColumn, boolean isAsc) {
		return companyDao.findAll(companys,company, pageNumber, pageSize, null,
				orderByColumn, isAsc);
	}

	public int findCompanys(List<Company> companys, Company company,
			int pageNumber, int pageSize) {
		return companyDao.findCompanys(companys, company, pageNumber, pageSize);
	}

	public boolean deleteSelectedCompanys(String ids) {
		// TODO Auto-generated method stub
		return companyDao.deleteEntitys("Company", ids);
	}
	//获取平台拥有公司
	public Company getOwnerCompany() {
		return companyDao.getOwnerCompany();
	}
	
}
