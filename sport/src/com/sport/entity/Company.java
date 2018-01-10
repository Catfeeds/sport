package com.sport.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

@Entity
public class Company  implements Serializable{
/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/*
 * Id；
	companyName；公司名；
	companyURL；公司网址；
	registerDate;公司入驻日期
	nationality;国籍
	logoImage；图标（logo）与Image类一对一，单向关联；
	address;公司地址
	flag;激活状态
	phone;热线电话
	email;公司邮箱
	proofFile;营业执照等的压缩包
	managers;该公司的管理员
	
	leaf；是否是叶子节点
	grade；度
	introduction；简介；
	detail;详细介绍
*/
	private int id;
	private String companyName;//公司名
	private String companyUrl;//公司服务器地址
	private Date date;//公司成立日期
	private Date registerDate;//公司入驻日期
	private boolean flag;//公司是否已经激活
	private boolean host;//是否是平台拥有者
	private Image proofFile;//公司营业执照相关证书，压缩包等上传审核
	private Image logoImage;//公司logo
	private Address address;//公司所属区域
	private String addressDetail;//详细地址
	private String phone;//热线电话
	private String email;//邮箱
	private List<Manager> managers;//公司的所有管理员
	private List<Coach> coachs;//场馆教练
	private List<Site> sites;//该公司有哪些场馆
	private List<Order> orders;//该公司的所有订单项
	private List<Product> products;//公司的产品
	private String introduction;//公司简介
	private String detail;//公司详情

	public Company(){}
	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}

	public Company setId(int id) {
		this.id = id;
		return this;
	}

	public String getCompanyName() {
		return companyName;
	}

	public Company setCompanyName(String companyName) {
		this.companyName = companyName;
		return this;
	}

	public String getCompanyUrl() {
		return companyUrl;
	}

	public Company setCompanyUrl(String companyUrl) {
		this.companyUrl = companyUrl;
		return this;
	}

	public Date getRegisterDate() {
		//registerDate=DateFormatUtil.formatDay(registerDate);
		return registerDate;
	}

	public Company setRegisterDate(Date registerDate) {
		//registerDate=DateFormatUtil.formatDay(registerDate);
		this.registerDate = registerDate;
		return this;
	}

	public boolean isFlag() {
		return flag;
	}

	public Company setFlag(boolean flag) {
		this.flag = flag;
		return this;
	}
	@OneToOne(fetch=FetchType.LAZY,cascade=CascadeType.REMOVE)
	public Image getProofFile() {
		return proofFile;
	}

	public Company setProofFile(Image proofFile) {
		this.proofFile = proofFile;
		return this;
	}
	@OneToOne(fetch=FetchType.EAGER,cascade=CascadeType.REMOVE)
	public Image getLogoImage() {
		return logoImage;
	}

	public Company setLogoImage(Image logoImage) {
		this.logoImage = logoImage;
		return this;
	}
	@ManyToOne(fetch=FetchType.EAGER)
	public Address getAddress() {
		return address;
	}

	public Company setAddress(Address address) {
		this.address = address;
		return this;
	}

	public String getAddressDetail() {
		return addressDetail;
	}

	public Company setAddressDetail(String addressDetail) {
		this.addressDetail = addressDetail;
		return this;
	}

	public String getPhone() {
		return phone;
	}

	public Company setPhone(String phone) {
		this.phone = phone;
		return this;
	}

	public String getEmail() {
		return email;
	}

	public Company setEmail(String email) {
		this.email = email;
		return this;
	}
	
	@OneToMany(fetch=FetchType.LAZY,mappedBy="company",cascade=CascadeType.PERSIST)
	public List<Coach> getCoachs() {
		return coachs;
	}

	public Company setCoachs(List<Coach> coachs) {
		this.coachs = coachs;
		return this;
	}
	@Lob
	public String getIntroduction() {
		return introduction;
	}

	public Company setIntroduction(String introduction) {
		this.introduction = introduction;
		return this;
	}
	@Lob
	public String getDetail() {
		return detail;
	}

	public Company setDetail(String detail) {
		this.detail = detail;
		return this;
	}
	@OneToMany(fetch=FetchType.LAZY,mappedBy="company",cascade={CascadeType.PERSIST,CascadeType.REMOVE})
	public List<Site> getSites() {
		return sites;
	}
	public Company setSites(List<Site> sites) {
		this.sites = sites;
		return this;
	}
	public boolean isHost() {
		return host;
	}
	public Company setHost(boolean host) {
		this.host = host;
		return this;
	}
	@OneToMany(fetch=FetchType.LAZY,cascade={CascadeType.PERSIST,CascadeType.REMOVE},mappedBy="company")
	public List<Manager> getManagers() {
		return managers;
	}
	public Company setManagers(List<Manager> managers) {
		this.managers = managers;
		return this;
	}
	public Date getDate() {
		//date=DateFormatUtil.formatDay(date);
		return date;
	}
	public Company setDate(Date date) {
		//date=DateFormatUtil.formatDay(date);
		this.date = date;
		return this;
	}
	
	@OneToMany(mappedBy="company",fetch=FetchType.LAZY,cascade=CascadeType.REMOVE)
	public List<Product> getProducts() {
		return products;
	}
	public Company setProducts(List<Product> products) {
		this.products = products;
		return this;
	}
	@OneToMany(fetch=FetchType.LAZY,cascade=CascadeType.REMOVE,mappedBy="company")
	public List<Order> getOrders() {
		return orders;
	}
	public Company setOrders(List<Order> orders) {
		this.orders = orders;
		return this;
	}	
	
	
}
