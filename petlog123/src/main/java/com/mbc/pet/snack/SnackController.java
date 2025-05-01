package com.mbc.pet.snack;

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

@Controller
public class SnackController {
	
	@Autowired
	SqlSession sql;
	//String path = "C:\\1MBC\\spring\\PetLog\\src\\main\\webapp\\image";
	
//	@RequestMapping("/login-temp") //?„?‹œ ë¡œê·¸?¸!!!!!!!!!!!!!!!!
//	public String hh(HttpSession session) {
//		
//	// ?„?‹œë¡? user_id?? user_login_idë¥? ?„¤? • (?˜ˆ?‹œ)
//    session.setAttribute("user_id", 1); // ?„?‹œ user_id (?˜ˆ: 1)
//    session.setAttribute("user_login_id", "tester"); // ?„?‹œ user_login_id (?˜ˆ: "tester")
//
//    return "redirect:/main"; // ?™ˆ?œ¼ë¡? ë¦¬ë””? ‰?…˜
//}
	
	
	@RequestMapping(value = "/snack_input")
	public String snack(HttpSession session) {
		
		//ë¹„íšŒ?› ë§‰ê¸°
	    Integer user_id = (Integer) session.getAttribute("user_id");

	    if (user_id == null) {
	    	return "redirect:/login?error=login_required"; // ë¹„íšŒ?› ? ‘ê·? ì°¨ë‹¨ + alert ?œ ?„
	    }
		
		
		return "snack_input";
	}
	
