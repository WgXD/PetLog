package com.mbc.pet.diary;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

public interface DiaryService {


	void diary_save(DiaryDTO dd);

	ArrayList<DiaryDTO> diary_out(); //일기 출력

	DiaryDTO diary_detail(int unum); //일기 자세히 보기

	DiaryDTO diary_update(int update); //일기 수정

	void update_save(int diary_id, String diary_title, String diary_date, String diary_image, String diary_content,
			int user_id, int pet_id); // 일기 수정한 내용 저장

	void delete1(String delete_image); //수정하고 수정 전 이미지 파일 삭제

	DiaryDTO delete_check(int delete); //삭제 전 확인 페이지

	void delete_page(int delete); //삭제

	int total_diary(); //일기 목록 페이징 처리
	
	ArrayList<DiaryDTO> diary_out(@Param("start") int start, @Param("end") int end);
	// 페이징 처리를 통해서 해당 페이지에 맞는 일기 목록 가져오기

	void grape_check(int diary_id); //작성한 게시물로 포도알이 적립되었는지?

	int get_id(); //Oracle 시퀀스에서 다음 diary_id 미리 뽑는 거

	

	
	
	



	
	


	
	
	
	
	
	
	
}
