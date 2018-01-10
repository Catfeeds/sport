package com.sport.action;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import net.sf.json.JSONArray;

import com.sport.entity.Address;
import com.sport.entity.Company;
import com.sport.entity.Site;
import com.sport.entity.User;
import com.sport.exception.PromptException;
import com.sport.exception.RootException;
import com.sport.exception.ServerErrorException;
import com.sport.service.AddressService;
import com.sport.service.SiteService;

/*
 * 利用ImageAction上传场馆图片，方式为：先上传图片，然后再反馈图片id给场馆页面，
 * 场馆再根据图片id进行关联操作
 */
@Component
@Scope("prototype")
public class SiteAction extends RootAction {
	private Site site;
	private List<Site> sites;
	private SiteService siteService;
	private List<Address> rootAddrs;
	private AddressService addressService;
	private List<Address> cityAddrs;//所有市级地区
	// 服务名
	private String serviceName;

	public String toAddSite() {

		return "addSite";
	}
	/**设置场馆的推荐级别1-10
	 * @throws ServerErrorException */
	public void topSite() throws ServerErrorException{
		this.getResponseAndOut();
		JSONArray json=new JSONArray();
		try{
			int topValue=site.getTopValue();
			site=siteService.load(site);
			site.setTopValue(topValue);
			siteService.alter(site);
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
	/*
	 * 添加场馆信息 使用规则： 1、设置好site的一些基本字段信息，页面需要先上传场馆图片信息，然后再上传场馆信息
	 * （页面获取到上传图片后返回的图片路径信息，然后在上传场馆时再次传回服务器实现场馆信息与图片的绑定） 2、
	 */
	public String addSite() throws PromptException, ServerErrorException {
		System.out.println("yes");
		try {
			// 获取场馆所属公司信息,并设置关联
			Company company = this.getCurrentCompany();
			site.setCompany(company);
			// 添加该场馆信息
			siteService.add(site);
		} catch (RootException e) {
			errorMsg = e.toString();
			throw new PromptException(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		siteList();
		return "siteList";
	}
	//商家查看自己的场馆信息
	public String siteList() throws ServerErrorException, PromptException {
		try {
			System.out.println("进入到方法");
			cityAddrs=addressService.findCityAddress();
			sites = new ArrayList<Site>();
			Company company = this.getCurrentCompany();		
			if(site==null)
				site=new Site();
			if(!company.isHost())//平台管理商家可以查看所有场馆信息
				site.setCompany(company);
			page.setTotalItemNumber(siteService.findAll(sites,site,
						page.getPageNumber(), page.getPageSize()));			
		} catch (PromptException e) {
			errorMsg = e.toString();
			throw e;
		} catch (RootException e) {
			errorMsg = e.toString();
			throw new PromptException(e.toString());
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "siteList";
	}
	//平台管理员查看所有场馆信息
	public String managerSiteList() throws ServerErrorException, PromptException {
		try {
			System.out.println("进入到方法");
			sites = new ArrayList<Site>();	
			cityAddrs=addressService.findCityAddress();
			page.setTotalItemNumber(siteService.findAll(sites,site,
						page.getPageNumber(), page.getPageSize()));
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "siteList";
	}

	// 删除场馆信息
	public String deleteSite() throws PromptException, ServerErrorException {
		System.out.println("删除场地");
		System.out.println("id==" + site.getId());
		try {
			siteService.delete(site);
			siteList();
		} catch (RootException e) {
			e.printStackTrace();
			throw new PromptException(e.toString());
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}		
		return "siteList";

	}

	public String alterSite() throws PromptException, ServerErrorException {
		try {
			long siteId = site.getId();
			siteService.update(site);
			site = siteService.load(siteId);
			site.getAddress();
		} catch (RootException e) {
			errorMsg = e.toString();
			throw new PromptException(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		String str = siteDetail();
		return str;
	}

	// 修改场馆基本信息,异步请求
	public void alterSiteBasicInfo() throws ServerErrorException {
		this.getResponseAndOut(false);
		JSONArray json = new JSONArray();
		try {
			Site u = null;
			try {
				u = siteService.load((Site) new Site().setId(site.getId()));
			} catch (RootException e) {
				json.add(false);
				json.add(e.toString());
				this.closeOut();
				return;
			}// 这里需要前台传递id即可
			if (u == null) {
				errorMsg = "对不起，该场馆信息不存在，无法修改其信息！请核实后再重试！";
				json.add(false);
				json.add(errorMsg);
			}
			/************* 反射动态调用实现代码开始 ***********/
			// 获取到用户管理器类和用户类的class
			Class servicecla = siteService.getClass();
			Class sitecla = site.getClass();
			// 获取到site需要修改的成员变量的get方法
			Method siteGetMethod = sitecla.getMethod(
					"get" + alterFlag.substring(0, 1).toUpperCase()
							+ alterFlag.substring(1), null);
			Class retClassType = siteGetMethod.getReturnType();
			// 设置需要调用的函数的参数类型
			Class[] parameterTypes = new Class[] { int.class, retClassType };
			// 获取需要调用的函数
			Method method = servicecla.getMethod(
					"alter" + alterFlag.substring(0, 1).toUpperCase()
							+ alterFlag.substring(1), parameterTypes);
			// 调用该函数需要传递的参数数组
			Object[] args = new Object[] { site.getId(),
					siteGetMethod.invoke(site, null) };
			// 调用该对象的该函数
			if ((Boolean) method.invoke(siteService, args)) {
				json.add(true);
			} else {
				json.add(false);
			}
		} catch (Exception e) {
			e.printStackTrace();
			json.add(false);
			json.add(RootException.SYSTEM_ERROR);
		}
		/************* 反射动态调用实现代码结束 ***********/
		out.println(json);
		this.closeOut();

	}

	// 查看某场馆信息
	public String siteDetail() throws PromptException {
		try {
			site = siteService.load(site);
		} catch (RootException e) {
			e.printStackTrace();
			throw new PromptException(e.toString());
		}
		return "siteDetail";
	}

	// 批量删除场馆信息
	public void deleteSites() {
		System.out.println("删除方法");
		JSONArray json = new JSONArray();
		try {
			this.getResponseAndOut();
			System.out.println(this.getIds());
			if (siteService.deleteSelectedSites(this.getIds())) {
				json.add(true);
			} else {
				json.add(false);
				json.add("删除出错啦！");
			}
		} catch (Exception e) {
			e.printStackTrace();
			json.add(false);
			json.add(RootException.SYSTEM_ERROR);
		} finally {
			out.println(json);
			this.closeOut();
		}

	}

	// 增加或删除一个服务项目
	public void addOrDeleteService() throws ServerErrorException {
		this.getResponseAndOut();
		JSONArray json = new JSONArray();
		try {
			site = siteService.load(site);
			if (site == null) {
				json.add(false);
				json.add("未找到您需要删除的信息，请核实后再重试！");
			} else {
				json.add(true);
				if (!site.getService().contains(serviceName)) {// 如果该场馆你没有该服务就添加该服务
					site.setService(site.getService() + serviceName + ",");
					json.add("添加服务信息成功！");
				} else {// 否则删除该服务
					site.setService(site.getService().replace(
							serviceName + ",", ""));
					json.add("删除服务信息成功！");
				}
			}

		} catch (RootException e) {
			json.add(false);
			json.add(e);
		} finally {
			out.println(json);
			this.closeOut();
		}
	}

	// 增加或删除场馆的私人教练
	public void addOrDeleteCoach() {

	}

	// 增加或关闭一个运动场地
	public void addOrDeletePlace() {

	}

	// 增加或删除一项教练服务
	public void addOrDeleteCoachService() {

	}

	/*********** 注入代码 **********/
	public Site getSite() {
		return site;
	}

	public void setSite(Site site) {
		this.site = site;
	}

	public List<Site> getSites() {
		return sites;
	}

	public void setSites(List<Site> sites) {
		this.sites = sites;
	}

	public SiteService getSiteService() {
		return siteService;
	}

	@Resource
	public void setSiteService(SiteService siteService) {
		this.siteService = siteService;
	}

	public String getServiceName() {
		return serviceName;
	}

	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}

	public AddressService getAddressService() {
		return addressService;
	}

	@Resource
	public void setAddressService(AddressService addressService) {
		this.addressService = addressService;
		rootAddrs = addressService.findRootAddrs();

	}

	public List<Address> getRootAddrs() {
		return rootAddrs;
	}

	public void setRootAddrs(List<Address> rootAddrs) {
		this.rootAddrs = rootAddrs;

	}

	public List<Address> getCityAddrs() {
		return cityAddrs;
	}

	public void setCityAddrs(List<Address> cityAddrs) {
		this.cityAddrs = cityAddrs;
	}

}
