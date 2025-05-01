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

@Controller
public class DiaryController {
	
	@Autowired
	SqlSession sqlSession;
	//String path = "C:\\1MBC\\spring\\PetLog\\src\\main\\webapp\\image";
	Principal principa;
	
	
	@RequestMapping(value = "/diary_input") //top에서 누르고 들어오는 곳
	public String diary(HttpSession session, Model mo) {
		
		//비회원 막기
	    Integer user_id = (Integer) session.getAttribute("user_id");

	    if (user_id == null) {
	    	return "redirect:/login?error=login_required"; // 비회원 접근 차단 + alert 유도
	    }
	    
	    // 반려동물 목록 불러오기 (여러 마리 있을 수도 있으니까)
	    PetService petService = sqlSession.getMapper(PetService.class);
	    ArrayList<PetDTO> list = petService.petsbyuser(user_id);

	    // JSP에 넘기기
	    mo.addAttribute("list", list);

        return "diary_input"; //jsp file name
	}

	
	@RequestMapping(value = "/diary_save") //from pet_input
	public String diary1(MultipartHttpServletRequest request) throws IllegalStateException, IOException {
		
		String path = request.getSession().getServletContext().getRealPath("/image");
		
	    // 로그인된 사용자 user_id 꺼냄
	    Integer user_id = (Integer) request.getSession().getAttribute("user_id");
	    
	    // null 체크 (예: 로그인 풀렸거나 비정상 접근 방지)
	    if (user_id == null) {
	        return "redirect:/login"; // 또는 에러 페이지로
	    }
	    
	    int pet_id = Integer.parseInt(request.getParameter("pet_id"));
	      
		//int diary_id = Integer.parseInt(request.getParameter("diary_id"));
		String diary_title = request.getParameter("diary_title");
		String diary_date = request.getParameter("diary_date");
		MultipartFile image = request.getFile("diary_image");
		String filename = image.getOriginalFilename();
		String diary_content = request.getParameter("diary_content");
		
		UUID ud = UUID.randomUUID();
		filename = ud.toString()+"_"+filename;
		
		//Service들 호출부분
		DiaryService ds = sqlSession.getMapper(DiaryService.class);
		PointService ps = sqlSession.getMapper(PointService.class);
		
		//Oracle 시퀀스에서 다음 diary_id 미리 뽑는 거
		int next_diaryid = ds.get_id();
		//
		
		//여기부터 포인트 적립 로직 추가 전용
		DiaryDTO dd = new DiaryDTO();
		dd.setDiary_id(next_diaryid);
		dd.setDiary_title(diary_title);
		dd.setDiary_date(diary_date);
		dd.setDiary_image(filename);
		dd.setDiary_content(diary_content);
		dd.setGet_grape(0); //글 아무것도 작성안하면 포도알 0개라 -> 0		
		dd.setPet_id(pet_id);
		dd.setUser_id(user_id);
		//여기까지
		
		ds.diary_save(dd);
		
		image.transferTo(new File(path+"\\"+filename));
		
		
		//여기부터 포도알 적립 -> 작성한 게시물로 포도알이 적립되었는지 check
		if(dd.getGet_grape()==0) {
			
			PointDTO point = new PointDTO();
			point.setUser_id(user_id);
			point.setPoint_action("diary");
			point.setPoint_action_id(dd.getDiary_id());
			point.setPoint_earned_grapes(1);
			ps.insert_point(point);
			
			ds.grape_check(dd.getDiary_id()); //boolean 0=false , 1=true
			
		}

		return "diary_input"; //jsp file name
	}

	
	@RequestMapping(value = "/diary_out") //top에서 누르고 들어오는 곳 //@RequestParam(defaultValue = "1") 디폴트로 1페이지 보여줌
	public String diary2(Model mo, HttpServletRequest request, @RequestParam(value = "page", defaultValue = "1") int page) {
		
		//비회원 막기
	    HttpSession hs = request.getSession();
	    Integer user_id = (Integer) hs.getAttribute("user_id");
	    if (user_id == null) {
	        return "redirect:/login?error=login_required";
	    }
	
	    
		//페이징 처리 1
		int page_size = 5; //한 페이지에 일기 5개씩 보이기!!
		int start = (page-1) * page_size; //현재 페이지에서 시작하는 데이터의 위치를 계산하는 공식
		int end = start + page_size;
		//페이징 1 end
		
		DiaryService ds = sqlSession.getMapper(DiaryService.class);
		
		//페이징 처리 2
		int total_count = ds.total_diary(); //전체 일기 갯수 //ceil 숫자 올림
		
		int page_count = (int) Math.ceil((double)total_count / page_size);
		//페이징 2 end
		
		//페이징 처리 3
		
		System.out.println("start: " + start);
		System.out.println("end: " + end);
		
		 ArrayList<DiaryDTO> list = ds.diary_out(start, end);
		 
		 //System.out.println("list size: " + list.size()); // 결과 목록의 크기 출력 for test
		 
		mo.addAttribute("list", list);
		mo.addAttribute("page", page);
		mo.addAttribute("page_count", page_count);
		mo.addAttribute("page_size", page_size);
		//페이징3 end
		
		return "diary_out"; //jsp file name
	}
	
