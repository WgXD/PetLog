package com.mbc.pet.user;

public interface UserService {

	int idcheck(String user_login_id);
	
	void insertsignup(UserDTO dto);

	String pwsave(String user_login_id);

	UserDTO editid(String user_login_id);

	void updateProfile(UserDTO dto);

	UserDTO selectUserByLoginId(String id);
}
