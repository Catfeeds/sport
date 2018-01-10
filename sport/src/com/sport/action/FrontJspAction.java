package com.sport.action;


import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;

import net.sf.json.JSONArray;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;


import com.sport.dto.AvgComment;
import com.sport.dto.CoachPreOrderInfo;
import com.sport.dto.ComplexSearchCondition;
import com.sport.dto.Page;
import com.sport.dto.SitePlacesOrderInfo;
import com.sport.entity.Address;
import com.sport.entity.Coach;
import com.sport.entity.CoachProduct;
import com.sport.entity.Comment;
import com.sport.entity.Company;
import com.sport.entity.Discount;
import com.sport.entity.Order;
import com.sport.entity.Place;
import com.sport.entity.PlaceProduct;
import com.sport.entity.Product;
import com.sport.entity.ProductType;
import com.sport.entity.Site;
import com.sport.exception.PromptException;
import com.sport.exception.RootException;
import com.sport.exception.ServerErrorException;
import com.sport.service.AddressService;
import com.sport.service.CoachCostService;
import com.sport.service.CoachPreOrderService;
import com.sport.service.CoachProductService;
import com.sport.service.CoachService;
import com.sport.service.CommentService;
import com.sport.service.CompanyService;
import com.sport.service.DiscountService;
import com.sport.service.OrderService;
import com.sport.service.PlacePreOrderService;
import com.sport.service.PlaceProductService;
import com.sport.service.PlaceService;
import com.sport.service.ProductTypeService;
import com.sport.timer.TimerTaskQueue;

