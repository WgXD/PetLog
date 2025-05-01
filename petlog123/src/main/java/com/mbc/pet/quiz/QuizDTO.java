package com.mbc.pet.quiz;

public class QuizDTO {
int quiz_id;
String quiz_question;
String quiz_option1, quiz_option2, quiz_option3, quiz_option4; 
String quiz_answer;

public QuizDTO() { }

public int getQuiz_id() {
	return quiz_id;
}
public void setQuiz_id(int quiz_id) {
	this.quiz_id = quiz_id;
}
public String getQuiz_question() {
	return quiz_question;
}
public void setQuiz_question(String quiz_question) {
	this.quiz_question = quiz_question;
}
public String getQuiz_option1() {
	return quiz_option1;
}
public void setQuiz_option1(String quiz_option1) {
	this.quiz_option1 = quiz_option1;
}
public String getQuiz_option2() {
	return quiz_option2;
}
public void setQuiz_option2(String quiz_option2) {
	this.quiz_option2 = quiz_option2;
}
public String getQuiz_option3() {
	return quiz_option3;
}
public void setQuiz_option3(String quiz_option3) {
	this.quiz_option3 = quiz_option3;
}
public String getQuiz_option4() {
	return quiz_option4;
}
public void setQuiz_option4(String quiz_option4) {
	this.quiz_option4 = quiz_option4;
}
public String getQuiz_answer() {
	return quiz_answer;
}
public void setQuiz_answer(String quiz_answer) {
	this.quiz_answer = quiz_answer;
}
}
