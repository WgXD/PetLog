package com.mbc.pet.point;

import com.mbc.pet.user.UserDTO;

public class PointDTO {
	
	int point_id; //포인트 고유 id, PK
	String point_action; //어떤 활동으로 포도알 얻었는지? ex.다이어리에 글 1개 게시 -> 1알
	int point_action_id; //활동id
	int point_earned_grapes; //누적포도알 -> 해당 활동으로 포도알 몇개 적립? -> 추후에 이벤트 같은거 하면 포도알 3개 주기도 가능
	
	UserDTO petuser; //외래키 -> PetuserDTO 가져오기
	
	int user_id; //외래키

	public PointDTO() {     }

	public int getPoint_id() {
		return point_id;
	}

	public void setPoint_id(int point_id) {
		this.point_id = point_id;
	}

	public String getPoint_action() {
		return point_action;
	}

	public void setPoint_action(String point_action) {
		this.point_action = point_action;
	}

	public int getPoint_action_id() {
		return point_action_id;
	}

	public void setPoint_action_id(int point_action_id) {
		this.point_action_id = point_action_id;
	}

	public int getPoint_earned_grapes() {
		return point_earned_grapes;
	}

	public void setPoint_earned_grapes(int point_earned_grapes) {
		this.point_earned_grapes = point_earned_grapes;
	}

	public UserDTO getPetuser() {
		return petuser;
	}

	public void setPetuser(UserDTO petuser) {
		this.petuser = petuser;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	
}
