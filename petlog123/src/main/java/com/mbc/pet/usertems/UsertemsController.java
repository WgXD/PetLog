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
@RequestMapping("/items") //<-items������ �ִ� buy_items ������ ������ �̰� �����!!
public class UsertemsController {
	
	@Autowired
	SqlSession sql;
	//String path = "C:\\1MBC\\spring\\PetLog\\src\\main\\webapp\\image";
	
	
//    @RequestMapping(value = "/myitem") 
//    public String utem1(@RequestParam("item_id") int item_id, HttpServletRequest request) {
//    	
//    	//int user_id = 1; //user_id �ӽð�!!!
//    	
//    	int user_id = (int) request.getSession().getAttribute("user_id"); //�α����� ��� id
//    	
//    	String usertem_equip = "N"; // �⺻��: ������
//    	
//    	UsertemsService us = sql.getMapper(UsertemsService.class);
//    	us.insert_usertem(user_id, item_id, usertem_equip);
//    	
//        return "items/buy_items"; //jsp file name
//    }
    
	//������ ��� �����ִ� �뵵
	@RequestMapping(value = "/buy_items", method = RequestMethod.GET)
	public String showBuyItems(HttpServletRequest request, Model mo) {
	    int user_id = (int) request.getSession().getAttribute("user_id");

	    UsertemsService us = sql.getMapper(UsertemsService.class);
	    ArrayList<UsertemsDTO> list = us.get_items(user_id);
	    mo.addAttribute("list", list);

	    return "buy_items"; // ������ JSP ���
	}
	
	 //Ajax�� ���� ó�� �뵵
	@RequestMapping(value = "/buy_items", method = RequestMethod.POST) //�� ������ ��ư ������ ���� ��
	@ResponseBody
	public String utem2(@RequestParam("item_id") int item_id, HttpServletRequest request) {
	    int user_id = (int) request.getSession().getAttribute("user_id");
	    String usertem_equip = "N";

	    UsertemsService us = sql.getMapper(UsertemsService.class);
	    us.insert_usertem(user_id, item_id, usertem_equip);

	    return "success";  // Ŭ���̾�Ʈ���� success �޽��� �ޱ� ��
	}
      

//    @RequestMapping(value = "/buy_items", method = RequestMethod.POST) //������ ���� �� �ڵ����� ������ ������ ������� �Ѿ ��
//    public String utem3(@RequestParam("item_id") int item_id, HttpServletRequest request, Model mo) {
//        int user_id = (int) request.getSession().getAttribute("user_id");
//
//    	String usertem_equip = "N"; // �⺻��: ������
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
