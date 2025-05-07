package com.mbc.pet.calendar;

import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mbc.pet.diary.DiaryDTO;
import com.mbc.pet.diary.DiaryService;

@Controller
public class CalController {
	
	@Autowired
	SqlSession sqlSession;
	
	
	@RequestMapping(value = "/calendar_view") // top에서 "달력 보기"
	public String cal(HttpSession session, Model mo, @RequestParam(value = "year", required = false) Integer year, @RequestParam(value = "month", required = false) Integer month) {
	    
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
        
        Calendar cal = Calendar.getInstance();
        
        if (year!= null && month != null) {
        	
        	cal.set(Calendar.YEAR, year);
        	cal.set(Calendar.MONTH, month-1);
        }
        
        int current_year = cal.get(Calendar.YEAR);
        int current_month = cal.get(Calendar.MONTH)+1;
        
        mo.addAttribute("current_year", current_year);
        mo.addAttribute("current_month", current_month);
        
        CalService cals = sqlSession.getMapper(CalService.class);
        ArrayList<CalDTO> list = cals.by_months(user_id,current_year,current_month);
        //로그인한 유저의 특정 년도와 월에 있는 일정 데이터 불러오기용
        mo.addAttribute("list",list);

        //------달력에 다이어리 작성한 것 추가---------
        DiaryService ds = sqlSession.getMapper(DiaryService.class);
        ArrayList<DiaryDTO> dto = ds.diary_by_months(user_id,current_year,current_month);
        mo.addAttribute("dto", dto);
        
        return "calendar_view"; //jsp file name
	}


}
