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
    //개발?�� 경로
    //String path = "C:\\MBC12AI\\spring\\PetLog\\PetLog\\src\\main\\webapp\\image"; 

    @RequestMapping(value = "/CommunityIn")
    public String cc(HttpSession session) {
    	 // ?��?�� 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login";
        }
        return "CommunityInput";
    }
    
    @RequestMapping(value = "/BoardInput")
    public String bc(HttpSession session) {
    	 // ?��?�� 체크
    	
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login";
        }
        return "BoardInput";
    }
//게시�? ???��----------------------------------------------------
    @RequestMapping(value = "/CommunitySave")
    public String cc1(HttpServletRequest request, MultipartHttpServletRequest mul, Model mo,
                      HttpSession session, @RequestParam(value = "post_type", required = false) String post_type)
            throws IllegalStateException, IOException {

    	String path = request.getSession().getServletContext().getRealPath("/image");
    	
        // ?��?�� 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login";
        }

        // post_type ?��?��?�� 보정
        if (post_type == null || (!post_type.equals("notice") && !post_type.equals("normal"))) {
            post_type = "normal";
        }

        // ?��?��미터 추출
        String title = mul.getParameter("post_title");
        String content = mul.getParameter("post_content");
        MultipartFile mf = mul.getFile("post_image");

        // ?��미�? ?��?�� 처리
        String ofname = "noimage.png"; // 기본 ?��미�?
        if (mf != null && !mf.isEmpty()) {
            String originName = mf.getOriginalFilename();
            UUID ud = UUID.randomUUID();
            ofname = ud.toString() + "_" + originName;

            File dest = new File(path + "\\" + ofname);
            try {
                mf.transferTo(dest); // ?��?�� ?��?�� ???��
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        
        // DB ???��
        CommunityService cs = sqlSession.getMapper(CommunityService.class);
        try {
            cs.insertc(user_id, title, content, ofname, post_type);
            // 게시�? ???�� ?���? ?�� 리다?��?��?��
            if (post_type.equals("notice")) {
                return "redirect:/NoticeBoard";
            } else {
                return "redirect:/CommunityView";
            }
        } catch (Exception e) {
            System.out.println("?�� DB ???�� �? ?��?�� 발생: " + e.getMessage());
            e.printStackTrace();
        }

        return "redirect:/CommunityView";
    }
//출력-------------------------------------------------------------
    @RequestMapping(value = "/CommunityView")
    public String cc2(HttpServletRequest request,HttpSession session,PageDTO dto,Model mo,@RequestParam(defaultValue = "1") int page) {
    	//////////////
	    Integer user_id = (Integer) session.getAttribute("user_id");
	    String user_login_id = (String) session.getAttribute("user_login_id");
	   
	    if (user_id == null || user_login_id == null) {
	        return "redirect:/login"; // 진짜 로그?�� ?��?���?�?
	    }
    	
    	//?��?���? 처리 1
        int page_size = 10; //?�� ?��?���??�� 출력?�� 게시�? �??��
        int start = (page-1) * page_size; //?��?�� ?��?���??��?�� ?��?��?��?�� ?��?��?��?�� ?��치�?? 계산?��?�� 공식
        int end = start + page_size;
        //?��?���? 1 end
        
        HttpSession hs = request.getSession();
        CommunityService cs = sqlSession.getMapper(CommunityService.class);
        
        //?��?���? 처리 2
        int total_count = cs.totalByType("normal"); //?���? �??�� //ceil ?��?�� ?���?
        int page_count = (int) Math.ceil((double)total_count / page_size);
        //?��?���? 2 end
        
        ArrayList<CommunityDTO> list = cs.outviewByType(start, end, "normal");
        mo.addAttribute("list", list);
        mo.addAttribute("page", page);
        mo.addAttribute("page_count", page_count);
        mo.addAttribute("page_size", page_size);
        //?��?���?3 end
        return "CommunityOut";
    }
    
///공�??��?�� 출력-------------------------------------------------------------
    @RequestMapping("/NoticeBoard")
    public String bb1(HttpServletRequest request,HttpSession session,PageDTO dto,Model mo,@RequestParam(defaultValue = "1") int page) {
    //////////////
    Integer user_id = (Integer) session.getAttribute("user_id");
    String user_login_id = (String) session.getAttribute("user_login_id");
   
    if (user_id == null || user_login_id == null) {
        return "redirect:/login"; // 진짜 로그?�� ?��?���?�?
    }
	
	//?��?���? 처리 1
    int page_size = 10; //?�� ?��?���??�� 출력?�� 게시�? �??��
    int start = (page-1) * page_size; //?��?�� ?��?���??��?�� ?��?��?��?�� ?��?��?��?�� ?��치�?? 계산?��?�� 공식
    int end = start + page_size;
    //?��?���? 1 end
    
    HttpSession hs = request.getSession();
    CommunityService cs = sqlSession.getMapper(CommunityService.class);
    
    //?��?���? 처리 2
    int total_count = cs.totalByType("notice"); //?���? �??�� //ceil ?��?�� ?���?
    int page_count = (int) Math.ceil((double)total_count / page_size);
    //?��?���? 2 end
    
    ArrayList<CommunityDTO> list = cs.outviewByType(start, end, "notice");
    mo.addAttribute("list", list);
    mo.addAttribute("page", page);
    mo.addAttribute("page_count", page_count);
    mo.addAttribute("page_size", page_size);
    //?��?���?3 end
        return "BoardView"; // 공�??��?�� ?��?�� JSP
    }
    
//?��?��?�� 보기----------------------------------------------------
    @RequestMapping(value = "/PostDetail")
    public String cc3(Model mo, HttpServletRequest request,HttpSession session) {
        int pnum = Integer.parseInt(request.getParameter("pnum"));
        CommunityService cs = sqlSession.getMapper(CommunityService.class);
        cs.readcnt(pnum);
        CommunityDTO dto = cs.detailview(pnum);
        mo.addAttribute("dto", dto);

        // 로그?��?�� ?��?��?�� ID
        Integer user_id = (Integer) session.getAttribute("user_id");
        mo.addAttribute("user_id", user_id);  // JSP?�� user_id ?��?��
        
        List<CommentsDTO> comments = cs.getCommentsByPostId(pnum);
        mo.addAttribute("comments", comments);
        
        // 좋아?�� ?�� �??��?���?
        int likeCount = cs.getLikeCount(pnum);
        mo.addAttribute("LikeCount", likeCount);
        
        //로그?��?�� ?��?��?��?�� 좋아?�� ?���? ?��?��
        int result = cs.check_like(user_id, pnum);
        boolean userLiked = result > 0;
        mo.addAttribute("userLiked", userLiked);
        return "CommunityDetail";
    }
    
//?��?��-----------------------------------------------------
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

        Integer user_id = (Integer) session.getAttribute("user_id"); // ?��?�� 로그?��?�� ?��??
        CommunityService cs = sqlSession.getMapper(CommunityService.class);

        // �? ?��?��?�� 조회
        CommunityDTO dto = cs.getPostById(dnum);
        if (dto == null) {
            return "redirect:/errorPage"; // 게시�? ?��?���?
        }
        if (!user_id.equals(dto.getUser_id())) {
            return "redirect:/accessDenied"; // ?��?��?�� 불일치하�?
        }

        // ?��?�� 진행
        cs.deletePost(dnum);

        // ?��미�? ?��?�� ?��?��
        if (dfname != null && !dfname.equals("noimage.png")) {
            File oldFile = new File(path + "\\" + dfname);
            if (oldFile.exists()) {
                boolean isDeleted = oldFile.delete();
                redirectAttributes.addFlashAttribute("msg", isDeleted ? "게시�? �? ?��?�� ?��?�� ?���?" : "게시�? ?��?�� ?���? (?��?�� ?��?�� ?��?��)");
            } else {
                redirectAttributes.addFlashAttribute("msg", "게시�? ?��?�� ?���? (?��?�� ?��?��)");
            }
        } else {
            redirectAttributes.addFlashAttribute("msg", "게시�? ?��?�� ?���?");
        }

        return "redirect:/CommunityView"; // 목록?���? ?��?��
    }
    
