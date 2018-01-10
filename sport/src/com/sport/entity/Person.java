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
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.Lob;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Transient;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.sport.util.DateFormatUtil;
@Component
@Scope("prototype")
@Entity
@Inheritance(strategy=InheritanceType.JOINED)
public class Person  implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	protected int id;
	protected String userName;//用户名(账号)
	protected String password;//密码
	protected String passwordConfirm;//确认密码
	protected String realName;//真实姓名
	protected String sex;//性别
	protected String phone;//电话
	protected String telephone;//座机
	protected String weixin;//微信号
	protected String email;//邮箱
	protected String postcode;//邮编
	protected Date birthday;//生日
	protected String nationality;//国籍
	protected String detail;//简介
	protected String addressName;//区内详细地址
	protected Address homeAddress;//居住地
	protected Image image;//头像
	protected List<Image> images;//相册
	protected List<Role> roles;	//角色
	protected List<Right> rights;//直接获取权限，没有特定角色
	protected List<Article> talkArticles;//主动发起的帖子
	protected List<Article> replyArticles;//别人回复自己的帖子
	protected List<Forum> careForums;//自己关注的社交圈
	
	public static final int TYPE_USER=1;//平台会员
	public static final int TYPE_COACH=2;//平台入驻教练
	public static final int TYPE_COMPANY_MANAGER=3;//平台入驻商家管理员
	public static final int TYPE_HOST_MANAGER=4;//平台管理管理员
	//dto
	private int idType;//身份类别
	
	public Person(){}	
	
	@Id
	@GeneratedValue
	@Column(name="person_id")
	public int getId() {
		return id;
	}
	public Person setId(int id) {
		this.id = id;
		return this;
	}
	@OneToMany(fetch=FetchType.LAZY)
	public List<Role> getRoles() {
		return roles;
	}

	public Person setRoles(List<Role> roles) {
		this.roles = roles;
		return this;
	}
	@Column(nullable=false,unique=true)
	public String getUserName() {
		return userName;
	}
	public Person setUserName(String userName) {
		this.userName = userName;
		return this;
	}
	
	public String getPassword() {
		return password;
	}
	public Person setPassword(String password) {
		this.password = password;
		return this;
	}
	@Transient
	public String getPasswordConfirm() {
		return passwordConfirm;
	}

	public Person setPasswordConfirm(String passwordConfirm) {
		this.passwordConfirm = passwordConfirm;
		return this;
	}
	public String getRealName() {
		return realName;
	}
	public Person setRealName(String realName) {
		this.realName = realName;
		return this;
	}
	public String getSex() {
		return sex;
	}
	public Person setSex(String sex) {
		this.sex = sex;
		return this;
	}
	//@Column(unique=true)
	public String getPhone() {
		return phone;
	}
	public Person setPhone(String phone) {
		this.phone = phone;
		return this;
	}
	public String getTelephone() {
		return telephone;
	}
	//@Column(unique=true)
	public String getWeixin() {
		return weixin;
	}

	public Person setWeixin(String weixin) {
		this.weixin = weixin;
		return this;
	}

	public Person setTelephone(String telephone) {
		this.telephone = telephone;
		return this;
	}
	public String getEmail() {
		return email;
	}
	public Person setEmail(String email) {
		this.email = email;
		return this;
	}
	public String getPostcode() {
		return postcode;
	}
	public Person setPostcode(String postcode) {
		this.postcode = postcode;
		return this;
	}
	public Date getBirthday() {
		//birthday=DateFormatUtil.formatDay(birthday);
		return birthday;
	}
	public Person setBirthday(Date birthday) {
		//birthday=DateFormatUtil.formatDay(birthday);
		this.birthday = birthday;
		return this;
	}
	public String getNationality() {
		return nationality;
	}
	public Person setNationality(String nationality) {
		this.nationality = nationality;
		return this;
	}
	@Lob
	public String getDetail() {
		return detail;
	}
	public Person setDetail(String detail) {
		this.detail = detail;
		return this;
	}
	@OneToMany(fetch=FetchType.LAZY)
	public List<Right> getRights() {
		return rights;
	}

	public Person setRights(List<Right> rights) {
		this.rights = rights;
		return this;
	}
	
	@OneToOne(fetch=FetchType.EAGER)
	public Image getImage() {
		return image;
	}
	public Person setImage(Image image) {
		this.image = image;
		return this;
	}
	@OneToMany(fetch=FetchType.LAZY)
	public List<Image> getImages() {
		return images;
	}
	public Person setImages(List<Image> images) {
		this.images = images;
		return this;
	}
	@Transient
	public boolean isPasswordEqual(){
		if(password.trim().equals(passwordConfirm.trim()))
			return true;
		return false;
	}
	
	@OneToMany(fetch=FetchType.LAZY,cascade=CascadeType.ALL,mappedBy="talker")
	public List<Article> getTalkArticles() {
		return talkArticles;
	}

	public Person setTalkArticles(List<Article> talkArticles) {
		this.talkArticles = talkArticles;
		return this;
	}
	@OneToMany(fetch=FetchType.LAZY,cascade=CascadeType.ALL,mappedBy="responser")
	public List<Article> getReplyArticles() {
		return replyArticles;
	}

	public Person setReplyArticles(List<Article> replyArticles) {
		this.replyArticles = replyArticles;
		return this;
	}
	@OneToMany(fetch=FetchType.LAZY)
	public List<Forum> getCareForums() {
		return careForums;
	}

	public Person setCareForums(List<Forum> careForums) {
		this.careForums = careForums;
		return this;
	}

	public String getAddressName() {
		return addressName;
	}

	public Person setAddressName(String addressName) {
		this.addressName = addressName;
		return this;
	}
	@OneToOne(fetch=FetchType.LAZY)
	public Address getHomeAddress() {
		return homeAddress;
	}

	public Person setHomeAddress(Address homeAddress) {
		this.homeAddress = homeAddress;
		return this;
	}

	@Transient
	public int getIdType() {
		return idType;
	}
	
	public Person setIdType(int idType) {
		this.idType = idType;
		return this;
	}
}
