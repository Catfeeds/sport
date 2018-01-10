package com.sport.security;

import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.SimplePrincipalCollection;

import com.sport.entity.Manager;
import com.sport.entity.Person;
import com.sport.entity.Right;
import com.sport.entity.Role;
import com.sport.exception.PromptException;
import com.sport.exception.RootException;
import com.sport.service.CompanyService;
import com.sport.service.HostConfigService;
import com.sport.service.PersonService;
import com.sport.service.RightService;
import com.sport.service.RoleService;
import com.sport.util.EncryptUtils;



//@Service("shiroDbRealm")
public class UserRealm extends AuthorizingRealm {
	/*
	 * @Resource UserService userService;
	 * 
	 * @Resource managerService managerService;
	 * 
	 */
	private String superCompanyName;
	private String hostSuperManagerName;
	private static HostConfigService configService;
	private RightService rightService;
	private RoleService roleService;
	private CompanyService companyService;
	static {
		try {
			configService=new HostConfigService();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
	}
	public UserRealm(){
		super();
		superCompanyName=configService.getCompanyName();
		hostSuperManagerName=configService.getHostSuperManagerName();
	}
	public RightService getRightService() {
		return rightService;
	}

	public void setRightService(RightService rightService) {
		this.rightService = rightService;
	}
	public RoleService getRoleService() {
		return roleService;
	}
	public void setRoleService(RoleService roleService) {
		this.roleService = roleService;
		
	}
	private PersonService personService;
	
	public PersonService getPersonService() {
		return personService;
	}

	public UserRealm setPersonService(PersonService personService) {
		this.personService = personService;
		return this;
	}


	public CompanyService getCompanyService() {
		return companyService;
	}
	public void setCompanyService(CompanyService companyService) {
		this.companyService = companyService;
		
	}
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(
			PrincipalCollection principals) {
		Set<String> roleNames = new HashSet<String>();
	    Set<String> permissions = new HashSet<String>();
	    String acount=(String)principals.getPrimaryPrincipal();
	    //角色封装某类型的具体权限，资源全依据管理员的权限来确定
	    Person m=null;
		try {
			m = personService.findPerson(acount);
		} catch (RootException e) {
			e.printStackTrace();
		}
		if(m instanceof Manager){//只有管理员属于平台拥有商家且是最高权限者才拥有所有权限
			if(((Manager) m).getCompany().getCompanyName()!=null){
				if(((Manager) m).getCompany().getCompanyName().equals(superCompanyName)){
					try {
						companyService.update(((Manager) m).getCompany().setHost(true));
					} catch (RootException e1) {
						e1.printStackTrace();
					}
					if(m.getRealName()!=null){
						if(m.getRealName().equals(hostSuperManagerName)){
							List<Right> rights=new ArrayList<Right>();
							rightService.findAll(rights, 1, 100);							
							m.setRights(rights);
							//List<Role> roles=new ArrayList<Role>();
							//roleService.findAll(roles, 1, 100);
							//m.setRoles(roles);
							try {
								personService.alterPersonInformation(m);
							} catch (PromptException e) {
								e.printStackTrace();
							}
						}
					}
				}
			}		
			
		}
	    List<Role> roles=m.getRoles();
	    for(Role r:roles)
	    {
	    	roleNames.add(r.getName());
	    	for(Right right:r.getRights()){
	    		permissions.add(right.getRightName());
	    	}
	    }
	    for(Right right:m.getRights()){
	    	permissions.add(right.getRightName());
	    }
		SimpleAuthorizationInfo info = new SimpleAuthorizationInfo(roleNames);
	    info.setStringPermissions(permissions);
		return info;
	}

	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(
			AuthenticationToken authcToken) throws AuthenticationException {
		System.out.println("security filter!");
		Person m=null;
		try {
			String userName=(String)authcToken.getPrincipal();
			m = personService.findPerson(new Person().setUserName(userName)
									.setPhone(userName).setWeixin(userName));
		} catch (RootException e) {
			e.printStackTrace();
		}
		if(m!=null)		
			return new SimpleAuthenticationInfo(m.getUserName(),
					EncryptUtils.encryptMD5(m.getPassword()),getName());
		else
			return new SimpleAuthenticationInfo(authcToken.getPrincipal(),"illegalUser",getName());
	}

	public void clearCachedAuthorizationInfo(String principal) {
		SimplePrincipalCollection principals = new SimplePrincipalCollection(
				principal, getName());
		clearCachedAuthorizationInfo(principals);
	}

	
	
	
}
