package com.mbc.pet.usertems;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping("/items")
public class UsertemsController {
	
	@Autowired
	SqlSession sql;
	//String path = "C:\\1MBC\\spring\\PetLog\\src\\main\\webapp\\image";
	
	
//    @RequestMapping(value = "/myitem") 
//    public String utem1(@RequestParam("item_id") int item_id, HttpServletRequest request) {
//    	
//    	//int user_id = 1; //user_id �ӽð�!!!
//    	
//    	int user_id = (int) request.getSession().getAttribute("user_id")
//    	
//    	String usertem_equip = "N";
//    	
//    	UsertemsService us = sql.getMapper(UsertemsService.class);
//    	us.insert_usertem(user_id, item_id, usertem_equip);
//    	
//        return "items/buy_items"; //jsp file name
//    }
    
	// 아이템 구매 페이지 출력 매핑
	@RequestMapping(value = "/buy_items", method = RequestMethod.GET)
	public String showBuyItems(HttpServletRequest request, Model mo, HttpSession session) {
	    //int user_id = (int) request.getSession().getAttribute("user_id");
	    
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
        
        UsertemsService us = sql.getMapper(UsertemsService.class);
	    ArrayList<UsertemsDTO> list = us.get_items(user_id);
	    mo.addAttribute("list", list);

	    return "buy_items";
	}
	
	// Ajax로 아이템 구매 처리 매핑
	@RequestMapping(value = "/buy_items", method = RequestMethod.POST) // 구매 버튼 클릭 시 호출됨
	@ResponseBody
	public String utem2(@RequestParam("item_id") int item_id, HttpServletRequest request, HttpSession session) {
		
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
        
	   // int user_id = (int) request.getSession().getAttribute("user_id");
	    String usertem_equip = "N"; //디폴트=N(착용x)

	    UsertemsService us = sql.getMapper(UsertemsService.class);
	    
	    //아이템 이미 있는지 중복 체크
	    int count = us.check_usertem(user_id, item_id);
	    if (count > 0) {
	        return "already_owned"; // 이미 보유한 아이템이면 insert 안 함
	    }
	    
	    us.insert_usertem(user_id, item_id, usertem_equip);

	    return "success";  // 클라이언트로 success 메시지 반환
	}
      

//    @RequestMapping(value = "/buy_items", method = RequestMethod.POST)
//    public String utem3(@RequestParam("item_id") int item_id, HttpServletRequest request, Model mo) {
//        int user_id = (int) request.getSession().getAttribute("user_id");
//
//    	String usertem_equip = "N"; //기본값 = 착용 x
//    	
//    	UsertemsService us = sql.getMapper(UsertemsService.class);
//    	us.insert_usertem(user_id, item_id, usertem_equip);
//    	
//        ArrayList<UsertemsDTO> list = us.get_items(user_id);
//        mo.addAttribute("list", list);
//
//        return "buy_items";
//    }
    
	@RequestMapping(value = "/items_delete", method = RequestMethod.POST) //유저가 보유한 아이템 삭제
	public String items4(HttpSession session, HttpServletRequest request) {
	    
	    // 로그인 체크
	    Integer user_id = (Integer) session.getAttribute("user_id");
	    String user_login_id = (String) session.getAttribute("user_login_id");
	    
	    if (user_id == null || user_login_id == null) {
	        return "redirect:/login?error=login_required";
	    }
	    
	    int delete = Integer.parseInt(request.getParameter("delete"));
	    UsertemsService us = sql.getMapper(UsertemsService.class);
	    us.items_delete1(delete);

	    return "redirect:/items/buy_items";
	}
    
    }
