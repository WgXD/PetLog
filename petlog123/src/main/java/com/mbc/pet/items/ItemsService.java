package com.mbc.pet.items;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;

import com.mbc.pet.usertems.UsertemsDTO;


public interface ItemsService {

	void items_save(String item_name, int item_cost, String item_category, String filename);

	ArrayList<ItemsDTO> items_out(@Param("start") int start,@Param("end") int end);

	int total_items();

	ItemsDTO items_detail(int num); //items_detail

	void insert_usertem(@Param("user_id") int user_id, @Param("item_id") int item_id, @Param("usertem_equip") String usertem_equip);




}
