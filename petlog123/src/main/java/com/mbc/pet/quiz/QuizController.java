
package com.mbc.pet.quiz;

import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
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
    
    //퀴즈 등록 페이지
    @RequestMapping(value = "/QuizInsertPage")
    public String quizinsert(HttpSession session) {
    	
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
    	
        return "QuizInsert";
    }
     
    //퀴즈 등록 처리
    @RequestMapping(value = "/QuizInsertSave")
    public String quizinsert1(QuizDTO dto, HttpSession session) {    
    	
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
    	
        QuizService qs=sqlSession.getMapper(QuizService.class);
        qs.insertQuiz(dto);
        return "QuizList";
    }
    
    //퀴즈 풀기
    @RequestMapping(value = "/QuizInput")
    public String quiz1(Model mo, HttpSession session) {
        // 세션 확인
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
        
        //풀지 않은 퀴즈 가져오기 / 이미 푼 문제 제외
        QuizService qs=sqlSession.getMapper(QuizService.class);
        QuizDTO quiz = qs.UnsolvedQuiz(user_id);
        

        // 모든 문제 다 풀었을 때 alert 띄우고 홈으로
        if (quiz == null) {
            mo.addAttribute("allDone", true);
            return "QuizList"; // 기존 퀴즈 페이지로 돌아가되, 모달만 보여줌
        }

        ArrayList<QuizDTO> dto = new ArrayList<QuizDTO>();
        dto.add(quiz);
        mo.addAttribute("dto", dto);
        return "QuizList";
    }
    
    //퀴즈 풀기 결과 저장
    @RequestMapping(value = "/QuizSave")
    public String quiz2(HttpServletRequest request, Model mo, @ModelAttribute QuizDTO dto,HttpSession session) {
    	
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
    	
        //사용자 정보
        int quiz_id=dto.getQuiz_id();
        String userAnswer=dto.getQuiz_answer(); //사용자가 선택한 답
        //int user_id=(Integer)session.getAttribute("user_id"); //사용자 아이디 불러오기
        
        //퀴즈 정답 가져오기
        QuizService qs= sqlSession.getMapper(QuizService.class);
        QuizDTO dbQuiz = qs.getQuizId(quiz_id);
        String correctAnswer = dbQuiz.getQuiz_answer(); // DB에 저장된 실제 정답
        
        //이미 푼 문제인지 확인
        boolean alreadySolved = qs.checkAlreadySolved(user_id, quiz_id);
        if (alreadySolved) {
            mo.addAttribute("message", "이미 푼 문제입니다!");
            return "quiz_done"; // 또는 결과 페이지
        }
        
        //정답 비교 및 전달
        boolean isCorrect =  userAnswer!= null && userAnswer.equalsIgnoreCase(correctAnswer);
        int score = isCorrect ? 1 : 0;
        int grape = isCorrect ? 10 : 0;
        
        //실제 풀이 시간 받기
        int timeTaken=Integer.parseInt(request.getParameter("result_time"));

        // 결과 저장
        QuizResultDTO redto = new QuizResultDTO();
        redto.setResult_score(score); //순위 가져오기
        redto.setResult_rank(0); //이후에 반영 예정
        redto.setResult_time(timeTaken); //전체 단위 풀이시간 가져오기
        redto.setUser_id(user_id);
        redto.setQuiz_id(quiz_id);
        redto.setGet_grape(isCorrect ? 10 : 0); // 정답이면 포도알 10개 지급
        qs.insertQuizResult(redto);
        
        //순위 계산
        int MyRank = qs.time_rank(quiz_id, user_id);
        redto.setResult_rank(MyRank);
    
        //top10 가져오기
        ArrayList<QuizResultDTO> top10 = qs.top10rank(quiz_id);
        
        mo.addAttribute("isCorrect", isCorrect);
        mo.addAttribute("top10", top10);
        mo.addAttribute("redto", redto);
        
        //퀴즈 오답시 정답 알려주기 dasom
        mo.addAttribute("quiz", dbQuiz);
        //

        return "QuizResult";
    }
    
    @RequestMapping("/quiz")
    public String quiz(HttpServletRequest request, Model mo, HttpSession session) {
    	
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
        
        QuizService qs= sqlSession.getMapper(QuizService.class);
        QuizDTO quiz = qs.UnsolvedQuiz(user_id);
    
        return "QuizResult";
    }
}
