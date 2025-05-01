package com.mbc.pet.community;

import com.mbc.pet.user.UserDTO;

public class LikesDTO {
int like_id, user_id, post_id;
String user_login_id;
CommunityDTO ctdto;
UserDTO psdto;

public int getLike_id() {
	return like_id;
}
public void setLike_id(int like_id) {
	this.like_id = like_id;
}
public int getUser_id() {
	return user_id;
}
public void setUser_id(int user_id) {
	this.user_id = user_id;
}
public int getPost_id() {
	return post_id;
}
public void setPost_id(int post_id) {
	this.post_id = post_id;
}
public String getUser_login_id() {
	return user_login_id;
}
public void setUser_login_id(String user_login_id) {
	this.user_login_id = user_login_id;
}
public CommunityDTO getCtdto() {
	return ctdto;
}
public void setCtdto(CommunityDTO ctdto) {
	this.ctdto = ctdto;
}
public UserDTO getPsdto() {
	return psdto;
}
public void setPsdto(UserDTO psdto) {
	this.psdto = psdto;
}
public LikesDTO() { }

}
