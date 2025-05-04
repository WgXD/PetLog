package com.mbc.pet.usertems;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import com.mbc.pet.items.ItemsDTO;

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

	

	
	

}
