package com.mbc.pet.quiz;

public class QuizResultDTO {
int result_id, result_score, result_rank, result_time, user_id, quiz_id, get_grape;
String user_login_id;

public QuizResultDTO() {  }

public int getResult_id() {
	return result_id;
}
public void setResult_id(int result_id) {
	this.result_id = result_id;
}
public int getResult_score() {
	return result_score;
}
public void setResult_score(int result_score) {
	this.result_score = result_score;
}
public int getResult_rank() {
	return result_rank;
}
public void setResult_rank(int result_rank) {
	this.result_rank = result_rank;
}
public int getResult_time() {
	return result_time;
}
public void setResult_time(int result_time) {
	this.result_time = result_time;
}
public int getUser_id() {
	return user_id;
}
public void setUser_id(int user_id) {
	this.user_id = user_id;
}
public int getQuiz_id() {
	return quiz_id;
}
public void setQuiz_id(int quiz_id) {
	this.quiz_id = quiz_id;
}
public int getGet_grape() {
	return get_grape;
}
public void setGet_grape(int get_grape) {
	this.get_grape = get_grape;
}
public String getUser_login_id() {
	return user_login_id;
}
public void setUser_login_id(String user_login_id) {
	this.user_login_id = user_login_id;
}
}
