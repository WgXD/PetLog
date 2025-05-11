package com.mbc.pet.diary;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.mbc.pet.pet.PetDTO;
import com.mbc.pet.pet.PetService;
import com.mbc.pet.point.PointDTO;
import com.mbc.pet.point.PointService;
import com.mbc.pet.user.UserDTO;
import com.mbc.pet.user.UserService;

@Controller
public class DiaryController {
	
	@Autowired
	SqlSession sqlSession;
	//String path = "C:\\1MBC\\spring\\PetLog\\src\\main\\webapp\\image";
	Principal principa;
	
	
	@RequestMapping(value = "/diary_input") // top에서 다이어리 작성 버튼 눌렀을 때
	public String diary(HttpSession session, Model mo) {
	    
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
	    
	    // 유저의 반려동물 목록 불러오기 (다이어리 작성 시 선택을 위해)
	    PetService petService = sqlSession.getMapper(PetService.class);
	    ArrayList<PetDTO> list = petService.petsbyuser(user_id);

	    // JSP로 전달
	    mo.addAttribute("list", list);

        return "diary_input"; //jsp file name
	}

	
	@RequestMapping(value = "/diary_save") // diary_input.jsp 에서 등록버튼 눌렀을 때
	public String diary1(MultipartHttpServletRequest request, HttpSession session) throws IllegalStateException, IOException {
		
		String path = request.getSession().getServletContext().getRealPath("/image");
		
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }

	    int pet_id = Integer.parseInt(request.getParameter("pet_id"));
		String diary_title = request.getParameter("diary_title");
		String diary_date = request.getParameter("diary_date");
		MultipartFile image = request.getFile("diary_image");
		String filename = image.getOriginalFilename();
		String diary_content = request.getParameter("diary_content");

		UUID ud = UUID.randomUUID();
		filename = ud.toString()+"_"+filename;

		DiaryService ds = sqlSession.getMapper(DiaryService.class);
		PointService ps = sqlSession.getMapper(PointService.class);

		// 다음 diary_id 조회 (시퀀스처럼 동작)
		int next_diaryid = ds.get_id();

		// DTO에 데이터 세팅
		DiaryDTO dd = new DiaryDTO();
		dd.setDiary_id(next_diaryid);
		dd.setDiary_title(diary_title);
		dd.setDiary_date(diary_date);
		dd.setDiary_image(filename);
		dd.setDiary_content(diary_content);
		dd.setGet_grape(0); // 처음에는 포도알 0
		dd.setPet_id(pet_id);
		dd.setUser_id(user_id);
		
		ds.diary_save(dd);

		image.transferTo(new File(path + "\\" + filename));

		// 포도알 지급 처리
		if (dd.getGet_grape() == 0) {
			PointDTO point = new PointDTO();
			point.setUser_id(user_id);
			point.setPoint_action("diary");
			point.setPoint_action_id(dd.getDiary_id());
			point.setPoint_earned_grapes(1);
			ps.insert_point(point);
			
			ds.grape_check(dd.getDiary_id()); // 지급 여부 체크 및 플래그 변경
		}

		//일기 작성 완료시 포도알 +1--------------------------------------------------------------------------------
		// 포도알 개수 +1 (user1.grape_count 증가)
		sqlSession.getMapper(UserService.class).plusGrapeCount(user_id);

		// 세션 갱신 (메뉴바 포도알 실시간 반영)
		UserDTO updated = sqlSession.getMapper(UserService.class).selectUserByLoginId(user_login_id);
		session.setAttribute("loginUser", updated);
		
