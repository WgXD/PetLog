package com.mbc.pet.pet;

import java.util.ArrayList;

public interface PetService {

	void pet_save(PetDTO dto); //입력한 펫정보 DB에 저장

	ArrayList<PetDTO> pet_out(); //출력

	PetDTO pet_detail(int update1); //pet_detail

	PetDTO pet_update(int update); //pet_update 수정

	void pet_update_save(int pet_id, String pet_name, String pet_bog, String pet_hbd, int user_id, String fname,
			String pet_neuter); //update 후 다시 save

	PetDTO delete1(int delete); //삭제

	void delete_check(int delete); //삭제 확인 페이지

	ArrayList<PetDTO> petsbyuser(Integer user_id); //반려동물 선택하기(여러 마리 있는 경우)
	
	
	
	
	

	

}
