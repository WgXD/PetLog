package com.mbc.pet.usertems;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import com.mbc.pet.items.ItemsDTO;
import com.mbc.pet.user.UserDTO;

public interface UsertemsService {

	   void insert_usertem(@Param("user_id") int user_id,
               @Param("item_id") int item_id,
               @Param("usertem_equip") String usertem_equip);

	ArrayList<ItemsDTO> item_list(int user_id);

	ArrayList<UsertemsDTO> get_items(int user_id);

	void frame_wearing(@Param("user_id") int user_id, @Param("item_id") int item_id);
	//프로필 프레임 착용

	ArrayList<ItemsDTO> frame_item(@Param("user_id") int user_id); //프레임 착용 확인(Y로)

	ItemsDTO getEquippedFrame(Integer user_id); //착용된 프레임 조회(from UserController)

	void items_delete1(@Param("item_id") int item_id); //유저가 보유한 아이템 삭제

	int check_usertem(@Param("user_id") Integer user_id,@Param("item_id") int item_id);

	int get_user_grapes(Integer user_id); //회원의 총 포도알 갯수 조회

	void minus_grapes(@Param("user_id") int user_id, @Param("cost") int cost); //아이템 구매시 포도알 차감

	UserDTO grape_update(String user_login_id); //아이템 구매 후 포도알 갯수 업데이트

	

	
	

}
