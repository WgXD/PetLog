package com.mbc.pet.snack;

import com.mbc.pet.user.UserDTO;

public class SnackDTO {
	
	int snack_id;
	String snack_title;
	String snack_recipe;
	String snack_image;
	String snack_date;
	
	UserDTO petuserdto; //user_ID 가져오려면 필요
	int user_id;
	
	public SnackDTO() {     }

	public int getSnack_id() {
		return snack_id;
	}

	public void setSnack_id(int snack_id) {
		this.snack_id = snack_id;
	}

	public String getSnack_title() {
		return snack_title;
	}

	public void setSnack_title(String snack_title) {
		this.snack_title = snack_title;
	}

	public String getSnack_recipe() {
		return snack_recipe;
	}

	public void setSnack_recipe(String snack_recipe) {
		this.snack_recipe = snack_recipe;
	}

	public String getSnack_image() {
		return snack_image;
	}

	public void setSnack_image(String snack_image) {
		this.snack_image = snack_image;
	}

	public String getSnack_date() {
		return snack_date;
	}

	public void setSnack_date(String snack_date) {
		this.snack_date = snack_date;
	}

	public UserDTO getPetuserdto() {
		return petuserdto;
	}

	public void setPetuserdto(UserDTO petuserdto) {
		this.petuserdto = petuserdto;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	
}
