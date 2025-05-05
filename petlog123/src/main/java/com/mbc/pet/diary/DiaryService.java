package com.mbc.pet.diary;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

public interface DiaryService {


	void diary_save(DiaryDTO dd);

	ArrayList<DiaryDTO> diary_out();

	DiaryDTO diary_detail(int unum); 

	DiaryDTO diary_update(int update); 

	void update_save(int diary_id, String diary_title, String diary_date, String diary_image, String diary_content,
			int user_id, int pet_id); 

	void delete1(String delete_image); 

	DiaryDTO delete_check(int delete); 

	void delete_page(int delete); 

	int total_diary(); // 일기 전체 수 (페이징 처리용)
	
	ArrayList<DiaryDTO> diary_out(@Param("start") int start, @Param("end") int end, @Param("user_id") int user_id);

	void grape_check(int diary_id); //작성한 게시물로 포도알 받았는지? 

	int get_id(); // Oracle 시퀀스로부터 diary_id 가져오기

	

	
	
	



	
	


	
	
	
	
	
	
	
}
