package com.mbc.pet.community;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.bind.annotation.RequestParam;
import com.mbc.pet.community.PageDTO;
import com.mbc.pet.user.UserDTO;

@Controller
public class CommunityController {

	 @Autowired
	 SqlSession sqlSession;
    //ê°œë°œ?š© ê²½ë¡œ
    //String path = "C:\\MBC12AI\\spring\\PetLog\\PetLog\\src\\main\\webapp\\image"; 

    @RequestMapping(value = "/CommunityIn")
    public String cc(HttpSession session) {
    	 // ?„¸?…˜ ì²´í¬
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login";
        }
        return "CommunityInput";
    }
    
    @RequestMapping(value = "/BoardInput")
    public String bc(HttpSession session) {
    	 // ?„¸?…˜ ì²´í¬
    	
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login";
        }
        return "BoardInput";
    }
//ê²Œì‹œê¸? ???¥----------------------------------------------------
    @RequestMapping(value = "/CommunitySave")
    public String cc1(HttpServletRequest request, MultipartHttpServletRequest mul, Model mo,
                      HttpSession session, @RequestParam(value = "post_type", required = false) String post_type)
            throws IllegalStateException, IOException {

    	String path = request.getSession().getServletContext().getRealPath("/image");
    	
        // ?„¸?…˜ ì²´í¬
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login";
        }

        // post_type ?œ ?š¨?„± ë³´ì •
        if (post_type == null || (!post_type.equals("notice") && !post_type.equals("normal"))) {
            post_type = "normal";
        }

        // ?ŒŒ?¼ë¯¸í„° ì¶”ì¶œ
        String title = mul.getParameter("post_title");
        String content = mul.getParameter("post_content");
        MultipartFile mf = mul.getFile("post_image");

        // ?´ë¯¸ì? ?ŒŒ?¼ ì²˜ë¦¬
        String ofname = "noimage.png"; // ê¸°ë³¸ ?´ë¯¸ì?
        if (mf != null && !mf.isEmpty()) {
            String originName = mf.getOriginalFilename();
            UUID ud = UUID.randomUUID();
            ofname = ud.toString() + "_" + originName;

            File dest = new File(path + "\\" + ofname);
            try {
                mf.transferTo(dest); // ?‹¤? œ ?ŒŒ?¼ ???¥
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        
        // DB ???¥
        CommunityService cs = sqlSession.getMapper(CommunityService.class);
        try {
            cs.insertc(user_id, title, content, ofname, post_type);
            // ê²Œì‹œê¸? ???¥ ?„±ê³? ?›„ ë¦¬ë‹¤?´? ‰?Š¸
            if (post_type.equals("notice")) {
                return "redirect:/NoticeBoard";
            } else {
                return "redirect:/CommunityView";
            }
        } catch (Exception e) {
            System.out.println("?Œ DB ???¥ ì¤? ?˜ˆ?™¸ ë°œìƒ: " + e.getMessage());
            e.printStackTrace();
        }

        return "redirect:/CommunityView";
    }
//ì¶œë ¥-------------------------------------------------------------
    @RequestMapping(value = "/CommunityView")
    public String cc2(HttpServletRequest request,HttpSession session,PageDTO dto,Model mo,@RequestParam(defaultValue = "1") int page) {
    	//////////////
	    Integer user_id = (Integer) session.getAttribute("user_id");
	    String user_login_id = (String) session.getAttribute("user_login_id");
	   
	    if (user_id == null || user_login_id == null) {
	        return "redirect:/login"; // ì§„ì§œ ë¡œê·¸?¸ ?˜?´ì§?ë¡?
	    }
    	
    	//?˜?´ì§? ì²˜ë¦¬ 1
        int page_size = 10; //?•œ ?˜?´ì§??— ì¶œë ¥?•  ê²Œì‹œë¬? ê°??ˆ˜
        int start = (page-1) * page_size; //?˜„?¬ ?˜?´ì§??—?„œ ?‹œ?‘?•˜?Š” ?°?´?„°?˜ ?œ„ì¹˜ë?? ê³„ì‚°?•˜?Š” ê³µì‹
        int end = start + page_size;
        //?˜?´ì§? 1 end
        
        HttpSession hs = request.getSession();
        CommunityService cs = sqlSession.getMapper(CommunityService.class);
        
        //?˜?´ì§? ì²˜ë¦¬ 2
        int total_count = cs.totalByType("normal"); //? „ì²? ê°??ˆ˜ //ceil ?ˆ«? ?˜¬ë¦?
        int page_count = (int) Math.ceil((double)total_count / page_size);
        //?˜?´ì§? 2 end
        
        ArrayList<CommunityDTO> list = cs.outviewByType(start, end, "normal");
        mo.addAttribute("list", list);
        mo.addAttribute("page", page);
        mo.addAttribute("page_count", page_count);
        mo.addAttribute("page_size", page_size);
        //?˜?´ì§?3 end
        return "CommunityOut";
    }
    
///ê³µì??‚¬?•­ ì¶œë ¥-------------------------------------------------------------
    @RequestMapping("/NoticeBoard")
    public String bb1(HttpServletRequest request,HttpSession session,PageDTO dto,Model mo,@RequestParam(defaultValue = "1") int page) {
    //////////////
    Integer user_id = (Integer) session.getAttribute("user_id");
    String user_login_id = (String) session.getAttribute("user_login_id");
   
    if (user_id == null || user_login_id == null) {
        return "redirect:/login"; // ì§„ì§œ ë¡œê·¸?¸ ?˜?´ì§?ë¡?
    }
	
	//?˜?´ì§? ì²˜ë¦¬ 1
    int page_size = 10; //?•œ ?˜?´ì§??— ì¶œë ¥?•  ê²Œì‹œë¬? ê°??ˆ˜
    int start = (page-1) * page_size; //?˜„?¬ ?˜?´ì§??—?„œ ?‹œ?‘?•˜?Š” ?°?´?„°?˜ ?œ„ì¹˜ë?? ê³„ì‚°?•˜?Š” ê³µì‹
    int end = start + page_size;
    //?˜?´ì§? 1 end
    
    HttpSession hs = request.getSession();
    CommunityService cs = sqlSession.getMapper(CommunityService.class);
    
    //?˜?´ì§? ì²˜ë¦¬ 2
    int total_count = cs.totalByType("notice"); //? „ì²? ê°??ˆ˜ //ceil ?ˆ«? ?˜¬ë¦?
    int page_count = (int) Math.ceil((double)total_count / page_size);
    //?˜?´ì§? 2 end
    
    ArrayList<CommunityDTO> list = cs.outviewByType(start, end, "notice");
    mo.addAttribute("list", list);
    mo.addAttribute("page", page);
    mo.addAttribute("page_count", page_count);
    mo.addAttribute("page_size", page_size);
    //?˜?´ì§?3 end
        return "BoardView"; // ê³µì??‚¬?•­ ? „?š© JSP
    }
    
//??„¸?ˆ ë³´ê¸°----------------------------------------------------
    @RequestMapping(value = "/PostDetail")
    public String cc3(Model mo, HttpServletRequest request,HttpSession session) {
        int pnum = Integer.parseInt(request.getParameter("pnum"));
        CommunityService cs = sqlSession.getMapper(CommunityService.class);
        cs.readcnt(pnum);
        CommunityDTO dto = cs.detailview(pnum);
        mo.addAttribute("dto", dto);

        // ë¡œê·¸?¸?•œ ?‚¬?š©? ID
        Integer user_id = (Integer) session.getAttribute("user_id");
        mo.addAttribute("user_id", user_id);  // JSP?— user_id ? „?‹¬
        
        List<CommentsDTO> comments = cs.getCommentsByPostId(pnum);
        mo.addAttribute("comments", comments);
        
        // ì¢‹ì•„?š” ?ˆ˜ ê°?? ¸?˜¤ê¸?
        int likeCount = cs.getLikeCount(pnum);
        mo.addAttribute("LikeCount", likeCount);
        
        //ë¡œê·¸?¸?•œ ?‚¬?š©??˜ ì¢‹ì•„?š” ?—¬ë¶? ?™•?¸
        int result = cs.check_like(user_id, pnum);
        boolean userLiked = result > 0;
        mo.addAttribute("userLiked", userLiked);
        return "CommunityDetail";
    }
    
//?‚­? œ-----------------------------------------------------
    @RequestMapping(value = "/PostDelete")
    public String cc4(HttpServletRequest request, Model mo) {
        int dnum = Integer.parseInt(request.getParameter("dnum"));
        CommunityService cs = sqlSession.getMapper(CommunityService.class);
        CommunityDTO dto = cs.deleteview(dnum);
        mo.addAttribute("dto", dto);
        return "CommunityDeleteView";
    }

    @RequestMapping(value = "/PostDeleteSave", method = RequestMethod.GET)
    public String deletePost(HttpServletRequest request, HttpSession session, RedirectAttributes redirectAttributes) {
        
    	String path = request.getSession().getServletContext().getRealPath("/image");
    	
    	int dnum = Integer.parseInt(request.getParameter("dnum"));
        String dfname = request.getParameter("dfimage");

        Integer user_id = (Integer) session.getAttribute("user_id"); // ?˜„?¬ ë¡œê·¸?¸?•œ ?œ ??
        CommunityService cs = sqlSession.getMapper(CommunityService.class);

        // ê¸? ?‘?„±? ì¡°íšŒ
        CommunityDTO dto = cs.getPostById(dnum);
        if (dto == null) {
            return "redirect:/errorPage"; // ê²Œì‹œê¸? ?—†?œ¼ë©?
        }
        if (!user_id.equals(dto.getUser_id())) {
            return "redirect:/accessDenied"; // ?‘?„±? ë¶ˆì¼ì¹˜í•˜ë©?
        }

        // ?‚­? œ ì§„í–‰
        cs.deletePost(dnum);

        // ?´ë¯¸ì? ?ŒŒ?¼ ?‚­? œ
        if (dfname != null && !dfname.equals("noimage.png")) {
            File oldFile = new File(path + "\\" + dfname);
            if (oldFile.exists()) {
                boolean isDeleted = oldFile.delete();
                redirectAttributes.addFlashAttribute("msg", isDeleted ? "ê²Œì‹œê¸? ë°? ?ŒŒ?¼ ?‚­? œ ?™„ë£?" : "ê²Œì‹œê¸? ?‚­? œ ?™„ë£? (?ŒŒ?¼ ?‚­? œ ?‹¤?Œ¨)");
            } else {
                redirectAttributes.addFlashAttribute("msg", "ê²Œì‹œê¸? ?‚­? œ ?™„ë£? (?ŒŒ?¼ ?—†?Œ)");
            }
        } else {
            redirectAttributes.addFlashAttribute("msg", "ê²Œì‹œê¸? ?‚­? œ ?™„ë£?");
        }

        return "redirect:/CommunityView"; // ëª©ë¡?œ¼ë¡? ?´?™
    }
    
//?ˆ˜? •----------------------------------------------------
    @RequestMapping(value = "/PostModify")
    public String cc6(HttpServletRequest request, Model mo) {
        int mnum = Integer.parseInt(request.getParameter("mnum"));
        CommunityService cs = sqlSession.getMapper(CommunityService.class);
        CommunityDTO dto = cs.modifyview(mnum);
        mo.addAttribute("dto", dto);
        return "CommunityModify";
    }

    @RequestMapping(value = "/PostModifySave", method = RequestMethod.POST)
    public String modifyPost(MultipartHttpServletRequest mul, HttpSession session, RedirectAttributes redirectAttributes) throws IllegalStateException, IOException {
        ////// ë¡œê·¸?¸ ?„¸?…˜ ì²´í¬ ///////
    	
    	String path = mul.getSession().getServletContext().getRealPath("/image");
    	
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");
        if (user_id == null || user_login_id == null) {
            return "redirect:/login"; // ë¡œê·¸?¸ ?•ˆ ?˜?–´ ?ˆ?œ¼ë©? ë¦¬ë‹¤?´? ‰?Š¸
        }

        int mnum = Integer.parseInt(mul.getParameter("mnum"));
        String title = mul.getParameter("post_title");
        String content = mul.getParameter("post_content");
        String dfname = mul.getParameter("himage"); // ê¸°ì¡´ ?ŒŒ?¼ëª?
        MultipartFile mf = mul.getFile("post_image"); // ?ƒˆë¡? ?—…ë¡œë“œ?œ ?ŒŒ?¼

        CommunityService cs = sqlSession.getMapper(CommunityService.class);

        // ê¸? ?‘?„±? ê²?ì¦?
        CommunityDTO dto = cs.getPostById(mnum);
        if (dto == null) {
            return "redirect:/errorPage";
        }
        if (!user_id.equals(dto.getUser_id())) {
            return "redirect:/accessDenied"; // ê¸? ?‘?„±??? ë¡œê·¸?¸ ?œ ??ê°? ?‹¤ë¥´ë©´ ?ˆ˜? • ë¶ˆê?
        }

        ////// ?ŒŒ?¼ ?—…ë¡œë“œ ì²˜ë¦¬ ///////
        String fname = dfname; // ê¸°ë³¸?? ê¸°ì¡´ ?ŒŒ?¼ëª? ?œ ì§?
        if (mf != null && !mf.isEmpty()) {
            // ?ƒˆ ?ŒŒ?¼ ?—…ë¡œë“œ
            UUID ud = UUID.randomUUID();
            fname = ud.toString() + "_" + mf.getOriginalFilename();
            mf.transferTo(new File(path + "\\" + fname));

            // ê¸°ì¡´ ?ŒŒ?¼ ?‚­? œ
            if (dfname != null && !dfname.equals("noimage.png")) {
                File oldFile = new File(path + "\\" + dfname);
                if (oldFile.exists()) {
                    oldFile.delete();
                }
            }
        }

        ////// DB ?ˆ˜? • ì²˜ë¦¬ ///////
        CommunityDTO modifyDto = new CommunityDTO();
        modifyDto.setPost_id(mnum);
        modifyDto.setPost_title(title);
        modifyDto.setPost_content(content);
        modifyDto.setPost_image(fname);
        cs.updatePost(modifyDto);

        redirectAttributes.addFlashAttribute("msg", "?ˆ˜? • ?™„ë£Œë˜?—ˆ?Šµ?‹ˆ?‹¤.");
        return "redirect:/PostDetail?pnum=" + mnum;
    }
    
//ê²??ƒ‰----------------------------------------------------
	@RequestMapping(value = "/searchview")
	public String cc8(HttpServletRequest request,Model mo,  HttpSession session, RedirectAttributes redirectAttributes) {
		
		String skey=request.getParameter("skey");
		String svalue=request.getParameter("keyword");
		
		if (svalue == null || svalue.trim().isEmpty()) {
		    String msg = "ê²??ƒ‰?–´ë¥? ?…? ¥?•˜?„¸?š”.";
		    redirectAttributes.addFlashAttribute("msg", msg);
		    return "redirect:/CommunitySearchView";
		}
		
		CommunityService cs=sqlSession.getMapper(CommunityService.class);
		ArrayList<CommunityDTO> list=null;
		if(skey.equals("user_id")){
			list=cs.searchid(svalue);
		}
		else if(skey.equals("post_title")){
			list=cs.searchtitle(svalue);
		}
		else if(skey.equals("post_content")){
			list=cs.searchcontent(svalue);
		}
		else{
			list=cs.searchdate(svalue);
		}
		mo.addAttribute("list", list);
		mo.addAttribute("keyword", svalue);
		
		if(list==null || list.isEmpty()) {
			String msg="ê²??ƒ‰ ê²°ê³¼ê°? ?—†?Šµ?‹ˆ?‹¤.";
			redirectAttributes.addFlashAttribute("msg", msg);
			return "redirect:/CommunitySearchView";
		}
		return "CommunitySearchView";
	}
	
	@RequestMapping("/CommunitySearchView")
	public String cc9(Model mo) {
	    return "CommunitySearchView"; // ?´ê±? ?ˆ?–´?•¼ FlashAttributeê°? ?„˜?–´ê°?
	}
	
//?Œ“ê¸?----------------------------------------------------
	@RequestMapping(value = "/commentInsert", method = RequestMethod.POST)
    public String cc10(HttpSession session, HttpServletRequest request,
		    	   	  @RequestParam("post_id") int post_id,
		              @RequestParam("com_com") String com_com,
		              @RequestParam(value = "parent_id", required = false) Integer parent_id,
		              @RequestParam(value = "depth", defaultValue = "0") int depth) {
	    //ë¡œê·¸?¸ ì²´í¬
		Integer user_id = (Integer) session.getAttribute("user_id");
	    String user_login_id = (String) session.getAttribute("user_login_id");
	    if (user_id == null || user_login_id == null) {
	        return "redirect:/login"; // ì§„ì§œ ë¡œê·¸?¸ ?˜?´ì§?ë¡?
	    }
	    //?•˜?œ„ DTO ê°ì²´ ?ƒ?„± ?›„ commentsDTO?— ???¥
	    UserDTO user=new UserDTO();
	    user.setUser_id(user_id);
	    
	    CommunityDTO post=new CommunityDTO();
	    post.setPost_id(post_id);
	    
	    CommentsDTO dto=new CommentsDTO(); 
	    dto.setCom_com(com_com);
	    if (parent_id == null) {
	        dto.setParent_id(0);      // ?¼ë°? ?Œ“ê¸?
	    } else {
	        dto.setParent_id(parent_id); // ???Œ“ê¸?
	    }
	    dto.setDepth(depth);
	    dto.setPsdto(user);
	    dto.setCtdto(post);
	    //DB ???¥
        CommunityService cs = sqlSession.getMapper(CommunityService.class);
        cs.insertco(dto);
        return "redirect:/PostDetail?pnum=" + post_id;
    }
//ì¢‹ì•„?š” ê¸°ëŠ¥----------------------------------------------------
	@RequestMapping(value = "/like", method = RequestMethod.POST)
	public String cc11(HttpServletRequest request,Model mo, HttpSession session,@RequestParam int post_id) {
		//ë¡œê·¸?¸ ì²´í¬
		Integer user_id = (Integer) session.getAttribute("user_id");
	    String user_login_id = (String) session.getAttribute("user_login_id");
	    if (user_id == null || user_login_id == null) {
	        return "redirect:/login"; // ì§„ì§œ ë¡œê·¸?¸ ?˜?´ì§?ë¡?
	    }
	    
	    CommunityService cs=sqlSession.getMapper(CommunityService.class);
	    int result = cs.check_like(user_id,post_id);
	    if (result == 0) cs.insert_like(user_id, post_id,user_login_id);
	    
		return "redirect:/PostDetail?pnum=" + post_id;
	}
}
