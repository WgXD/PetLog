package com.mbc.pet.quiz;

import java.util.ArrayList;
import javax.servlet.http.HttpSession;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class QuizController { // 관리자 전용!!!!!

	@Autowired
	SqlSession sqlSession;
	
//	@RequestMapping(value = "/QuizInput")
//	public String quiz(HttpSession session) {
//	   // 로그인 체크
//		Integer user_id = (Integer) session.getAttribute("user_id");
//		String user_login_id = (String) session.getAttribute("user_login_id");
//
//		if (user_id == null || user_login_id == null) {
//			return "redirect:/login";
//	    }
//	    return "QuizList";
//	 }
	 
	 // 퀴즈 문제 등록 화면
	@RequestMapping(value = "/QuizInsertPage")
	public String quizinsert() {    	
		return "QuizInsert";
	}
	 
	// 퀴즈 등록 처리
	@RequestMapping(value = "/QuizInsertSave")
	public String quizinsert1(QuizDTO dto) {    
		QuizService qs = sqlSession.getMapper(QuizService.class);
		qs.insertQuiz(dto);
		return "QuizList";
	}
	
	// 사용자 퀴즈 풀이 화면
	@RequestMapping(value = "/QuizInput")
	public String quiz1(Model mo, HttpSession session) {
		// 로그인 체크
		Integer user_id = (Integer) session.getAttribute("user_id");
		String user_login_id = (String) session.getAttribute("user_login_id");

		if (user_id == null || user_login_id == null) {
			return "redirect:/login";
		}
		
		// 랜덤 퀴즈 가져오기
		QuizService qs = sqlSession.getMapper(QuizService.class);
		ArrayList<QuizDTO> dto = qs.getRandomQuiz();
		mo.addAttribute("dto", dto);
		return "QuizList";
	}
	 
	// 퀴즈 결과 저장
	@RequestMapping(value = "/QuizSave")
	public String quiz2(Model mo, @ModelAttribute QuizDTO dto, HttpSession session) {
		// 사용자가 선택한 값
		int quiz_id = dto.getQuiz_id();
		String userAnswer = dto.getQuiz_answer(); // 사용자가 선택한 보기
		
		// DB에서 정답 가져오기
		QuizService qs = sqlSession.getMapper(QuizService.class);
		QuizDTO dbQuiz = qs.getQuizId(quiz_id);
		String correctAnswer = dbQuiz.getQuiz_answer(); // DB에 저장된 정답
		
		// 정답 비교
		boolean isCorrect = userAnswer != null && userAnswer.equalsIgnoreCase(correctAnswer);
		
		// 결과 저장
		QuizResultDTO resultDTO = new QuizResultDTO();
		resultDTO.setResult_score(isCorrect ? 1 : 0);
		resultDTO.setResult_rank(null); // 나중에 랭크 추가 시 설정
		resultDTO.setResult_time(30);   // 추후 실제 시간 측정으로 변경 가능
		resultDTO.setUser_id((Integer) session.getAttribute("user_id"));
		resultDTO.setQuiz_id(quiz_id);
		resultDTO.setGet_grape(isCorrect ? 10 : 0); // 맞으면 포도알 10개

		qs.insertQuizResult(resultDTO);

		mo.addAttribute("isCorrect", isCorrect);
		return "QuizResult";
	}
}
