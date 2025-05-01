package com.mbc.pet.items;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.mbc.pet.usertems.UsertemsService;

@Controller
public class ItemsController {
	
	@Autowired
	SqlSession sql;
	//String path = "C:\\1MBC\\spring\\PetLog\\src\\main\\webapp\\image";
	
	
	@RequestMapping(value = "/items_out") //"포도알 쓰러가기" 누르고 들어옴 -> items 사러 가기
    public String items(Model mo, HttpServletRequest request,@RequestParam(defaultValue = "1") int page) {
		
		//비회원 막기
	    HttpSession hs = request.getSession();
	    Integer user_id = (Integer) hs.getAttribute("user_id");
	    if (user_id == null) {
	        return "redirect:/login?error=login_required";
	    }
		
		
		//페이징 처리 1
		int page_size = 5; //한 페이지에 일기 5개씩 보이기!!
		int start = (page-1) * page_size; //현재 페이지에서 시작하는 데이터의 위치를 계산하는 공식
		int end = page * page_size;
	
		//페이징 1 end
		
		
    	ItemsService is = sql.getMapper(ItemsService.class);
    	
		//페이징 처리 2
		int total_count = is.total_items(); //전체 일기 갯수 //ceil 숫자 올림
		
		int page_count = (int) Math.ceil((double)total_count / page_size);
		//페이징 2 end
    	
		//페이징 처리 3
		
		System.out.println("start: " + start);
		System.out.println("end: " + end);
		
    	//기존
    	ArrayList<ItemsDTO> list = is.items_out(start, end);
    	
    	System.out.println("list.size = " + list.size());
    	//
    	
    	//기존
    	mo.addAttribute("list",list);
    	//
    	mo.addAttribute("page", page);
		mo.addAttribute("page_count", page_count);
		mo.addAttribute("page_size", page_size);
		//페이징3 end
    	
        return "items_out";
    }	
    
    
    @RequestMapping("/items_input") //관리자 전용!!! - 아이템 목록 입력
    public String items1(HttpSession session) {
    	
		//비회원 막기
	    Integer user_id = (Integer) session.getAttribute("user_id");

	    if (user_id == null) {
	    	return "redirect:/login?error=login_required"; // 비회원 접근 차단 + alert 유도
	    }
		
    	
        return "items_input";  //jsp 이름
    }
    
    @RequestMapping(value = "/items_save") //아이템 목록 저장
    public String items1_1(MultipartHttpServletRequest mul) throws IllegalStateException, IOException {
    	
    	String path = mul.getSession().getServletContext().getRealPath("/image");
    	
    	String item_name = mul.getParameter("item_name");
    	int item_cost = Integer.parseInt(mul.getParameter("item_cost"));
    	String item_category = mul.getParameter("item_category");
    	MultipartFile image = mul.getFile("item_image");
    	String filename = image.getOriginalFilename();
    	
    	UUID ud = UUID.randomUUID();
    	filename = ud.toString()+"_"+filename;
    	
    	ItemsService is = sql.getMapper(ItemsService.class);
    	
    	is.items_save(item_name, item_cost, item_category, filename);
    	
    	image.transferTo(new File(path+"\\"+filename));
    	
        return "redirect:/items_input";
    }	    
    
    
    @RequestMapping(value="/items_detail") //아이템 구매 페이지
    public String items2(Model mo, HttpServletRequest request) {
    	
    	int num = Integer.parseInt(request.getParameter("num"));
    	ItemsService is = sql.getMapper(ItemsService.class);
    	ItemsDTO dto = is.items_detail(num);
    	mo.addAttribute("dto", dto);
    	
        return "items_detail";  //jsp 이름
    }  

    
    @RequestMapping(value="/buy_items", method=RequestMethod.POST)
    public String item3(HttpSession session, @RequestParam int item_id) {
    Integer user_id = (Integer) session.getAttribute("user_id");

    System.out.println("user_id: " + user_id);
    
    if (user_id == null) {
        // 비회원은 구매 불가 처리
        return "redirect:/login?error=login_required"; // 로그인 페이지로
    }
    
    System.out.println("user_id: " + user_id);
    
    	UsertemsService us = sql.getMapper(UsertemsService.class);
    	us.insert_usertem(user_id, item_id, "N"); // 기본 장착 상태 N으로 저장
    	
    return "redirect:/my_items";
}
   
    
    
    
    
    
}


