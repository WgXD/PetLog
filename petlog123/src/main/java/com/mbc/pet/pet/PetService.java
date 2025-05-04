package com.mbc.pet.pet;

import java.util.ArrayList;

public interface PetService {

	void pet_save(PetDTO dto); //�Է��� ������ DB�� ����

	ArrayList<PetDTO> pet_out(); //���

	PetDTO pet_detail(int update1); //pet_detail

	PetDTO pet_update(int update); //pet_update ����

	void pet_update_save(int pet_id, String pet_name, String pet_bog, String pet_hbd, int user_id, String fname,
			String pet_neuter); //update �� �ٽ� save

	PetDTO delete1(int delete); //����

	void delete_check(int delete); //���� Ȯ�� ������

	ArrayList<PetDTO> petsbyuser(Integer user_id); //회원별 반려동물 출력!!!

	
	
	
	

	

}
