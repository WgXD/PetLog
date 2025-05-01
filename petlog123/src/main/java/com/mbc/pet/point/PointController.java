package com.mbc.pet.point;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
	
	@Controller
	public class PointController {

	    @RequestMapping(value = "/stamp_grapes") //�������� ���
	    public String point(HttpSession session) {
	    	
			//��ȸ�� ����
		    Integer user_id = (Integer) session.getAttribute("user_id");

		    if (user_id == null) {
		    	return "redirect:/login?error=login_required"; // ��ȸ�� ���� ���� + alert ����
		    }
	    	
		    
	        return "stamp_grapes"; //jsp file name
	    }
	      
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	}
	
	
	
	
	
	

