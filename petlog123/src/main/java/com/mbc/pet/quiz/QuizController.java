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
public class QuizController {

	@Autowired
	SqlSession sqlSession;
	
//	@RequestMapping(value = "/QuizInput")
//	public String quiz(HttpSession session) {
//	   // 세션 체크
//		Integer user_id = (Integer) session.getAttribute("user_id");
//		String user_login_id = (String) session.getAttribute("user_login_id");
//
//		if (user_id == null || user_login_id == null) {
//			return "redirect:/login";
//	    }
//	    return "QuizList";
//	 }
	 
	 //퀴즈 등록 페이지
	@RequestMapping(value = "/QuizInsertPage")
	public String quizinsert() {    	
		return "QuizInsert";
	 }
	 
	//퀴즈 등록 처리
	@RequestMapping(value = "/QuizInsertSave")
	public String quizinsert1(QuizDTO dto) {    
		QuizService qs=sqlSession.getMapper(QuizService.class);
		qs.insertQuiz(dto);
		return "QuizList";
	}
	
	@RequestMapping(value = "/QuizInput")
	public String quiz1(Model mo, HttpSession session) {
		// 세션 체크
		Integer user_id = (Integer) session.getAttribute("user_id");
		String user_login_id = (String) session.getAttribute("user_login_id");

		if (user_id == null || user_login_id == null) {
		return "redirect:/login";
		}
		
		//랜덤 퀴즈 불러오기
		QuizService qs= sqlSession.getMapper(QuizService.class);
		ArrayList<QuizDTO> dto= qs.getRandomQuiz();
		mo.addAttribute("dto", dto);
		return "QuizList";
	 }
	 
	@RequestMapping(value = "/QuizSave")
	public String quiz2(Model mo, @ModelAttribute QuizDTO dto,HttpSession session) {
		//사용자 정보
		int quiz_id=dto.getQuiz_id();
		String userAnswer=dto.getQuiz_answer(); //유저가 선택한 답
		 	
		//퀴즈 정답 불러오기
		QuizService qs= sqlSession.getMapper(QuizService.class);
		QuizDTO dbQuiz = qs.getQuizId(quiz_id);
		String correctAnswer = dbQuiz.getQuiz_answer(); // DB에 저장된 진짜 정답
	        
		//정답 비교 및 전송
		//boolean isCorrect = quiz_answer.equalsIgnoreCase(correctanswer);
		boolean isCorrect =  userAnswer!= null && userAnswer.equalsIgnoreCase(correctAnswer);
		 	
		// 결과 저장
		QuizResultDTO resultDTO = new QuizResultDTO();
		resultDTO.setResult_score(isCorrect ? 1 : 0);
		resultDTO.setResult_rank(null); // 나중에 랭크 계산할 수도 있음
		resultDTO.setResult_time(30); // 문제 푸는 데 걸린 시간 예시
		resultDTO.setUser_id((Integer)session.getAttribute("user_id"));
		resultDTO.setQuiz_id(quiz_id);
		resultDTO.setGet_grape(isCorrect ? 10 : 0); // 정답이면 포도알 10개 지급

		qs.insertQuizResult(resultDTO);

		mo.addAttribute("isCorrect", isCorrect);
		return "QuizResult";
	 }
}