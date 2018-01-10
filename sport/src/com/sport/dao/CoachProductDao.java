package com.sport.dao;

import java.util.List;

import org.springframework.stereotype.Component;

import com.sport.entity.CoachProduct;

@Component
public class CoachProductDao extends RootDao {
	public void save(CoachProduct product) {
		hibernateTemplate.save(product);
	}

	public CoachProduct load(int id) {
		if (id < 1)
			return null;
		return (CoachProduct) hibernateTemplate.load(CoachProduct.class, id);
	}

	public CoachProduct load(CoachProduct product) {
		return load(product.getId());
	}

	public void delete(int id) {
		if (id < 1)
			return;
		delete((CoachProduct) new CoachProduct().setId(id));
	}

	public void delete(CoachProduct product) {

		hibernateTemplate.delete(product);

	}

	public void update(CoachProduct product) {
		hibernateTemplate.update(product);
	}

	// 分页查询
	public int findAll(List<CoachProduct> products, CoachProduct product,
			int pageNumber, int pageSize, String groupByColumn,
			String orderByColumn, boolean isAsc) {
		StringBuffer queryString = new StringBuffer(
				"from CoachProduct e where 1=1 ");
		try {

			if (product.isHasBargin())
				queryString.append(" and e.hasBargin=1");
			if (product.isHasTop())
				queryString.append(" and e.hasTop=1");
			if (product.isHasBegin())
				queryString.append(" and e.hasBegin=1");
			if (product.getCompany() != null) {
				queryString.append(" and e.company.id="
						+ product.getCompany().getId());
			}
			if (product.getType() != null) {
				queryString.append(" and e.type.id="
						+ product.getType().getId());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return find(queryString.toString(), products, pageNumber, pageSize,
				groupByColumn, orderByColumn, isAsc);
	}

}
