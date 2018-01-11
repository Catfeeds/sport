package com.sport.dao;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Component;

@Component
public class RootDao {
    /*
     * 所有DAO类全继承此根类，用来获取HibernateTemplate类的注入
     */
    protected HibernateTemplate hibernateTemplate;

    public HibernateTemplate getHibernateTemplate() {
        return hibernateTemplate;
    }

    @Resource
    public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
        this.hibernateTemplate = hibernateTemplate;
    }

    // 为所有子类添加分页查询、按某列排序、分组等功能
    //	@SuppressWarnings("unchecked")
    @SuppressWarnings("unchecked")
    public <T> int find(String queryString, List<T> members, int pageNumber, int pageSize, String groupByColumn, String orderByColumn,
            boolean isAsc) {
        try {
            // 分组
            if (groupByColumn == null || groupByColumn.trim().equals(""))
                ;
            else
                queryString += " group by e." + groupByColumn;
            // 排序
            if (orderByColumn == null || orderByColumn.trim().equals(""))
                ;
            else
                queryString += " order by e." + orderByColumn + (isAsc ? " asc" : " desc");
            // 获取总的记录数
            int count = hibernateTemplate.find(queryString).size();

            List<T> copyMembers = null;
            copyMembers = (List<T>) (hibernateTemplate.getSessionFactory().getCurrentSession().createQuery(queryString)
                    .setFirstResult((pageNumber - 1) * pageSize).setMaxResults(pageSize).list());
            System.out.println("inner" + copyMembers.size() + "entitys:" + members);
            // 将查询得到的对象数组添加到我们传入的List对象中
            members.addAll(copyMembers);

            return count;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    //将所有po同步到数据库
    public void flush() {
        hibernateTemplate.flush();
    }

    //由于该po不止一个，需要清除一些
    public void evict(Object e) {
        hibernateTemplate.evict(e);
    }

    public boolean deleteEntitys(String entityName, String ids) {//无级联删除，可以用此方法直接删除
        String sql = "delete " + entityName + " e  where e.id in (";
        sql += ids;
        sql += ")";
        Query query = hibernateTemplate.getSessionFactory().getCurrentSession().createQuery(sql);
        if (query.executeUpdate() > 0)
            return true;
        return false;
    }

    /*******************修改实体常见字段通用方法*****************/
    //执行更新实体的HQL语句
    protected boolean update(String sql) {
        Query query = hibernateTemplate.getSessionFactory().getCurrentSession().createQuery(sql);
        if (query.executeUpdate() > 0)
            return true;
        return false;
    }

    //更新常见字符串字段
    //修改字符串类型的字段
    public boolean alterColString(String entityName, int id, String colName, String colValue) {
        String sql = "update " + entityName + " e set e." + colName + "=? where e.id = " + id;
        System.out.println(sql);
        Query query = hibernateTemplate.getSessionFactory().getCurrentSession().createQuery(sql).setString(0, colValue);
        if (query.executeUpdate() > 0)
            return true;
        return false;
    }

    //利用自动装箱后tostring方法
    public boolean alterColNumber(String entityName, int id, String colName, String colValue) {
        String sql = "update " + entityName + " e set e." + colName + "= " + colValue + " where e.id = " + id;
        System.out.println(sql);
        return update(sql);
    }

    //修改日期类型的字段
    public boolean alterDate(String entityName, int id, String colName, Date date) {
        System.out.println(date);
        String sql = "update " + entityName + " e set e." + colName + "=? where e.id = " + id;
        Query query = hibernateTemplate.getSessionFactory().getCurrentSession().createQuery(sql).setDate(0, date);
        if (query.executeUpdate() > 0)
            return true;
        return false;
    }

}
