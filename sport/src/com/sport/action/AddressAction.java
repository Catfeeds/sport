package com.sport.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import net.sf.json.JSONArray;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.sport.dto.AddressInfo;
import com.sport.entity.Address;
import com.sport.exception.PromptException;
import com.sport.exception.RootException;
import com.sport.exception.ServerErrorException;
import com.sport.service.AddressService;

@Component
@Scope("prototype")
public class AddressAction extends RootAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private AddressService addressService;
	private Address address;// 需要添加或修改的地区
	private Address parentAddress;// 父地区
	private List<Address> addrs;
	private List<Address> rootAddrs;
	//获取需要修改的原始地区信息
	public String alterAddress() throws RootException, Exception {
		address = addressService.load(address);
		return "alterAddress";
	}

	// 添加地区
	//@RequiresPermissions("address:add")
	public void addAddress() throws RootException, IOException {
		this.getResponseAndOut();
		JSONArray json=new JSONArray();
		try {
			// 先将父子结点之间的关系关联上
			if (parentAddress == null || (parentAddress.getId() == -1))
				addressService.initRelation(null, address);
			else {
				addressService.initRelation(parentAddress, address);
			}
			// 再保存结点信息
			addressService.add(address);
			json.add(true);
			json.add("添加地区信息成功（地区名：" + address.getAddressName() + "）");		
		} catch (Exception e) {
			e.printStackTrace();
			json.add(false);
			json.add("添加地区信息失败，请重试！");						
		}finally{
			out.println(json);
			this.closeOut();
		}		
	}

	// 删除地区,异步
	//@RequiresPermissions("address:delete")
	public void deleteAddress() throws RootException {
		this.getResponseAndOut();
		JSONArray json=new JSONArray();
		try {
			addressService.delete(address);
			errorMsg = "删除地区成功！";
			json.add(true);			
		} catch (Exception e) {
			json.add(false);
			errorMsg = "删除地区失败!";
			e.printStackTrace();
		}
		json.add(errorMsg);
		out.println(json);		
		this.closeOut();
	}

	// 修改地区
	//@RequiresPermissions("address:update")
	public String updateAddress() throws RootException {
		try {
			addressService.update(address);
		} catch (Exception e) {
			errorMsg = "更新地区失败!";
			e.printStackTrace();
			throw new RootException(errorMsg);
		}
		errorMsg = "更新地区成功！";
		return "prompt";
	}

	// 获取某地区的子地区同步分页获取
	public String addressList() throws RootException, Exception {
		addrs = new ArrayList<Address>();
		if (address == null || (address.getId() == -1)
				|| (address.getId() == 0)) {
			address = new Address();
			address.setId(-1);
			address.setAddressName("根地区");
			page.setTotalItemNumber(addressService.findRootAddrs(addrs,
					page.getPageNumber(), page.getPageSize()));
		} else {
			if (page.getPageNumber() != 0)
				page.setTotalItemNumber(addressService.findByAddress(addrs,
						address, page.getPageNumber(), page.getPageSize()));
			else
				page.setTotalItemNumber(addressService.findByAddress(addrs,
						address, 1, page.getPageSize()));
			address = addressService.load(address);
		}
		session.put("addrs", addrs);
		return "addressList";
	}

	// 获取某地区的子地区异步获取
	public void getChildAddrs() throws RootException, Exception {
		this.getResponseAndOut();
		try {
			addrs = new ArrayList<Address>();
			if (address == null || (address.getId() == -1)) {
				addrs = addressService.findRootAddrs();
				System.out.println("获取根地区成功！");
			} else {
				addrs = addressService.findChildAddress(address);
				System.out.println("获取子地区成功！");
			}

			System.out.println(addrs.size());
			try {
				List<AddressInfo> addrInfos=AddressInfo.fromAddresss(addrs);
				JSONArray json = JSONArray.fromObject(addrInfos);
				out.println(json);				
				System.out.println(json);
			} catch (Exception e) {
				e.printStackTrace();
				JSONArray json = new JSONArray();
				json.add("获取信息失败，请稍后重试！");
				out.println(json);
			}
		} catch (Exception e1) {
			e1.printStackTrace();
			JSONArray json = new JSONArray();
			json.add("获取信息失败，请稍后重试！");
			out.println(json);
		}
		this.closeOut();
	}

	// 批量删除地区
	//@RequiresPermissions("address:delete")
	public void deleteAddrs() throws PromptException, ServerErrorException {
		this.getResponseAndOut();
		JSONArray json=new JSONArray();
		try {
			if (addressService.deleteSelectedAddrs(this.getIds()))
			{
				json.add(true);
				json.add("删除选中地区成功！");
			}
			else{
				json.add(false);
				json.add("删除选中地区失败!");
			}
		} catch (Exception e) {
			e.printStackTrace();
			json.add(false);
			json.add(RootException.SYSTEM_ERROR);
		}
		out.println(json);
		this.closeOut();
	}
	/**********注入代码*********/
	public List<Address> getAddrs() {
		return addrs;
	}
	
	public void setAddrs(List<Address> addrs) {
		this.addrs = addrs;
	}

	public List<Address> getRootAddrs() {
		return rootAddrs;
	}

	public void setRootAddrs(List<Address> rootAddrs) {
		this.rootAddrs = rootAddrs;
	}

	public Address getAddress() {
		return address;
	}

	public void setAddress(Address address) {
		this.address = address;
	}

	public Address getParentAddress() {
		return parentAddress;
	}

	public void setParentAddress(Address parentAddress) {
		this.parentAddress = parentAddress;
	}

	@Resource
	public void setAddressService(AddressService addressService) {
		this.addressService = addressService;
		rootAddrs = addressService.findRootAddrs();
	}

	public AddressService getAddressService() {
		return addressService;
	}

}
