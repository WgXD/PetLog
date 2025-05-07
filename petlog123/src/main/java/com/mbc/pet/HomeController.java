package com.mbc.pet;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mbc.pet.calendar.CalDTO;
import com.mbc.pet.calendar.CalService;
import com.mbc.pet.community.CommunityService;

@Controller
public class HomeController {

	@Autowired
	SqlSession sqlSession;
	 
	@RequestMapping(value = "/")
	public String home1(HttpServletRequest request) {
		
			      HttpSession hs=request.getSession();
			      hs.setAttribute("loginstate", false);
		
		return "main";
	}
	
	
	@RequestMapping(value = "/main")
	public String home(HttpSession session, Model model) {

	    Integer user_id = (Integer) session.getAttribute("user_id");
	    System.out.println("user_id: " + user_id);

	    if (user_id != null) {
	        CommunityService cs = sqlSession.getMapper(CommunityService.class);
	        String role = cs.getUserRole(user_id);
	        session.setAttribute("user_role", role);

	        // 오늘 일정 가져오기
	        CalService cals = sqlSession.getMapper(CalService.class);
	        String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	        ArrayList<CalDTO> todaySchedule = cals.today_sche(user_id, today);
	        model.addAttribute("todaySchedule", todaySchedule);
	    }

	    return "main";
	
}
	
}
