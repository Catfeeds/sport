package com.sport.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.sport.dao.CoachCostDao;
import com.sport.dao.CoachDao;
import com.sport.dao.PersonDao;
import com.sport.dao.UpdateProgressDao;
import com.sport.dto.ComplexSearchCondition;
import com.sport.entity.CoachCost;
import com.sport.entity.CoachProduct;
import com.sport.entity.Company;
import com.sport.entity.Coach;
import com.sport.entity.CoachPreOrder;
import com.sport.entity.UpdateProgress;
import com.sport.exception.PromptException;
import com.sport.exception.RootException;
import com.sport.timer.TimerTaskQueue;

@Component
public class CoachService extends PersonService {
	private static final String ENTITY_NAME = "Coach";
	private CoachDao coachDao;
	private CoachPreOrderService  coachPreOrderService;
	private UpdateProgressDao updateProgressDao;
	private CoachCostDao coachCostDao;
	public CoachDao getCoachDao() {
		return coachDao;
	}

	@Resource
	public void setCoachDao(CoachDao coachDao) {
		this.coachDao = coachDao;
	}

	// 添加教练
	public boolean add(Coach c) throws RootException {
		if (c == null)
			throw new RootException(RootException.NEED_MORE_ADD_INFO);
		if (null != personDao.loadByPhone(c.getPhone()))
			throw new PromptException(PromptException.PHONE_EXISTS);
		if (null != personDao.loadByWeixin(c.getWeixin()))
			throw new PromptException(PromptException.WEIXIN_EXISTS);
		if(c.getAddrs()!=null){
			if(c.getAddrs().size()>Coach.MAX_ACTIVE_ADDRESS)
				throw new PromptException("对不起，您最多只能添加 "+Coach.MAX_ACTIVE_ADDRESS+"个活动区域!");
		}
		// 需要分配教练的基本权限信息
		
		//需要为教练所选择的教练服务初始化为该服务产品的收费标准,后面可以具体修改这些收费标准		
		if(c.getCoachProducts()!=null){
			List<CoachCost> costs=new ArrayList<CoachCost>();
			int i=0;
			for(CoachProduct p:c.getCoachProducts()){				
				CoachCost cost=new CoachCost().setCoach(c).setProduct(p);
				cost.setTimePrice(c.getCosts()[i]);
				costs.add(cost);
				i++;
			}
			if(costs!=null&&(costs.size()>0))
				c.setCoachCosts(costs);
			else{
				c.setCoachCosts(null);
			}
		}else{
			c.setCoachCosts(null);
		}
		
		c.setId(0);
		c.setTotalSoldNumber(0).setScore(5);
		boolean re=coachDao.save(c);
		coachDao.flush();
		this.initPreOrder(c);
		return re;
	}
	//初始化该教练的预定信息
	public void initPreOrder(Coach coach) throws RootException{
		UpdateProgress update = updateProgressDao.load();
		if(update==null)//如果还从未更新过预定信息，则本次也不用更新，等系统统一更新
			return;		
		Calendar date = Calendar.getInstance();		
		int updateDayNumber = update.getUpdateDayNumber();// 需要初始化更新该场地的预定信息		
		long tempDate = date.getTimeInMillis();
		for (int k = 0; k < updateDayNumber; k++) {//
			CoachPreOrder pOrder = new CoachPreOrder();
			date.set(date.get(Calendar.YEAR), date.get(Calendar.MONTH),
					date.get(Calendar.DAY_OF_MONTH));

			long time = date.getTimeInMillis();
			System.out.println("time:" + time);
			time += TimerTaskQueue.SCHEDULE * k;// 定位到某天
			date.setTime(new Date(time));
			pOrder.setCoach(coach)
					.setDate(date.getTime())
					.setUnionOrderInfos(coach.getEmployNumber());
			coachPreOrderService.add(pOrder);
			date.setTime(new Date(tempDate));
		}
	}
	/**更新少量信息，先加载再更新*/
	public void updateCoach(Coach c) throws RootException {
		if (c == null || c.getId() <= 0)
			throw new RootException(RootException.NEED_MORE_UPDATE_INFO);
		coachDao.update(c);
	}
	/** 所有信息更新教练信息*/
	public void alterCoach(Coach c) throws RootException {
		if (c == null || c.getId() <= 0)
			throw new RootException(RootException.NEED_MORE_UPDATE_INFO);
		Coach oldCoach=coachDao.load(c);
		oldCoach.setBaseCostPrice(c.getBaseCostPrice())
				.setTopValue(c.getTopValue())
				.setBasePrice(c.getBasePrice())
				.setEmployNumber(c.getEmployNumber())
				.setIntroduction(c.getIntroduction())
				.setDayJobTime(c.getDayJobTime())
				.setWeekJobTime(c.getWeekJobTime())
				.setAddrs(c.getAddrs())
				.setAddressName(c.getAddressName())
				.setBirthday(c.getBirthday())
				.setDetail(c.getDetail())
				.setEmail(c.getEmail())
				.setNationality(c.getNationality())
				.setPhone(c.getPhone())
				.setPostcode(c.getPostcode())
				.setRealName(c.getRealName())
				.setSex(c.getSex())
				.setTelephone(c.getTelephone())
				.setWeixin(c.getWeixin())
				;
		if(c.getPassword()!=null&&(!c.getPassword().trim().equals("")))
			oldCoach.setPassword(c.getPassword());
		if(c.getSkillType()!=null)
			oldCoach.setSkillType(c.getSkillType());
		if(c.getHomeAddress()!=null)
			oldCoach.setHomeAddress(c.getHomeAddress());		
		if(c.getImage()!=null)
			oldCoach.setImage(c.getImage());
		if(oldCoach.getCertificates()!=null){
			if(c.getCertificates()!=null)
				oldCoach.getCertificates().addAll(c.getCertificates());
		}else{
			if(c.getCertificates()!=null)
				oldCoach.setCertificates(c.getCertificates());
		}
		if(oldCoach.getImages()!=null){
			if(c.getImages()!=null)
				oldCoach.getImages().addAll(c.getImages());
		}else{
			if(c.getImages()!=null)
				oldCoach.setImages(c.getImages());
		}
		if(oldCoach.getPhotoes()!=null){
			if(c.getPhotoes()!=null)
				oldCoach.getPhotoes().addAll(c.getPhotoes());
		}else{
			if(c.getPhotoes()!=null)
				oldCoach.setPhotoes(c.getPhotoes());
		}
		//先删除教练收费标准
		oldCoach.setCoachCosts(null);
		if(oldCoach.getCoachCosts()!=null&&(oldCoach.getCoachCosts().size()>0)){
			for(CoachCost cost:oldCoach.getCoachCosts())
				coachCostDao.delete(cost);
		}
		//需要为教练所选择的教练服务初始化为该服务产品的收费标准,后面可以具体修改这些收费标准		
		if(c.getCoachProducts()!=null){
			List<CoachCost> costs=new ArrayList<CoachCost>();
			int i=0;
			for(CoachProduct p:c.getCoachProducts()){				
				CoachCost cost=new CoachCost().setCoach(oldCoach).setProduct(p);
				cost.setTimePrice(c.getCosts()[i]);
				costs.add(cost);
				i++;
			}
			oldCoach.setCoachCosts(costs).setCoachProducts(c.getCoachProducts());
		}
		c.setId(0);
		coachDao.update(oldCoach);
	}

