package com.sport.dao;

import java.util.List;

import org.springframework.stereotype.Component;

import com.sport.entity.Coach;
import com.sport.entity.Company;
import com.sport.entity.OrderItem;
import com.sport.entity.Place;

@Component
public class OrderItemDao extends RootDao {
	public void save(OrderItem item) {
		hibernateTemplate.save(item);
	}

	public OrderItem load(int id) {
		if (id < 1)
			return null;
		return hibernateTemplate.load(OrderItem.class, id);
	}

	public OrderItem load(OrderItem item) {
		return load(item.getId());
	}

	public void delete(int id) {
		if (id < 1)
			return;
		delete(new OrderItem().setId(id));
	}

	public void delete(OrderItem item) {

		hibernateTemplate.delete(item);

	}

	public void update(OrderItem item) {
		hibernateTemplate.update(item);
	}

	// 分页查询
	public int findAll(List<OrderItem> items, int pageNumber, int pageSize,
			String groupByColumn, String orderByColumn, boolean isAsc) {
		String queryString = "from OrderItem e ";
		return find(queryString, items, pageNumber, pageSize, groupByColumn,
				orderByColumn, isAsc);
	}

	public int findAll(List<OrderItem> items, int pageNumber, int pageSize) {

		return findAll(items, pageNumber, pageSize, null, null, true);
	}

	// 获取某个教练的所有订单
	public int findAllByCoach(List<OrderItem> items, Coach coach,
			int pageNumber, int pageSize, String groupByColumn,
			String orderByColumn, boolean isAsc) {
		String queryString = "from OrderItem e where e.coach.id="
				+ coach.getId();
		return find(queryString, items, pageNumber, pageSize, groupByColumn,
				orderByColumn, isAsc);
	}

	public int findAllByCoach(List<OrderItem> items, Coach coach,
			int pageNumber, int pageSize) {

		return findAllByCoach(items, coach, pageNumber, pageSize, null, null,
				true);
	}

	// 获取某个场地的所有订单
	public int findAllByPlace(List<OrderItem> items, Place place,
			int pageNumber, int pageSize, String groupByColumn,
			String orderByColumn, boolean isAsc) {
		String queryString = "from OrderItem e where e.place.id="
				+ place.getId();
		return find(queryString, items, pageNumber, pageSize, groupByColumn,
				orderByColumn, isAsc);
	}

	public int findAllByPlace(List<OrderItem> items, Place place,
			int pageNumber, int pageSize) {

		return findAllByPlace(items, place, pageNumber, pageSize, null, null,
				true);
	}

	// 获取某个公司的所有订单
	public int findAllByCompany(List<OrderItem> items, Company company,
			int pageNumber, int pageSize, String groupByColumn,
			String orderByColumn, boolean isAsc) {
		String queryString = "from OrderItem e where e.company.id="
				+ company.getId();
		return find(queryString, items, pageNumber, pageSize, groupByColumn,
				orderByColumn, isAsc);
	}

	public int findAllByCompany(List<OrderItem> items, Company company,
			int pageNumber, int pageSize) {
		return findAllByCompany(items, company, pageNumber, pageSize, null, null,
				true);
	}
}
