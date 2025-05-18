
package com.mbc.pet.quiz;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mbc.pet.community.CommunityDTO;
import com.mbc.pet.community.CommunityService;
import com.mbc.pet.community.PageDTO;
import com.mbc.pet.point.PointDTO;
import com.mbc.pet.point.PointService;
import com.mbc.pet.user.UserDTO;
import com.mbc.pet.user.UserService;

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
        return "QuizView";
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
        int grape = isCorrect ? 3 : 0;
        
        //실제 풀이 시간 받기
        int timeTaken=Integer.parseInt(request.getParameter("result_time"));

        //----------------------정답 포도알 +3 dasom
        // 결과 저장
        QuizResultDTO redto = new QuizResultDTO();
        redto.setResult_score(score); // 맞았으면 1, 틀렸으면 0
        redto.setResult_rank(0);
        redto.setResult_time(timeTaken); // 풀이 시간
        redto.setUser_id(user_id);
        redto.setQuiz_id(quiz_id);
        redto.setGet_grape(isCorrect ? 3 : 0); // 정답 시만 3점 적립
        qs.insertQuizResult(redto);

        //정답일때  포도알 적립 처리
        if (isCorrect) {
            PointService ps = sqlSession.getMapper(PointService.class);

            // 포인트 적립 기록
            PointDTO point = new PointDTO();
            point.setUser_id(user_id);
            point.setPoint_action("quiz"); // 적립 타입
            point.setPoint_action_id(quiz_id); // 퀴즈 ID 기준
            point.setPoint_earned_grapes(3); // 지급량
            ps.insert_point(point);

            // 유저 테이블 포도알 +3 업데이트
            sqlSession.getMapper(UserService.class).quiz_grapes(user_id, 3);

            // 세션 갱신 (메뉴바 포도알 실시간 반영용)
            UserDTO updated = sqlSession.getMapper(UserService.class).selectUserByLoginId(user_login_id);
            session.setAttribute("loginUser", updated);
	        
	        //포도알 +10 여기까지
	        
	        //순위 계산
	        int MyRank = qs.time_rank(quiz_id, user_id);
	        redto.setResult_rank(MyRank);
	        mo.addAttribute("redto", redto);
        } else {
            mo.addAttribute("redto", null); // 오답일 경우 개인 기록은 null
        }

        // ✅ 오답이더라도 TOP 10 랭킹은 항상 전달
        mo.addAttribute("top10", qs.top10rank(quiz_id));

        // 정답 여부 및 퀴즈 정보 전달
        mo.addAttribute("isCorrect", isCorrect);
        mo.addAttribute("quiz", dbQuiz);


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
    
    //퀴즈 목록
    @RequestMapping("/Quiz_admin")
    public String quizupdate(Model mo, PageDTO dto, @RequestParam(defaultValue = "1") int page) {
    	QuizService qs= sqlSession.getMapper(QuizService.class);
    	
    	// 페이징 기본 설정
        int page_size = 10; // 한 페이지당 퀴즈 수
        int start = (page - 1) * page_size;
        int end = page_size;

        // 전체 퀴즈 개수 구하기
        int total_count = qs.getQuizCount(); // 새로 만들어야 할 메서드
        int page_count = (int) Math.ceil((double) total_count / page_size);

        // 퀴즈 목록 조회 (start부터 page_size개 조회)
        List<QuizDTO> list = qs.getQuizListByPage(start, end);
     
        mo.addAttribute("list", list);
        mo.addAttribute("page", page);
        mo.addAttribute("page_count", page_count);
        mo.addAttribute("page_size", page_size);
        mo.addAttribute("optionFields", Arrays.asList("quiz_option1", "quiz_option2", "quiz_option3", "quiz_option4"));
        return "Quiz_admin";
    }
    
 // 퀴즈 수정 페이지 이동
    @RequestMapping("/quiz_admin/edit/{quiz_id}")
    public String quizEdit(@PathVariable("quiz_id") int quiz_id, Model model) {
        QuizService qs = sqlSession.getMapper(QuizService.class);
        QuizDTO dto = qs.getQuizById(quiz_id);
        model.addAttribute("dto", dto);
        return "Quiz_edit";
    }

    // 퀴즈 수정 처리
    @RequestMapping("/quiz_admin/update")
    public String quizUpdate(QuizDTO dto, RedirectAttributes rttr) {
        QuizService qs = sqlSession.getMapper(QuizService.class);
        qs.updateQuiz(dto);
        rttr.addFlashAttribute("msg", "퀴즈가 수정되었습니다.");
        return "redirect:/Quiz_admin";
    }

    // 퀴즈 삭제 처리
    @RequestMapping("/quiz_admin/delete/{quiz_id}")
    public String quizDelete(@PathVariable("quiz_id") int quiz_id, RedirectAttributes rttr) {
        QuizService qs = sqlSession.getMapper(QuizService.class);
        qs.deleteQuiz(quiz_id);
        rttr.addFlashAttribute("msg", "퀴즈가 삭제되었습니다.");
        return "redirect:/Quiz_admin";
    }
    
}
