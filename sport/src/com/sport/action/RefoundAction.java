package com.sport.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import net.sf.json.JSONArray;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.google.gson.JsonArray;

import com.sport.entity.Order;
import com.sport.entity.Refound;
import com.sport.exception.PromptException;
import com.sport.exception.RootException;
import com.sport.exception.ServerErrorException;
import com.sport.service.OrderService;
import com.sport.service.RefoundService;

@Component
@Scope("prototype")
public class RefoundAction extends RootAction{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Refound refound;
	private List<Refound> refounds;
	private RefoundService refoundService;
	private OrderService orderService;
	
	//用户提交退款申请
	public String submitRefound() throws ServerErrorException, PromptException{
		
		try{
			Order order=orderService.load(refound.getOrder());
			refound.setOrder(order)
					.setApplyTime(new Date())
					.setUser(order.getBuyer());
			refoundService.add(refound);	
			order.setOrderStatus(Order.REFOUNDING_ORDER);	
			//释放该订单下的预定信息
			orderService.releaseOrder(order);
			orderService.update(order);
			refound=refoundService.load(refound);
		}catch(RootException e){
			errorMsg=e.toString();
			throw new PromptException(errorMsg);
		}catch(Exception e){
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "refoundDetail";
		
	}
	//管理员确认已经退款
	public void ensureRefounded() throws ServerErrorException{
		this.getResponseAndOut();
		JSONArray json=new JSONArray();
		try{
			refound=refoundService.load(refound);
			refound.setHasRefound(true).setRefoundedTime(new Date());
			refoundService.update(refound);
			orderService.update(orderService.load(refound.getOrder()).setOrderStatus(Order.REFOUNDED_ORDER));			
			json.add(true);
		}catch(RootException e){
			json.add(false);
			json.add(e.toString());
		}catch(Exception e){
			json.add(false);
			json.add(RootException.SYSTEM_ERROR);
			e.printStackTrace();
		}
		out.println(json);
		this.closeOut();
	}
	//管理员删除退款单
		public void deleteRefound() throws ServerErrorException{
			this.getResponseAndOut();
			JSONArray json=new JSONArray();
			try{
				refound=refoundService.load(refound);
				if(orderService.load(refound.getOrder()).getOrderStatus()!=Order.REFOUNDED_ORDER){
					throw new PromptException("你还未退款给用户，请进行退款成功确认后再删除！");
				}
				refoundService.delete(refound);		
				json.add(true);
			}catch(RootException e){
				json.add(false);
				json.add(e.toString());
			}catch(Exception e){
				json.add(false);
				json.add(RootException.SYSTEM_ERROR);
				e.printStackTrace();
			}
			out.println(json);
			this.closeOut();
		}
	//查看退款单
	public String refoundList() throws PromptException, ServerErrorException{
		try{
			refounds=new ArrayList<Refound>();
			if(refound==null)
				refound=new Refound();
			page.setTotalItemNumber(refoundService.findAll(refounds, refound, page.getPageNumber(), page.getPageSize()));
		}catch(Exception e){
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "refoundList";
	}
	
	//查看退款单详情
	public String refoundDetail() throws ServerErrorException, PromptException{
		try{
			refound=refoundService.load(refound);
		}catch(RootException e){
			errorMsg=e.toString();
			throw new PromptException(errorMsg);
		}catch(Exception e){
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "refoundDetail";
	}
	// 批量删除退款单
		public void deleteSelectedRefounds() throws PromptException, ServerErrorException {
			this.getResponseAndOut();
			JSONArray json = new JSONArray();
			System.out.println(this.getIds());
			try {
				if (refoundService.deleteSelectedRefounds(this.getIds())) {
					json.add(true);
					json.add("删除选中退款单成功！");
				} else {
					json.add(false);
					json.add("删除选中退款单失败!");
				}
			} catch (Exception e) {
				json.add(false);
				json.add(RootException.SYSTEM_ERROR);
			}
			out.println(json);
			this.closeOut();

		}
	/* 自动注入代码*/
	public Refound getRefound() {
		return refound;
	}
	public void setRefound(Refound refound) {
		this.refound = refound;
	}
	public List<Refound> getRefounds() {
		return refounds;
	}
	public void setRefounds(List<Refound> refounds) {
		this.refounds = refounds;
	}
	public RefoundService getRefoundService() {
		return refoundService;
	}
	@Resource
	public void setRefoundService(RefoundService refoundService) {
		this.refoundService = refoundService;
	}
	public OrderService getOrderService() {
		return orderService;
	}
	@Resource
	public void setOrderService(OrderService orderService) {
		this.orderService = orderService;
	}
}
