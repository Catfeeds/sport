package com.sport.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.sport.dao.CoachCostDao;
import com.sport.dao.OrderItemDao;
import com.sport.entity.Coach;
import com.sport.entity.CoachCost;
import com.sport.entity.CoachPreOrder;
import com.sport.entity.CoachProduct;
import com.sport.entity.Company;
import com.sport.entity.OrderItem;
import com.sport.entity.Place;
import com.sport.entity.PlacePreOrder;
import com.sport.exception.PromptException;
import com.sport.exception.RootException;


@Component
public class OrderItemService  extends RootService{
	private static final String ENTITY_NAME="OrderItem";
	private OrderItemDao orderItemDao;
	private CoachPreOrderService coachPreOrderService;
	private PlacePreOrderService placePreOrderService;
	private CoachCostDao coachCostDao;
	public OrderItemDao getOrderItemDao() {
		return orderItemDao;
	}
	@Resource
	public OrderItemService setOrderItemDao(OrderItemDao orderItemDao) {
		this.orderItemDao = orderItemDao;
		return this;
	}
	
	public CoachPreOrderService getCoachPreOrderService() {
		return coachPreOrderService;
	}
	@Resource
	public void setCoachPreOrderService(CoachPreOrderService coachPreOrderService) {
		this.coachPreOrderService = coachPreOrderService;
	}
	public PlacePreOrderService getPlacePreOrderService() {
		return placePreOrderService;
	}
	@Resource
	public void setPlacePreOrderService(PlacePreOrderService placePreOrderService) {
		this.placePreOrderService = placePreOrderService;
	}
	//添加订单时需要对预定信息进行修改
	public CoachCostDao getCoachCostDao() {
		return coachCostDao;
	}
	@Resource
	public void setCoachCostDao(CoachCostDao coachCostDao) {
		this.coachCostDao = coachCostDao;
	}
	public void add(OrderItem item) throws RootException{
		if(item==null)
			throw new PromptException(RootException.NEED_MORE_ADD_INFO);	
		Company company=null;
		if(item.getCoachPreOrder()==null){
			PlacePreOrder  pOrder=placePreOrderService.load(item.getPlacePreOrder());
			pOrder.getPlace().getProduct().setTotalSoldNumber(pOrder.getPlace().getProduct().getTotalSoldNumber()+1);
			item.setPlace(pOrder.getPlace())
				.setProduct(pOrder.getPlace().getProduct())
				.setUseDate(pOrder.getDate());
			company=pOrder.getPlace().getSite().getCompany();
			int[] orderInfos=pOrder.getOrderInfos();
			System.out.println("preOrderId:"+pOrder.getId()+"time:"+item.getTime()+" value:"+orderInfos[item.getTime()]);
			if(orderInfos[item.getTime()]>0)
				orderInfos[item.getTime()]--;
			else{
				throw new PromptException("该场地刚才已经被别人预定了，你无法进行约定！");
			}
			item.setPrice(item.getPlace().getPrices()[item.getTime()])
				.setDiscount(
						Math.abs(item.getPlace().getProduct().getNormalPrice()-
								item.getPlace().getPrices()[item.getTime()]
										));
			pOrder.setOrderInfos(orderInfos);	
			placePreOrderService.update(pOrder);
		}else{
			CoachPreOrder  cOrder=coachPreOrderService.load(item.getCoachPreOrder());
			cOrder.getCoach().setTotalSoldNumber(cOrder.getCoach().getTotalSoldNumber()+1);
			item.setCoach(cOrder.getCoach())
				.setUseDate(cOrder.getDate());
			company=cOrder.getCoach().getCompany();
			int[] orderInfos=cOrder.getOrderInfos();
			if(orderInfos[item.getTime()]>0&&(item.getTime()<3)){
				orderInfos[item.getTime()]--;				
			}else if(item.getTime()==3){
				if(orderInfos[0]<1||(orderInfos[1]<1)||(orderInfos[2]<1)){
					throw new PromptException("亲，该教练太抢手了，改天再约吧！");
				}
				orderInfos[0]--;
				orderInfos[1]--;
				orderInfos[2]--;			
			}
			else{
				throw new PromptException("该教练在此时间段已经有约了，你无法进行预约！");
			}			
			if(item.getProduct()!=null&&(item.getProduct().getId()>0)){//是否是某个指定项目
				CoachCost cost=coachCostDao.load(new CoachCost().setCoach(item.getCoach())
						.setProduct((CoachProduct)item.getProduct()));
				item.setPrice(cost.getPrices()[item.getTime()])
						.setDiscount(
						Math.abs(item.getProduct().getNormalPrice()-
							item.getPrice()
									));
				
			}else{//否则按教练自己的起步价，让教练自行安排
				item.setPrice(cOrder.getCoach().getBaseCostPrices()[item.getTime()])
				.setDiscount(
				Math.abs(cOrder.getCoach().getBasePrice()-
					item.getPrice()
							))
				.setProduct(null);
			}
			cOrder.setOrderInfos(orderInfos);
			coachPreOrderService.update(cOrder);
		}
		orderItemDao.save(item);
		orderItemDao.flush();
		//更新订单状态
		if(item.getCoach()!=null){
			item.getOrder().setCoach(item.getCoach());
		}else if(item.getPlace()!=null){
			if(item.getPlace().getSite()!=null){
				item.getOrder().setSite(item.getPlace().getSite());
			}
		}
		if(item.getOrder().getPreOrderTime()!=null){
		long oldUseDate=item.getOrder().getPreOrderTime().getTime();
		long newUseDate=item.getUseDate().getTime();
		if(newUseDate>oldUseDate)//当所有的订单项生命周期结束时，订单才能标记为使用结束
			item.getOrder().setPreOrderTime(item.getUseDate());
		}else{
			item.getOrder().setPreOrderTime(item.getUseDate());
		}
		
		item.getOrder().setTotalAcount(item.getOrder().getTotalAcount()+item.getPrice())
			.setCompany(company).setCoach(item.getCoach());
			
		orderItemDao.update(item);
	}
	
