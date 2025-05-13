package com.mbc.pet.diary;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import org.springframework.security.access.method.P;

import com.mbc.pet.pet.PetDTO;

public interface DiaryService {


	void diary_save(DiaryDTO dd);

	ArrayList<DiaryDTO> diary_out();

	DiaryDTO diary_detail(int diary_id); 

	DiaryDTO diary_update(int update); 

	void update_save(int diary_id, String diary_title, String diary_date, String diary_image, String diary_content,
			int user_id, int pet_id); 

	void delete1(String delete_image); 

	DiaryDTO delete_check(int delete); 

	void delete_page(int delete); 

	int total_diary(int user_id); // 일기 전체 수 (페이징 처리용)
	
	ArrayList<DiaryDTO> diary_out(@Param("start") int start, @Param("end") int end, @Param("user_id") int user_id);

	void grape_check(int diary_id); //작성한 게시물로 포도알 받았는지? 

	int get_id(); // Oracle 시퀀스로부터 diary_id 가져오기

	ArrayList<DiaryDTO> diary_by_months(@Param("user_id") Integer user_id, @Param("current_year") int current_year, @Param("current_month") int current_month,@Param("pet_id") int pet_id);
	//로그인한 유저가 작성한 다이어리 달력에 출력하기 용

	DiaryDTO getLatestDiary(Integer user_id);
	
    public ArrayList<PetDTO> petsbyuser(int user_id);
	

	
	
	



	
	


	
	
	
	
	
	
	
}
