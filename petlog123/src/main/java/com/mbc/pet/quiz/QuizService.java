package com.mbc.pet.quiz;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

public interface QuizService {

	ArrayList<QuizDTO> getRandomQuiz();

	QuizDTO getQuizId(int quiz_id);

	void insertQuiz(QuizDTO dto);

	void insertQuizResult(QuizResultDTO resultDTO);

	int time_rank(@Param("quiz_id") int quiz_id,@Param("user_id") int user_id);
	//ArrayList<QuizResultDTO> time_rank(@Param("quiz_id") int quiz_id, @Param("user_id") int user_id);
	//컨트롤러에서 DTO를 두개 이상 쓰는 경우 @param으로 매칭해줘야 함

	ArrayList<QuizResultDTO> top10rank(int quiz_id);

	QuizDTO getNextQuiz(Integer user_id);

	QuizDTO UnsolvedQuiz(@Param("user_id")int user_id);

	boolean checkAlreadySolved(@Param("user_id") int user_id, @Param("quiz_id") int quiz_id);

	
}