	@RequestMapping(value = "/diary_detail")
	public String diary3(Model mo, HttpServletRequest request) {

	            int unum = Integer.parseInt(request.getParameter("unum"));
	            DiaryService ds = sqlSession.getMapper(DiaryService.class);
	            DiaryDTO dto = ds.diary_detail(unum);  // 해당 일기 데이터를 가져옴
	            mo.addAttribute("dto", dto); 

	    return "diary_detail";
	}
	
	@RequestMapping(value = "/diary_update") //detail 누르고 들어오는 곳 (연필)
	public String diary4(Model mo, HttpServletRequest request) {
		
			int update = Integer.parseInt(request.getParameter("update"));
			DiaryService ds = sqlSession.getMapper(DiaryService.class);
			DiaryDTO dto = ds.diary_update(update);
			mo.addAttribute("dto", dto);
		
		return "diary_update"; //jsp file name
	}

	
	@RequestMapping(value = "/update_save") //update에서 누르고 들어오는 곳
	public String diary5(MultipartHttpServletRequest mul) throws IllegalStateException, IOException {
		
		String path = mul.getSession().getServletContext().getRealPath("/image");
		
		int pet_id = 0;
		int user_id = 0;

		if (principa != null) {
		    try {
		        int parsedId = Integer.parseInt(principa.getName());
		        pet_id = parsedId;
		        user_id = parsedId; // 둘 다 동일한 아이디일 경우
		    } catch (NumberFormatException e) {
		        // 예외 발생 시 기본값 유지
		        pet_id = 0;
		        user_id = 0;
		    }
		}

		int diary_id = Integer.parseInt(mul.getParameter("diary_id")); 
		String diary_title = mul.getParameter("diary_title");
		String diary_date = mul.getParameter("diary_date");
		String diary_content = mul.getParameter("diary_content");
		MultipartFile mf = mul.getFile("diary_image");
		String dfimage = mul.getParameter("himage");
		String fname = mf.getOriginalFilename();
		
		// >> 여기부터 추가한 부분
		
		if (mf != null && !mf.isEmpty()) {
		    // 새 이미지가 있을 경우
		    fname = UUID.randomUUID().toString() + "_" + mf.getOriginalFilename();
		    mf.transferTo(new File(path + "\\" + fname));

		    // 기존 이미지 삭제
		    if (dfimage != null && !dfimage.trim().equals("")) {
		        File ff = new File(path + "\\" + dfimage);
		        if (ff.exists()) ff.delete();
		    }
		} else {
		    // 새 이미지가 없을 경우 기존 이미지 그대로 사용
		    fname = dfimage;
		}
		
		// << 여기까지
		
		DiaryService ds = sqlSession.getMapper(DiaryService.class);
		ds.update_save(diary_id, diary_title, diary_date, fname, diary_content,user_id, pet_id);
		

  
		return "redirect:/diary_out"; //jsp file name
	}
	
	
	@RequestMapping(value = "/diary_delete") //diary_detail.jsp 누르고 들어오는 곳 (휴지통)
	public String diary6(HttpServletRequest request,Model mo) {
		
		int delete = Integer.parseInt(request.getParameter("delete"));
		DiaryService ds = sqlSession.getMapper(DiaryService.class);
		
		DiaryDTO dto = ds.delete_check(delete);
		mo.addAttribute("dto", dto);
				
		return "diary_delete"; //jsp file name
	}
	
	@RequestMapping(value = "/delete_page") //diary_delete.jsp 누르고 들어오는 곳
	public String diary7(HttpServletRequest request,Model mo) {
		
		String path = request.getSession().getServletContext().getRealPath("/image");
		
		int delete = Integer.parseInt(request.getParameter("diary_id"));
		String dfname = request.getParameter("himage");
		
		DiaryService ds = sqlSession.getMapper(DiaryService.class);
		ds.delete_page(delete);
				
		File ff = new File(path+"\\"+dfname);
		ff.delete();
		
		return "redirect:/diary_out"; //jsp file name
	}
	
	
	
	
	
}
