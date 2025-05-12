package com.mbc.pet.diary;

import com.mbc.pet.pet.PetDTO;
import com.mbc.pet.user.UserDTO;

public class DiaryDTO {
	
	int diary_id;
	String diary_title;
	String diary_date;
	String diary_image;
	String diary_content;
	
	int get_grape; // 글 작성 시 포도알이 적립되었는지 여부
	
	UserDTO petdto;
	PetDTO petuserdto;
	
	int user_id;
	int pet_id;
	
	String pet_name;
	
	
	public DiaryDTO() {          }

	public int getDiary_id() {
		return diary_id;
	}

	public void setDiary_id(int diary_id) {
		this.diary_id = diary_id;
	}

	public String getDiary_title() {
		return diary_title;
	}

	public void setDiary_title(String diary_title) {
		this.diary_title = diary_title;
	}

	public String getDiary_date() {
		return diary_date;
	}

	public void setDiary_date(String diary_date) {
		this.diary_date = diary_date;
	}

	public String getDiary_image() {
		return diary_image;
	}

	public void setDiary_image(String diary_image) {
		this.diary_image = diary_image;
	}

	public String getDiary_content() {
		return diary_content;
	}

	public void setDiary_content(String diary_content) {
		this.diary_content = diary_content;
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

	public int getGet_grape() {
		return get_grape;
	}

	public void setGet_grape(int get_grape) {
		this.get_grape = get_grape;
	}

	public UserDTO getPetdto() {
		return petdto;
	}

	public void setPetdto(UserDTO petdto) {
		this.petdto = petdto;
	}

	public PetDTO getPetuserdto() {
		return petuserdto;
	}

	public void setPetuserdto(PetDTO petuserdto) {
		this.petuserdto = petuserdto;
	}

	public String getPet_name() {
		return pet_name;
	}

	public void setPet_name(String pet_name) {
		this.pet_name = pet_name;
	}

	
}
