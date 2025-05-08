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

import com.mbc.pet.items.ItemsService;
import com.mbc.pet.user.UserDTO;
import com.mbc.pet.user.UserService;


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
	@RequestMapping(value = "/buy_items", method = RequestMethod.POST)
	@ResponseBody
	public String utem2(@RequestParam("item_id") int item_id, HttpServletRequest request, HttpSession session) {

	    // 로그인 체크
	    Integer user_id = (Integer) session.getAttribute("user_id");
	    String user_login_id = (String) session.getAttribute("user_login_id");

	    if (user_id == null || user_login_id == null) {
	        return "login_required"; // Ajax니까 redirect 안 됨
	    }

	    String usertem_equip = "N"; // 디폴트: 미착용 상태로 저장

	    UsertemsService us = sql.getMapper(UsertemsService.class);
	    ItemsService is = sql.getMapper(ItemsService.class); // 아이템 정보에서 가격 불러옴
	    UserService uss = sql.getMapper(UserService.class);

	    // 1. 중복 보유 체크
	    int count = us.check_usertem(user_id, item_id);
	    if (count > 0) {
	        return "already_owned";
	    }

	    // 2. 아이템 가격 조회
	    int cost = is.how_much(item_id);  // items 테이블에서 item_cost 가져오기

	    // 3. 사용자 포도알 조회
	    int ugrapes = us.get_user_grapes(user_id);  // users 테이블에서 grape_total 가져오기

	    // 4. 포도알 부족 시 구매 불가 처리
	    if (ugrapes < cost) {
	        return "not_enough_grapes";
	    }

	    // 5. 아이템 등록 및 포도알 차감
	    us.insert_usertem(user_id, item_id, usertem_equip);
	    us.minus_grapes(user_id, cost);
	    
	    // 6. 세션 갱신 (메뉴바 포도알 실시간 반영용)
	    UserDTO updated = uss.grape_update(user_login_id);
	    session.setAttribute("loginUser", updated);

	    return "success";
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
