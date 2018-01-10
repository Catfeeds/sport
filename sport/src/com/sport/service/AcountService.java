package com.sport.service;

import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.jdom.DataConversionException;
import org.springframework.stereotype.Component;

import com.sport.dao.AcountDao;
import com.sport.dao.CoachDao;
import com.sport.dao.CompanyDao;
import com.sport.dao.OrderDao;
import com.sport.dao.SiteDao;
import com.sport.dto.Page;
import com.sport.entity.Acount;
import com.sport.entity.Coach;
import com.sport.entity.Company;
import com.sport.entity.Order;
import com.sport.entity.Site;
import com.sport.exception.PromptException;
import com.sport.exception.RootException;


@Component
public class AcountService  extends RootService{
	private static final String ENTITY_NAME="Acount";
	private AcountDao acountDao;
	private OrderDao orderDao;
	private CoachDao coachDao;
	private SiteDao siteDao;
	private CompanyDao companyDao;
	public AcountDao getAcountDao() {
		return acountDao;
	}
	@Resource
	public AcountService setAcountDao(AcountDao acountDao) {
		this.acountDao = acountDao;
		return this;
	}
	public OrderDao getOrderDao() {
		return orderDao;
	}
	@Resource
	public void setOrderDao(OrderDao orderDao) {
		this.orderDao = orderDao;
	}
	public CoachDao getCoachDao() {
		return coachDao;
	}
	@Resource
	public void setCoachDao(CoachDao coachDao) {
		this.coachDao = coachDao;
	}
	public SiteDao getSiteDao() {
		return siteDao;
	}
	@Resource
	public void setSiteDao(SiteDao siteDao) {
		this.siteDao = siteDao;
	}
	public CompanyDao getCompanyDao() {
		return companyDao;
	}
	@Resource
	public void setCompanyDao(CompanyDao companyDao) {
		this.companyDao = companyDao;
	}
	public void add(Acount acount) throws RootException{
		if(acount==null)
			throw new RootException(RootException.NEED_MORE_ADD_INFO);	
		acount.setPayedTotalFee(acount.getPayedTotalFee()+acount.getTotalFee()).setTotalFee(0);//将需要结算的总金额设置到已经结算的金额里
		acount.setPayedDate(new Date()).setStatus(Acount.PAYED);
		acountDao.save(acount);
	}
	
