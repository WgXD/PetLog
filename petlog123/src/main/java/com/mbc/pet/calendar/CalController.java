package com.mbc.pet.calendar;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CalController {
	
	@Autowired
	SqlSession sqlSession;
	
	
	@RequestMapping(value = "/calendar_view") // top에서 다이어리 작성 버튼 눌렀을 때
	public String diary(HttpSession session, Model mo) {
	    
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
	

        return "calendar_view"; //jsp file name
	}


}
