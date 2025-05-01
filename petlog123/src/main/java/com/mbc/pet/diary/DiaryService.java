package com.mbc.pet.diary;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

public interface DiaryService {


	void diary_save(DiaryDTO dd);

	ArrayList<DiaryDTO> diary_out(); //�ϱ� ���

	DiaryDTO diary_detail(int unum); //�ϱ� �ڼ��� ����

	DiaryDTO diary_update(int update); //�ϱ� ����

	void update_save(int diary_id, String diary_title, String diary_date, String diary_image, String diary_content,
			int user_id, int pet_id); // �ϱ� ������ ���� ����

	void delete1(String delete_image); //�����ϰ� ���� �� �̹��� ���� ����

	DiaryDTO delete_check(int delete); //���� �� Ȯ�� ������

	void delete_page(int delete); //����

	int total_diary(); //�ϱ� ��� ����¡ ó��
	
	ArrayList<DiaryDTO> diary_out(@Param("start") int start, @Param("end") int end);
	// ����¡ ó���� ���ؼ� �ش� �������� �´� �ϱ� ��� ��������

	void grape_check(int diary_id); //�ۼ��� �Խù��� �������� �����Ǿ�����?

	int get_id(); //Oracle ���������� ���� diary_id �̸� �̴� ��

	

	
	
	



	
	


	
	
	
	
	
	
	
}
