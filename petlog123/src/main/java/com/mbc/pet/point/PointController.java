package com.mbc.pet.point;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
	
	@Controller
	public class PointController {

	    @RequestMapping(value = "/stamp_grapes") //포도송이 출력
	    public String point(HttpSession session) {
	    	
			//비회원 막기
		    Integer user_id = (Integer) session.getAttribute("user_id");

		    if (user_id == null) {
		    	return "redirect:/login?error=login_required"; // 비회원 접근 차단 + alert 유도
		    }
	    	
		    
	        return "stamp_grapes"; //jsp file name
	    }
	      
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	}
	
	
	
	
	
	