	public void delete(OrderItem item) throws RootException{		
		if(item==null||(item.getId()<=0))
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);	
		item=orderItemDao.load(item);
		float price=0;
		if(item.getCoachPreOrder()==null){
			PlacePreOrder  pOrder=item.getPlacePreOrder();	
			pOrder.getPlace().getProduct().setTotalSoldNumber(pOrder.getPlace().getProduct().getTotalSoldNumber()-1);
			int[] orderInfos=pOrder.getOrderInfos();
			orderInfos[item.getTime()]++;
			pOrder.setOrderInfos(orderInfos);	
			placePreOrderService.update(pOrder);
		}else{
			CoachPreOrder  cOrder=item.getCoachPreOrder();
			cOrder.getCoach().setTotalSoldNumber(cOrder.getCoach().getTotalSoldNumber()-1);
			item.setCoach(cOrder.getCoach());
			int[] orderInfos=cOrder.getOrderInfos();
			if(item.getTime()==3){
				orderInfos[0]++;
				orderInfos[1]++;
				orderInfos[2]++;
			}else
				orderInfos[item.getTime()]++;
			cOrder.setOrderInfos(orderInfos);
			coachPreOrderService.update(cOrder);
		}
		 item.getOrder().setTotalAcount(item.getOrder().getTotalAcount()-item.getPrice());
		 orderItemDao.delete(item);
		
	}
	public void delete(int id) throws RootException{		
		if(id<=0)
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);	
		 delete(new OrderItem().setId(id));
	}
	public void update(OrderItem item) throws RootException{
		if(item==null||(item.getId()<=0))
			throw new RootException(RootException.NEED_MORE_UPDATE_INFO);	
		orderItemDao.update(item);
	}
	
	public OrderItem load(OrderItem item) throws RootException{
		if(item==null||(item.getId()<=0))
			throw new RootException(RootException.NEED_MORE_FIND_INFO);	
		return orderItemDao.load(item);			
	}
	public OrderItem load(int id) throws RootException{
		if(id<=0)
			throw new RootException(RootException.NEED_MORE_FIND_INFO);	
		return orderItemDao.load(id);			
	}
	//查看所有订单项记录
	public  int findAll(List<OrderItem> items,
			int pageNumber,
			int pageSize
			){
		return orderItemDao.findAll( items,pageNumber,pageSize);
	}
	//按某列排序查看订单项信息
	public  int findAll(List<OrderItem> items,
			int pageNumber,
			int pageSize,
			String orderByColumn,
			boolean isAsc){
		return orderItemDao.findAll( items,pageNumber,pageSize,null,orderByColumn,isAsc);
	}
	//查看某教练的所有订单项记录
		public  int findAllByCoach(List<OrderItem> items,Coach coach,
				int pageNumber,
				int pageSize
				){
			return orderItemDao.findAllByCoach( items,coach,pageNumber,pageSize);
		}
		//按某教练排序查看订单项信息
		public  int findAllByCoach(List<OrderItem> items,Coach coach,
				int pageNumber,
				int pageSize,
				String orderByColumn,
				boolean isAsc){
			return orderItemDao.findAllByCoach( items,coach,pageNumber,pageSize,null,orderByColumn,isAsc);
		}
		//查看某场地的所有订单项记录
		public  int findAllByPlace(List<OrderItem> items,Place place,
				int pageNumber,
				int pageSize
				){
			return orderItemDao.findAllByPlace( items,place,pageNumber,pageSize);
		}
		//查看某场地的所有订单项记录
		public  int findAllByPlace(List<OrderItem> items,Place place,
				int pageNumber,
				int pageSize,
				String orderByColumn,
				boolean isAsc){
			return orderItemDao.findAllByPlace( items,place,pageNumber,pageSize,null,orderByColumn,isAsc);
		}
		//查看某公司拥有的订单项
		public int findAllByCompany(List<OrderItem> items, Company company,
				int pageNumber, int pageSize) {
			return orderItemDao.findAllByCompany( items,company,pageNumber,pageSize);
		}
		
}
