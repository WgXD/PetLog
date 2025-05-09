package com.mbc.pet.point;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.mbc.pet.user.UserDTO;
import com.mbc.pet.user.UserService;

@Controller
public class GrapeController {
	
	@Autowired
	SqlSession sqlSession;

	
    @RequestMapping(value = "/stamp_grapes") //포도 게이지
    public String point(HttpSession session) {

        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }

        if (session.getAttribute("loginUser") == null) {
            UserService us = sqlSession.getMapper(UserService.class);
            UserDTO loginUser = us.selectUserByLoginId(user_login_id);
            session.setAttribute("loginUser", loginUser);
        }

        return "stamp_grapes";
    }

}
 
	
	
	
	
	

