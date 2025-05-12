package com.mbc.pet.community;

import com.mbc.pet.user.UserDTO;

public class CommunityDTO {
 int post_id;
 int user_id;
 String post_title, post_content, post_image;
 int post_readcnt;
 String post_date;
 String user_login_id;
 int comment_count;
 int like_count;
 String profileimg;
 String post_type;
 UserDTO psdto;
 CommentsDTO cmdto;

public CommunityDTO() { }


public String getPost_type() {
	return post_type;
}
public void setPost_type(String post_type) {
	this.post_type = post_type;
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
public String getPost_image() {
	return post_image;
}
public void setPost_image(String post_image) {
	this.post_image = post_image;
}
public int getPost_id() {
	return post_id;
}
public void setPost_id(int post_id) {
	this.post_id = post_id;
}
public String getPost_title() {
	return post_title;
}
public void setPost_title(String post_title) {
	this.post_title = post_title;
}
public String getPost_content() {
	return post_content;
}
public void setPost_content(String post_content) {
	this.post_content = post_content;
}
public int getPost_readcnt() {
	return post_readcnt;
}
public void setPost_readcnt(int post_readcnt) {
	this.post_readcnt = post_readcnt;
}
public String getPost_date() {
	return post_date;
}
public void setPost_date(String post_date) {
	this.post_date = post_date;
}
public int getUser_id() {
	return user_id;
}
public void setUser_id(int user_id) {
	this.user_id = user_id;
}
public UserDTO getPsdto() {
	return psdto;
}
public void setPsdto(UserDTO psdto) {
	this.psdto = psdto;
}
public CommentsDTO getCmdto() {
	return cmdto;
}
public void setCmdto(CommentsDTO cmdto) {
	this.cmdto = cmdto;
}
public String getUser_login_id() {
	return user_login_id;
}
public void setUser_login_id(String user_login_id) {
	this.user_login_id = user_login_id;
}
public String getProfileimg() {
	return profileimg;
}
public void setProfileimg(String profileimg) {
	this.profileimg = profileimg;
} 
}