	// 删除某教练
	public boolean deleteCoach(Coach c) throws RootException {
		if (c == null
				|| (c.getId() <= 0
						&& (c.getUserName() == null || c.getUserName().trim()
								.equals("")) && (c.getWeixin() == null || (c
						.getWeixin().trim().equals("")))))
			throw new RootException(RootException.NEED_MORE_DELETE_INFO);
		if (coachDao.load(c) != null)
			coachDao.delete(c);
		else
			return false;
		return true;
	}

	// 加载某教练信息
	public Coach findCoach(Coach c) throws RootException {
		if (c == null)
			throw new RootException(RootException.NEED_MORE_FIND_INFO);
		return coachDao.load(c);
	}

	public Coach findCoach(String userName) throws RootException {
		if (userName == null || userName.trim().equals(""))
			throw new RootException(RootException.NEED_MORE_FIND_INFO);
		return coachDao.load(userName);
	}

	/************** 教练管理会员信息 **********************/
	// 默认方式查询所有教练信息，分页查看
	public int findAll(List<Coach> coachs, Coach coach, int pageNumber,
			int pageSize) {
		return coachDao.findAll(coachs, coach, pageNumber, pageSize);
	}

	// 按某列排序查看教练信息
	public int findAll(List<Coach> coachs, Coach coach, int pageNumber,
			int pageSize, String orderByColumn, boolean isAsc) {
		return coachDao.findAll(coachs, coach, pageNumber, pageSize,
				null, orderByColumn, isAsc);
	}
	// 默认方式查询所有教练信息，分页查看
		public int findAll(List<Coach> coachs,  int pageNumber,
				int pageSize) {
			return coachDao.findAll(coachs,  pageNumber, pageSize);
		}

