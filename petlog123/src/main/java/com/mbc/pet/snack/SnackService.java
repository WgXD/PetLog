package com.mbc.pet.snack;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface SnackService {

	int snack_save(SnackDTO dto);

	int total_recipe();

	ArrayList<SnackDTO> snack_out(@Param("start") int start, @Param("end") int end);

	SnackDTO snack_detail(int dnum);
	

	SnackDTO snack_update(int update); //������ ����

	int snackupdate_save(@Param("dto") SnackDTO dto); //���� �� DB�� ����

	SnackDTO snackdelete_check(int delete); //���� �� Ȯ��

	void delete_recipe(int delete); //����

	List<SnackDTO> getsnackList();

	List<SnackDTO> getSnackPreview();


	

}
