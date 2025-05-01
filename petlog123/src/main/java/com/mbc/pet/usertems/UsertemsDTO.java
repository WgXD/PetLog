package com.mbc.pet.usertems;

import com.mbc.pet.items.ItemsDTO;
import com.mbc.pet.user.UserDTO;

public class UsertemsDTO {
	
	int usertem_id;
	String usertem_equip; //Âø¿ë¿©ºÎ boolean X, StringÀ¸·Î
	
	UserDTO petuserdto;
	ItemsDTO itemsdto;
	
	int item_id;
	int user_id;
	
	//Items¶û join
	String item_name;
	String item_category;
	String item_image;
	//
	
	public UsertemsDTO() {     }

	public int getUsertem_id() {
		return usertem_id;
	}

	public void setUsertem_id(int usertem_id) {
		this.usertem_id = usertem_id;
	}

	public String getUsertem_equip() {
		return usertem_equip;
	}

	public void setUsertem_equip(String usertem_equip) {
		this.usertem_equip = usertem_equip;
	}

	public UserDTO getPetuserdto() {
		return petuserdto;
	}

	public void setPetuserdto(UserDTO petuserdto) {
		this.petuserdto = petuserdto;
	}

	public ItemsDTO getItemsdto() {
		return itemsdto;
	}

	public void setItemsdto(ItemsDTO itemsdto) {
		this.itemsdto = itemsdto;
	}

	public int getItem_id() {
		return item_id;
	}

	public void setItem_id(int item_id) {
		this.item_id = item_id;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public String getItem_name() {
		return item_name;
	}

	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}

	public String getItem_category() {
		return item_category;
	}

	public void setItem_category(String item_category) {
		this.item_category = item_category;
	}

	public String getItem_image() {
		return item_image;
	}

	public void setItem_image(String item_image) {
		this.item_image = item_image;
	}	
	
	

}
