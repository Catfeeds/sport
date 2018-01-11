package com.sport.dao;

import java.util.List;

import org.springframework.stereotype.Component;

import com.sport.entity.Discount;

@Component
public class DiscountDao extends RootDao {
    public void save(Discount discount) {
        hibernateTemplate.save(discount);
    }

    public Discount load(int id) {
        if (id < 1)
            return null;
        return (Discount) hibernateTemplate.load(Discount.class, id);
    }

    public Discount load(Discount discount) {
        return load(discount.getId());
    }

    public void delete(int id) {
        if (id < 1)
            return;
        delete(new Discount().setId(id));
    }

    public void delete(Discount discount) {

        hibernateTemplate.delete(discount);

    }

    public void update(Discount discount) {
        hibernateTemplate.update(discount);
    }

    //分页查询
    public int findAll(List<Discount> discounts, Discount discount, int pageNumber, int pageSize, String groupByColumn,
            String orderByColumn, boolean isAsc) {
        StringBuffer queryString = new StringBuffer("from Discount e where e.discountStatus=" + discount.getDiscountStatus());
        if (discount.getCoach() != null) {
            queryString.append(" and e.coach.id=" + discount.getCoach().getId() + "  ");
        }
        if (discount.getSite() != null) {
            queryString.append(" and e.site.id=" + discount.getSite().getId() + "  ");
        }
        if (discount.getType() == Discount.TYPE_COACH) {
            queryString.append(" and e.type=" + discount.getType() + "  ");
        }
        if (discount.getType() == Discount.TYPE_SITE) {
            queryString.append(" and e.type=" + discount.getType() + "  ");
        }

        return find(queryString.toString(), discounts, pageNumber, pageSize, groupByColumn, "beginDate", false);
    }

    public void findAll(List<Discount> discounts, Discount discount, int pageNumber, int pageSize) {
        findAll(discounts, discount, pageNumber, pageSize, null, null, true);
    }
}
