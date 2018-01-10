package com.sport.dao;

import java.text.SimpleDateFormat;
import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Component;

import com.sport.entity.Acount;
import com.sport.entity.Order;
import com.sport.entity.User;

@Component
public class OrderDao extends RootDao{
	SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	public void save(Order order){
		hibernateTemplate.save(order);
	}
	
	public Order load(int id){
		if(id<1)
			return null;
		return (Order)hibernateTemplate.load(Order.class, id);
	}
	
	@SuppressWarnings("unchecked")
	public Order load(String orderNumber){
		List<Order> orders=(List<Order>)hibernateTemplate.getSessionFactory().
		getCurrentSession().
		createCriteria(Order.class).
		add(Restrictions.eq("orderNumber", orderNumber)).list();
		if(orders.isEmpty())
			return null;
		return (Order)orders.get(0);
	}
	
	public Order load(Order order){	
		Order obj=load(order.getOrderNumber());
		if(obj==null)
			obj=load(order.getId());
		return obj;
	}
	
	public void delete(int id){
		if(id<1)
			return ;
		delete(new Order().setId(id));
	}
	
	public void delete(Order order){
		
		hibernateTemplate.delete(order);
				
	}
	
	public void update(Order order){
		hibernateTemplate.update(order);
	}
	//分页查询
	public  int findAll(List<Order> orders,Order order,
			int pageNumber,
			int pageSize,
			String groupByColumn,
			String orderByColumn,
			boolean isAsc){
		
		StringBuffer queryString=new StringBuffer("from Order e where 1=1 ");
		if(order.getOrderStatus()>0){
			queryString.append(" and e.orderStatus="+order.getOrderStatus()+"  ");
		}
		if(order.getCompany()!=null){
			queryString.append(" and e.company.id="+order.getCompany().getId()+"  ");
		}
		if(order.getSite()!=null){
			queryString.append(" and e.site.id="+order.getSite().getId());
		}
		if(order.getCoach()!=null){
			queryString.append(" and e.coach.id="+order.getCoach().getId());
		}
		if(order.getBuyer()!=null){
			queryString.append(" and e.buyer.id="+order.getBuyer().getId());
		}
		if(order.getDtoBeginDate()!=null&&(order.getDtoEndDate()!=null)){//在此时间段的订单
			queryString.append(" and e.payTime>='"+f.format(order.getDtoBeginDate())+"'");
			queryString.append(" and e.payTime<='"+f.format(order.getDtoEndDate())+"'");
		}
		if(order.getOrderNumber()!=null){
			queryString.append(" and e.orderNumber = '"+order.getOrderNumber()+"' ");
		}
		return find(queryString.toString(), orders,pageNumber,pageSize,groupByColumn,orderByColumn,isAsc);
	}
	public int findAll(List<Order> orders,Order order,
			int pageNumber,
			int pageSize
			){
		
		return findAll(orders,order,pageNumber,pageSize,null,null,true);
	}
	//分页查询
		public  int findAllByUser(List<Order> orders,User user,
				int pageNumber,
				int pageSize,
				String groupByColumn,
				String orderByColumn,
				boolean isAsc){
			String queryString="from Order e where e.buyer.id="+user.getId();
			return find(queryString, orders,pageNumber,pageSize,groupByColumn,orderByColumn,isAsc);
		}
		public int findAllByUser(List<Order> orders,User user,
				int pageNumber,
				int pageSize
				){
			
			return findAllByUser(orders,user,pageNumber,pageSize,null,null,true);
		}

		//分页查询
		public  int findAllTimeOutOrders(List<Order> orders,
				int pageNumber,
				int pageSize,
				String groupByColumn,
				String orderByColumn,
				boolean isAsc){
			//将
			StringBuffer queryString=new StringBuffer("from Order e where e.orderStatus="+Order.PAYING_ORDER);
			queryString.append(" or e.orderStatus<"+Order.PAYED_NOT_USE_ORDER)
						.append(" or e.orderStatus="+Order.CONFIRM_OK_ORDER+"  ");
			return find(queryString.toString(), orders,pageNumber,pageSize,groupByColumn,orderByColumn,isAsc);
		}
		//生成账单明细
		public int findAll(List<Order> orders, Acount acount, int pageNumber,
				int pageSize) {
			StringBuffer queryString=new StringBuffer("from Order e where 1=1 and e.orderStatus= "+Order.USEED_ORDER+" ");
			if(acount.getCoach()!=null&&(acount.getCoach().getId()>0)){
				queryString.append(" and e.coach.id="+acount.getCoach().getId()+"  ");
			}
			if(acount.getCompany()!=null&&(acount.getCompany().getId()>0)){
				queryString.append(" and e.company.id="+acount.getCompany().getId()+"  ");
			}
			if(acount.getSite()!=null&&(acount.getSite().getId()>0)){
				queryString.append(" and e.site.id="+acount.getSite().getId()+"  ");
			}
			if(acount.getAcountBeginDate()!=null&&(acount.getAcountEndDate()!=null)){
				queryString.append(" and e.payTime>='"+f.format(acount.getAcountBeginDate())+"'  ");
				queryString.append(" and e.payTime<='"+f.format(acount.getAcountEndDate())+"'  ");
			}
			
			return find(queryString.toString(), orders,pageNumber,pageSize,null,"payTime",true);
		}
}
