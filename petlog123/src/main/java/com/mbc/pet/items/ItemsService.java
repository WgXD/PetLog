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

	ArrayList<ItemsDTO> items_out_admin(@Param("start") int start, @Param("end") int end); //관리자용 아이템 출력

	void items_delete_admin(@Param("item_id") int item_id); //판매중 -> 판매종료 (진짜 지우는거 아님)

	ArrayList<ItemsDTO> items_stopped(); //판매 종료된 아이템 목록 보기(관리자용)

	void items_restore(@Param("item_id") int item_id); //판매종료 -> 판매중

	int how_much(int item_id); //아이템 가격 조회

	ItemsDTO items_modify(int modify); //아이템 수정(관리자용)

	void modify_save(int item_id, String item_name, int item_cost, String item_category, String fname);
	
	


}
