package com.mbc.pet.qna;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mbc.pet.community.PageDTO;

import java.util.Objects;

@Controller
public class QnAController { 

	@Autowired
	SqlSession sqlSession;
	
	// qna 입력 화면으로 이동
	@RequestMapping(value = "/QnAinput")
	public String qna(HttpSession session) {
		
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
		
		//Integer user_id = (Integer) session.getAttribute("user_id");
	    //String user_login_id = (String) session.getAttribute("user_login_id");

	    if (user_id == null || user_login_id == null) {
	    return "redirect:/login";
	    }
		return "QnAInput";
	}
	
	//qna 등록
	@RequestMapping(value = "/submitContact")
	public String qna1(HttpSession session, HttpServletRequest request) {
		
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
		
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
	public String qna0(HttpSession session, PageDTO dto,Model mo, @RequestParam(defaultValue = "1") int page) {
		
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
        //페이징 처리 1
        int page_size = 10; //한 페이지에 출력할 게시물 갯수
        int start = (page-1) * page_size; //현재 페이지에서 시작하는 데이터의 위치를 계산하는 공식
        int end = start + page_size;
        //페이징 1 end
        
	    QnAService qs = sqlSession.getMapper(QnAService.class);

	    //페이징 처리 2
        int total_count = qs.totalByType(); //전체 갯수 //ceil 숫자 올림
        int page_count = (int) Math.ceil((double)total_count / page_size);
        //페이징 2 end
        
	    List<QnADTO> list = qs.allqnalist(start, end);  //페이징 쿼리 호출
	    mo.addAttribute("list", list);
	    mo.addAttribute("page", page);
		mo.addAttribute("page_count", page_count);
		mo.addAttribute("page_size", page_size);
		return "QnAList";
	}
	
	//작성글 자세히 보기(작성자, 관리자만 접근)
	@RequestMapping(value = "/qnadetail")
	public String qna5(HttpSession session, Model mo, HttpServletRequest request, RedirectAttributes redirectAttr) {
		
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
        
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
	public String qna6(HttpServletRequest request, RedirectAttributes redirectAttr, HttpSession session) {
		
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
        
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
	
	// 수정 폼 이동
	@RequestMapping("/qna/edit/{qna_id}")
	public String editQnA(@PathVariable int qna_id, HttpSession session, Model model, RedirectAttributes ra) {
	    QnAService service = sqlSession.getMapper(QnAService.class);
	    QnADTO dto = service.getQnAById(qna_id);
	    int loginUserId = Integer.parseInt(session.getAttribute("user_id").toString());

	    if (dto.getUser_id() != loginUserId) {
	        ra.addFlashAttribute("msg", "본인 글만 수정할 수 있습니다.");
	        return "redirect:/qnalist";
	    }
	    model.addAttribute("dto", dto);
	    return "QnA/QnA_edit";
	}

	// 수정 처리
	@RequestMapping("/qna/update")
	public String updateQnA(QnADTO dto, HttpSession session, RedirectAttributes ra) {
		 // ✔ 로그인 체크
	    Object userIdAttr = session.getAttribute("user_id");
	    if (userIdAttr == null) {
	        ra.addFlashAttribute("alertMsg", "로그인 후 이용해주세요.");
	        return "redirect:/login";
	    }
	    
	    int loginUserId = Integer.parseInt(session.getAttribute("user_id").toString());
	    if (dto.getUser_id() != loginUserId) {
	        ra.addFlashAttribute("alertMsg", "수정 권한이 없습니다.");
	        return "redirect:/qnalist";
	    }
	    if ("완료".equals(dto.getQna_status())) {
	        ra.addFlashAttribute("alertMsg", "답변이 달린 글은 수정할 수 없습니다.");
	        return "redirect:/qnalist";
	    }
	    QnAService service = sqlSession.getMapper(QnAService.class);
	    service.updateQnA(dto);
	    ra.addFlashAttribute("alertMsg", "수정 완료!");
	    return "redirect:/qnalist";
	}

	// 삭제 처리
	@RequestMapping("/qna/delete/{qna_id}")
	public String deleteQnA(@PathVariable int qna_id, HttpSession session, RedirectAttributes ra) {
	    QnAService service = sqlSession.getMapper(QnAService.class);
	    QnADTO dto = service.getQnAById(qna_id);
	    int loginUserId = Integer.parseInt(session.getAttribute("user_id").toString());

	    if (dto.getUser_id() != loginUserId) {
	        ra.addFlashAttribute("alertMsg", "삭제 권한이 없습니다.");
	        return "redirect:/qnalist";
	    }
	    if (dto.getQna_status().equals("완료")) {
	        ra.addFlashAttribute("alertMsg", "답변이 달린 글은 삭제할 수 없습니다.");
	        return "redirect:/qnalist";
	    }
	    service.deleteQnA(qna_id);
	    ra.addFlashAttribute("alertMsg", "삭제 완료!");
	    return "redirect:/qnalist";
	}

}
