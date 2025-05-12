package com.mbc.pet.snack;

import com.mbc.pet.user.UserDTO;

public class SnackDTO {
	
	int snack_id;
	String snack_title;
	String snack_recipe;
	String snack_image;
	String snack_date;
	int snack_readcnt;
	int comment_count;
	int like_count;

	String get_grape; 
	UserDTO petuserdto;

	int user_id;
	String user_login_id;
	
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

	public String getGet_grape() {
		return get_grape;
	}

	public void setGet_grape(String get_grape) {
		this.get_grape = get_grape;
	}

	public String getUser_login_id() {
		return user_login_id;
	}

	public void setUser_login_id(String user_login_id) {
		this.user_login_id = user_login_id;
	}

	public int getSnack_readcnt() {
		return snack_readcnt;
	}

	public void setSnack_readcnt(int snack_readcnt) {
		this.snack_readcnt = snack_readcnt;
	}

	public int getComment_count() {
		return comment_count;
	}

	public void setComment_count(int comment_count) {
		this.comment_count = comment_count;
	}

	public int getLike_count() {
		return like_count;
	}

	public void setLike_count(int like_count) {
		this.like_count = like_count;
	}
	
}
