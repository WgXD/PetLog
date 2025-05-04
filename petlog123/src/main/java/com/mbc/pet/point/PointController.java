package com.mbc.pet.point;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
	
	@Controller
	public class PointController {

	    @RequestMapping(value = "/stamp_grapes") //
	    public String point(HttpSession session) {
	    	
	    	// 로그인 체크
	        Integer user_id = (Integer) session.getAttribute("user_id");
	        String user_login_id = (String) session.getAttribute("user_login_id");

	        if (user_id == null || user_login_id == null) {
	            return "redirect:/login?error=login_required";
	        }
	    	
		    
	        return "stamp_grapes"; //jsp file name
	    }
	      
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	}
	
	
	
	
	
	

