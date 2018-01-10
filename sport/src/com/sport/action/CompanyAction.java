package com.sport.action;

import java.lang.reflect.*;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.sport.entity.Company;
import com.sport.entity.Image;
import com.sport.entity.Manager;
import com.sport.exception.PromptException;
import com.sport.exception.RootException;
import com.sport.exception.ServerErrorException;
import com.sport.service.CompanyService;
import com.sport.service.ImageService;

@Component
@Scope("prototype")
public class CompanyAction extends RootAction {
	CompanyService companyService;
	ImageService imageService;
	Manager manager;
	Company company;
	List<Company> companys;
	File file;
	String fileContentType;
	String fileFileName;

	/******* 业务逻辑代码 *******/
	public String companyRegister(){
		System.out.println("商家注册！");
		return "companyRegister";
	}
	// 公司注册
	public String addCompany() throws PromptException, ServerErrorException {
		System.out.println("添加公司开始！");
		try {
			// 先保存凭证
			String webDir = "/upload/file/companyInfo";
			String savePath = ServletActionContext.getServletContext()
					.getRealPath(webDir);
			if (file == null || file.length() < 1 || !file.canRead()
					|| !file.exists()) {
				errorMsg = "请选择公司营业执照等证明文件，再进行信息提交注册！";
				throw new PromptException(errorMsg);
			}
			Image image = imageService.saveFile(file, savePath, webDir,
					fileFileName);
			// 再注册公司
			companyService.add(company, manager, image);
		} catch (RootException e) {
			errorMsg = e.toString();
			e.printStackTrace();
			throw new PromptException(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			throw new PromptException("请填写合法的信息，保证您的登录账号与电话号码没有在本系统中重复使用，再重试！");
		}
		errorMsg = "商家注册成功！";
		throw new PromptException(errorMsg);
	}

	// 检测管理员账号是否已经被注册
	public void isExistsUserName() throws PromptException, ServerErrorException {
		this.getResponseAndOut();
		JSONArray json=new JSONArray();
		try {
			System.out.println("管理员的 userName:" + manager.getUserName());
			if (managerService.findManager(manager.getUserName().trim()) != null){
				json.add(true);
				json.add("该用户名已经被注册，请更改用户名！");
			}				
			else{
				json.add(false);
				json.add("该用户名可用!");
			}
		} catch (Exception e) {
			e.printStackTrace();
			json.add(false);
			json.add(RootException.SYSTEM_ERROR);
		}
		out.println(json);
		this.closeOut();
	}

	// 查看某公司详细信息
	public String companyDetail() throws ServerErrorException {
		try {
			if (company == null) {
				Manager m = (Manager) session.get("currentManager");
				m = managerService.findManager(m);
				company = m.getCompany();
			} else {
				company = companyService.load(company);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "companyDetail";
	}

	// 更新某公司基本信息
	//@RequiresPermissions("company:update")
	public String alterCompany() throws PromptException, ServerErrorException {
		try {
			// 如果要修改公司logo
			if (file != null) {
				if (file.canRead() && (file.isFile()) && (file.exists())) {
					String webDir = "/upload/file/companyInfo";
					String savePath = ServletActionContext.getServletContext()
							.getRealPath(webDir);
					fileFileName = "logo" + new Date().getTime() + fileFileName;
					Image image = imageService.saveFile(file, savePath, webDir,
							fileFileName);
					if (image != null)
						company.setLogoImage(image);
				}
			}
			companyService.update(company);
			company = companyService.load(company);
		} catch (RootException e) {
			e.printStackTrace();
			errorMsg = e.toString();
			throw new PromptException(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "companyDetail";
	}

	// 注销某公司信息,异步操作
	// @RequiresPermissions("company:delete")
	public void deleteCompany() throws IOException, ServerErrorException,
			PromptException {
		this.getResponseAndOut();
		JSONArray json=new JSONArray();
		try {
			Manager m = (Manager) session.get("currentManager");
			if (m == null) {
				errorMsg = "您还未登录，或者长时间未操作，请重新登录！";
				json.add(false);				
			}
			String companyName = company.getCompanyName();
			companyService.delete(company);
			json.add(true);
			errorMsg="注销公司：" + companyName + "的所有信息成功！";
		} catch (PromptException e) {
			errorMsg = e.toString();	
			json.add(false);
		} catch (Exception e) {
			e.printStackTrace();
			json.add(false);
			errorMsg=RootException.SYSTEM_ERROR;
		}
		json.add(errorMsg);
		out.println(json);
		this.closeOut();
	}

	// 管理公司的激活状态
	public void activeCompany() throws IOException, PromptException,
			ServerErrorException {
		this.getResponseAndOut();
		JSONArray json=new JSONArray();
		try {
			
			Manager m = (Manager) session.get("currentManager");
			if (m == null) {
				errorMsg = "您还未登录，或者长时间未操作，请重新登录！";
				json.add(false);				
			}
			company = companyService.load(company);
			company.setFlag(!company.isFlag());
			companyService.activeCompany(company);
			json.add(true);
			if (company.isFlag())
				errorMsg="激活公司成功！";
			else
				errorMsg="停止公司运营成功！";			
		}  catch (PromptException e) {
			errorMsg = e.toString();	
			json.add(false);
		} catch (Exception e) {
			e.printStackTrace();
			json.add(false);
			errorMsg=RootException.SYSTEM_ERROR;
		}
		json.add(errorMsg);
		out.println(json);
		this.closeOut();
	}

	// 管理所有加盟公司
	public String companyList() throws ServerErrorException, PromptException {
		
		try {
			companys = new ArrayList<Company>();
			if (company == null) {// 如果未搜索，则显示所有公司信息
				Company currentCompany=this.getCurrentCompany();
				if(!currentCompany.isHost())
					throw new PromptException("对不起，您不是平台拥有者公司的管理员！");
				page.setTotalItemNumber(companyService.findAll(companys,company, page.getPageNumber(),
							page.getPageSize()));
				
			} else {
				company.setCompanyUrl(company.getCompanyName())
						.setEmail(company.getCompanyName())
						.setIntroduction(company.getCompanyName())
						.setPhone(company.getCompanyName());
				
				page.setTotalItemNumber(companyService.findCompanys(
							companys, company, page.getPageNumber(),
							page.getPageSize()));
				
			}
		} catch(RootException e){
			errorMsg=e.toString();
			throw new PromptException(errorMsg);
		}catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "companyList";
	}

	// 批量删除公司信息
	// @RequiresPermissions("company:delete")
	public void deleteCompanys() throws PromptException, ServerErrorException {
		this.getResponseAndOut();
		JSONArray json=new JSONArray();
		try {
			if (companyService.deleteSelectedCompanys(this.getIds())){
				json.add(true);
				json.add("删除选中公司信息成功！");
			}
			else{
				json.add(false);
				json.add("删除选中公司信息失败!");
			}
		} catch (Exception e) {
			e.printStackTrace();
			json.add(false);
			errorMsg=RootException.SYSTEM_ERROR;
		}
		json.add(errorMsg);
		out.println(json);
		this.closeOut();
	}

	@Override
	public void setActionErrors(Collection<String> errorMessages) {
		for (String error : errorMessages) {
			if (error.contains("File extension not allowed")) {
				errorMsg = "您上传的文件类型非法，请核实后再上传！";
				errorMessages.add(errorMsg);
				
			}
			System.out.println(error);
		}
		super.setActionErrors(errorMessages);
	}

	/********* 注入代码 *********/
	public CompanyService getCompanyService() {
		return companyService;
	}

	@Resource
	public void setCompanyService(CompanyService companyService) {
		this.companyService = companyService;
	}

	public Manager getManager() {
		return manager;
	}

	public void setManager(Manager manager) {
		this.manager = manager;
	}

	public Company getCompany() {
		return company;
	}

	public void setCompany(Company company) {
		this.company = company;
	}

	public List<Company> getCompanys() {
		return companys;
	}

	public void setCompanys(List<Company> companys) {
		this.companys = companys;
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
		this.fileFileName = (new Date().getTime())+fileFileName;// 避免同名冲突
	}

	public ImageService getImageService() {
		return imageService;
	}

	@Resource
	public void setImageService(ImageService imageService) {
		this.imageService = imageService;
	}

}
