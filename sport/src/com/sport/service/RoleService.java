package com.sport.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.sport.dao.RoleDao;
import com.sport.entity.Role;
import com.sport.exception.RootException;

@Component
public class RoleService  extends RootService{
	private static final String ENTITY_NAME="Role";
	private RoleDao roleDao;

	public RoleDao getRoleDao() {
		return roleDao;
	}
	@Resource
	public RoleService setRoleDao(RoleDao roleDao) {
		this.roleDao = roleDao;
		return this;
	}
	public void add(Role role) throws RootException{
		if(role==null)
			throw new RootException(RootException.NEED_MORE_ADD_INFO);	
		roleDao.save(role);
	}
	
	public void delete(Role role) throws RootException{
		
		if(role==null||(role.getId()<=0&&(role.getName()==null||role.getName().trim().equals(""))))
			throw new RootException(RootException.NEED_MORE_FIND_INFO);	
		 roleDao.delete(role);
	}
	public void delete(int id) throws RootException{		
		if(id<=0)
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);	
		 roleDao.delete(id);
	}
	public void update(Role role) throws RootException{
		if(role==null||(role.getId()<=0&&(role.getName()==null||role.getName().trim().equals(""))))
			throw new RootException(RootException.NEED_MORE_UPDATE_INFO);	
		roleDao.update(role);
	}
	
	public Role load(Role role) throws RootException{
		if(role==null||(role.getId()<=0&&(role.getName()==null||role.getName().trim().equals(""))))
			throw new RootException(RootException.NEED_MORE_FIND_INFO);	
		return roleDao.load(role);			
	}
	public Role load(int id) throws RootException{
		if(id<=0)
			throw new RootException(RootException.NEED_MORE_FIND_INFO);	
		return roleDao.load(id);			
	}
	
	public  int findAll(List<Role> roles,
			int pageNumber,
			int pageSize
			){
		return roleDao.findAll( roles,pageNumber,pageSize);
	}
	//按某列排序查看会员信息
	public  int findAll(List<Role> roles,
			int pageNumber,
			int pageSize,
			String orderByColumn,
			boolean isAsc){
		return roleDao.findAll( roles,pageNumber,pageSize,null,orderByColumn,isAsc);
	}
}
