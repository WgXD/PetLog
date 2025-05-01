package com.mbc.pet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

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
	public String home(HttpSession session) {
		
		Integer user_id = (Integer) session.getAttribute("user_id");
	       System.out.println("user_id: " + user_id);

	       if (user_id != null) {
	           CommunityService cs = sqlSession.getMapper(CommunityService.class);

	           // ?œ… ?—¬ê¸°ê? ë°”ë¡œ ?””ë²„ê¹…?š© ì½”ë“œ ?„£?Š” ?œ„ì¹?!
	           String role = cs.getUserRole(user_id);
	           System.out.println("ì¿¼ë¦¬ ê²°ê³¼ user_role: [" + role + "]");

	           session.setAttribute("user_role", role);
	       }
		return "main";
	}
	
}
