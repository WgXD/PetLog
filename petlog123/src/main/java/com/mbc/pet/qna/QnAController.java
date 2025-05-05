package com.mbc.pet.qna;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.util.Objects;

@Controller
public class QnAController {

	@Autowired
	SqlSession sqlSession;
	
	// qna 입력 화면으로 이동
	@RequestMapping(value = "/QnAinput")
	public String qna(HttpSession session) {
		Integer user_id = (Integer) session.getAttribute("user_id");
	    String user_login_id = (String) session.getAttribute("user_login_id");

	    if (user_id == null || user_login_id == null) {
	    return "redirect:/login";
	    }
		return "QnAInput";
	}
	
	//qna 등록
	@RequestMapping(value = "/submitContact")
	public String qna1(HttpSession session, HttpServletRequest request) {
		Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");
        String qna_title = request.getParameter("qna_title");
        String qna_content = request.getParameter("qna_content");
        
        QnADTO dto= new QnADTO();
        dto.setUser_id(user_id);
        dto.setQna_title(qna_title);
        dto.setQna_content(qna_content);
        
        QnAService qs = sqlSession.getMapper(QnAService.class);
        qs.insertqna(dto);
        
		return "QnASaveView";
	}
	
	//qna 목록 출력
	@RequestMapping(value = "/qnalist")
	public String qna0(HttpSession session, Model mo) {
		Integer user_id = (Integer) session.getAttribute("user_id");
	    String user_login_id = (String) session.getAttribute("user_login_id");

	    if (user_id == null || user_login_id == null) {
	    return "redirect:/login";
	    }
	    
	    QnAService qs = sqlSession.getMapper(QnAService.class);
	    List<QnADTO> list = qs.allqnalist();
	    mo.addAttribute("list", list);
		return "QnAList";
	}
	
	//작성글 자세히 보기(작성자, 관리자만 접근)
	@RequestMapping(value = "/qnadetail")
	public String qna5(HttpSession session, Model mo, HttpServletRequest request, RedirectAttributes redirectAttr) {
		Integer user_id = (Integer) session.getAttribute("user_id");
	    String user_login_id = (String) session.getAttribute("user_login_id");
	    String user_role = (String)session.getAttribute("user_role");
	    Integer qnum = Integer.parseInt(request.getParameter("qnum"));

	    if (user_id == null || user_login_id == null) {
	    return "redirect:/login";
	    }
	    
	    QnAService qs = sqlSession.getMapper(QnAService.class);
	    QnADTO dto= qs.qnadetail(qnum);
	    
	    if (dto == null || (!Objects.equals(dto.getUser_id(), user_id) && !"admin".equals(user_role))) {
	        redirectAttr.addFlashAttribute("alertMsg", "작성자만 열람 가능합니다.");
	        return "redirect:/qnalist";
	    }
	    mo.addAttribute("dto", dto);
		return "QnADetail";
	}
	
	//관리자용 답변
	@RequestMapping(value = "/updateAnswer")
	public String qna6(HttpServletRequest request, RedirectAttributes redirectAttr) {
		Integer qna_id = Integer.parseInt(request.getParameter("qna_id"));
		String qna_answer = request.getParameter("qna_answer");
		String qna_status= request.getParameter("qna_status");
		
		QnADTO dto = new QnADTO();
		dto.setQna_id(qna_id);
		dto.setQna_answer(qna_answer);
		dto.setQna_status(qna_status);
		
		QnAService qs= sqlSession.getMapper(QnAService.class);
		qs.updateqnswer(dto);
		
		redirectAttr.addFlashAttribute("alertMsg", "답변이 등록되었습니다.");
		return "redirect:/qnalist";
	}
}
