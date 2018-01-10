package com.sport.dto;

import java.util.ArrayList;
import java.util.List;

import com.sport.entity.Address;

public class AddressInfo {
	private int id;
	private String addressName;
	private String introduction;
	public AddressInfo(){}
	public AddressInfo(Address address){
		this.id=address.getId();
		this.addressName=address.getAddressName();
		this.introduction=address.getIntroduction();
	}
	public static List<AddressInfo> fromAddresss(List<Address> addresss){
		List<AddressInfo> infos=new ArrayList<AddressInfo>();
		for(Address address:addresss)
		{
			infos.add(new AddressInfo(address));
		}
		return infos;
	}
	public int getId() {
		return id;
	}
	public AddressInfo setId(int id) {
		this.id = id;
		return this;
	}
	public String getAddressName() {
		return addressName;
	}
	public AddressInfo setAddressName(String addressName) {
		this.addressName = addressName;
		return this;
	}
	public String getIntroduction() {
		return introduction;
	}
	public AddressInfo setIntroduction(String introduction) {
		this.introduction = introduction;
		return this;
	}
}
