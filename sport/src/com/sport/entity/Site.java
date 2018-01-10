package com.sport.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Transient;

import com.sport.exception.RootException;
import com.sport.service.ImageService;

//场馆
@Entity
public class Site  implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Resource
	@Transient
	private ImageService imageService;
	private long id;
	private String siteName;// 名字
	private String siteAddress;// 详细地址
	private String sitePhone;// 场馆热线电话
	private float xAddr;// 经度
	private float yAddr;// 纬度
	private Company company;// 隶属公司
	private Address address;// 隶属地区
	private String route;// 行车路线
	private String sellProducts;// 零食
	private String detail;// 场馆简介
	private int topValue;//推荐指数，默认为0，最高为10
	private List<Image> images;// 体育馆的展示图片
	private List<PlaceProduct> placeProducts;// 该场馆提供那些类型的场地和
	private List<CoachProduct> coachProducts;// 该场馆有哪些私人教练服务
	private String service;// 附加服务，每项服务名以逗号分隔,eg. 提供WiFi，可以停车
	private String dayJobTime;// 场馆每天的营业时间,24个小时，以小时为单位，数据格式如：1,0,1,1,1,0,......
	private String weekJobTime;// 场馆每个星期的营业时间，7天，以天为单位,数据格式如：1,0,1,1,0,......
	private List<Coach> coachs;// 该场馆有哪些私人教练
	private List<Place> places;// 该场馆有哪些场地
	// 传输对象
	private String[] services;// 所有服务项目
	private int[] imageIds;// 所有图片路径
	private int[] dayJobTimes;// 每天的营业时间数组
	private int[] weekJobTimes;// 每个星期的营业时间数组
	public Site(){
		dayJobTimes=new int[24];
		weekJobTimes=new int[7];
	}
	@Id
	@GeneratedValue
	public long getId() {
		return id;
	}

	public Site setId(long id) {
		this.id = id;
		return this;
	}

	public String getSiteName() {
		return siteName;
	}

	public Site setSiteName(String siteName) {
		this.siteName = siteName;
		return this;
	}

	public String getSiteAddress() {
		return siteAddress;
	}

	public Site setSiteAddress(String siteAddress) {
		this.siteAddress = siteAddress;
		return this;
	}

	public String getSitePhone() {
		return sitePhone;
	}

	public Site setSitePhone(String sitePhone) {
		this.sitePhone = sitePhone;
		return this;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	public Company getCompany() {
		return company;
	}

	public Site setCompany(Company company) {
		this.company = company;
		return this;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	public Address getAddress() {
		return address;
	}

	public Site setAddress(Address address) {
		this.address = address;
		return this;
	}

	public String getRoute() {
		return route;
	}

	public Site setRoute(String route) {
		this.route = route;
		return this;
	}

	public String getSellProducts() {
		return sellProducts;
	}

	public Site setSellProducts(String sellProducts) {
		this.sellProducts = sellProducts;
		return this;
	}

	@Lob
	public String getService() {
		return service;
	}

	public Site setService(String service) {
		this.service = service;
		return this;
	}

	@ManyToMany(fetch = FetchType.LAZY)
	public List<Coach> getCoachs() {
		return coachs;
	}

	public Site setCoachs(List<Coach> coachs) {
		this.coachs = coachs;
		return this;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "site",cascade=CascadeType.REMOVE)
	public List<PlaceProduct> getPlaceProducts() {
		return placeProducts;
	}

	public Site setPlaceProducts(List<PlaceProduct> placeProducts) {
		this.placeProducts = placeProducts;
		return this;
	}

	@ManyToMany(fetch = FetchType.LAZY, mappedBy = "sites")
	public List<CoachProduct> getCoachProducts() {
		return coachProducts;
	}

	public Site setCoachProducts(List<CoachProduct> coachProducts) {
		this.coachProducts = coachProducts;
		return this;
	}

	@OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	public List<Image> getImages() {
		return images;
	}

	public Site setImages(List<Image> images) {
		this.images = images;
		return this;
	}

	@Lob
	public String getDayJobTime() {
		return dayJobTime;
	}

	public Site setDayJobTime(String dayJobTime) {
		this.dayJobTime = dayJobTime;
		return this;
	}

	@Lob
	public String getWeekJobTime() {
		return weekJobTime;
	}

	public Site setWeekJobTime(String weekJobTime) {
		this.weekJobTime = weekJobTime;
		return this;
	}

	/************ 传输变量 **********/
	@Transient
	public int[] getImageIds() {
		return imageIds;
	}

	public Site setImageIds(int[] imageIds) {
		this.imageIds = imageIds;
		// 设置产品与图片的关联
		images = new ArrayList<Image>();
		for (int id : imageIds) {
			try {
				images.add(imageService.load(new Image().setId(id)));
			} catch (RootException e) {
				e.printStackTrace();
			}
			System.out.println("site Img:" + id);
		}
		return this;
	}

	@Transient
	public String[] getServices() {
		// 将所有服务转换为一个数组便于展示
		services = service.split(",");
		return services;
	}

	public Site setServices(String[] services) {
		this.services = services;
		// 该函数用以接收服务名数组,并将其组装为一个字符串
		StringBuffer buffer = new StringBuffer();
		for (String str : services) {
			buffer.append(str + ',');
		}
		service = buffer.substring(0, buffer.length() - 1);
		return this;
	}

	@Transient
	public int[] getDayJobTimes() {
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
		return dayJobTimes;
	}

	public Site setDayJobTimes(int dayJobTimes[]) {
		this.dayJobTimes = dayJobTimes;
		StringBuffer buffer = new StringBuffer();
		for (int i : dayJobTimes) {
			buffer.append(i + ",");
		}
		dayJobTime = buffer.substring(0, buffer.length() - 1);
		System.out.println("dayJobTime:"+dayJobTime);
		return this;
	}

	@Transient
	public int[] getWeekJobTimes() {
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
		return weekJobTimes;
	}

	public Site setWeekJobTimes(int weekJobTimes[]) {
		this.weekJobTimes = weekJobTimes;
		StringBuffer buffer = new StringBuffer();
		for (int i : weekJobTimes) {
			buffer.append(i + ",");
		}
		weekJobTime = buffer.substring(0, buffer.length() - 1);
		System.out.println("weekJobTime:"+weekJobTime);
		return this;
	}

	@OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL, mappedBy = "site")
	public List<Place> getPlaces() {
		return places;
	}

	public Site setPlaces(List<Place> places) {
		this.places = places;
		return this;
	}

	public float getXAddr() {
		return xAddr;
	}

	public Site setXAddr(float xAddr) {
		this.xAddr = xAddr;
		return this;
	}

	public float getYAddr() {
		return yAddr;
	}

	public Site setYAddr(float yAddr) {
		this.yAddr = yAddr;
		return this;
	}

	@Lob
	public String getDetail() {
		return detail;
	}

	public Site setDetail(String detail) {
		this.detail = detail;
		return this;
	}
	public int getTopValue() {
		return topValue;
	}
	public Site setTopValue(int topValue) {
		this.topValue = topValue;
		return this;
	}

}
