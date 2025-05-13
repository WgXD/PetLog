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
import org.springframework.web.bind.annotation.RequestMethod;
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
	
	@RequestMapping(value = "/calendar_input", method = RequestMethod.POST) //modal용
	public String insertSchedule(HttpServletRequest request, HttpSession session) {
	    
	    Integer user_id = (Integer) session.getAttribute("user_id");
	    String user_login_id = (String) session.getAttribute("user_login_id");

	    if (user_id == null || user_login_id == null) {
	        return "redirect:/login?error=login_required";
	    }

	    String cal_title = request.getParameter("cal_title");
	    String cal_content = request.getParameter("cal_content");
	    String cal_date = request.getParameter("cal_date"); // yyyy-MM-dd
	    int pet_id = Integer.parseInt(request.getParameter("pet_id"));

	    CalService cs = sqlSession.getMapper(CalService.class);
	    cs.insertSchedule(cal_title, cal_content, cal_date, pet_id, user_id);

	    return "redirect:/calendar_view"; // 작성 후 다시 달력으로
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
        
        String[] parts = cal_date.split("-");
        String year = parts[0];
        String month = parts[1];
       
		return "redirect:/calendar_view?pet_id=" +pet_id + "&year=" + year + "&month=" + month;
	}

	@RequestMapping(value = "/calendar_detail") //일정 내용 자세히 보기
	public String cal_d(@RequestParam("cal_id") int cal_id, HttpSession session, Model mo) {
		
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
		
        CalService cs = sqlSession.getMapper(CalService.class);
        CalDTO cdto = cs.calendar_detail(cal_id);
        mo.addAttribute("cdto", cdto);
        
        mo.addAttribute("current_year", cdto.getCal_date().substring(0, 4));
        mo.addAttribute("current_month", cdto.getCal_date().substring(5, 7));
        mo.addAttribute("pet_id", cdto.getPet_id());
       
		return "calendar_detail";
	}

	@RequestMapping(value = "/calendar_delete")
	public String cal_delete(HttpSession session, Model mo, HttpServletRequest req,
							@RequestParam("cal_id") int cal_id,
				            @RequestParam("year") int year,
				            @RequestParam("month") int month,
				            @RequestParam("pet_id") int pet_id) {
		
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
		
        CalService cs = sqlSession.getMapper(CalService.class);
        cs.cal_delete(cal_id);
        
        return "redirect:/calendar_view?pet_id=" + pet_id + "&year=" + year + "&month=" + month;
	}
	
	@RequestMapping(value = "/calendar_update") //일정 수정
	public String cal_update(Model mo, HttpServletRequest req, HttpSession session) {

	    Integer user_id = (Integer) session.getAttribute("user_id");
	    String user_login_id = (String) session.getAttribute("user_login_id");

	    if (user_id == null || user_login_id == null) {
	        return "redirect:/login?error=login_required";
	    }

	    int cal_id = Integer.parseInt(req.getParameter("cal_id"));
	    
	    CalService cs = sqlSession.getMapper(CalService.class);
	    CalDTO cdto = cs.calendar_detail(cal_id);
	    
	    mo.addAttribute("cdto", cdto);

	    return "calendar_update";
	}
	
	@RequestMapping(value = "/cupdate_save")
	public String cal_update_save(HttpServletRequest req, HttpSession session) {

	    Integer user_id = (Integer) session.getAttribute("user_id");
	    String user_login_id = (String) session.getAttribute("user_login_id");

	    if (user_id == null || user_login_id == null) {
	        return "redirect:/login?error=login_required";
	    }

	    int cal_id = Integer.parseInt(req.getParameter("cal_id"));
	    String cal_title = req.getParameter("cal_title");
	    String cal_date = req.getParameter("cal_date");
	    String cal_content = req.getParameter("cal_content");
	    int pet_id = Integer.parseInt(req.getParameter("pet_id"));

	    CalService cs = sqlSession.getMapper(CalService.class);
	    cs.update_save(cal_id, cal_title, cal_date, cal_content, user_id, pet_id);

	    return "redirect:/calendar_view?pet_id=" + pet_id;
	}

}
