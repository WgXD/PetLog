package com.mbc.pet.community;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;
 
public interface CommunityService {

	void insertc(Integer user_id, String title, String content, String ofname, String post_type);

	ArrayList<CommunityDTO> outviewByType(@Param("start") int start, @Param("end") int end, @Param("post_type") String post_type);

	void readcnt(int pnum);

	CommunityDTO detailview(int pnum);

	CommunityDTO deleteview(int dnum);

	void delete1(int dnum);

	void modify(int mnum, String title, String content, String ofname, int user_id);

	CommunityDTO modifyview(int mnum);

	List<CommentsDTO> getCommentsByPostId(int mnum);

	ArrayList<CommunityDTO> searchid(String svalue);

	ArrayList<CommunityDTO> searchtitle(String svalue);

	ArrayList<CommunityDTO> searchcontent(String svalue);

	ArrayList<CommunityDTO> searchdate(String svalue);

	int getUserIdByLoginId(String user_login_id);

	void insertco(CommentsDTO dto);

	int total();

	public ArrayList<CommunityDTO> page(PageDTO dto);//������ ���� 

	int check_like(@Param("user_id") int user_id, @Param("post_id") int post_id);

	int getLikeCount(int post_id);

	void insert_like(Integer user_id, int post_id, String user_login_id);

	void insertbo(Integer user_id, String title, String content, String ofname);

	ArrayList<CommunityDTO> booutview(int start, int end);
	
	int totalByType(@Param("post_type") String post_type);

	String getUserRole(int user_id);

	CommunityDTO getPostById(int dnum);

	void deletePost(@Param("param1") int post_id, @Param("param2") int user_id);

	ArrayList<CommunityDTO> getPopularPosts();

	void modify(CommunityDTO modifyDto);

	ArrayList<CommunityDTO> getRecentNotices();

}
