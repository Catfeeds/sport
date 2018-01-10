package com.sport.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Transient;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.sport.exception.RootException;
import com.sport.service.AddressService;
import com.sport.service.CoachProductService;
import com.sport.service.ImageService;
import com.sport.util.DateFormatUtil;

/*
 * 教练
 */
@Entity
@PrimaryKeyJoinColumn(name = "id", referencedColumnName = "person_id")
public class Coach extends Person implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/*
	 * 
	 * totalSoldNumber;总指导服务量 score;综合得分 Introduction；简介； sites;场馆(多个)
	 * List<Company>companys;//教练所属的公司 coachProducts;教练有哪些项目可以出售
	 */
	public final static int MAX_ACTIVE_ADDRESS = 4;// 最多可选的活动区域
	private float basePrice;// 起步价
	private String baseCostPrice;// 教练预定义的收费价格集
	private int employNumber;// 每次同时可以为几个用户提供服务
	private long totalSoldNumber;// 该教练为用户提供服务的总次数
	private long score;// 用户对该教练的综合评分
	private String introduction;// 该教练的个人简介
	private Date registerDate;// 教练入驻时间
	private String dayJobTime;// 教练自定义的每天上班时间段
	private String weekJobTime;// 教练自定义的每星期上班时间
	private int topValue;// 推荐指数，默认为0，最高为10
	private List<Site> sites;// 该教练在哪几个体育场馆工作
	private ProductType skillType;// 教练的专长项目类型
	private List<CoachProduct> coachProducts;// 该教练可以提供那些服务产品
	private List<CoachCost> coachCosts;// 该教练自定义的收费情况和上班时间
	private List<CoachPreOrder> preOrders;// 该教练的所有预定情况
	private List<OrderItem> orderItems;// 该教练已经被预定的情况
	private List<Image> certificates;// 该教练已经获得的相关证书
	private List<Image> photoes;// 教练照片展示,供用户查看
	private Company company;// 教练所属的公司
	private List<Address> addrs;// 活动区域，最多4个活动区域
	// dto变量
	private int dayJobTimes[];// 每天上班时间，以小时为单位，共24个,值为0或1，代表工作或不工作
	private int weekJobTimes[];// 每星期上班时间，以天为单位，共7个,值为0或1，代表工作或不工作
	private int[] photoIds;
	private int[] certificateIds;
	private int[] addrIds;
	private int[] coachProductIds;
	private String[] costs;// 每一个字符串中是一条项目的收费标准
	private int dayJobTimeArr[];// 每一个字符串代表上午、下午、晚上,0代表不营业,1代表营业
	private float[] currentPrices;// 当前的收费标准,根据不同的教练产品发生变化
	private float[] baseCostPrices;// 价格数组
	// 使用到的服务
	@Resource
	@Transient
	private ImageService imageService;
	@Resource
	@Transient
	private AddressService addressService;
	@Resource
	@Transient
	private CoachProductService coachProductService;

	public Coach() {
		dayJobTimes = new int[24];
		weekJobTimes = new int[7];
		costs = new String[24];// 暂时只用到前4个
		baseCostPrices = new float[24];// 暂时只用到前4个
		dayJobTimeArr = new int[24];// 暂时只用到前4个
	}

	public float getBasePrice() {
		return basePrice;
	}

	public Coach setBasePrice(float basePrice) {
		this.basePrice = basePrice;
		return this;
	}

	public String getBaseCostPrice() {
		return baseCostPrice;
	}

	public Coach setBaseCostPrice(String baseCostPrice) {
		this.baseCostPrice = baseCostPrice;
		if (baseCostPrice != null) {
			String arr[] = baseCostPrice.split(",");
			int i = 0;
			for (String val : arr) {
				baseCostPrices[i] = Float.parseFloat(val);
				i++;
			}
		}
		return this;
	}

	public int getEmployNumber() {
		return employNumber;
	}

	public Coach setEmployNumber(int employNumber) {
		this.employNumber = employNumber;
		return this;
	}

	public long getTotalSoldNumber() {
		return totalSoldNumber;
	}

	public Coach setTotalSoldNumber(long totalSoldNumber) {
		this.totalSoldNumber = totalSoldNumber;
		return this;
	}

	public long getScore() {
		return score;
	}

	public Coach setScore(long score) {
		this.score = score;
		return this;
	}

	@Lob
	public String getIntroduction() {
		return introduction;
	}

	public Coach setIntroduction(String introduction) {
		this.introduction = introduction;
		return this;
	}

	@ManyToMany(fetch = FetchType.LAZY, mappedBy = "coachs")
	public List<Site> getSites() {
		return sites;
	}

	public Coach setSites(List<Site> sites) {
		this.sites = sites;
		return this;
	}

	@OneToMany(fetch = FetchType.LAZY)
	public List<CoachProduct> getCoachProducts() {
		return coachProducts;
	}

	public Coach setCoachProducts(List<CoachProduct> coachProducts) {
		this.coachProducts = coachProducts;
		return this;
	}

	@OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	public List<Image> getCertificates() {
		return certificates;
	}

	public Coach setCertificates(List<Image> certificates) {
		this.certificates = certificates;
		return this;
	}

	@OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	public List<Image> getPhotoes() {
		return photoes;
	}

	public Coach setPhotoes(List<Image> photoes) {
		this.photoes = photoes;
		return this;
	}

	public Date getRegisterDate() {
		// registerDate=DateFormatUtil.formatDay(registerDate);
		return registerDate;
	}

	public Coach setRegisterDate(Date registerDate) {
		// registerDate=DateFormatUtil.formatDay(registerDate);
		this.registerDate = registerDate;
		return this;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	public Company getCompany() {
		return company;
	}

	public Coach setCompany(Company company) {
		this.company = company;
		return this;
	}

	@OneToMany(mappedBy = "coach", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	public List<CoachCost> getCoachCosts() {
		return coachCosts;
	}

	public Coach setCoachCosts(List<CoachCost> coachCosts) {
		this.coachCosts = coachCosts;
		int i = 0;
		if (coachCosts != null) {
			for (CoachCost cost : coachCosts) {
				costs[i] = cost.getTimePrice();
				i++;
			}
		}
		return this;
	}

	public String getDayJobTime() {
		return dayJobTime;
	}

	public Coach setDayJobTime(String dayJobTime) {

		this.dayJobTime = dayJobTime;
		return this;
	}

	public String getWeekJobTime() {
		return weekJobTime;
	}

	public Coach setWeekJobTime(String weekJobTime) {
		this.weekJobTime = weekJobTime;
		return this;
	}

	public int getTopValue() {
		return topValue;
	}

	public Coach setTopValue(int topValue) {
		this.topValue = topValue;
		return this;
	}

	@OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL, mappedBy = "coach")
	public List<CoachPreOrder> getPreOrders() {
		return preOrders;
	}

	public Coach setPreOrders(List<CoachPreOrder> preOrders) {
		this.preOrders = preOrders;
		return this;
	}

	@OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL, mappedBy = "coach")
	public List<OrderItem> getOrderItems() {
		return orderItems;
	}

	public Coach setOrderItems(List<OrderItem> orderItems) {
		this.orderItems = orderItems;
		return this;
	}

	@OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
	public List<Address> getAddrs() {
		return addrs;
	}

	public Coach setAddrs(List<Address> addrs) {
		this.addrs = addrs;
		return this;
	}

	@OneToOne(fetch = FetchType.LAZY)
	public ProductType getSkillType() {
		return skillType;
	}

	public Coach setSkillType(ProductType skillType) {
		this.skillType = skillType;
		return this;
	}

	/*********** 传输变量 **********/
	@Transient
	public int[] getDayJobTimes() {
		if (dayJobTime != null) {
			String[] jobStr = dayJobTime.split(",");
			int i = 0;
			for (String str : jobStr) {
				try {
					dayJobTimes[i++] = Integer.parseInt(str);
				} catch (Exception e) {
					String info = "数据非法，无法转化为int型！";
					System.out.println(info);
					continue;
				}
			}
		}
		return dayJobTimes;
	}

	public Coach setDayJobTimes(int dayJobTimes[]) {
		if (dayJobTimes != null) {
			this.dayJobTimes = dayJobTimes;
			StringBuffer buffer = new StringBuffer();
			for (int i : dayJobTimes) {
				buffer.append(i + ",");
			}
			dayJobTime = buffer.substring(0, buffer.length() - 1);
		}
		return this;
	}

	@Transient
	public int[] getWeekJobTimes() {
		if (weekJobTime != null) {
			String[] jobStr = weekJobTime.split(",");
			int i = 0;
			for (String str : jobStr) {
				try {
					weekJobTimes[i++] = Integer.parseInt(str);
				} catch (Exception e) {
					String info = "数据非法，无法转化为int型！";
					System.out.println(info);
					continue;
				}
			}
		}
		return weekJobTimes;
	}

	public Coach setWeekJobTimes(int weekJobTimes[]) {
		if (weekJobTimes != null) {
			this.weekJobTimes = weekJobTimes;
			StringBuffer buffer = new StringBuffer();
			for (int i : weekJobTimes) {
				buffer.append(i + ",");
			}
			weekJobTime = buffer.substring(0, buffer.length() - 1);
		}
		return this;
	}

	@Transient
	public int[] getPhotoIds() {
		return photoIds;
	}

	public Coach setPhotoIds(int[] photoIds) {
		this.photoIds = photoIds;
		if (photoIds != null) {
			// 设置教练与图片的关联
			photoes = new ArrayList<Image>();
			for (int id : photoIds) {
				try {
					photoes.add(imageService.load(new Image().setId(id)));
				} catch (RootException e) {
					e.printStackTrace();
				}
				System.out.println("photo:" + id);
			}
		}
		return this;
	}

	@Transient
	public int[] getCertificateIds() {
		return certificateIds;
	}

	public Coach setCertificateIds(int[] certificateIds) {
		this.certificateIds = certificateIds;
		if (certificateIds != null) {
			certificates = new ArrayList<Image>();
			for (int id : certificateIds) {
				try {
					certificates.add(imageService.load(new Image().setId(id)));
				} catch (RootException e) {
					e.printStackTrace();
				}
				System.out.println("certificate:" + id);
			}
		}
		return this;
	}

	@Transient
	public int[] getAddrIds() {
		return addrIds;
	}

	public Coach setAddrIds(int[] addrIds) {
		if (addrIds != null) {
			this.addrIds = addrIds;
			addrs = new ArrayList<Address>();
			for (int id : addrIds) {
				try {
					addrs.add(addressService.load(new Address().setId(id)));
				} catch (RootException e) {
					e.printStackTrace();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return this;
	}

	@Transient
	public int[] getCoachProductIds() {
		return coachProductIds;
	}

	public Coach setCoachProductIds(int[] coachProductIds) {
		this.coachProductIds = coachProductIds;
		if (coachProductIds != null) {
			coachProducts = new ArrayList<CoachProduct>();
			for (int id : coachProductIds) {
				try {
					CoachProduct tempProduct = coachProductService
							.load((CoachProduct) new CoachProduct().setId(id));
					coachProducts.add(tempProduct);

				} catch (RootException e) {
					e.printStackTrace();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return this;
	}

	@Transient
	public String[] getCosts() {
		if (costs != null) {
			for (String cost : costs) {
				System.out.println("costs:" + cost);
			}
		}
		return costs;
	}

	public Coach setCosts(String[] costs) {
		this.costs = costs;
		return this;
	}

	@Transient
	public int[] getDayJobTimeArr() {
		if (dayJobTime != null) {
			String arr[] = dayJobTime.split(",");
			if (arr[CoachPreOrder.TIME_AM_BEGIN_WORK].equals("1")) {
				dayJobTimeArr[0] = 1;
			}
			if (arr[CoachPreOrder.TIME_PM_BEGIN_WORK].equals("1")) {
				dayJobTimeArr[1] = 1;
			}
			if (arr[CoachPreOrder.TIME_NIGHT_BEGIN_WORK].equals("1")) {
				dayJobTimeArr[2] = 1;
			}
			if (arr[CoachPreOrder.TIME_AM_BEGIN_WORK].equals("1")
					&& (arr[CoachPreOrder.TIME_PM_BEGIN_WORK].equals("1"))
					&& (arr[CoachPreOrder.TIME_NIGHT_BEGIN_WORK].equals("1"))) {
				dayJobTimeArr[3] = 1;
			}
		}
		return dayJobTimeArr;
	}

	public Coach setDayJobTimeArr(int dayJobTimeArr[]) {
		if (dayJobTimeArr != null) {
			int dayjobTimesTemp[] = new int[24];
			if (dayJobTimeArr[0] == 1) {
				for (int i = 0; i <= CoachPreOrder.TIME_AM_END_WORK; i++)
					dayjobTimesTemp[i] = 1;
			}
			if (dayJobTimeArr[1] == 1) {
				for (int i = CoachPreOrder.TIME_PM_BEGIN_WORK; i <= CoachPreOrder.TIME_PM_END_WORK; i++)
					dayjobTimesTemp[i] = 1;
			}
			if (dayJobTimeArr[2] == 1) {
				for (int i = CoachPreOrder.TIME_NIGHT_BEGIN_WORK; i <= CoachPreOrder.TIME_NIGHT_END_WORK; i++)
					dayjobTimesTemp[i] = 1;
			}
			this.setDayJobTimes(dayjobTimesTemp);
			this.dayJobTimeArr = dayJobTimeArr;
		}
		return this;
	}

	@Transient
	public float[] getCurrentPrices() {
		return currentPrices;
	}

	public Coach setCurrentPrices(float[] currentPrices) {
		this.currentPrices = currentPrices;
		return this;
	}

	@Transient
	public float[] getBaseCostPrices() {
		return baseCostPrices;
	}

	public Coach setBaseCostPrices(float[] baseCostPrices) {
		this.baseCostPrices = baseCostPrices;
		if (baseCostPrices != null) {
			baseCostPrice = "";
			for (float baseCost : baseCostPrices) {
				baseCostPrice += Float.toString(baseCost) + ",";
			}
			baseCostPrice = baseCostPrice.substring(0,
					baseCostPrice.length() - 1);
		}
		return this;
	}

}
