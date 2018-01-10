package com.sport.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ApplicationAware;
import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.interceptor.SessionAware;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.opensymphony.xwork2.ActionSupport;

import com.sport.dto.Page;
import com.sport.entity.Address;
import com.sport.entity.Coach;
import com.sport.entity.Company;
import com.sport.entity.Manager;
import com.sport.entity.Person;
import com.sport.entity.User;
import com.sport.exception.PromptException;
import com.sport.exception.ServerErrorException;
import com.sport.service.AddressService;
import com.sport.service.CompanyService;
import com.sport.service.ManagerService;
import com.sport.service.UserService;

@Component
@Scope("prototype")
public class RootAction extends ActionSupport implements RequestAware,
		SessionAware, ApplicationAware {

	/**
	 * 
	 */
	protected static final long serialVersionUID = 1L;
	protected static final String ERROR = "error";
	protected String ids;
	protected String error;
	protected String errorMsg;// 在prompt.jsp页面将要显示的提示信息
	protected String alterFlag;// 修改实体改字段名称
	protected Page page;
	// 获取地址信息
	protected List<Address> rootAddrs;
	protected AddressService addressService;
	protected Map<String, Object> request, application, session;
	protected ManagerService managerService;
	protected CompanyService companyService;
	protected HttpServletResponse response;
	protected PrintWriter out;

	public ManagerService getManagerService() {
		return managerService;
	}

	@Resource
	public void setManagerService(ManagerService managerService) {
		this.managerService = managerService;
	}

	public String error() {
		return "error";
	}

	public String getErrorMsg() {
		return errorMsg;
	}

	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}

	public void setApplication(Map<String, Object> application) {
		// TODO Auto-generated method stub
		this.application = application;
	}

	public void setSession(Map<String, Object> session) {
		// TODO Auto-generated method stub
		this.session = session;
		
	}

	public void setRequest(Map<String, Object> request) {
		// TODO Auto-generated method stub
		this.request = request;
	}

	public Page getPage() {
		return page;
	}

	@Resource
	public void setPage(Page page) {
		this.page = page;
	}

	public String getError() {
		return error;
	}

	public void setError(String error) {
		this.error = error;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public CompanyService getCompanyService() {
		return companyService;
	}

	@Resource
	public void setCompanyService(CompanyService companyService) {
		this.companyService = companyService;
	}

	public HttpServletResponse getResponse() {
		return response;
	}

	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}

	public PrintWriter getOut() {
		return out;
	}

	public void setOut(PrintWriter out) {
		this.out = out;
	}

	public String getAlterFlag() {
		return alterFlag;
	}

	public void setAlterFlag(String alterFlag) {
		this.alterFlag = alterFlag;
	}

	public AddressService getAddressService() {
		return addressService;
	}

	@Resource
	public void setAddressService(AddressService addressService) {
		this.addressService = addressService;
		rootAddrs = addressService.findRootAddrs();
		// System.out.println("rootAction rootAddrs"+rootAddrs);
	}

	public List<Address> getRootAddrs() {
		return rootAddrs;
	}

	public void setRootAddrs(List<Address> rootAddrs) {
		this.rootAddrs = rootAddrs;

	}

	// 获取到输出流,如果flag=true 则为同步，否则为异步
	protected void getResponseAndOut(boolean flag) throws ServerErrorException {
		
		try {
			response = ServletActionContext.getResponse();
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
		} catch (Exception e) {
			e.printStackTrace();
			if (flag)
				throw new ServerErrorException();
			else {
				JSONArray json = new JSONArray();
				json.add(false);
				json.add(PromptException.SYSTEM_ERROR);
				closeOut();
			}
		}

	}

	// 默认为异步请求
	protected void getResponseAndOut() throws ServerErrorException {
		getResponseAndOut(false);
	}

	// 关闭输出流，向浏览器端回显信息
	protected void closeOut() {
		if (out != null) {
			out.flush();
			out.close();
		}
	}

	// 获取当前用户登录信息
	protected User getCurrentUser() throws PromptException {
		User m = (User) session.get("currentUser");
		if (m == null)
			throw new PromptException("您还未登录，请登陆后再操作!");
		return m;
	}

	// 获取当前管理员登录信息
	protected Manager getCurrentManager() throws PromptException {
		Manager m = (Manager) session.get("currentManager");
		if (m == null)
			throw new PromptException("您还未登录，请登陆后再操作!");
		return m;
	}

	// 获取当前管理员登录账号的公司信息
	protected Company getCurrentCompany() throws PromptException {
		Manager m = getCurrentManager();
		m = managerService.findManager(m);
		return m.getCompany();
	}
	//获取当前登录的教练信息
	protected Coach getCurrentCoach(){
		Coach coach=(Coach)session.get("currentCoach");
		return coach;
	}
	//检测是否有用户、管理员或者教练在线
	protected Person getCurrentPerson() throws PromptException{
		Person person=(Person)session.get("currentPerson");
		if(person==null)
			person=(Person)session.get("currentUser");
		if(person==null)
			person=(Person)session.get("currentManager");
		if(person==null)
			person=(Person)session.get("currentCoach");
		if(person==null)
			throw new PromptException("您还未登录，请登陆后再操作!");
		return person;
	}
}
