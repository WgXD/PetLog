package com.mbc.pet.user;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

public interface UserService {

	int idcheck(String user_login_id);
	
	void insertsignup(UserDTO dto);

	String pwsave(String user_login_id);

	UserDTO editid(String user_login_id);

	void updateProfile(UserDTO dto);

	String findIdByEmailName(@Param("email")String email, @Param("name") String name, @Param("phone") String phone);

	UserDTO selectUserByLoginId(String id);
	
	void updatePassword(@Param("user_login_id")String user_login_id, @Param("password") String encTempPw);

	UserDTO UserByLoginIdAndEmail(@Param("user_login_id")String user_login_id,@Param("email") String email);

	UserDTO userPwChange(@Param("user_login_id") String user_login_id);

	void updatePw(@Param("user_login_id") String user_login_id, @Param("password") String encPw);

	void plusGrapeCount(Integer user_id);

	void quiz_grapes(@Param("user_id") int user_id, @Param("grape") int grape); //퀴즈 정답일때 포도알 +10

	UserDTO grape_update(String user_login_id); //아이템 구매 후 포도알 갯수 변경 업데이트 하기

	ArrayList<UserDTO> get_all_users(); //관리자가 어느 회원한테 포도알 줄지 고르는 용

	UserDTO getUserById(Integer user_id);

	UserDTO selectUserById(int user_id); //작성자 정보 조회용, 게시판 프로필 이미지 출력 위해

	int emailCheck(String email); //이메일 중복 체크용

	int emailCheckForUpdate(@Param("email") String email,@Param("user_login_id") String user_login_id);
}