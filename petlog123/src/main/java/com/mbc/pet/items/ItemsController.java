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
	
	
	@RequestMapping(value = "/items_out") //"아이템 전체출력" 페이지 매핑 -> items 리스트 출력
    public String items(Model mo,HttpSession session, HttpServletRequest request,@RequestParam(defaultValue = "1") int page) {
		
		// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
		
		//페이징 처리 1
		int page_size = 5; //한 페이지당 보기 5개로 설정!!
		int start = (page-1) * page_size; //현재 페이지에서 출력하는 시작 위치를 구하는 공식
		int end = page * page_size;
		//페이징 1 end
		
    	ItemsService is = sql.getMapper(ItemsService.class);
    	
		//페이징 처리 2
		int total_count = is.total_items(); //전체 개수 구함 //ceil 처리 필요
		int page_count = (int) Math.ceil((double)total_count / page_size);
		//페이징 2 end
    	
		//페이징 처리 3
		System.out.println("start: " + start);
		System.out.println("end: " + end);
		
    	//리스트
    	ArrayList<ItemsDTO> list = is.items_out(start, end);
    	System.out.println("list.size = " + list.size());
    	
    	//전송
    	mo.addAttribute("list",list);
    	mo.addAttribute("page", page);
		mo.addAttribute("page_count", page_count);
		mo.addAttribute("page_size", page_size);
		//페이징 3 end
    	
        return "items_out";
    }	
    
    
	@RequestMapping("/items_input") //판매할 아이템 등록(관리자용)
	public String items1(HttpSession session) {
	    
	    // 로그인 체크
	    Integer user_id = (Integer) session.getAttribute("user_id");
	    String user_login_id = (String) session.getAttribute("user_login_id");
	    //String user_role = (String) session.getAttribute("user_role"); // 관리자 권한 체크용

	    if (user_id == null || user_login_id == null) {
	        return "redirect:/login?error=login_required";
	    }

//	    // 관리자 체크
//	    if (user_role == null || !user_role.equals("admin")) {
//	        return "redirect:/?error=not_authorized"; // 홈으로 보내거나 접근 불가 안내
//	    }

	    return "items_input";  //jsp 이름
	}
	
    
	@RequestMapping("/items_out_admin") //판매 아이템 목록 출력(관리자용)
	public String items1_out(Model mo,HttpSession session, HttpServletRequest request,@RequestParam(defaultValue = "1") int page) {
	    
	    // 로그인 체크
	    Integer user_id = (Integer) session.getAttribute("user_id");
	    String user_login_id = (String) session.getAttribute("user_login_id");

	    if (user_id == null || user_login_id == null) {
	        return "redirect:/login?error=login_required";
	    }
	    
		//페이징 처리 1
		int page_size = 5; //한 페이지당 보기 5개로 설정!!
		int start = (page-1) * page_size; //현재 페이지에서 출력하는 시작 위치를 구하는 공식
		int end = page * page_size;
		//페이징 1 end
		
    	ItemsService is = sql.getMapper(ItemsService.class);
    	
		//페이징 처리 2
		int total_count = is.total_items(); //전체 개수 구함 //ceil 처리 필요
		int page_count = (int) Math.ceil((double)total_count / page_size);
		//페이징 2 end
    	
		//페이징 처리 3
		System.out.println("start: " + start);
		System.out.println("end: " + end);
		
    	//리스트
    	ArrayList<ItemsDTO> list = is.items_out_admin(start, end);
    	System.out.println("list.size = " + list.size());
    	
    	//전송
    	mo.addAttribute("list",list);
    	mo.addAttribute("page", page);
		mo.addAttribute("page_count", page_count);
		mo.addAttribute("page_size", page_size);
		mo.addAttribute("page_type", "admin");
		//페이징 3 end

	    return "items_out_admin";  //jsp 이름
	}
	
	
	@RequestMapping("/items_delete_admin") //판매중 -> 판매종료 (관리자용)
	public String items1_delete(HttpSession session, HttpServletRequest request) {
	    
	    // 로그인 체크
	    Integer user_id = (Integer) session.getAttribute("user_id");
	    String user_login_id = (String) session.getAttribute("user_login_id");

	    if (user_id == null || user_login_id == null) {
	        return "redirect:/login?error=login_required";
	    }
	    
	    int delete = Integer.parseInt(request.getParameter("delete"));
	    ItemsService is = sql.getMapper(ItemsService.class);
	    is.items_delete_admin(delete);

	    return "redirect:/items_out_admin";  //jsp 이름
	}
	
	
	@RequestMapping("/items_stopped") //판매중 -> 판매종료 (관리자용)
	public String items1_stopped(HttpSession session, HttpServletRequest request, Model mo) {
	    
	    // 로그인 체크
	    Integer user_id = (Integer) session.getAttribute("user_id");
	    String user_login_id = (String) session.getAttribute("user_login_id");

	    if (user_id == null || user_login_id == null) {
	        return "redirect:/login?error=login_required";
	    }
	    
	    ItemsService is = sql.getMapper(ItemsService.class);
	    ArrayList<ItemsDTO> list = is.items_stopped();
	    mo.addAttribute("list", list);

	    return "items_stopped";  //jsp 이름
	}
	
	@RequestMapping(value = "/items_restore", method = RequestMethod.POST) //판매종료 -> 판매중 (관리자용)
	public String items1_restore(@RequestParam("item_id") int item_id, HttpSession session) {
	   
		// 로그인 체크
	    Integer user_id = (Integer) session.getAttribute("user_id");
	    String user_login_id = (String) session.getAttribute("user_login_id");

	    if (user_id == null || user_login_id == null) {
	        return "redirect:/login?error=login_required";
	    }

	    ItemsService is = sql.getMapper(ItemsService.class);
	    is.items_restore(item_id);

	    return "redirect:/items_out_admin";
	}
	
	
    @RequestMapping(value = "/items_save") //아이템 등록 처리
    public String items1_1(MultipartHttpServletRequest mul, HttpSession session) throws IllegalStateException, IOException {
    	
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
    	
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
    
    
    @RequestMapping(value="/items_detail") //아이템 상세 페이지
    public String items2(Model mo, HttpServletRequest request, HttpSession session) {
    	
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
        
    	int num = Integer.parseInt(request.getParameter("num"));
    	ItemsService is = sql.getMapper(ItemsService.class);
    	ItemsDTO dto = is.items_detail(num);
    	mo.addAttribute("dto", dto);
    	
        return "items_detail";  //jsp 이름
    }  

    
    @RequestMapping(value="/buy_items", method=RequestMethod.POST)
    public String item3(HttpSession session, @RequestParam int item_id) {
    
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
    
    	UsertemsService us = sql.getMapper(UsertemsService.class);
    	us.insert_usertem(user_id, item_id, "N"); // 기본 장착 상태 N으로 저장
    	
    	return "redirect:/my_items";
	}
   
    
 //프레임 아이템 목록 출력 (착용 가능 페이지)
    @RequestMapping(value = "/put_on_item", method = RequestMethod.GET)
    public String showPutOnItemPage(Model model, HttpSession session) {
    	
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }

        UsertemsService us = sql.getMapper(UsertemsService.class);
        ArrayList<ItemsDTO> list = us.frame_item(user_id); // 프레임 아이템만 조회
        model.addAttribute("list", list);

        return "put_on_item"; // JSP
    }

    //프로필 프레임 착용 처리
    @RequestMapping(value = "/put_on_frame", method = RequestMethod.POST)
    public String wearFrame(@RequestParam("item_id") int item_id, HttpSession session) {
    	
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }

        UsertemsService us = sql.getMapper(UsertemsService.class);
        us.frame_wearing(user_id, item_id); // 착용 처리 (기존 프레임 해제)

        return "redirect:/put_on_item"; // 다시 프레임 리스트로
    }
    
    //아이템 수정(관리자용)
    @RequestMapping(value = "/items_modify")
    public String modify1(Model mo, HttpServletRequest request, HttpSession session) {
    	
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
        
        //예외처리
        String param = request.getParameter("modify");
        if (param == null || param.trim().equals("")) {
            return "redirect:/items_out_admin?error=invalid_id";
        }

        int modify = Integer.parseInt(request.getParameter("modify"));
        ItemsService is = sql.getMapper(ItemsService.class);
        ItemsDTO dto = is.items_modify(modify);
        mo.addAttribute("dto", dto);

        return "items_modify"; // 다시 프레임 리스트로
    }
    
    //아이템 수정 후 저장(관리자용)
    @RequestMapping(value = "/modify_save")
    public String modify2(MultipartHttpServletRequest mul, HttpSession session) throws IllegalStateException, IOException {
    	
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }

        String path = mul.getSession().getServletContext().getRealPath("/image");
        
        int item_id = Integer.parseInt(mul.getParameter("item_id"));
    	String item_name = mul.getParameter("item_name");
    	int item_cost = Integer.parseInt(mul.getParameter("item_cost"));
    	String item_category = mul.getParameter("item_category");
    	MultipartFile mf = mul.getFile("item_image");
    	String dfimage = mul.getParameter("himage");
    	
	    String fname = null;

	    if (mf != null && !mf.isEmpty()) {
	        fname = UUID.randomUUID().toString() + "_" + mf.getOriginalFilename();
	        mf.transferTo(new File(path + "\\" + fname));

	        if (dfimage != null && !dfimage.trim().equals("")) {
	            File ff = new File(path + "\\" + dfimage);
	            if (ff.exists()) ff.delete();
	        }
	    } else {
	        fname = dfimage;
	    }

	    ItemsService is = sql.getMapper(ItemsService.class);
	    
	    is.modify_save(item_id,item_name,item_cost,item_category,fname);

        return "redirect:/items_out_admin"; // 다시 프레임 리스트로
    }
}
