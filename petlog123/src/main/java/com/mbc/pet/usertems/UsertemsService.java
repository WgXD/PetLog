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

	
	

	
	

}
