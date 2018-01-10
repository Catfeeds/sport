package com.sport.action;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import net.sf.json.JSONArray;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.sport.entity.Event;
import com.sport.entity.Image;
import com.sport.entity.Person;
import com.sport.exception.PromptException;
import com.sport.exception.RootException;
import com.sport.exception.ServerErrorException;
import com.sport.service.EventService;
import com.sport.service.ImageService;
import com.sport.service.PersonService;

//赛事子操作
@Component
@Scope("prototype")
public class EventAction extends RootAction {
	private Event event;
	private List<Event> events;
	private EventService eventService;
	private Person owner;// 赛事圈主	
	private PersonService personService;	
	// 上传
	File file;
	String fileContentType;
	String fileFileName;
	private ImageService imageService;
	
	// 添加一个赛事,同时需要设置当前登录用户为赛事圈主
	public String addEvent() throws PromptException, ServerErrorException {
		try {
			// 如果要上传公司logo
			if (file != null) {
				if (file.canRead() && (file.isFile()) && (file.exists())) {
					String webDir = "/upload/file/companyInfo";
					String savePath = ServletActionContext.getServletContext()
							.getRealPath(webDir);
					fileFileName = "logo" +fileFileName;
					Image image = imageService.saveFile(file, savePath, webDir,
							fileFileName);
					if (image != null)
						event.setImage(image);
				}
			}
			
			eventService.add(event);
			event=eventService.load(event);
		} catch (RootException e) {
			e.printStackTrace();
			errorMsg = e.toString();
			throw new PromptException(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "eventDetail";
	}

	// 查看某赛事详情
	public String eventDetail() throws PromptException, ServerErrorException {
		try {
			event = eventService.load(event);
		} catch (RootException e) {
			e.printStackTrace();
			errorMsg = e.toString();
			throw new PromptException(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "eventDetail";
	}

	// 修改某赛事基本信息
	public String alterEvent() throws PromptException, ServerErrorException {
		try {
			// 如果要修改公司logo
			if (file != null) {
				if (file.canRead() && (file.isFile()) && (file.exists())) {
					String webDir = "/upload/file/companyInfo";
					String savePath = ServletActionContext.getServletContext()
							.getRealPath(webDir);
					fileFileName = "logo" + new Date().getTime() + fileFileName;
					Image image = imageService.saveFile(file, savePath, webDir,
							fileFileName);
					if (image != null)
						event.setImage(image);
				}
			}
			eventService.update(event);
		} catch (RootException e) {
			e.printStackTrace();
			errorMsg = e.toString();
			throw new PromptException(errorMsg);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		eventList();
		return "eventList";
	}

	// 删除某赛事
	public void deleteEvent() throws PromptException, ServerErrorException {
		this.getResponseAndOut();
		JSONArray json=new JSONArray();
		try {
			eventService.delete(event);
			json.add(true);
		} catch (RootException e) {
			json.add(false);
			json.add(e.toString());
		} catch (Exception e) {
			e.printStackTrace();
			json.add(false);
			json.add(RootException.SYSTEM_ERROR);
		}
		out.println(json);
		this.closeOut();
		
	}

	// 查看某种分类信息的赛事
	public String eventList() throws ServerErrorException {
		try {
			events = new ArrayList<Event>();
			page.setTotalItemNumber(eventService.findAll(events, event,
					page.getPageNumber(), page.getPageSize()));
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "eventList";
	}
	public void deleteSelectedEvent() throws ServerErrorException{
		this.getResponseAndOut();
		JSONArray json = new JSONArray();
		try {
			eventService.deleteSelectedEvents(ids);
			json.add(true);
		} catch (Exception e) {
			e.printStackTrace();
			json.add(false);
			json.add(RootException.SYSTEM_ERROR);
		}
		out.println(json);
		this.closeOut();
	}
	/********** 注入代码 **********/
	

	public Person getOwner() {
		return owner;
	}

	public void setOwner(Person owner) {
		this.owner = owner;

	}

	
	public PersonService getPersonService() {
		return personService;
	}

	@Resource
	public void setPersonService(PersonService personService) {
		this.personService = personService;

	}

	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
	}

	public String getFileContentType() {
		return fileContentType;
	}

	public void setFileContentType(String fileContentType) {
		this.fileContentType = fileContentType;
	}

	public String getFileFileName() {
		return fileFileName;
	}

	public void setFileFileName(String fileFileName) {
		this.fileFileName = new Date().getTime() + fileFileName;
	}

	public ImageService getImageService() {
		return imageService;
	}

	@Resource
	public void setImageService(ImageService imageService) {
		this.imageService = imageService;
	}

	public Event getEvent() {
		return event;
	}

	public void setEvent(Event event) {
		this.event = event;
		
	}

	public List<Event> getEvents() {
		return events;
	}

	public void setEvents(List<Event> events) {
		this.events = events;
	}

	public EventService getEventService() {
		return eventService;
	}
	@Resource
	public void setEventService(EventService eventService) {
		this.eventService = eventService;
	}
	
}
