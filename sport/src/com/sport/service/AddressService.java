package com.sport.service;

import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.sport.dao.AddressDao;
import com.sport.entity.Address;
import com.sport.exception.RootException;

@Component
public class AddressService extends RootService {
    private static final String ENTITY_NAME = "Address";

    private AddressDao addressDao;

    public AddressDao getAddressDao() {
        return addressDao;
    }

    @Resource
    public void setAddressDao(AddressDao addressDao) {
        this.addressDao = addressDao;
    }

    // 产品地区信息的增删改
    public void add(Address paddr) throws RootException, Exception {
        if (paddr == null || (paddr.getAddressName() == null || (paddr.getAddressName().trim().equals(""))))
            throw new RootException(RootException.NEED_MORE_ADD_INFO);
        addressDao.save(paddr);
    }

    public boolean delete(Address paddr) throws RootException, Exception {
        if (paddr == null || (paddr.getId() <= 0))
            throw new RootException(RootException.NEED_MORE_DELETE_INFO);
        // 先加载该地区所有信息
        paddr = addressDao.load(paddr);
        if (paddr == null)
            throw new RootException("不存在该地区!");
        // 如果为根地区,直接删除
        if (paddr.getParentAddress() == null)
            return addressDao.delete(paddr);
        // 先保存父节点信息
        Address ppaddr = paddr.getParentAddress();
        int size = ppaddr.getChildrenAddress().size();
        // 删除该节点
        boolean re = addressDao.delete(paddr);
        // 修改父节点状态
        if (size < 2) {
            ppaddr.setLeaf(true);
            addressDao.update(ppaddr);
        }
        return re;
    }

    public void update(Address paddr) throws RootException, Exception {
        if (paddr == null || (paddr.getId() <= 0))
            throw new RootException(RootException.NEED_MORE_UPDATE_INFO);
        int oldAddressId;
        try {
            // 如果更新的是根地区,则直接更新
            if (addressDao.load(paddr).getParentAddress() == null) {
                addressDao.update(paddr);
                return;
            }
            // 先加载到内存
            Address oldpaddr = addressDao.load(paddr);
            // 否则，需要判断是否更新父地区状态
            oldAddressId = oldpaddr.getParentAddress().getId();
            // 先将参数加载到paddr中,因为后面调用evict后,无法加载paddr
            oldpaddr.setAddressName(paddr.getAddressName()).setIntroduction(paddr.getIntroduction());
            addressDao.update(oldpaddr);
            // 如果修改该地区关联的父地区，就检查修改后对前后父地区的属性影响
            if (!(addressDao.load(oldpaddr.getParentAddress()).getId() == (oldAddressId))) {
                Address oldPPaddr = addressDao.load(oldAddressId);
                Address newPPaddr = addressDao.load(oldpaddr.getParentAddress().getId());
                if (oldPPaddr.getChildrenAddress() == null || oldPPaddr.getChildrenAddress().isEmpty())
                    oldPPaddr.setLeaf(true);
                addressDao.update(oldPPaddr);
                if (newPPaddr == null)
                    throw new RootException("不存在该父地区，请先添加！");
                newPPaddr.setLeaf(false);
                addressDao.update(newPPaddr);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    public Address load(Address paddr) throws RootException, Exception {
        if (paddr == null || (paddr.getId() <= 0))
            throw new RootException(RootException.NEED_MORE_FIND_INFO);
        return addressDao.load(paddr);
    }

    // 查询操作
    // 查询所有根地区
    public List<Address> findRootAddrs() {
        return addressDao.loadRootAddress();
    }

    // 查询某根地区下的所有子地区集
    public List<Address> findChildAddress(Address addr) throws RootException, Exception {
        List<Address> addrs = new ArrayList<Address>();
        addrs = findChildAddress(addr.getId());
        return addrs;
    }

    public List<Address> findChildAddress(int id) throws RootException, Exception {
        if (id == -1)
            return addressDao.loadRootAddress();
        return addressDao.load(id).getChildrenAddress();
    }

    public List<Address> findCityAddress() throws RootException, Exception {
        return addressDao.findCityAddress();
    }

    // 简化客服端编程操作
    // 设置父子结点之间的默认关联属性
    public void initRelation(Address parentAddress, Address addr) {
        if (parentAddress == null) {
            addr.setParentAddress(null);
            addr.setGrade(0);
            addr.setLeaf(true);
            addr.setChildrenAddress(null);
        } else {
            parentAddress = addressDao.load(parentAddress);
            addr.setParentAddress(parentAddress);
            addr.setGrade(parentAddress.getGrade() + 1);
            addr.setLeaf(true);
            parentAddress.setLeaf(false);
            addr.setChildrenAddress(null);
        }
    }

    // 默认方式查询某产品地区的子地区集信息，分页查看
    public int findByAddress(List<Address> addrs, Address addr, int pageNumber, int pageSize) {
        return addressDao.findAll(addrs, addr, pageNumber, pageSize);
    }

    // 按某列排序查看某产品地区的子地区集信息
    public int findByAddress(List<Address> addrs, Address addr, int pageNumber, int pageSize, String orderByColumn, boolean isAsc) {
        return addressDao.findAll(addrs, addr, pageNumber, pageSize, orderByColumn, isAsc);
    }

    // 按某列排序查看某产品地区的子地区集信息
    public int findRootAddrs(List<Address> addrs, int pageNumber, int pageSize) {
        return addressDao.findRootAddrs(addrs, pageNumber, pageSize);
    }

    public boolean deleteSelectedAddrs(String ids) {
        return addressDao.deleteEntitys(ENTITY_NAME, ids);
    }
}
