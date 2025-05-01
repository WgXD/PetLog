package com.mbc.pet.community;

import com.mbc.pet.user.UserDTO;

public class CommentsDTO {
// 댓글 id,  회원 id,  게시글 id,
int com_id, user_id;
String user_login_id;
int post_id;
String com_com;   //댓글,
int parent_id; //부모댓글(대댓글을 위한)
int depth;
 // 들여쓰기
UserDTO psdto;
CommunityDTO ctdto;

public CommentsDTO() {  }

public int getCom_id() {
	return com_id;
}
public void setCom_id(int com_id) {
	this.com_id = com_id;
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
public String getCom_com() {
	return com_com;
}
public void setCom_com(String com_com) {
	this.com_com = com_com;
}
public int getParent_id() {
	return parent_id;
}
public void setParent_id(int parent_id) {
	this.parent_id = parent_id;
}
public int getDepth() {
	return depth;
}
public void setDepth(int depth) {
	this.depth = depth;
}
public UserDTO getPsdto() {
	return psdto;
}
public void setPsdto(UserDTO psdto) {
	this.psdto = psdto;
}
public CommunityDTO getCtdto() {
	return ctdto;
}
public void setCtdto(CommunityDTO ctdto) {
	this.ctdto = ctdto;
}
public String getUser_login_id() {
	return user_login_id;
}
public void setUser_login_id(String user_login_id) {
	this.user_login_id = user_login_id;
}
}