package com.mbc.pet.point;

import java.util.ArrayList;


import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.mbc.pet.user.UserDTO;
import com.mbc.pet.user.UserService;

@RequestMapping("/point")	
@Controller
public class PointController {
	
	@Autowired
	SqlSession sqlSession;
    
    @RequestMapping(value = "/grapes_admin_form", method = RequestMethod.GET) //Get 받기 용
    public String showGrantForm(HttpSession session, Model mo) {

        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }

        UserService us = sqlSession.getMapper(UserService.class);
        ArrayList<UserDTO> list = us.get_all_users(); //전체 유저 목록 출력하기
        mo.addAttribute("list", list);
        
        return "grapes_admin";  // 폼 있는 JSP 이름
    }
    
    @RequestMapping(value = "/grapes_admin", method = RequestMethod.POST) //관리자용 포도알 관리 페이지
    public String admin(HttpSession session, @RequestParam("user_id1") int user_id1, @RequestParam("grape_amount") int grape_amount, Model mo) {

        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }

        PointService ps = sqlSession.getMapper(PointService.class);
        boolean result = ps.grant_grapes(user_id1,grape_amount);
        mo.addAttribute("message", result ? "포도알 적용 완료!" : "유저 없음 또는 지급 실패");
        
        // ✅ 관리자 본인에게 지급했을 경우 세션 loginUser 갱신
        if (user_id.equals(user_id1)) {
            UserService us = sqlSession.getMapper(UserService.class);
            UserDTO updatedUser = us.selectUserByLoginId(user_login_id);
            session.setAttribute("loginUser", updatedUser);
        }
        
        UserService us = sqlSession.getMapper(UserService.class);
        ArrayList<UserDTO> list = us.get_all_users();
        mo.addAttribute("list", list);

        return "grapes_admin";
    }
    
    
    @RequestMapping(value = "/grapes_rank", method = RequestMethod.GET)
    public String showGrapeRanking(HttpSession session, Model mo) {

        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
        
        UserService us = sqlSession.getMapper(UserService.class);
        UserDTO updatedUser = us.selectUserByLoginId(user_login_id);
        session.setAttribute("loginUser", updatedUser);
        
        ArrayList<UserDTO> list = us.get_all_users(); // 이미 내림차순 정렬되어 있어야 함
        mo.addAttribute("list", list);

        return "grapes_rank";
    }
    
}
 
	
	
	
	
	

