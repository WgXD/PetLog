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
	
	
	@RequestMapping(value = "/items_out") //"������ ��������" ������ ���� -> items �緯 ����
    public String items(Model mo, HttpServletRequest request,@RequestParam(defaultValue = "1") int page) {
		
		//��ȸ�� ����
	    HttpSession hs = request.getSession();
	    Integer user_id = (Integer) hs.getAttribute("user_id");
	    if (user_id == null) {
	        return "redirect:/login?error=login_required";
	    }
		
		
		//����¡ ó�� 1
		int page_size = 5; //�� �������� �ϱ� 5���� ���̱�!!
		int start = (page-1) * page_size; //���� ���������� �����ϴ� �������� ��ġ�� ����ϴ� ����
		int end = page * page_size;
	
		//����¡ 1 end
		
		
    	ItemsService is = sql.getMapper(ItemsService.class);
    	
		//����¡ ó�� 2
		int total_count = is.total_items(); //��ü �ϱ� ���� //ceil ���� �ø�
		
		int page_count = (int) Math.ceil((double)total_count / page_size);
		//����¡ 2 end
    	
		//����¡ ó�� 3
		
		System.out.println("start: " + start);
		System.out.println("end: " + end);
		
    	//����
    	ArrayList<ItemsDTO> list = is.items_out(start, end);
    	
    	System.out.println("list.size = " + list.size());
    	//
    	
    	//����
    	mo.addAttribute("list",list);
    	//
    	mo.addAttribute("page", page);
		mo.addAttribute("page_count", page_count);
		mo.addAttribute("page_size", page_size);
		//����¡3 end
    	
        return "items_out";
    }	
    
    
    @RequestMapping("/items_input") //������ ����!!! - ������ ��� �Է�
    public String items1(HttpSession session) {
    	
		//��ȸ�� ����
	    Integer user_id = (Integer) session.getAttribute("user_id");

	    if (user_id == null) {
	    	return "redirect:/login?error=login_required"; // ��ȸ�� ���� ���� + alert ����
	    }
		
    	
        return "items_input";  //jsp �̸�
    }
    
    @RequestMapping(value = "/items_save") //������ ��� ����
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
    
    
    @RequestMapping(value="/items_detail") //������ ���� ������
    public String items2(Model mo, HttpServletRequest request) {
    	
    	int num = Integer.parseInt(request.getParameter("num"));
    	ItemsService is = sql.getMapper(ItemsService.class);
    	ItemsDTO dto = is.items_detail(num);
    	mo.addAttribute("dto", dto);
    	
        return "items_detail";  //jsp �̸�
    }  

    
    @RequestMapping(value="/buy_items", method=RequestMethod.POST)
    public String item3(HttpSession session, @RequestParam int item_id) {
    Integer user_id = (Integer) session.getAttribute("user_id");

    System.out.println("user_id: " + user_id);
    
    if (user_id == null) {
        // ��ȸ���� ���� �Ұ� ó��
        return "redirect:/login?error=login_required"; // �α��� ��������
    }
    
    System.out.println("user_id: " + user_id);
    
    	UsertemsService us = sql.getMapper(UsertemsService.class);
    	us.insert_usertem(user_id, item_id, "N"); // �⺻ ���� ���� N���� ����
    	
    return "redirect:/my_items";
}
   
    
    
    
    
    
}


