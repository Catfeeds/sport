package com.sport.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.sport.timer.TimerTaskQueue;
import com.sport.util.DateFormatUtil;
import com.sport.util.DateToWeek;
import com.sport.util.NumberFormatUtil;


@Entity
@Table(name="user_order")
public class Order  implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/*
	 * Id；
		List<OrderItem> item;订单项；（一对多、双向关联）
		oderNumber；订单编号；
		tradeNumber；交易编号；
		buyer；购买者（引用类Member）；（多对一、双向关联）
		receiverName;收件人；
		receiverPhone;收件人电话；
		totalAcount;总金额；
		submitTime;提交时间；
		hasSubmit;是否已经提交
		hasPay;是否已支付
		hasDelivered;确认预定（管理员操作）；
		hasUse;确认已消费（确认收货时间）；（完成）
		orderStatus;订单状态；（3个状态）已提交、已支付、已消费或已退款（提前一天以上才能退款）
		items；订单项
		*/
	public final static int NOT_SUBMIT_ORDER=1;//未提交
	public final static int SUBMIT_NOT_PAY_ORDER=2;//已提交但未支付
	public final static int PAYED_NOT_USE_ORDER=3;//已支付成功但未使用
	public final static int USEED_ORDER=4;//已经使用完成的订单,此状态才能算作成功获得收益,当用户来消费时，管理员执行确认操作
	public final static int USELESS_ORDER=5;//废单,包括已使用的或者
	public final static int PAYING_ORDER=6;//订单正在支付中
	public final static int PAY_FAILED=7;//支付失败
	public final static int REFOUNDING_ORDER=8;//用户已经申请了退款
	public final static int REFOUNDED_ORDER=9;//已经退款成功
	public final static int CONFIRM_OK_ORDER=10;//已经成功输入了联系方式进行了验证
	public final static long ORDER_TIMEOUT_LIMIT=TimerTaskQueue.CHECK_NOTPAY_ORDER;
	private int id;
	private List<OrderItem> items;//订单项
	private Company company;//这个订单是属于哪个公司的
	private Coach coach;//这个订单是哪个教练的
	private Site site;//这个订单属于的场馆
	private String orderNumber;//订单编号
	private String tradeNumber;//交易编号
	private User buyer;//购买用户
	private String phone;//购买用户留下的联系电话
	private String receiverName;//预定人姓名
	private String receiverPhone;//预订人电话
	private float totalAcount;//该订单总金额
	private Date createTime;//订单创建时间
	private Date submitTime;//订单提交时间
	private Date payTime;//订单支付时间
	private Date deliveredTime;//确认时间
	private Date useTime;//消费时间
	private Date preOrderTime;//预定使用时间
	private Date payingBeginTime;//开始支付时间
	private Date refoundAplyTime;//退款申请时间
	private boolean hasRead;//管理员是否已经查看过了	
	private boolean hasSubmit;//是否已经提交
	private boolean hasPay;//是否已支付
	private boolean hasDelivered;//确认预定（管理员操作）；
	private boolean hasUse;//是否已经消费
	private boolean hasUseless;//是否是废单
	private int orderStatus;//订单状态,如上面所定义的所示
	private String jsPayParams;//微信内支付参数
	private String nativePayUrl;//原生态扫码支付链接
	//dto
	private String week;//根据date换算星期
	private Date dtoBeginDate;//查询某个时间段的订单
	private Date dtoEndDate;//与上面参数配合使用
	public Order(){}	
	
	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}
	public Order setId(int id) {
		this.id = id;
		return this;
	}
	@OneToMany(mappedBy="order",fetch=FetchType.LAZY,cascade=CascadeType.ALL)
	public List<OrderItem> getItems() {
		return items;
	}
	public Order setItems(List<OrderItem> items) {
		this.items = items;
		return this;
	}
	@Column(unique=true)
	public String getOrderNumber() {
		return orderNumber;
	}
	public Order setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
		return this;
	}
	@Column(unique=true)
	public String getTradeNumber() {
		return tradeNumber;
	}
	public Order setTradeNumber(String tradeNumber) {
		this.tradeNumber = tradeNumber;
		return this;
	}
	@ManyToOne(fetch=FetchType.EAGER)
	public User getBuyer() {
		return buyer;
	}
	public Order setBuyer(User buyer) {
		this.buyer = buyer;
		return this;
	}

	
	public String getPhone() {
		return phone;
	}

	public Order setPhone(String phone) {
		this.phone = phone;
		return this;
	}

	public String getReceiverName() {
		return receiverName;
	}
	public Order setReceiverName(String receiverName) {
		this.receiverName = receiverName;
		return this;
	}

	public String getReceiverPhone() {
		return receiverPhone;
	}
	public Order setReceiverPhone(String receiverPhone) {
		this.receiverPhone = receiverPhone;
		return this;
	}
	
	public float getTotalAcount() {
		totalAcount=NumberFormatUtil.formatFloat(totalAcount);
		return totalAcount;
	}
	public Order setTotalAcount(float totalAcount) {
		totalAcount=NumberFormatUtil.formatFloat(totalAcount);
		this.totalAcount = totalAcount;
		return this;
	}
	
	public Date getCreateTime() {
		//createTime=DateFormatUtil.formatDay(createTime);
		return createTime;
	}

	public Order setCreateTime(Date createTime) {
		//createTime=DateFormatUtil.formatDay(createTime);
		System.out.println("createTime is " + createTime + "___________");
		this.createTime = createTime;
		return this;
	}

	public Date getSubmitTime() {
		//submitTime=DateFormatUtil.formatDay(submitTime);
		return submitTime;
	}
	public Order setSubmitTime(Date submitTime) {
		//submitTime=DateFormatUtil.formatDay(submitTime);
		this.submitTime = submitTime;
		return this;
	}
	public Date getPayTime() {
		//payTime=DateFormatUtil.formatDay(payTime);
		return payTime;
	}
	public Order setPayTime(Date payTime) {
		//payTime=DateFormatUtil.formatDay(payTime);
		this.payTime = payTime;
		return this;
	}
	public Date getDeliveredTime() {
		//deliveredTime=DateFormatUtil.formatDay(deliveredTime);
		return deliveredTime;
	}
	public Order setDeliveredTime(Date deliveredTime) {
		//deliveredTime=DateFormatUtil.formatDay(deliveredTime);
		this.deliveredTime = deliveredTime;
		return this;
	}
	
	public Date getPreOrderTime() {
		//preOrderTime=DateFormatUtil.formatDay(preOrderTime);
		return preOrderTime;
	}

	public Order setPreOrderTime(Date preOrderTime) {
		//preOrderTime=DateFormatUtil.formatDay(preOrderTime);
		this.preOrderTime = preOrderTime;
		return this;
	}

	public int getOrderStatus() {
		return orderStatus;
	}
	public Order setOrderStatus(int orderStatus) {
		this.orderStatus = orderStatus;
		return this;
	}


	public boolean isHasSubmit() {
		return hasSubmit;
	}


	public Order setHasSubmit(boolean hasSubmit) {
		this.hasSubmit = hasSubmit;
		return this;
	}


	public boolean isHasPay() {
		return hasPay;
	}


	public Order setHasPay(boolean hasPay) {
		this.hasPay = hasPay;
		return this;
	}


	public boolean isHasDelivered() {
		return hasDelivered;
	}


	public Order setHasDelivered(boolean hasDelivered) {
		this.hasDelivered = hasDelivered;
		return this;
	}


	public boolean isHasUse() {
		return hasUse;
	}


	public Order setHasUse(boolean hasUse) {
		this.hasUse = hasUse;
		return this;
	}

	public boolean isHasRead() {
		return hasRead;
	}

	public Order setHasRead(boolean hasRead) {
		this.hasRead = hasRead;
		return this;
	}

	public Date getUseTime() {
		return useTime;
	}

	public Order setUseTime(Date useTime) {
		this.useTime = useTime;
		return this;
	}

	public Date getRefoundAplyTime() {
		return refoundAplyTime;
	}

	public Order setRefoundAplyTime(Date refoundAplyTime) {
		this.refoundAplyTime = refoundAplyTime;
		return this;
	}

	public boolean isHasUseless() {
		return hasUseless;
	}

	public Order setHasUseless(boolean hasUseless) {
		this.hasUseless = hasUseless;
		return this;
	}
	@ManyToOne(fetch=FetchType.LAZY)
	public Company getCompany() {
		return company;
	}


	public Order setCompany(Company company) {
		this.company = company;
		return this;
	}
	@OneToOne(fetch=FetchType.LAZY)
	public Coach getCoach() {
		return coach;
	}

	public Order setCoach(Coach coach) {
		this.coach = coach;
		return this;
	}
	@ManyToOne(fetch=FetchType.LAZY)
	public Site getSite() {
		return site;
	}

	public Order setSite(Site site) {
		this.site = site;
		return this;
	}

	public Date getPayingBeginTime() {
		return payingBeginTime;
	}

	public Order setPayingBeginTime(Date payingBeginTime) {
		this.payingBeginTime = payingBeginTime;
		return this;
	}

	public String getJsPayParams() {
		return jsPayParams;
	}

	public Order setJsPayParams(String jsPayParams) {
		this.jsPayParams = jsPayParams;
		return this;
	}

	public String getNativePayUrl() {
		return nativePayUrl;
	}

	public Order setNativePayUrl(String nativePayUrl) {
		this.nativePayUrl = nativePayUrl;
		return this;
	}

	@Transient
	public String getWeek() {
		week=DateToWeek.getWeek(this.preOrderTime);
		return week;
	}

	public Order setWeek(String week) {
		this.week = week;
		return this;
	}
	@Transient
	public Date getDtoBeginDate() {
		return dtoBeginDate;
	}
	
	public Order setDtoBeginDate(Date dtoBeginDate) {
		this.dtoBeginDate = dtoBeginDate;
		return this;
	}
	@Transient
	public Date getDtoEndDate() {
		return dtoEndDate;
	}

	public Order setDtoEndDate(Date dtoEndDate) {
		this.dtoEndDate = dtoEndDate;
		return this;
	}
}
