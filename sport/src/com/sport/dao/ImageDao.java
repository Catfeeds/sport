package com.sport.dao;

import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Component;

import com.sport.entity.Image;
import com.sport.entity.Image;
import com.sport.entity.Image;
import com.sport.util.FileUtil;

@Component
public class ImageDao extends RootDao {
	//产品分类的增删改、获取
		public void save(Image image){
			hibernateTemplate.persist(image);
		}
		
		public Image load(int id){
			if(id<1)
				return null;
			return (Image)hibernateTemplate.get(Image.class, id);
		}
		
		public Image load(String pathName){
			@SuppressWarnings("unchecked")
			List<Image> types=(List<Image>)hibernateTemplate.getSessionFactory()
					.getCurrentSession().createCriteria(Image.class)
					.add(Restrictions.eq("pathName", pathName))
					.list();
			if(types.isEmpty())
				return null;
			else
				return types.get(0);
		}
		public Image loadFromDisk(String diskName){
			@SuppressWarnings("unchecked")
			List<Image> types=(List<Image>)hibernateTemplate.getSessionFactory()
					.getCurrentSession().createCriteria(Image.class)
					.add(Restrictions.eq("diskName", diskName))
					.list();
			if(types.isEmpty())
				return null;
			else
				return types.get(0);
		}
		public Image load(Image image){
			Image typeTemp=load(image.getPathName());
			if(typeTemp==null)
				typeTemp=load(image.getId());
			if(typeTemp==null)
				typeTemp=loadFromDisk(image.getDiskName());
			return typeTemp;
		}
		
		public boolean delete(String pathName){
			Image image=load(pathName);
			return delete(image.getId());
		}
		
		public boolean delete(int id){
			if(id<1)
				return false;
			boolean re=true;
			if(load(id)!=null)
				hibernateTemplate.delete(load(id));
			else
				re=false;		
			return re;
		}
		
		public boolean delete(Image image) throws Exception{
			boolean re=true;
			if((image=load(image))!=null)
			{
				hibernateTemplate.delete(image);
				FileUtil.deleteFile(image.getDiskName());
			}
			else
				re=false;
			return re;
		}
		
		public void update(Image image){
			hibernateTemplate.update(image);
		}
		
		public  int findAll(List<Image> images,
				int pageNumber,
				int pageSize,
				String groupByColumn,
				String orderByColumn,
				boolean isAsc){
			String queryString="from Image e ";
			return find(queryString, images,pageNumber,pageSize,groupByColumn,orderByColumn,isAsc);
		}
		public int findAll(List<Image> images,
				int pageNumber,
				int pageSize
				){
			
			return findAll(images,pageNumber,pageSize,null,null,true);
		}

		

		
}
