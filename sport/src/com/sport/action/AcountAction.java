package com.sport.action;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import net.sf.json.JSONArray;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.sport.dto.AcountItem;
import com.sport.entity.Acount;
import com.sport.entity.Address;
import com.sport.entity.Order;
import com.sport.exception.RootException;
import com.sport.exception.ServerErrorException;
import com.sport.service.AcountService;
import com.sport.service.CoachService;
import com.sport.service.CompanyService;
import com.sport.service.OrderService;

@Component
@Scope("prototype")
public class AcountAction extends RootAction {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Acount acount;
	private List<Acount> acounts;
	private AcountService acountService;
	private Order order;
	private List<AcountItem> items;
	private OrderService orderService;
	private CompanyService companyService;
	private CoachService coachService;
	private List<Address> cityAddrs;//所有市级地区
	/********* 功能代码 **********/
	/**
	 * 删除一个账单
	 * 
	 * @throws ServerErrorException
	 */
	public void deleteAcount() throws ServerErrorException {
		this.getResponseAndOut();
		JSONArray json = new JSONArray();
		try {
			acountService.delete(acount);
			json.add(true);
		} catch (RootException e) {
			json.add(false);
			json.add(e.toString());
		} catch (Exception e) {
			json.add(false);
			json.add(RootException.SYSTEM_ERROR);
		}
		out.println(json);
		this.closeOut();
	}
	/**确认已经给该公司进行了结算,同时将其保存到数据库中
	 * @throws ServerErrorException */
	public void ensureAcount() throws ServerErrorException{
		this.getResponseAndOut();
		JSONArray json = new JSONArray();
		try {			
			acountService.add(acount);		
			json.add(true);
		} catch (RootException e) {
			json.add(false);
			json.add(e.toString());
		} catch (Exception e) {
			e.printStackTrace();
			json.add(false);
			json.add(RootException.SYSTEM_ERROR);
		}
		out.println(json);
		this.closeOut();
	}
	/**删除选中的账单*/
	public void deleteSelectedAcount() throws ServerErrorException {
		this.getResponseAndOut();
		JSONArray json = new JSONArray();
		try {
			acountService.deleteSelectedAcounts(ids);
			json.add(true);
		} catch (Exception e) {
			json.add(false);
			json.add(RootException.SYSTEM_ERROR);
		}
		out.println(json);
		this.closeOut();
	}
	public String acountItemList() throws ServerErrorException {
		try {
			items = new ArrayList<AcountItem>();
			List<Order> orders = new ArrayList<Order>();
			page.setTotalItemNumber(orderService.findAll(orders, acount,
					page.getPageNumber(), page.getPageSize()));
			Acount lastestAcount=acountService.findLastestAcount(acount);
			items = AcountItem.fromOrders(orders,lastestAcount);
			Acount persistAcount=acountService.load(acount);
			if(persistAcount!=null)
				acount=persistAcount;
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "acountItemList";
	}

	/****** 自动注入代码 ******/
	public Acount getAcount() {
		return acount;
	}

	public void setAcount(Acount acount) {
		this.acount = acount;
	}

	public List<Acount> getAcounts() {
		return acounts;
	}

	public void setAcounts(List<Acount> acounts) {
		this.acounts = acounts;
	}

	public AcountService getAcountService() {
		return acountService;
	}

	@Resource
	public void setAcountService(AcountService acountService) {
		this.acountService = acountService;
	}

	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

	public List<AcountItem> getItems() {
		return items;
	}

	public void setItems(List<AcountItem> items) {
		this.items = items;
	}

	public OrderService getOrderService() {
		return orderService;
	}

	@Resource
	public void setOrderService(OrderService orderService) {
		this.orderService = orderService;
	}

	@Override
	public CompanyService getCompanyService() {
		return companyService;
	}

	@Override
	@Resource
	public void setCompanyService(CompanyService companyService) {
		this.companyService = companyService;
	}

	public CoachService getCoachService() {
		return coachService;
	}

	@Resource
	public void setCoachService(CoachService coachService) {
		this.coachService = coachService;
	}

	public List<Address> getCityAddrs() {
		return cityAddrs;
	}

	public void setCityAddrs(List<Address> cityAddrs) {
		this.cityAddrs = cityAddrs;
	}
}