		return "redirect:/diary_input";
	}

	
	@RequestMapping(value = "/diary_out") // 다이어리 목록 출력
	public String diary2(Model mo, HttpServletRequest request, HttpSession session, @RequestParam(value = "page", defaultValue = "1") int page) {
		
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }

		// 페이징 처리 1
		int page_size = 5;
		int start = (page-1) * page_size;
		int end = start + page_size;

		DiaryService ds = sqlSession.getMapper(DiaryService.class);

		// 페이징 처리 2
		int total_count = ds.total_diary(user_id);
		int page_count = (int) Math.ceil((double)total_count / page_size);

		// 페이징 처리 3
		ArrayList<DiaryDTO> list = ds.diary_out(start, end, user_id);
		 
		mo.addAttribute("list", list);
		mo.addAttribute("page", page);
		mo.addAttribute("page_count", page_count);
		mo.addAttribute("page_size", page_size);

		return "diary_out";
	}
	
	@RequestMapping(value = "/diary_detail") // 다이어리 상세 보기
	public String diary3(@RequestParam("diary_id") int diary_id, Model mo, HttpServletRequest request, HttpSession session) {

    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }

	    //int unum = Integer.parseInt(request.getParameter("unum"));
	    DiaryService ds = sqlSession.getMapper(DiaryService.class);
	    //DiaryDTO dto = ds.diary_detail(unum);
	    DiaryDTO dto = ds.diary_detail(diary_id); //달력에 일기 출력한 거 누르면 -> 자세히 보기로 이동
	    mo.addAttribute("dto", dto);
	    
	    UserService us = sqlSession.getMapper(UserService.class);
	    UserDTO loginUser = us.getUserById(user_id);
	    session.setAttribute("loginUser", loginUser);

	    return "diary_detail";
	}
	
	@RequestMapping(value = "/diary_update") // 다이어리 수정 폼 호출
	public String diary4(Model mo, HttpServletRequest request, HttpSession session) {
		
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }

		int update = Integer.parseInt(request.getParameter("update"));
		DiaryService ds = sqlSession.getMapper(DiaryService.class);
		DiaryDTO dto = ds.diary_update(update);
		mo.addAttribute("dto", dto);
		
		return "diary_update";
	}

	@RequestMapping(value = "/update_save") // 다이어리 수정 저장
	public String diary5(MultipartHttpServletRequest mul, HttpSession session) throws IllegalStateException, IOException {

	    // 로그인 체크
	    Integer user_id = (Integer) session.getAttribute("user_id");
	    String user_login_id = (String) session.getAttribute("user_login_id");

	    if (user_id == null || user_login_id == null) {
	        return "redirect:/login?error=login_required";
	    }

	    String path = mul.getSession().getServletContext().getRealPath("/image");

	    int diary_id = Integer.parseInt(mul.getParameter("diary_id")); 
	    String diary_title = mul.getParameter("diary_title");
	    String diary_date = mul.getParameter("diary_date");
	    String diary_content = mul.getParameter("diary_content");
	    MultipartFile mf = mul.getFile("diary_image");
	    String dfimage = mul.getParameter("himage");

	    // [⚠️ 위험] mf가 null일 경우 NPE 발생 가능 → 아래에서 fname 처리 위치 옮겨서 대응함
	    String fname = null;

	    if (mf != null && !mf.isEmpty()) {
	        fname = UUID.randomUUID().toString() + "_" + mf.getOriginalFilename();
	        mf.transferTo(new File(path + "\\" + fname));

	        if (dfimage != null && !dfimage.trim().equals("")) {
	            File ff = new File(path + "\\" + dfimage);
	            if (ff.exists()) ff.delete();
	        }
	    } else {
	        fname = dfimage;
	    }

	    DiaryService ds = sqlSession.getMapper(DiaryService.class);
	    DiaryDTO dto = ds.diary_detail(diary_id);
	    int pet_id = dto.getPet_id();

	    ds.update_save(diary_id, diary_title, diary_date, fname, diary_content, user_id, pet_id);

	    return "redirect:/diary_out";
	}

	@RequestMapping(value = "/diary_delete") // 삭제 확인 페이지
	public String diary6(HttpServletRequest request, Model mo, HttpSession session) {
		
	    // 로그인 체크
	    Integer user_id = (Integer) session.getAttribute("user_id");
	    String user_login_id = (String) session.getAttribute("user_login_id");

	    if (user_id == null || user_login_id == null) {
	        return "redirect:/login?error=login_required";
	    }

		int delete = Integer.parseInt(request.getParameter("delete"));
		DiaryService ds = sqlSession.getMapper(DiaryService.class);
		DiaryDTO dto = ds.delete_check(delete);
		mo.addAttribute("dto", dto);

		return "diary_delete";
	}
	
	@RequestMapping(value = "/delete_page") // 실제 삭제 처리
	public String diary7(HttpServletRequest request, Model mo, HttpSession session) {
		
	    // 로그인 체크
	    Integer user_id = (Integer) session.getAttribute("user_id");
	    String user_login_id = (String) session.getAttribute("user_login_id");

	    if (user_id == null || user_login_id == null) {
	        return "redirect:/login?error=login_required";
	    }

		String path = request.getSession().getServletContext().getRealPath("/image");

		int delete = Integer.parseInt(request.getParameter("diary_id"));
		String dfname = request.getParameter("himage");

		DiaryService ds = sqlSession.getMapper(DiaryService.class);
		ds.delete_page(delete);

		File ff = new File(path + "\\" + dfname);
		ff.delete();

		return "redirect:/diary_out";
	}
	
	
}
