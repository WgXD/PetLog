package com.mbc.pet.snack;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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

import com.mbc.pet.community.CommentsDTO;
import com.mbc.pet.user.UserDTO;
import com.mbc.pet.user.UserService;

@Controller
public class SnackController {
	
	@Autowired
	SqlSession sql;
	
	@RequestMapping(value = "/snack_input")
	public String snack(HttpSession session) {
		
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
		
		
		return "snack_input";
	}
	
	@RequestMapping(value = "/snack_save", method = RequestMethod.POST)
	public String snack1(MultipartHttpServletRequest request, HttpSession hs, HttpSession session) throws IllegalStateException, IOException {
		
		String path = request.getSession().getServletContext().getRealPath("/image");
		
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
		
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

		SnackService ss = sql.getMapper(SnackService.class);
		
		int result = ss.snack_save(dto);
		System.out.println("insert 결과: " + result); //?���? 콘솔?�� ?�� ?���? 매퍼 ?���? ?��체�? ?�� ?�� 거야

		
		image.transferTo(new File(path+"\\"+fname));
		
		return "snack_input";
	}
	
	
	@RequestMapping(value = "/snack_out")
	public String snack2(HttpSession session, Model mo, HttpServletRequest request, @RequestParam(defaultValue ="1") int page) {
		
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
		
	
		//페이징 처리 1
		int page_size = 5; //1페이지 5게시물
		int start = (page-1) * page_size;
		int end = start + page_size;
		//페이징 처리 1 end
		
		
		SnackService ss = sql.getMapper(SnackService.class);
		
		//페이징 처리 2
		int total_count = ss.total_recipe(); 
		int page_count = (int) Math.ceil((double)total_count / page_size);
		//페이징 처리 2 end
		
		//페이징 처리 3
		ArrayList<SnackDTO> list = ss.snack_out(start,end);
		
		mo.addAttribute("list", list);
		mo.addAttribute("page", page);
		mo.addAttribute("page_count", page_count);
		mo.addAttribute("page_size", page_size);
		//페이징 처리 3 end
		
		return "snack_out";
	}
		
	
	@RequestMapping(value = "/snack_detail")
	public String snack3(Model mo, HttpServletRequest request, HttpSession session) {
		
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
        
        int dnum=Integer.parseInt(request.getParameter("dnum"));
		SnackService ss = sql.getMapper(SnackService.class);
		ss.readcnt(dnum);  //조회수
		SnackDTO dto = ss.snack_detail(dnum);
		mo.addAttribute("dto", dto);
		mo.addAttribute("user_id", user_id);
	
        //작성자 프로필 이미지 가져오기
        UserService us = sql.getMapper(UserService.class);
        UserDTO udto = us.selectUserById(dto.getUser_id());
        mo.addAttribute("profileimg", udto.getProfileimg());
		
		//좋아요 수 체크
        int result = ss.check_like(user_id, dnum);//
        boolean userLiked = result > 0;//
        mo.addAttribute("userLiked", userLiked);//
		
        //좋아요 수 넘기기
        int likeCount = ss.getLikeCount(dnum);
        mo.addAttribute("likeCount", likeCount);
        
        //댓글
        List<CommentsDTO> comments = ss.getCommentsBySnackId(dnum);
        mo.addAttribute("comments", comments);
		return "snack_detail";  
	}
		
	
	@RequestMapping(value = "/snack_update")
	public String snackup(Model mo, HttpServletRequest request, HttpSession session) { 
		
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
		
		int update = Integer.parseInt(request.getParameter("update"));
		SnackService ss = sql.getMapper(SnackService.class);
		SnackDTO dto = ss.snack_update(update);
		mo.addAttribute("dto", dto);
		
		return "snack_update";
	}
	
	
	@RequestMapping(value = "/snackupdate_save", method = RequestMethod.POST)
	public String snack4(MultipartHttpServletRequest mul, HttpSession hs, HttpSession session) throws IllegalStateException, IOException {

		String path = mul.getSession().getServletContext().getRealPath("/image");
		
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
        
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

	        // 기존 image 삭제
	        if (dfimage != null && !dfimage.trim().equals("")) {
	            File ff = new File(path + "\\" + dfimage);
	            if (ff.exists()) ff.delete();
	        }
	    } else {
	        fname = dfimage;
	    }