//?��?��----------------------------------------------------
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
        ////// 로그?�� ?��?�� 체크 ///////
    	
    	String path = mul.getSession().getServletContext().getRealPath("/image");
    	
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");
        if (user_id == null || user_login_id == null) {
            return "redirect:/login"; // 로그?�� ?�� ?��?�� ?��?���? 리다?��?��?��
        }

        int mnum = Integer.parseInt(mul.getParameter("mnum"));
        String title = mul.getParameter("post_title");
        String content = mul.getParameter("post_content");
        String dfname = mul.getParameter("himage"); // 기존 ?��?���?
        MultipartFile mf = mul.getFile("post_image"); // ?���? ?��로드?�� ?��?��

        CommunityService cs = sqlSession.getMapper(CommunityService.class);

        // �? ?��?��?�� �?�?
        CommunityDTO dto = cs.getPostById(mnum);
        if (dto == null) {
            return "redirect:/errorPage";
        }
        if (!user_id.equals(dto.getUser_id())) {
            return "redirect:/accessDenied"; // �? ?��?��?��?? 로그?�� ?��??�? ?��르면 ?��?�� 불�?
        }

        ////// ?��?�� ?��로드 처리 ///////
        String fname = dfname; // 기본?? 기존 ?��?���? ?���?
        if (mf != null && !mf.isEmpty()) {
            // ?�� ?��?�� ?��로드
            UUID ud = UUID.randomUUID();
            fname = ud.toString() + "_" + mf.getOriginalFilename();
            mf.transferTo(new File(path + "\\" + fname));

            // 기존 ?��?�� ?��?��
            if (dfname != null && !dfname.equals("noimage.png")) {
                File oldFile = new File(path + "\\" + dfname);
                if (oldFile.exists()) {
                    oldFile.delete();
                }
            }
        }

        ////// DB ?��?�� 처리 ///////
        CommunityDTO modifyDto = new CommunityDTO();
        modifyDto.setPost_id(mnum);
        modifyDto.setPost_title(title);
        modifyDto.setPost_content(content);
        modifyDto.setPost_image(fname);
        cs.updatePost(modifyDto);

        redirectAttributes.addFlashAttribute("msg", "?��?�� ?��료되?��?��?��?��.");
        return "redirect:/PostDetail?pnum=" + mnum;
    }
    
