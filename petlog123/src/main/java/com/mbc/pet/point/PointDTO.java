package com.mbc.pet.point;

import com.mbc.pet.user.UserDTO;

public class PointDTO {
	
	int point_id; //����Ʈ ���� id, PK
	String point_action; //� Ȱ������ ������ �������? ex.���̾�� �� 1�� �Խ� -> 1��
	int point_action_id; //Ȱ��id
	int point_earned_grapes; //���������� -> �ش� Ȱ������ ������ � ����? -> ���Ŀ� �̺�Ʈ ������ �ϸ� ������ 3�� �ֱ⵵ ����
	
	UserDTO petuser; //�ܷ�Ű -> PetuserDTO ��������
	
	int user_id; //�ܷ�Ű

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
