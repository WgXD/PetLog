package com.mbc.pet.place;


public class PlaceDTO {
	
	String place_phone;
	String place_name;
	String place_address;
	String thumbnail;
	String category;
	String place_latitude;
	String place_longitude;
	int place_id;
	int rate;
	
	public PlaceDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public int getRate() {
		return rate;
	}
	public void setRate(int rate) {
		this.rate = rate;
	}
	public String getPlace_phone() {
		return place_phone;
	}

	public void setPlace_phone(String place_phone) {
		this.place_phone = place_phone;
	}

	public String getPlace_name() {
		return place_name;
	}

	public void setPlace_name(String place_name) {
		this.place_name = place_name;
	}

	public String getPlace_address() {
		return place_address;
	}

	public void setPlace_address(String place_address) {
		this.place_address = place_address;
	}

	public String getThumbnail() {
		return thumbnail;
	}

	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getPlace_latitude() {
		return place_latitude;
	}

	public void setPlace_latitude(String place_latitude) {
		this.place_latitude = place_latitude;
	}

	public String getPlace_longitude() {
		return place_longitude;
	}

	public void setPlace_longitude(String place_longitude) {
		this.place_longitude = place_longitude;
	}

	public int getPlace_id() {
		return place_id;
	}

	public void setPlace_id(int place_id) {
		this.place_id = place_id;
	}
}