//�??��----------------------------------------------------
	@RequestMapping(value = "/searchview")
	public String cc8(HttpServletRequest request,Model mo,  HttpSession session, RedirectAttributes redirectAttributes) {
		
		String skey=request.getParameter("skey");
		String svalue=request.getParameter("keyword");
		
		if (svalue == null || svalue.trim().isEmpty()) {
		    String msg = "�??��?���? ?��?��?��?��?��.";
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
			String msg="�??�� 결과�? ?��?��?��?��.";
			redirectAttributes.addFlashAttribute("msg", msg);
			return "redirect:/CommunitySearchView";
		}
		return "CommunitySearchView";
	}
	
	@RequestMapping("/CommunitySearchView")
	public String cc9(Model mo) {
	    return "CommunitySearchView"; // ?���? ?��?��?�� FlashAttribute�? ?��?���?
	}
	
//?���?----------------------------------------------------
	@RequestMapping(value = "/commentInsert", method = RequestMethod.POST)
    public String cc10(HttpSession session, HttpServletRequest request,
		    	   	  @RequestParam("post_id") int post_id,
		              @RequestParam("com_com") String com_com,
		              @RequestParam(value = "parent_id", required = false) Integer parent_id,
		              @RequestParam(value = "depth", defaultValue = "0") int depth) {
	    //로그?�� 체크
		Integer user_id = (Integer) session.getAttribute("user_id");
	    String user_login_id = (String) session.getAttribute("user_login_id");
	    if (user_id == null || user_login_id == null) {
	        return "redirect:/login"; // 진짜 로그?�� ?��?���?�?
	    }
	    //?��?�� DTO 객체 ?��?�� ?�� commentsDTO?�� ???��
	    UserDTO user=new UserDTO();
	    user.setUser_id(user_id);
	    
	    CommunityDTO post=new CommunityDTO();
	    post.setPost_id(post_id);
	    
	    CommentsDTO dto=new CommentsDTO(); 
	    dto.setCom_com(com_com);
	    if (parent_id == null) {
	        dto.setParent_id(0);      // ?���? ?���?
	    } else {
	        dto.setParent_id(parent_id); // ???���?
	    }
	    dto.setDepth(depth);
	    dto.setPsdto(user);
	    dto.setCtdto(post);
	    //DB ???��
        CommunityService cs = sqlSession.getMapper(CommunityService.class);
        cs.insertco(dto);
        return "redirect:/PostDetail?pnum=" + post_id;
    }
//좋아?�� 기능----------------------------------------------------
	@RequestMapping(value = "/like", method = RequestMethod.POST)
	public String cc11(HttpServletRequest request,Model mo, HttpSession session,@RequestParam int post_id) {
		//로그?�� 체크
		Integer user_id = (Integer) session.getAttribute("user_id");
	    String user_login_id = (String) session.getAttribute("user_login_id");
	    if (user_id == null || user_login_id == null) {
	        return "redirect:/login"; // 진짜 로그?�� ?��?���?�?
	    }
	    
	    CommunityService cs=sqlSession.getMapper(CommunityService.class);
	    int result = cs.check_like(user_id,post_id);
	    if (result == 0) cs.insert_like(user_id, post_id,user_login_id);
	    
		return "redirect:/PostDetail?pnum=" + post_id;
	}
}