		// 按某列排序查看教练信息
		public int findAll(List<Coach> coachs,  int pageNumber,
				int pageSize, String orderByColumn, boolean isAsc) {
			return coachDao.findAll(coachs,  pageNumber, pageSize,
					null, orderByColumn, isAsc);
		}

	// 教练登录验证
	public boolean login(String userName, String password) {
		Coach u = coachDao.load(userName);
		if (u != null && (u.getPassword().equals(password)))
			return true;
		return false;
	}

	public boolean deleteSelectedCoachs(String ids, Company company)
			throws PromptException {
		// return coachDao.deleteEntitys(ENTITY_NAME,ids);
		String idStrArr[] = ids.split("\\W");
		int id = 0;
		for (String str : idStrArr) {
			if (str.equals("1") || (str.trim().equals("")))
				continue;
			try {
				id = Integer.valueOf(str);
				System.out.println("产品Id：" + id);
				Coach c = coachDao.load(id);
				if (null == coachDao.loadCompanyCoach(c))
					throw new PromptException("你的公司不存在该教练，无法删除！");
				deleteCoach(c);
			} catch (Exception e) {
				e.printStackTrace();
				throw new PromptException("删除教练失败！请检查您公司是否存在该教练，若存在，请重试！");
			}
		}
		return true;
	}
	public CoachPreOrderService getCoachPreOrderService() {
		return coachPreOrderService;
	}
	@Resource
	public void setCoachPreOrderService(CoachPreOrderService coachPreOrderService) {
		this.coachPreOrderService = coachPreOrderService;
	}
	public UpdateProgressDao getUpdateProgressDao() {
		return updateProgressDao;
	}
	@Resource
	public void setUpdateProgressDao(UpdateProgressDao updateProgressDao) {
		this.updateProgressDao = updateProgressDao;
	}

	public CoachCostDao getCoachCostDao() {
		return coachCostDao;
	}
	@Resource
	public void setCoachCostDao(CoachCostDao coachCostDao) {
		this.coachCostDao = coachCostDao;
		
	}

	public int simpleSearchedPlaceProducts(ComplexSearchCondition condition,
			List<Coach> coachs, int pageNumber, int pageSize) {
		return coachDao.simpleSearchedPlaceProducts(condition,coachs,pageNumber,pageSize);
	}

	public int searchedPlaceProducts(ComplexSearchCondition condition,
			List<Coach> coachs, int pageNumber, int pageSize) {
		return coachDao.searchedPlaceProducts(condition,coachs,pageNumber,pageSize);
	}

}
