package com.mbc.pet.user;

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
}