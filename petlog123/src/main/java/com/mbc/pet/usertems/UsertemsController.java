package com.mbc.pet.usertems;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping("/items") //<-items폴더에 있는 buy_items 가져다 쓰려면 이거 써야함!!
public class UsertemsController {
	
	@Autowired
	SqlSession sql;
	//String path = "C:\\1MBC\\spring\\PetLog\\src\\main\\webapp\\image";
	
	
//    @RequestMapping(value = "/myitem") 
//    public String utem1(@RequestParam("item_id") int item_id, HttpServletRequest request) {
//    	
//    	//int user_id = 1; //user_id 임시값!!!
//    	
//    	int user_id = (int) request.getSession().getAttribute("user_id"); //로그인한 사람 id
//    	
//    	String usertem_equip = "N"; // 기본값: 미착용
//    	
//    	UsertemsService us = sql.getMapper(UsertemsService.class);
//    	us.insert_usertem(user_id, item_id, usertem_equip);
//    	
//        return "items/buy_items"; //jsp file name
//    }
    
	//아이템 목록 보여주는 용도
	@RequestMapping(value = "/buy_items", method = RequestMethod.GET)
	public String showBuyItems(HttpServletRequest request, Model mo) {
	    int user_id = (int) request.getSession().getAttribute("user_id");

	    UsertemsService us = sql.getMapper(UsertemsService.class);
	    ArrayList<UsertemsDTO> list = us.get_items(user_id);
	    mo.addAttribute("list", list);

	    return "buy_items"; // 보여줄 JSP 경로
	}
	
	 //Ajax로 구매 처리 용도
	@RequestMapping(value = "/buy_items", method = RequestMethod.POST) //내 아이템 버튼 누르고 들어올 때
	@ResponseBody
	public String utem2(@RequestParam("item_id") int item_id, HttpServletRequest request) {
	    int user_id = (int) request.getSession().getAttribute("user_id");
	    String usertem_equip = "N";

	    UsertemsService us = sql.getMapper(UsertemsService.class);
	    us.insert_usertem(user_id, item_id, usertem_equip);

	    return "success";  // 클라이언트에서 success 메시지 받기 용
	}
      

//    @RequestMapping(value = "/buy_items", method = RequestMethod.POST) //아이템 구매 후 자동으로 구매한 아이템 목록으로 넘어갈 때
//    public String utem3(@RequestParam("item_id") int item_id, HttpServletRequest request, Model mo) {
//        int user_id = (int) request.getSession().getAttribute("user_id");
//
//    	String usertem_equip = "N"; // 기본값: 미착용
//    	
//    	UsertemsService us = sql.getMapper(UsertemsService.class);
//    	us.insert_usertem(user_id, item_id, usertem_equip);
//    	
//        ArrayList<UsertemsDTO> list = us.get_items(user_id);
//        mo.addAttribute("list", list);
//
//        return "buy_items";
//    }
    
    
    
    }