	public void delete(Acount acount) throws RootException{
		
		if(acount==null||(acount.getId()<=0))
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);	
		 acountDao.delete(acount);
	}
	public void delete(int id) throws RootException{		
		if(id<=0)
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);	
		 acountDao.delete(id);
	}
	public void update(Acount acount) throws RootException{
		if(acount==null||(acount.getId()<=0))
			throw new RootException(RootException.NEED_MORE_UPDATE_INFO);	
		acountDao.update(acount);
	}
	
	public Acount load(Acount acount) throws RootException{
		if(acount==null)
			throw new RootException(RootException.NEED_MORE_FIND_INFO);	
		return acountDao.load(acount);			
	}
	public Acount load(int id) throws RootException{
		if(id<=0)
			throw new RootException(RootException.NEED_MORE_FIND_INFO);	
		return acountDao.load(id);			
	}
	public boolean deleteSelectedAcounts(String ids){
		boolean re=false;
		re=acountDao.deleteEntitys(ENTITY_NAME, ids);
		return re;
	}

	public  int findAll(List<Acount> acounts,Acount acount,
			int pageNumber,
			int pageSize
			) throws PromptException{
		
		return findAll( acounts,acount,pageNumber,pageSize,null,true);
	}
	public  int findAll(List<Acount> acounts,Acount acount,
			int pageNumber,
			int pageSize,
			String orderByColumn,
			boolean isAsc) throws PromptException{
		int itemTotalNumber=0;
		Page page=new Page().setPageSize(pageSize).setPageNumber(pageNumber);
		if(acount.getCoach()!=null){
			if(acount.getCoach().getId()>0)
				acount.setCoach(coachDao.load(acount.getCoach()));
		}
		if(acount.getCompany()!=null){
			if(acount.getCompany().getId()>0)
				acount.setCompany(companyDao.load(acount.getCompany()));
		}
		if(acount.getSite()!=null){
			if(acount.getSite().getId()>0)
				acount.setSite(siteDao.load(acount.getSite()));
		}
		if(acount!=null){
			if(acount.getAcountType()==Acount.TYPE_COACH){
					List<Coach> cs=new ArrayList<Coach>();
					itemTotalNumber=coachDao.findAll(cs,acount.getCoach(),page.getPageNumber(),page.getPageSize());
					for(Coach coach:cs){
						List<Order> orders=new ArrayList<Order>();
						Order order=new Order().setCoach(coach).setDtoBeginDate(acount.getAcountBeginDate())
												.setDtoEndDate(acount.getAcountEndDate())
												.setOrderStatus(Order.USEED_ORDER);
						Acount tempAcount=new Acount().setCoach(coach)
								.setBeginDate(acount.getAcountBeginDate())
								.setEndDate(acount.getAcountEndDate())
								.setAcountType(Acount.TYPE_COACH);
						Acount parentAcount=acountDao.findLastAcount(tempAcount);
						if(parentAcount!=null)
							if(parentAcount.getEndDate().getTime()>tempAcount.getEndDate().getTime())
								tempAcount.setStatus(Acount.PAYED);//如果在最近结算时间以前的查询，则置为已结算状态
						tempAcount.setLatestAcount(parentAcount);//允许结算时间交叉，但是已经结算过的订单，不会继续进行结算
						float totalAcount=0;
						float payedTotalAcount=0;
						Page orderPage=new Page().setPageSize(50);
						orderPage.setTotalItemNumber(orderDao.findAll(orders, order, orderPage.getPageNumber(), orderPage.getPageSize()));
						for(int j=1;j<=orderPage.getTotalPageNumber();j++){
							List<Order> os=new ArrayList<Order>();
							orderDao.findAll(os, order, j, orderPage.getPageSize());
							for(Order tempOrder:os){
								//如果该时间段有订单需要结算，则需要计算出可结算金额和已结算金额
								if(parentAcount!=null){
									if(parentAcount.getEndDate().getTime()<tempOrder.getPayTime().getTime())
										totalAcount+=tempOrder.getTotalAcount();//未结算过的订单
									else
										payedTotalAcount+=tempOrder.getTotalAcount();//已结算过的订单
								}else{
									totalAcount+=tempOrder.getTotalAcount();
								}
							}
						}						
						tempAcount.setTotalFee(totalAcount).setPayedTotalFee(payedTotalAcount);
						if(totalAcount<=0)
							tempAcount.setStatus(Acount.NO_FEE_NEED_PAY);
						if(tempAcount.getBeginDate()!=null&&(tempAcount.getEndDate()!=null)){
							Acount presistAcount=acountDao.load(tempAcount);
							if(presistAcount!=null)
								acounts.add(presistAcount);
							else
								acounts.add(tempAcount);
						}else{
							acounts.add(tempAcount);
						}													
					}
				
			}else if(acount.getAcountType()==Acount.TYPE_SITE){
								
					List<Site> ss=new ArrayList<Site>();
					itemTotalNumber=siteDao.findAll(ss,acount.getSite(),page.getPageNumber(),page.getPageSize());
					for(Site site:ss){
						List<Order> orders=new ArrayList<Order>();
						Order order=new Order().setSite(site).setDtoBeginDate(acount.getAcountBeginDate())
												.setDtoEndDate(acount.getAcountEndDate())
												.setOrderStatus(Order.USEED_ORDER);
						Acount tempAcount=new Acount().setSite(site)
								.setBeginDate(acount.getAcountBeginDate())
								.setEndDate(acount.getAcountEndDate())
								.setAcountType(Acount.TYPE_SITE);
						Acount parentAcount=acountDao.findLastAcount(tempAcount);
						if(parentAcount!=null)
							if(parentAcount.getEndDate().getTime()>tempAcount.getEndDate().getTime())
								tempAcount.setStatus(Acount.PAYED);//如果在最近结算时间以前的查询，则置为已结算状态
						tempAcount.setLatestAcount(parentAcount);//允许结算时间交叉，但是已经结算过的订单，不会继续进行结算
						float totalAcount=0;
						float payedTotalAcount=0;
						Page orderPage=new Page().setPageSize(50);
						orderPage.setTotalItemNumber(orderDao.findAll(orders, order, orderPage.getPageNumber(), orderPage.getPageSize()));
						for(int j=1;j<=orderPage.getTotalPageNumber();j++){
							List<Order> os=new ArrayList<Order>();
							orderDao.findAll(os, order, j, orderPage.getPageSize());
							for(Order tempOrder:os){
								//如果该时间段有订单需要结算，则需要计算出可结算金额和已结算金额
								if(parentAcount!=null){
									if(parentAcount.getEndDate().getTime()<tempOrder.getPayTime().getTime())
										totalAcount+=tempOrder.getTotalAcount();//未结算过的订单
									else
										payedTotalAcount+=tempOrder.getTotalAcount();//已结算过的订单
								}else{
									totalAcount+=tempOrder.getTotalAcount();
								}
							}
						}						
						tempAcount.setTotalFee(totalAcount).setPayedTotalFee(payedTotalAcount);
						if(totalAcount<=0)
							tempAcount.setStatus(Acount.NO_FEE_NEED_PAY);
						if(tempAcount.getBeginDate()!=null&&(tempAcount.getEndDate()!=null)){
							Acount presistAcount=acountDao.load(tempAcount);
							if(presistAcount!=null)
								acounts.add(presistAcount);
							else
								acounts.add(tempAcount);
						}else{
							acounts.add(tempAcount);
						}															
					}
				
			}else if(acount.getAcountType()==Acount.TYPE_COMPANY){
				
					List<Company> cs=new ArrayList<Company>();
					itemTotalNumber=companyDao.findAll(cs,acount.getCompany(),page.getPageNumber(),page.getPageSize());
					for(Company company:cs){
						List<Order> orders=new ArrayList<Order>();
						Order order=new Order().setCompany(company).setDtoBeginDate(acount.getAcountBeginDate())
												.setDtoEndDate(acount.getAcountEndDate())
												.setOrderStatus(Order.USEED_ORDER);
						Acount tempAcount=new Acount().setCompany(company)
								.setBeginDate(acount.getAcountBeginDate())
								.setEndDate(acount.getAcountEndDate())
								.setAcountType(Acount.TYPE_COMPANY);
						Acount parentAcount=acountDao.findLastAcount(tempAcount);
						if(parentAcount!=null)
							if(parentAcount.getEndDate().getTime()>tempAcount.getEndDate().getTime())
								tempAcount.setStatus(Acount.PAYED);//如果在最近结算时间以前的查询，则置为已结算状态
						tempAcount.setLatestAcount(parentAcount);//允许结算时间交叉，但是已经结算过的订单，不会继续进行结算
						float totalAcount=0;
						float payedTotalAcount=0;
						Page orderPage=new Page().setPageSize(50);
						orderPage.setTotalItemNumber(orderDao.findAll(orders, order, orderPage.getPageNumber(), orderPage.getPageSize()));
						for(int j=1;j<=orderPage.getTotalPageNumber();j++){
							List<Order> os=new ArrayList<Order>();
							orderDao.findAll(os, order, j, orderPage.getPageSize());
							for(Order tempOrder:os){
								//如果该时间段有订单需要结算，则需要计算出可结算金额和已结算金额
								if(parentAcount!=null){
									if(parentAcount.getEndDate().getTime()<tempOrder.getPayTime().getTime())
										totalAcount+=tempOrder.getTotalAcount();//未结算过的订单
									else
										payedTotalAcount+=tempOrder.getTotalAcount();//已结算过的订单
								}else{
									totalAcount+=tempOrder.getTotalAcount();
								}
							}
						}					
						if(totalAcount<=0)
							tempAcount.setStatus(Acount.NO_FEE_NEED_PAY);
						tempAcount.setTotalFee(totalAcount).setPayedTotalFee(payedTotalAcount);
						if(tempAcount.getBeginDate()!=null&&(tempAcount.getEndDate()!=null)){
							Acount presistAcount=acountDao.load(tempAcount);
							if(presistAcount!=null)
								acounts.add(presistAcount);
							else
								acounts.add(tempAcount);
						}else{
							acounts.add(tempAcount);
						}																			
					}
				}
			
		}
		return itemTotalNumber;
		//return acountDao.findAll( acounts,acount,pageNumber,pageSize,null,orderByColumn,isAsc);
	}
	public Acount findLastestAcount(Acount acount) {
		return acountDao.findLastAcount(acount);
	}
}