	@RequestMapping(value = "/snack_save", method = RequestMethod.POST)
	public String snack1(MultipartHttpServletRequest request, HttpSession hs) throws IllegalStateException, IOException {
		
		String path = request.getSession().getServletContext().getRealPath("/image");
		
		Integer user_id = (Integer) hs.getAttribute("user_id");
		
		if (user_id == null) {
			return  "redirect:/login-temp";
		} //ë¡œê·¸?¸ ?•ˆ??„?•Œ..?
		
		//---
		
	    String snack_title = request.getParameter("snack_title");
	    String snack_recipe = request.getParameter("snack_recipe");
	    String snack_date = request.getParameter("snack_date");
	    MultipartFile image = request.getFile("snack_image");
		
	    String fname = image.getOriginalFilename();
	    UUID ud = UUID.randomUUID();
		fname = ud.toString()+"_"+fname;
		
		SnackDTO dto = new SnackDTO();
		dto.setSnack_title(snack_title);
		dto.setSnack_recipe(snack_recipe);
		dto.setSnack_image(fname);
		dto.setSnack_date(snack_date);
		dto.setUser_id(user_id);	
		
//	    System.out.println("title: " + snack_title);
//	    System.out.println("recipe: " + snack_recipe);
//	    System.out.println("image name: " + fname);
//	    System.out.println("date: " + snack_date);
//	    System.out.println("user_id: " + user_id);

		SnackService ss = sql.getMapper(SnackService.class);
		
		int result = ss.snack_save(dto);
		System.out.println("insert ê²°ê³¼: " + result); //?´ê²? ì½˜ì†”?— ?•ˆ ?œ¨ë©? ë§¤í¼ ?—°ê²? ?ì²´ê? ?•ˆ ?œ ê±°ì•¼

		
		image.transferTo(new File(path+"\\"+fname));
		
		return "snack_input";
	}
	
	
	@RequestMapping(value = "/snack_out")
	public String snack2(Model mo, HttpServletRequest request, @RequestParam(defaultValue ="1") int page) {
		
		//ë¹„íšŒ?› ë§‰ê¸°
	    HttpSession hs = request.getSession();
	    Integer user_id = (Integer) hs.getAttribute("user_id");
	    if (user_id == null) {
	        return "redirect:/login?error=login_required";
	    }
		
	
		//?˜?´ì§? ì²˜ë¦¬ 1
		int page_size = 5; //?•œ ?˜?´ì§??— ?¼ê¸? 5ê°œì”© ë³´ì´ê¸?!!
		int start = (page-1) * page_size; //?˜„?¬ ?˜?´ì§??—?„œ ?‹œ?‘?•˜?Š” ?°?´?„°?˜ ?œ„ì¹˜ë?? ê³„ì‚°?•˜?Š” ê³µì‹
		int end = start + page_size;
		//?˜?´ì§? 1 end
		
		
		SnackService ss = sql.getMapper(SnackService.class);
		
		//?˜?´ì§? ì²˜ë¦¬ 2
		int total_count = ss.total_recipe(); //? „ì²? ? ˆ?‹œ?”¼ ê°??ˆ˜ //ceil ?ˆ«? ?˜¬ë¦?
		int page_count = (int) Math.ceil((double)total_count / page_size);
		//?˜?´ì§? 2 end
		
		//?˜?´ì§? 3
		ArrayList<SnackDTO> list = ss.snack_out(start,end);
		
		mo.addAttribute("list", list);
		mo.addAttribute("page", page);
		mo.addAttribute("page_count", page_count);
		mo.addAttribute("page_size", page_size);
		//?˜?´ì§?3 end
		
		return "snack_out";
	}
		
	
	@RequestMapping(value = "/snack_detail")
	public String snack3(Model mo, HttpServletRequest request) {
		
		int dnum = Integer.parseInt(request.getParameter("dnum"));
		SnackService ss = sql.getMapper(SnackService.class);
		SnackDTO dto = ss.snack_detail(dnum);
		
		mo.addAttribute("dto", dto);
		
		return "snack_detail";  
	}
		
	
	@RequestMapping(value = "/snack_update") //? ˆ?‹œ?”¼ ?ˆ˜? •
	public String snackup(Model mo, HttpServletRequest request) { 
		
		int update = Integer.parseInt(request.getParameter("update"));
		SnackService ss = sql.getMapper(SnackService.class);
		SnackDTO dto = ss.snack_update(update);
		mo.addAttribute("dto", dto);
		
		return "snack_update";
	}
	
	
	@RequestMapping(value = "/snackupdate_save", method = RequestMethod.POST)
	public String snack4(MultipartHttpServletRequest mul, HttpSession hs) throws IllegalStateException, IOException {

		String path = mul.getSession().getServletContext().getRealPath("/image");
		
	    Integer user_id = (Integer) hs.getAttribute("user_id");
	    if (user_id == null) return "redirect:/login-temp";

	    // ?°?´?„° ?ŒŒ?‹±
	    int snack_id = Integer.parseInt(mul.getParameter("snack_id"));
	    String snack_title = mul.getParameter("snack_title");
	    String snack_recipe = mul.getParameter("snack_recipe");
	    String snack_date = mul.getParameter("snack_date");
	    MultipartFile mf = mul.getFile("snack_image");
	    String dfimage = mul.getParameter("himage");
	    String fname = mf.getOriginalFilename();

	    if (mf != null && !mf.isEmpty()) {
	        fname = UUID.randomUUID().toString() + "_" + mf.getOriginalFilename();
	        mf.transferTo(new File(path + "\\" + fname));

	        // ê¸°ì¡´ ?´ë¯¸ì? ?‚­? œ
	        if (dfimage != null && !dfimage.trim().equals("")) {
	            File ff = new File(path + "\\" + dfimage);
	            if (ff.exists()) ff.delete();
	        }
	    } else {
	        fname = dfimage;
	    }

	    // DTO ?„¸?Œ…
	    SnackDTO dto = new SnackDTO();
	    dto.setSnack_id(snack_id);
	    dto.setSnack_title(snack_title);
	    dto.setSnack_recipe(snack_recipe);
	    dto.setSnack_image(fname);
	    dto.setSnack_date(snack_date);
	    dto.setUser_id(user_id);

	    // DB update ?‹¤?–‰
	    SnackService ss = sql.getMapper(SnackService.class);
	    int result = ss.snackupdate_save(dto);
	    System.out.println("?—…?°?´?Š¸ ê²°ê³¼: " + result);

	    return "redirect:/snack_out";
	}

	
	@RequestMapping(value = "/snack_delete") //?‚­? œ ?• ê±°ëƒê³? ë³´ì—¬ì£¼ëŠ” ?˜?´ì§?
	public String snack5(HttpServletRequest request,Model mo) {
		
		int delete = Integer.parseInt(request.getParameter("delete"));
		SnackService ss = sql.getMapper(SnackService.class);
		
		SnackDTO dto = ss.snackdelete_check(delete);
		mo.addAttribute("dto", dto);
				
		return "snack_delete"; //jsp file name
	}
	
	@RequestMapping(value = "/delete_recipe", method = RequestMethod.POST) //? ˆ?‹œ?”¼ ?‚­? œ
	public String snack6(HttpServletRequest request,Model mo) {
		
		String path = request.getSession().getServletContext().getRealPath("/image");
		
		int delete = Integer.parseInt(request.getParameter("snack_id"));

		String dfname = request.getParameter("himage"); //from snack_delete.jsp
		
		SnackService ss = sql.getMapper(SnackService.class);
		ss.delete_recipe(delete);
		
		File ff = new File(path+"\\"+dfname);
		ff.delete();
		
		return "redirect:/snack_out"; //jsp file name
	}
	
}
