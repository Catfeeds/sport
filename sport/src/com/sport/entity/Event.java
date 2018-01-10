package com.sport.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;

@Entity
public class Event  implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private String title;//标题
	private String author;//作者名字
	private String content;//内容
	private String imgPath;//图片路径
	private Date time;//时间
	//private Person person;//作者对象
	private Image image;//封面图
	public Event(){
		
	}
	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}
	public Event setId(int id) {
		this.id = id;
		return this;
	}
	public String getAuthor() {
		return author;
	}
	public Event setAuthor(String author) {
		this.author = author;
		return this;
	}
	@Column(name="event_title")
	public String getTitle() {
		return title;
	}
	public Event setTitle(String title) {
		this.title = title;
		return this;
	}
	@Column(name="event_content")
	public String getContent() {
		return content;
	}
	public Event setContent(String content) {
		this.content = content;
		return this;
	}
	@Column(name="img_path")
	public String getImgPath() {
		return imgPath;
	}
	public Event setImgPath(String imgPath) {
		this.imgPath = imgPath;
		return this;
	}
	public Date getTime() {
		return time;
	}
	public Event setTime(Date time) {
		this.time = time;
		return this;
	}
	
	@OneToOne(fetch=FetchType.EAGER,cascade=CascadeType.ALL)
	public Image getImage() {
		return image;
	}
	public Event setImage(Image image) {
		this.image = image;
		if(image!=null)
			this.imgPath=new String(image.getPathName());
		return this;
	}
	
	
	
}
