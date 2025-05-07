package com.mbc.pet.calendar;

import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.mbc.pet.diary.DiaryDTO;
import com.mbc.pet.diary.DiaryService;
import com.mbc.pet.pet.PetDTO;
import com.mbc.pet.pet.PetService;

@Controller
public class CalController {
	
	@Autowired
	SqlSession sqlSession;
	
	@RequestMapping(value = "/calendar_view") // top에서 "달력 보기"
	public String cal(@RequestParam(value = "pet_id", required = false) Integer pet_id,
	                  HttpSession session, Model mo,
	                  @RequestParam(value = "year", required = false) Integer year,
	                  @RequestParam(value = "month", required = false) Integer month) {

	    // 로그인 체크
	    Integer user_id = (Integer) session.getAttribute("user_id");
	    String user_login_id = (String) session.getAttribute("user_login_id");

	    if (user_id == null || user_login_id == null) {
	        return "redirect:/login?error=login_required";
	    }

	    // ✅ 항상 반려동물 목록을 가져옴 (드롭다운 유지 위해)
	    PetService ps = sqlSession.getMapper(PetService.class);
	    ArrayList<PetDTO> petlist = ps.petsbyuser(user_id);
	    mo.addAttribute("petlist", petlist);

	    // pet_id 없으면 첫 번째 반려동물로 자동 설정
	    if (pet_id == null) {
	        if (petlist != null && !petlist.isEmpty()) {
	            pet_id = petlist.get(0).getPet_id(); // 첫 번째 반려동물 사용
	        } else {
	            return "redirect:/calendar_input?error=no_pet"; // 펫 없을 경우 등록 페이지로
	        }
	    }

	    // 날짜 설정
	    Calendar cal = Calendar.getInstance();
	    if (year != null && month != null) {
	        cal.set(Calendar.YEAR, year);
	        cal.set(Calendar.MONTH, month - 1);
	    }

	    int current_year = cal.get(Calendar.YEAR);
	    int current_month = cal.get(Calendar.MONTH) + 1;

	    mo.addAttribute("current_year", current_year);
	    mo.addAttribute("current_month", current_month);
	    mo.addAttribute("pet_id", pet_id); // 현재 선택된 pet_id도 넘겨줌

	    // 일정 데이터 불러오기
	    CalService cals = sqlSession.getMapper(CalService.class);
	    ArrayList<CalDTO> list = cals.by_months(user_id, current_year, current_month, pet_id);
	    mo.addAttribute("list", list);

	    // 다이어리 데이터 불러오기
	    DiaryService ds = sqlSession.getMapper(DiaryService.class);
	    ArrayList<DiaryDTO> dto = ds.diary_by_months(user_id, current_year, current_month, pet_id);
	    mo.addAttribute("dto", dto);

	    return "calendar_view";
	}

	
	@RequestMapping(value = "/calendar_input")
	public String cal1(HttpSession session, Model mo) {
		
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
		
        PetService ps = sqlSession.getMapper(PetService.class);
        ArrayList<PetDTO> petlist = ps.petsbyuser(user_id);
        
        mo.addAttribute("petlist", petlist);
        		
		return "calendar_input";
	}
	
	
	@RequestMapping(value = "/cal_save") //직접 추가한 일정 DB에 저장
	public String cal2(HttpSession session, HttpServletRequest request) {
		
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
		
        int pet_id = Integer.parseInt(request.getParameter("pet_id"));
        String cal_title = request.getParameter("cal_title");
        String cal_content = request.getParameter("cal_content");
        String cal_date = request.getParameter("cal_date");
        
        
        CalDTO cdto = new CalDTO();
        cdto.setCal_title(cal_title);
        cdto.setCal_content(cal_content);
        cdto.setCal_date(cal_date);
        cdto.setPet_id(pet_id);
        cdto.setUser_id(user_id);
        
        CalService cs = sqlSession.getMapper(CalService.class);
        cs.cal_save(cdto);
       
		return "redirect:/calendar_view?pet_id=" +pet_id;
	}

}
