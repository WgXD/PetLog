package com.mbc.pet.pet;

import java.util.ArrayList;

public interface PetService {

	void pet_save(PetDTO dto); // 입력한 반려동물 정보를 DB에 저장

	ArrayList<PetDTO> pet_out(); // 반려동물 전체 목록 출력

	PetDTO pet_detail(int update1); // 반려동물 상세 보기

	PetDTO pet_update(int update); 

	void pet_update_save(int pet_id, String pet_name, String pet_bog, String pet_hbd, int user_id, String fname,
			String pet_neuter); // 수정한 반려동물 정보를 다시 저장

	PetDTO delete1(int delete);

	void delete_check(int delete);

	ArrayList<PetDTO> petsbyuser(Integer user_id); //회원별 반려동물 출력!!!

	ArrayList<Integer> petsbyuser_cal(Integer user_id); //달력 일정 직접 추가용!!!!!!
	
	ArrayList<PetDTO> getpetbyuserid(Integer user_id); //메인 페이지에 펫 목록 불러오기

	PetDTO getPetById(int pet_id);
	

	

}
