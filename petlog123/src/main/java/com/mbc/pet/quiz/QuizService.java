package com.mbc.pet.quiz;

import java.util.ArrayList;

public interface QuizService {

	ArrayList<QuizDTO> getRandomQuiz();

	QuizDTO getQuizId(int quiz_id);

	//void saveQuizResult(QuizResultDTO resultDTO);

	void insertQuiz(QuizDTO dto);

	void insertQuizResult(QuizResultDTO resultDTO);

	
}
