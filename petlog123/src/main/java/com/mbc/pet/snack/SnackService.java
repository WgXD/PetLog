package com.mbc.pet.snack;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.mbc.pet.community.CommentsDTO;

public interface SnackService {

	int snack_save(SnackDTO dto);

	int total_recipe();

	ArrayList<SnackDTO> snack_out(@Param("start") int start, @Param("end") int end);

	SnackDTO snack_detail(int dnum);

	SnackDTO snack_update(int update); 

	int snackupdate_save(@Param("dto") SnackDTO dto);

	SnackDTO snackdelete_check(int delete);

	void delete_recipe(int delete);

	List<SnackDTO> getsnackList();

	void readcnt(int dnum); //조회수

	int check_like(@Param("user_id") Integer user_id, @Param("snack_id") int snack_id); //likes

	int getLikeCount(@Param("snack_id") int snack_id);

	void insert_like(Map<String, Object> map);

	List<CommentsDTO> getCommentsBySnackId(@Param("snack_id") int dnum);

	void comment_insert(Map<String, Object> map);

	List<SnackDTO> getTopSnackByLikes();

	List<SnackDTO> getTopSnackByComments();

	List<SnackDTO> getSnackPreview(); //레시피 인기 게시물




	

}
