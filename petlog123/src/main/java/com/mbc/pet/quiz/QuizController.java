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
//	   // ���� üũ
//		Integer user_id = (Integer) session.getAttribute("user_id");
//		String user_login_id = (String) session.getAttribute("user_login_id");
//
//		if (user_id == null || user_login_id == null) {
//			return "redirect:/login";
//	    }
//	    return "QuizList";
//	 }
	 
	 //���� ��� ������
	@RequestMapping(value = "/QuizInsertPage")
	public String quizinsert() {    	
		return "QuizInsert";
	 }
	 
	//���� ��� ó��
	@RequestMapping(value = "/QuizInsertSave")
	public String quizinsert1(QuizDTO dto) {    
		QuizService qs=sqlSession.getMapper(QuizService.class);
		qs.insertQuiz(dto);
		return "QuizList";
	}
	
	@RequestMapping(value = "/QuizInput")
	public String quiz1(Model mo, HttpSession session) {
		// ���� üũ
		Integer user_id = (Integer) session.getAttribute("user_id");
		String user_login_id = (String) session.getAttribute("user_login_id");

		if (user_id == null || user_login_id == null) {
		return "redirect:/login";
		}
		
		//���� ���� �ҷ�����
		QuizService qs= sqlSession.getMapper(QuizService.class);
		ArrayList<QuizDTO> dto= qs.getRandomQuiz();
		mo.addAttribute("dto", dto);
		return "QuizList";
	 }
	 
	@RequestMapping(value = "/QuizSave")
	public String quiz2(Model mo, @ModelAttribute QuizDTO dto,HttpSession session) {
		//����� ����
		int quiz_id=dto.getQuiz_id();
		String userAnswer=dto.getQuiz_answer(); //������ ������ ��
		 	
		//���� ���� �ҷ�����
		QuizService qs= sqlSession.getMapper(QuizService.class);
		QuizDTO dbQuiz = qs.getQuizId(quiz_id);
		String correctAnswer = dbQuiz.getQuiz_answer(); // DB�� ����� ��¥ ����
	        
		//���� �� �� ����
		//boolean isCorrect = quiz_answer.equalsIgnoreCase(correctanswer);
		boolean isCorrect =  userAnswer!= null && userAnswer.equalsIgnoreCase(correctAnswer);
		 	
		// ��� ����
		QuizResultDTO resultDTO = new QuizResultDTO();
		resultDTO.setResult_score(isCorrect ? 1 : 0);
		resultDTO.setResult_rank(null); // ���߿� ��ũ ����� ���� ����
		resultDTO.setResult_time(30); // ���� Ǫ�� �� �ɸ� �ð� ����
		resultDTO.setUser_id((Integer)session.getAttribute("user_id"));
		resultDTO.setQuiz_id(quiz_id);
		resultDTO.setGet_grape(isCorrect ? 10 : 0); // �����̸� ������ 10�� ����

		qs.insertQuizResult(resultDTO);

		mo.addAttribute("isCorrect", isCorrect);
		return "QuizResult";
	 }
}