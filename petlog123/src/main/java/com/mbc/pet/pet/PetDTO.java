package com.mbc.pet.pet;

import com.mbc.pet.user.UserDTO;

public class PetDTO {

	int pet_id;
	String pet_name;
	String pet_bog; // 성별
	String pet_hbd; // 생일
	int user_id; //FK
	String pet_img;
	String pet_neuter;
	
	UserDTO userdto;

	public PetDTO() {     }

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

	public String getPet_bog() {
		return pet_bog;
	}

	public void setPet_bog(String pet_bog) {
		this.pet_bog = pet_bog;
	}

	public String getPet_hbd() {
		return pet_hbd;
	}

	public void setPet_hbd(String pet_hbd) {
		this.pet_hbd = pet_hbd;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public String getPet_img() {
		return pet_img;
	}

	public void setPet_img(String pet_img) {
		this.pet_img = pet_img;
	}

	public String getPet_neuter() {
		return pet_neuter;
	}

	public void setPet_neuter(String pet_neuter) {
		this.pet_neuter = pet_neuter;
	}

	public UserDTO getUserdto() {
		return userdto;
	}

	public void setUserdto(UserDTO userdto) {
		this.userdto = userdto;
	}
	
}