	    // DTO
	    SnackDTO dto = new SnackDTO();
	    dto.setSnack_id(snack_id);
	    dto.setSnack_title(snack_title);
	    dto.setSnack_recipe(snack_recipe);
	    dto.setSnack_image(fname);
	    dto.setSnack_date(snack_date);
	    dto.setUser_id(user_id);

	    // DB update
	    SnackService ss = sql.getMapper(SnackService.class);
	    int result = ss.snackupdate_save(dto);

	    return "redirect:/snack_out";
	}

	
	@RequestMapping(value = "/snack_delete") //삭제 전 확인
	public String snack5(HttpServletRequest request,Model mo, HttpSession session) {
		
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
		
		int delete = Integer.parseInt(request.getParameter("delete"));
		SnackService ss = sql.getMapper(SnackService.class);
		
		SnackDTO dto = ss.snackdelete_check(delete);
		mo.addAttribute("dto", dto);
				
		return "snack_delete"; //jsp file name
	}
	
	@RequestMapping(value = "/delete_recipe", method = RequestMethod.POST) //?��?��?�� ?��?��
	public String snack6(HttpServletRequest request,Model mo, HttpSession session) {
		
		String path = request.getSession().getServletContext().getRealPath("/image");
		
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
		
		int delete = Integer.parseInt(request.getParameter("snack_id"));

		String dfname = request.getParameter("himage"); //from snack_delete.jsp
		
		SnackService ss = sql.getMapper(SnackService.class);
		ss.delete_recipe(delete);
		
		File ff = new File(path+"\\"+dfname);
		ff.delete();
		
		return "redirect:/snack_out"; //jsp file name
	}
	
	// 댓글 등록
	@RequestMapping(value = "/comment_insert", method = RequestMethod.POST)
	public String insertComment(HttpSession session,
	                            @RequestParam("snack_id") int snack_id,
	                            @RequestParam("com_com") String com_com,
	                            @RequestParam(value = "parent_id", required = false) Integer parent_id,
	                            @RequestParam(value = "depth", defaultValue = "0") int depth) {
	    Integer user_id = (Integer) session.getAttribute("user_id");
	    String user_login_id = (String) session.getAttribute("user_login_id");
	    if (user_id == null || user_login_id == null) {
	        return "redirect:/login?error=login_required";
	    }

	    CommentsDTO comment = new CommentsDTO();
	    comment.setCom_com(com_com);
	    comment.setParent_id(parent_id != null ? parent_id : 0);
	    comment.setDepth(depth);

	    UserDTO user = new UserDTO();
	    user.setUser_id(user_id);
	    comment.setPsdto(user);

	    SnackDTO snack = new SnackDTO();
	    snack.setSnack_id(snack_id);
	    comment.setSdto(snack);
	    
	    SnackService ss = sql.getMapper(SnackService.class);
	    
	    Map<String, Object> map = new HashMap<>();
	    map.put("user_id", user_id);
	    map.put("snack_id", snack_id);
	    map.put("com_com", com_com);
	    map.put("parent_id", parent_id != null ? parent_id : 0);
	    map.put("depth", parent_id != null ? depth : 0);
	    ss.comment_insert(map);

	    return "redirect:/snack_detail?dnum=" + snack_id;
	}

	// 좋아요 등록
	@RequestMapping(value = "/like_s")
	public String toggleLike(HttpSession session, @RequestParam("snack_id") int snack_id) {
	    Integer user_id = (Integer) session.getAttribute("user_id");
	    String user_login_id = (String) session.getAttribute("user_login_id");
	    
	    if (user_id == null || user_login_id == null) {
	        return "redirect:/login?error=login_required";
	    }

	    Map<String, Object> map = new HashMap<>();
	    map.put("user_id", user_id);
	    map.put("snack_id", snack_id);
	    map.put("user_login_id", user_login_id);
	    map.put("post_id", null); 
	    
	    SnackService ss = sql.getMapper(SnackService.class);
	    ss.insert_like(map);

	    return "redirect:/snack_detail?dnum=" + snack_id;
	}

}