@Component
@Scope("prototype")
public class FrontJspAction extends RootAction {
	public static final String[] WEEKS={"周日","周一","周二","周三","周四","周五","周六"};
	private List<Date> dates;//今天的日期
	private int[] weekIndexArr;//根据dates参数换算过来的星期索引数组
	private List<String> weeks;//存放星期几
	private List<ProductType> types;// 跟类别，用来按分类检索产品
	private ProductTypeService productTypeService;
	private Address addr;//地址
	private List<Address> cityAddrs;//所有市级地区
	private List<Address> addrs;//当前选中城市管辖内的所有地区
	private AddressService addressService;
	private Place place;
	private List<Place> places;
	private List<Coach> coachs;//教练
	private PlaceService placeService;
	private CoachService coachService;
	private PlaceProduct placeProduct;
	private CoachProduct coachProduct;
	private List<PlaceProduct> placeProducts;
	private List<CoachProduct> coachProducts;
	private PlaceProductService placeProductService;
	private CoachProductService coachProductService;
	private PlacePreOrderService placePreOrderService;
	private CoachPreOrderService coachPreOrderService;
	private CompanyService companyService;
	private List<Company> companys;
	//用于搜索的条件
	private ComplexSearchCondition condition;
	//用于获取并管理某场馆的预订信息
	private Site site;
	private List<SitePlacesOrderInfo> sitePreOrderInfos;//某场馆的某类场地7天的预订信息
	//用于获取教练预定信息
	private Coach coach;
	private List<CoachPreOrderInfo> coachPreOrderInfos;//某教练最近7天的预定信息
	private CoachCostService coachCostService;
	//商品评论信息查看
	private List<Comment> comments;
	private CommentService commentService;
	private AvgComment avgComment;
	//查看当前订单状态
	private Order currentOrder;
	private OrderService orderService;
	//优惠信息显示
	private List<Discount> discounts;
	private DiscountService discountService;
	//设置当前选择的城市
	public void setCurrentCity() throws ServerErrorException{
		this.getResponseAndOut();
		try {
			addr=addressService.load(addr);
		} catch (RootException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		session.put("currentAddr", addr);
		this.closeOut();
		
	}
	public String header(){
		return "header";
	}
	
	public String index() throws ServerErrorException {		
		return "index";
	}

	public String login() {
		return "login";
	}

	public String register() {
		return "register";
	}
	public String companyRegister(){
		return "companyRegister";
	}
	public String simpleSearch() throws PromptException, ServerErrorException{
		if(condition.getSearchType().equals("place")){
			choosePlace();
			return "choosePlace";
		}else{
			chooseCoach();
			return "chooseCoach";
		}
	}
	public String choosePlace() throws PromptException, ServerErrorException{
		try{
			//优惠信息
			discounts=new ArrayList<Discount>();
			discountService.findAll(discounts, new Discount().setType(Discount.TYPE_SITE), page.getPageNumber(),6);
			//结束
			ComplexSearchCondition oldCondition=(ComplexSearchCondition)session.get("currentCondition");
			addr=(Address)session.get("currentAddr");
			if(addr==null)
				addrs=addressService.findChildAddress(cityAddrs.get(0));
			else{
				addrs=addressService.findChildAddress(addr);
			}
			types=productTypeService.findTypes();
			
			if(condition==null){//如果没有传递任何搜索条件，则默认按第一个类型搜索
				condition=(ComplexSearchCondition)session.get("currentCondition");
				if(condition==null){//如果还从未搜索过，就默认按第一种项目展示场地详情
					condition=new ComplexSearchCondition();
					condition.setType(types.get(0));
				}	
				oldCondition=condition;
			}else{//设置新的搜索条件
				
				if(condition.getSearchFlag()!=null){
					if(condition.getSearchFlag().trim().equals(ComplexSearchCondition.COMPLEX_SEARCH)){
						condition.setSimpleFlag(false);
					}else{
						condition.setSimpleFlag(true);
					}
					//确保oldCondition有值
					if(oldCondition==null||(oldCondition.isSimpleFlag()!=condition.isSimpleFlag())){//如果简单搜索与复杂搜索切换
						oldCondition=new ComplexSearchCondition().setSimpleFlag(condition.isSimpleFlag());
					}
				}
				if(condition.getAddress()!=null){
					if(condition.getAddress().getId()==0){//是否是清除地址选择
						oldCondition.setAddress(null);
					}else{
						oldCondition.setAddress(condition.getAddress());
					}
				}
				if(condition.getProduct()!=null){
					oldCondition.setProduct(condition.getProduct());
				}
				if(condition.getType()!=null){
					oldCondition.setType(condition.getType());
				}
				if(oldCondition.isSimpleFlag()){//如果是简单搜索
					oldCondition.setAddress(new Address().setAddressName(condition.getSimpleKeyWord()))
						.setType(new ProductType().setTypeName(condition.getSimpleKeyWord()))
						.setProduct(new PlaceProduct().setProductName(condition.getSimpleKeyWord()));
				}
			}
			//将本次的搜索条件放入session中
			session.put("currentCondition", oldCondition);
			if(addr!=null)
				oldCondition.setCityAddress(addr);
			if(page==null)
				page=new Page();
			placeProducts=new ArrayList<PlaceProduct>();
			if(oldCondition.isSimpleFlag()){
				page.setTotalItemNumber(placeProductService.simpleSearchedPlaceProducts(oldCondition, placeProducts, page.getPageNumber(), page.getPageSize()));
			}else{
				page.setTotalItemNumber(placeProductService.searchedPlaceProducts(oldCondition, placeProducts, page.getPageNumber(), page.getPageSize()));
			}
		}catch(RootException e){
			errorMsg=e.toString();
			throw new PromptException(errorMsg);
		}catch(Exception e){
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "choosePlace";
	}
	public String chooseCoach() throws PromptException, ServerErrorException{
		try{
			//优惠信息
			discounts=new ArrayList<Discount>();
			discountService.findAll(discounts, new Discount().setType(Discount.TYPE_COACH), page.getPageNumber(), 6);
			//结束
			ComplexSearchCondition oldCondition=(ComplexSearchCondition)session.get("currentCondition");
			addr=(Address)session.get("currentAddr");
			if(addr==null){
				addrs=addressService.findChildAddress(cityAddrs.get(0));
			}else{
				addrs=addressService.findChildAddress(addr);
			}
			types=productTypeService.findTypes();
			
			if(condition==null){//如果没有传递任何搜索条件，则默认按第一个类型搜索
				condition=(ComplexSearchCondition)session.get("currentCondition");
				if(condition==null){//如果还从未搜索过，就默认按第一种项目展示场地详情
					condition=new ComplexSearchCondition();
					condition.setType(types.get(0));
				}	
				oldCondition=condition;
			}else{//设置新的搜索条件
				
				if(condition.getSearchFlag()!=null){
					if(condition.getSearchFlag().trim().equals(ComplexSearchCondition.COMPLEX_SEARCH)){
						condition.setSimpleFlag(false);
					}else{
						condition.setSimpleFlag(true);
					}
					//确保oldCondition有值
					if(oldCondition==null||(oldCondition.isSimpleFlag()!=condition.isSimpleFlag())){//如果简单搜索与复杂搜索切换
						oldCondition=new ComplexSearchCondition().setSimpleFlag(condition.isSimpleFlag());
					}
				}
				if(condition.getAddress()!=null){
					if(condition.getAddress().getId()==0){//是否是清除地址选择
						oldCondition.setAddress(null);
					}else{
						oldCondition.setAddress(condition.getAddress());
					}
				}
				if(condition.getProduct()!=null){
					oldCondition.setProduct(condition.getProduct());
				}
				if(condition.getType()!=null){
					oldCondition.setType(condition.getType());
				}
				if(oldCondition.isSimpleFlag()){//如果是简单搜索
					oldCondition.setAddress(new Address().setAddressName(condition.getSimpleKeyWord()))
						.setType(new ProductType().setTypeName(condition.getSimpleKeyWord()))
						.setProduct(new PlaceProduct().setProductName(condition.getSimpleKeyWord()));
				}
			}
			//将本次的搜索条件放入session中
			session.put("currentCondition", oldCondition);
			if(addr!=null)
				oldCondition.setCityAddress(addr);
			else{
				oldCondition.setCityAddress(cityAddrs.get(0));
			}
			if(page==null)
				page=new Page();
			coachs=new ArrayList<Coach>();
			if(oldCondition.isSimpleFlag()){
				page.setTotalItemNumber(coachService.simpleSearchedPlaceProducts(oldCondition, coachs, page.getPageNumber(), page.getPageSize()));
			}else{
				page.setTotalItemNumber(coachService.searchedPlaceProducts(oldCondition, coachs, page.getPageNumber(), page.getPageSize()));
			}
		}catch(RootException e){
			errorMsg=e.toString();
			throw new PromptException(errorMsg);
		}catch(Exception e){
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "chooseCoach";
	}
	public String orderPlace() throws PromptException, ServerErrorException{
		try {
			placeProduct=placeProductService.load(placeProduct);
			sitePreOrderInfos=new ArrayList<SitePlacesOrderInfo>();
			dates=getDates();
			for(Date date:dates){
				SitePlacesOrderInfo info=new SitePlacesOrderInfo()
										.setPlacePreOrderService(placePreOrderService)
										.setPlaceService(placeService);
				info.init(date, site, placeProduct);
				sitePreOrderInfos.add(info);	
				
			}
			avgComment=new AvgComment().init(commentService, new Comment().setProduct((Product)placeProduct));
			comments=new ArrayList<Comment>();
			page.setTotalItemNumber(commentService.findComments(comments,new Comment().setProduct((Product)placeProduct),
					page.getPageNumber(), page.setPageSize(5).getPageSize()));
		} catch(RootException e){
			errorMsg=e.toString();
			throw new PromptException(errorMsg);
		}catch(Exception e){
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "orderPlace";
	}
	
	public String orderCoach() throws PromptException, ServerErrorException{
		try{
			if(coachProduct!=null)
				coachProduct=coachProductService.load(coachProduct);
			coach=coachService.findCoach(coach);
			coachPreOrderInfos=new ArrayList<CoachPreOrderInfo>();
			dates=getDates();
			for(Date date:dates){
				CoachPreOrderInfo info=new CoachPreOrderInfo()
										.setCoachPreOrderService(coachPreOrderService)
										.setCoachService(coachService)
										.setCoachProductService(coachProductService)
										.setCoachCostService(coachCostService); 
				info.init(date, coach, coachProduct);
				coachPreOrderInfos.add(info);	
				
			}
			avgComment=new AvgComment().init(commentService, new Comment().setCoach(coach));
			comments=new ArrayList<Comment>();
			page.setTotalItemNumber(commentService.findComments(comments,new Comment().setCoach(coach),
					page.getPageNumber(), page.setPageSize(5).getPageSize()));
			//加载当前用户的订单
			String orderNumber = (String) session.get("orderNumber");
			if(orderNumber!=null){
				setCurrentOrder(orderService.load(new Order()
							.setOrderNumber(orderNumber)));
			}
		}catch(RootException e){
			errorMsg=e.toString();
			throw new PromptException(errorMsg);
		}catch(Exception e){
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "orderCoach";
	}
	public String help() {
		return "help";
	}
	
	public String aboutUs() {
		return "aboutUs";
	}

	public String userHome() throws PromptException{
		this.getCurrentUser();
		return "userHome";
	}

	/*********** 注入代码 ************/
	public List<ProductType> getTypes() {
		return types;
	}

	public void setTypes(List<ProductType> types) {
		this.types = types;
	}

	public ProductTypeService getProductTypeService() {
		return productTypeService;
	}

	@Resource
	public void setProductTypeService(ProductTypeService productTypeService) {
		this.productTypeService = productTypeService;
		//types = productTypeService.findRootTypes();
	}

	

	public CompanyService getCompanyService() {
		return companyService;
	}

	@Resource
	public void setCompanyService(CompanyService companyService) {
		this.companyService = companyService;
	}

	public List<Company> getCompanys() {
		return companys;
	}

	public void setCompanys(List<Company> companys) {
		this.companys = companys;
	}

	public Address getAddr() {
		return addr;
	}

	public void setAddr(Address addr) {
		this.addr = addr;
		
	}

	public List<Address> getCityAddrs() {
		return cityAddrs;
	}

	public void setCityAddrs(List<Address> cityAddrs) {
		this.cityAddrs = cityAddrs;
		
	}

	public AddressService getAddressService() {
		return addressService;
	}
	@Resource
	public void setAddressService(AddressService addressService) {
		this.addressService = addressService;
		try {
			cityAddrs=addressService.findCityAddress();
			rootAddrs=addressService.findRootAddrs();
		} catch (RootException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public List<Address> getAddrs() {
		return addrs;
	}
	public void setAddrs(List<Address> addrs) {
		this.addrs = addrs;		
	}
	public List<Date> getDates() {
		dates=new ArrayList<Date>();
		weeks=new ArrayList<String>();
		weekIndexArr=new int[7];
		Date date=new Date(new java.util.Date().getTime());
		long time=date.getTime();
		for(int i=0;i<7;i++){
			time+=i*TimerTaskQueue.SCHEDULE;
			Date temp=new Date(time);
			dates.add(temp);
			Calendar calendar=Calendar.getInstance();
			calendar.setTimeInMillis(time);
			weeks.add(WEEKS[calendar.get(Calendar.DAY_OF_WEEK)-1]);
			if(calendar.get(Calendar.DAY_OF_WEEK)==1)
				weekIndexArr[i]=6;
			else
				weekIndexArr[i]=calendar.get(Calendar.DAY_OF_WEEK)-2;
			time=date.getTime();
		}
		return dates;
	}
	public void setDates(List<Date> dates) {
		this.dates = dates;
		
	}
	public int[] getWeekIndexArr() {
		return weekIndexArr;
	}
	public void setWeekIndexArr(int[] weekIndexArr) {
		this.weekIndexArr = weekIndexArr;
	}
	public List<Place> getPlaces() {
		return places;
	}
	public void setPlaces(List<Place> places) {
		this.places = places;
		
	}
	public List<Coach> getCoachs() {
		return coachs;
	}
	public void setCoachs(List<Coach> coachs) {
		this.coachs = coachs;
		
	}
	public PlaceService getPlaceService() {
		return placeService;
	}
	@Resource
	public void setPlaceService(PlaceService placeService) {
		this.placeService = placeService;
		
	}
	public CoachService getCoachService() {
		return coachService;
	}
	@Resource
	public void setCoachService(CoachService coachService) {
		this.coachService = coachService;
		
	}
	public ComplexSearchCondition getCondition() {
		return condition;
	}
	public void setCondition(ComplexSearchCondition condition) {
		this.condition = condition;
	}
	public Place getPlace() {
		return place;
	}
	public void setPlace(Place place) {
		this.place = place;
	}
	public List<PlaceProduct> getPlaceProducts() {
		return placeProducts;
	}
	public void setPlaceProducts(List<PlaceProduct> placeProducts) {
		this.placeProducts = placeProducts;
		
	}
	public List<CoachProduct> getCoachProducts() {
		return coachProducts;
	}
	public void setCoachProducts(List<CoachProduct> coachProducts) {
		this.coachProducts = coachProducts;
		
	}
	public PlaceProductService getPlaceProductService() {
		return placeProductService;
	}
	@Resource
	public void setPlaceProductService(PlaceProductService placeProductService) {
		this.placeProductService = placeProductService;
		
	}
	public CoachProductService getCoachProductService() {
		return coachProductService;
	}
	@Resource
	public void setCoachProductService(CoachProductService coachProductService) {
		this.coachProductService = coachProductService;
		
	}
	public PlaceProduct getPlaceProduct() {
		return placeProduct;
	}
	public void setPlaceProduct(PlaceProduct placeProduct) {
		this.placeProduct = placeProduct;
		
	}
	public CoachProduct getCoachProduct() {
		return coachProduct;
	}
	public void setCoachProduct(CoachProduct coachProduct) {
		this.coachProduct = coachProduct;
		
	}
	public List<SitePlacesOrderInfo> getSitePreOrderInfos() {
		return sitePreOrderInfos;
	}
	public void setSitePreOrderInfos(List<SitePlacesOrderInfo> sitePreOrderInfos) {
		this.sitePreOrderInfos = sitePreOrderInfos;
		
	}
	public PlacePreOrderService getPlacePreOrderService() {
		return placePreOrderService;
	}
	@Resource
	public void setPlacePreOrderService(PlacePreOrderService placePreOrderService) {
		this.placePreOrderService = placePreOrderService;
		
	}
	public Site getSite() {
		return site;
	}
	public void setSite(Site site) {
		this.site = site;
		
	}
	public Coach getCoach() {
		return coach;
	}
	public void setCoach(Coach coach) {
		this.coach = coach;
		
	}
	public List<String> getWeeks() {
		return weeks;
	}
	public void setWeeks(List<String> weeks) {
		this.weeks = weeks;
	}
	public List<Comment> getComments() {
		return comments;
	}
	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}
	public CommentService getCommentService() {
		return commentService;
	}
	@Resource
	public void setCommentService(CommentService commentService) {
		this.commentService = commentService;
	}
	public AvgComment getAvgComment() {
		return avgComment;
	}
	public void setAvgComment(AvgComment avgComment) {
		this.avgComment = avgComment;
		
	}
	public List<CoachPreOrderInfo> getCoachPreOrderInfos() {
		return coachPreOrderInfos;
	}
	public void setCoachPreOrderInfos(List<CoachPreOrderInfo> coachPreOrderInfos) {
		this.coachPreOrderInfos = coachPreOrderInfos;
	}
	public CoachPreOrderService getCoachPreOrderService() {
		return coachPreOrderService;
	}
	@Resource
	public void setCoachPreOrderService(CoachPreOrderService coachPreOrderService) {
		this.coachPreOrderService = coachPreOrderService;
	}
	public CoachCostService getCoachCostService() {
		return coachCostService;
	}
	@Resource
	public void setCoachCostService(CoachCostService coachCostService) {
		this.coachCostService = coachCostService;
	}
	public Order getCurrentOrder() {
		return currentOrder;
	}
	public void setCurrentOrder(Order currentOrder) {
		this.currentOrder = currentOrder;
		
	}
	public OrderService getOrderService() {
		return orderService;
	}
	@Resource
	public void setOrderService(OrderService orderService) {
		this.orderService = orderService;
	}

	public List<Discount> getDiscounts() {
		return discounts;
	}
	public void setDiscounts(List<Discount> discounts) {
		this.discounts = discounts;
	}
	public DiscountService getDiscountService() {
		return discountService;
	}
	@Resource
	public void setDiscountService(DiscountService discountService) {
		this.discountService = discountService;
	}

}
