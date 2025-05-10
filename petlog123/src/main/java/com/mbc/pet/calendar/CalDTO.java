package com.mbc.pet.calendar;

public class CalDTO {
	
	int cal_id;
	String cal_title;
	String cal_content;
	String cal_date;
	
	int user_id;
	int pet_id;
	String pet_name;
	
	public CalDTO() {    }

	public int getCal_id() {
		return cal_id;
	}
	
	public void setCal_id(int cal_id) {
		this.cal_id = cal_id;
	}

	public String getCal_title() {
		return cal_title;
	}

	public void setCal_title(String cal_title) {
		this.cal_title = cal_title;
	}

	public String getCal_content() {
		return cal_content;
	}

	public void setCal_content(String cal_content) {
		this.cal_content = cal_content;
	}

	public String getCal_date() {
		return cal_date;
	}

	public void setCal_date(String cal_date) {
		this.cal_date = cal_date;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public int getPet_id() {
		return pet_id;
	}

	public void setPet_id(int pet_id) {
		this.pet_id = pet_id;
	}

	public String getPet_name() {
		return pet_name;
	}

	public void setPet_name(String pet_name) {
		this.pet_name = pet_name;
	}

}
