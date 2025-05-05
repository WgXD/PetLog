package com.mbc.pet.point;

import com.mbc.pet.user.UserDTO;

public class PointDTO {
    
    int point_id; // 포인트 기록 id, PK
    String point_action; // 어떤 활동으로 적립된 포인트인지 ex. 다이어리 작성 → "diary"
    int point_action_id; // 활동 id (예: 다이어리 번호, 게시글 번호 등)
    int point_earned_grapes; // 적립된 포도알 수 (해당 활동에서 얼마나 적립되었는지)

    UserDTO petuser; // 유저 정보 객체 (UserDTO 참조)

    int user_id; // 외래키 - 유저 ID

    public PointDTO() { }

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
