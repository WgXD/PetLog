package com.mbc.pet.user;

public class UserDTO {
int user_id;
String user_login_id, password, name, phone, email, profileimg;
String rank;   //int -> String 수정
String user_role;
int grape_count;

public UserDTO() {  }

public int getUser_id() {
	return user_id;
}
public void setUser_id(int user_id) {
	this.user_id = user_id;
}
public String getUser_login_id() {
	return user_login_id;
}
public void setUser_login_id(String user_login_id) {
	this.user_login_id = user_login_id;
}
public String getPassword() {
	return password;
}
public void setPassword(String password) {
	this.password = password;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public String getPhone() {
	return phone;
}
public void setPhone(String phone) {
	this.phone = phone;
}
public String getEmail() {
	return email;
}
public void setEmail(String email) {
	this.email = email;
}
public String getProfileimg() {
	return profileimg;
}
public void setProfileimg(String profileimg) {
	this.profileimg = profileimg;
}

public String getRank() {
	return rank;
}
public void setRank(String rank) {
	this.rank = rank;
}
public String getUser_role() {
	return user_role;
}
public void setUser_role(String user_role) {
	this.user_role = user_role;
}
public int getGrape_count() {
	return grape_count;
}
public void setGrape_count(int grape_count) {
	this.grape_count = grape_count;
}
}
