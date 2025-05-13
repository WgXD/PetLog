package com.mbc.pet.community;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import com.mbc.pet.user.UserService;

@Controller
public class CommunityController {

	@Autowired
	SqlSession sqlSession;
    
    @RequestMapping(value = "/CommunityIn")
    public String cc(HttpSession session) {
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
        return "CommunityInput";
    }
    
    @RequestMapping(value = "/BoardInput")
    public String bc(HttpSession session) {
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
        return "BoardInput";
    }

//게시글 저장----------------------------------------------------
    @RequestMapping(value = "/CommunitySave")
    public String cc1(HttpServletRequest request, MultipartHttpServletRequest mul, Model mo,
                      HttpSession session, @RequestParam(value = "post_type", required = false) String post_type)
            throws IllegalStateException, IOException {

    	String path = request.getSession().getServletContext().getRealPath("/image");
    	
        // 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }

        // post_type 기본값 보정
        if (post_type == null || (!post_type.equals("notice") && !post_type.equals("normal"))) {
            post_type = "normal";
        }

        // 파라미터 추출
        String title = mul.getParameter("post_title");
        String content = mul.getParameter("post_content");
        MultipartFile mf = mul.getFile("post_image");

        // 이미지 처리
        String ofname = "noimage.png"; // 기본 이미지
        if (mf != null && !mf.isEmpty()) {
            String originName = mf.getOriginalFilename();
            UUID ud = UUID.randomUUID();
            ofname = ud.toString() + "_" + originName;

            File dest = new File(path + "\\" + ofname);
            try {
                mf.transferTo(dest); // 실제 파일 저장
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        
        // DB 저장
        CommunityService cs = sqlSession.getMapper(CommunityService.class);
        try {
            cs.insertc(user_id, title, content, ofname, post_type);
            // 게시글 타입에 따라 리다이렉트
            if (post_type.equals("notice")) {
                return "redirect:/NoticeBoard";
            } else {
                return "redirect:/CommunityView";
            }
        } catch (Exception e) {
            System.out.println("DB 저장 중 예외 발생: " + e.getMessage());
            e.printStackTrace();
        }
        
        return "redirect:/CommunityView";
    }

//출력-------------------------------------------------------------
    @RequestMapping(value = "/CommunityView")
    public String cc2(HttpServletRequest request,HttpSession session,PageDTO dto,Model mo,@RequestParam(defaultValue = "1") int page) {
	    Integer user_id = (Integer) session.getAttribute("user_id");
	    String user_login_id = (String) session.getAttribute("user_login_id");
	   
	    if (user_id == null || user_login_id == null) {
	        return "redirect:/login?error=login_required"; // 로그인 안 했을 경우
	    }
    	
    	//페이징 처리 1
        int page_size = 10; //한 페이지당 출력할 게시글 개수
        int start = (page-1) * page_size;
        int end = start + page_size;
        
        CommunityService cs = sqlSession.getMapper(CommunityService.class);
        
        //페이징 처리 2
        int total_count = cs.totalByType("normal");
        int page_count = (int) Math.ceil((double)total_count / page_size);
        
        ArrayList<CommunityDTO> list = cs.outviewByType(start, end, "normal");
        mo.addAttribute("list", list);
        mo.addAttribute("page", page);
        mo.addAttribute("page_count", page_count);
        mo.addAttribute("page_size", page_size);
        return "CommunityOut";
    }
    
//공지사항 출력-------------------------------------------------------------
    @RequestMapping("/NoticeBoard")
    public String bb1(HttpServletRequest request,HttpSession session,PageDTO dto,Model mo,@RequestParam(defaultValue = "1") int page) {
	    Integer user_id = (Integer) session.getAttribute("user_id");
	    String user_login_id = (String) session.getAttribute("user_login_id");

	    if (user_id == null || user_login_id == null) {
	        return "redirect:/login?error=login_required";
	    }

	    int page_size = 10;
	    int start = (page-1) * page_size;
	    int end = start + page_size;
	    
	    CommunityService cs = sqlSession.getMapper(CommunityService.class);
	    
	    int total_count = cs.totalByType("notice");
	    int page_count = (int) Math.ceil((double)total_count / page_size);
	    
	    ArrayList<CommunityDTO> list = cs.outviewByType(start, end, "notice");
	    mo.addAttribute("list", list);
	    mo.addAttribute("page", page);
	    mo.addAttribute("page_count", page_count);
	    mo.addAttribute("page_size", page_size);
	    return "BoardView"; // 공지사항 출력 JSP
    }

//공지사항 상세 보기----------------------------------------------------
    @RequestMapping(value = "/BoardDetail")
    public String cc5(Model mo, HttpServletRequest request,HttpSession session) {
      
	    Integer user_id = (Integer) session.getAttribute("user_id");
	    String user_login_id = (String) session.getAttribute("user_login_id");

	    if (user_id == null || user_login_id == null) {
	        return "redirect:/login?error=login_required";
	    }
    	
    	int pnum = Integer.parseInt(request.getParameter("pnum"));
        CommunityService cs = sqlSession.getMapper(CommunityService.class);
        cs.readcnt(pnum);
        CommunityDTO dto = cs.detailview(pnum);
        mo.addAttribute("dto", dto);
        mo.addAttribute("user_id", user_id);
        
        int result = cs.check_like(user_id, pnum);
        boolean userLiked = result > 0;
        mo.addAttribute("userLiked", userLiked);
        return "BoardDetail";
    }

  //게시글 상세 보기----------------------------------------------------
    @RequestMapping(value = "/PostDetail")
    public String cc3(Model mo, HttpServletRequest request,HttpSession session) {
      
	    Integer user_id = (Integer) session.getAttribute("user_id");
	    String user_login_id = (String) session.getAttribute("user_login_id");

	    if (user_id == null || user_login_id == null) {
	        return "redirect:/login?error=login_required";
	    }
    	
    	int pnum = Integer.parseInt(request.getParameter("pnum"));
        CommunityService cs = sqlSession.getMapper(CommunityService.class);
        cs.readcnt(pnum);
        CommunityDTO dto = cs.detailview(pnum);
        mo.addAttribute("dto", dto);
        mo.addAttribute("user_id", user_id);
        
        //작성자 프로필 이미지 가져오기
        UserService us = sqlSession.getMapper(UserService.class);
        UserDTO udto = us.selectUserById(dto.getUser_id());
        mo.addAttribute("profileimg", udto.getProfileimg());
        
        List<CommentsDTO> comments = cs.getCommentsByPostId(pnum);
        mo.addAttribute("comments", comments);
        
        int likeCount = cs.getLikeCount(pnum);
        mo.addAttribute("LikeCount", likeCount);
        
        int result = cs.check_like(user_id, pnum);
        boolean userLiked = result > 0;
        mo.addAttribute("userLiked", userLiked);
        return "CommunityDetail";
    }

    
//삭제-----------------------------------------------------
    @RequestMapping(value = "/PostDelete")
    public String cc4(HttpServletRequest request, Model mo, HttpSession session) {
    	
	    Integer user_id = (Integer) session.getAttribute("user_id");
	    String user_login_id = (String) session.getAttribute("user_login_id");

	    if (user_id == null || user_login_id == null) {
	        return "redirect:/login?error=login_required";
	    }
    	
        int dnum = Integer.parseInt(request.getParameter("dnum"));
        CommunityService cs = sqlSession.getMapper(CommunityService.class);
        CommunityDTO dto = cs.deleteview(dnum);
        mo.addAttribute("dto", dto);
        return "CommunityDeleteView";
    }

    @RequestMapping(value = "/PostDeleteSave", method = RequestMethod.GET)
    public void deletePost(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException {

        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");
        String user_role = (String) session.getAttribute("user_role");

        if (user_id == null || user_login_id == null) {
            response.sendRedirect("/login?error=login_required");
            return;
        }

        int dnum = Integer.parseInt(request.getParameter("dnum"));
        String dfname = request.getParameter("dfimage");
        String path = request.getSession().getServletContext().getRealPath("/image");

        CommunityService cs = sqlSession.getMapper(CommunityService.class);
        CommunityDTO dto = cs.getPostById(dnum);

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
 
        //관리자랑 작성자만 삭제 가능
        String user_role1 = (String) session.getAttribute("user_role");
        boolean isAdmin = "admin".equals(user_role1);

        if (dto == null || (!user_id.equals(dto.getUser_id()) && !isAdmin)) {
            out.println("<script>alert('삭제 권한이 없습니다.'); history.back();</script>");
            return;
        }

        // 삭제 처리
        cs.deletePost(dnum, user_id);

        // 이미지 파일 삭제
        if (dfname != null && !dfname.equals("noimage.png")) {
            File oldFile = new File(path + "\\" + dfname);
            if (oldFile.exists()) oldFile.delete();
        }

        // 게시글 타입에 따라 분기해서 목록으로 리다이렉트
        String redirectUrl = "CommunityView";
        if ("notice".equals(dto.getPost_type())) {
            redirectUrl = "NoticeBoard";
        }
        
        System.out.println("이미지 삭제 경로: " + path + "\\" + dfname);
        File oldFile = new File(path + "\\" + dfname);
        System.out.println("파일 존재? " + oldFile.exists());

        out.println("<script>alert('게시글이 삭제되었습니다.'); location.href='" + redirectUrl + "';</script>");
    }

//수정----------------------------------------------------
    @RequestMapping(value = "/PostModify")
    public String cc6(HttpServletRequest request, Model mo, HttpSession session) {
    	
	    Integer user_id = (Integer) session.getAttribute("user_id");
	    String user_login_id = (String) session.getAttribute("user_login_id");

	    if (user_id == null || user_login_id == null) {
	        return "redirect:/login?error=login_required";
	    }
    	
        int mnum = Integer.parseInt(request.getParameter("mnum"));
        CommunityService cs = sqlSession.getMapper(CommunityService.class);
        CommunityDTO dto = cs.modifyview(mnum);
        mo.addAttribute("dto", dto);
        return "CommunityModify";
    }

    @RequestMapping(value = "/PostModifySave", method = RequestMethod.POST)
    public String modifyPost(MultipartHttpServletRequest mul, HttpSession session, 
    		RedirectAttributes redirectAttributes, HttpServletResponse response) throws IllegalStateException, IOException {
    	
	    Integer user_id = (Integer) session.getAttribute("user_id");
	    String user_login_id = (String) session.getAttribute("user_login_id");

	    if (user_id == null || user_login_id == null) {
	        return "redirect:/login?error=login_required";
	    }
    	
    	String path = mul.getSession().getServletContext().getRealPath("/image");

        if (user_id == null || user_login_id == null) return "redirect:/login";

        int mnum = Integer.parseInt(mul.getParameter("mnum"));
        String title = mul.getParameter("post_title");
        String content = mul.getParameter("post_content");
        String dfname = mul.getParameter("himage");
        MultipartFile mf = mul.getFile("post_image");

        CommunityService cs = sqlSession.getMapper(CommunityService.class);
        CommunityDTO dto = cs.getPostById(mnum);
        if (dto == null) return "redirect:/errorPage";

        //관리자랑 작성자만 수정 가능
        String user_role = (String) session.getAttribute("user_role");
        boolean isAdmin = "admin".equals(user_role);

        if (!user_id.equals(dto.getUser_id()) && !isAdmin) {
            redirectAttributes.addFlashAttribute("msg", "수정 권한이 없습니다.");
            return "redirect:/PostDetail?pnum=" + mnum;
        }

        String fname = dfname;
        if (mf != null && !mf.isEmpty()) {
            UUID ud = UUID.randomUUID();
            fname = ud.toString() + "_" + mf.getOriginalFilename();
            mf.transferTo(new File(path + "\\" + fname));

            if (dfname != null && !dfname.equals("noimage.png")) {
                File oldFile = new File(path + "\\" + dfname);
                if (oldFile.exists()) oldFile.delete();
        }}


        CommunityDTO modifyDto = new CommunityDTO();
        modifyDto.setPost_id(mnum);
        modifyDto.setUser_id(user_id);
        modifyDto.setPost_title(title);
        modifyDto.setPost_content(content);
        modifyDto.setPost_image(fname);
        cs.modify(modifyDto);

        redirectAttributes.addFlashAttribute("msg", "수정이 완료되었습니다.");
        
        // 게시글 타입에 따라 분기
        if ("notice".equals(dto.getPost_type())) {
            return "redirect:/NoticeBoard";
        } else {
            return "redirect:/CommunityView";
        }
    }

//검색----------------------------------------------------
	@RequestMapping(value = "/searchview")
	public String cc8(HttpServletRequest request,Model mo,  HttpSession session, RedirectAttributes redirectAttributes) {
		
	    Integer user_id = (Integer) session.getAttribute("user_id");
	    String user_login_id = (String) session.getAttribute("user_login_id");

	    if (user_id == null || user_login_id == null) {
	        return "redirect:/login?error=login_required";
	    }
		
		String skey=request.getParameter("skey");
		String svalue=request.getParameter("keyword");
		
		if (svalue == null || svalue.trim().isEmpty()) {
		    String msg = "검색어를 입력해주세요.";
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

		mo.addAttribute("list", list);
		mo.addAttribute("keyword", svalue);
		
		if(list==null || list.isEmpty()) {
			String msg="검색 결과가 없습니다.";
			redirectAttributes.addFlashAttribute("msg", msg);
			return "redirect:/CommunitySearchView";
		}
		return "CommunitySearchView";
	}
	
	@RequestMapping("/CommunitySearchView")
	public String cc9(Model mo) {
	    return "CommunitySearchView"; // 검색 화면으로 이동
	}
	
//댓글----------------------------------------------------
	@RequestMapping(value = "/commentInsert", method = RequestMethod.POST)
    public String cc10(HttpSession session, HttpServletRequest request,
		    	   	  @RequestParam("post_id") int post_id,
		              @RequestParam("com_com") String com_com,
		              @RequestParam(value = "parent_id", required = false) Integer parent_id,
		              @RequestParam(value = "depth", defaultValue = "0") int depth) {
	    //로그인 체크
		Integer user_id = (Integer) session.getAttribute("user_id");
	    String user_login_id = (String) session.getAttribute("user_login_id");
	    if (user_id == null || user_login_id == null) {
	        return "redirect:/login?error=login_required";
	    }
	    //댓글 DTO 객체 생성 및 저장
	    UserDTO user=new UserDTO();
	    user.setUser_id(user_id);
	    
	    CommunityDTO post=new CommunityDTO();
	    post.setPost_id(post_id);
	    
	    CommentsDTO dto=new CommentsDTO(); 
	    dto.setCom_com(com_com);
	    dto.setParent_id( parent_id != null ? parent_id : 0);
	    dto.setDepth( parent_id != null ? depth : 0);
	    dto.setPsdto(user);
	    dto.setCtdto(post);

        CommunityService cs = sqlSession.getMapper(CommunityService.class);
        cs.insertco(dto);
        return "redirect:/PostDetail?pnum=" + post_id;
    }

//좋아요 기능----------------------------------------------------
	@RequestMapping(value = "/like", method = RequestMethod.POST)
	public String cc11(HttpServletRequest request,Model mo, HttpSession session,@RequestParam int post_id) {
		//로그인 체크
		Integer user_id = (Integer) session.getAttribute("user_id");
	    String user_login_id = (String) session.getAttribute("user_login_id");
	    if (user_id == null || user_login_id == null) {
	        return "redirect:/login?error=login_required";
	    }
	    
	    CommunityService cs=sqlSession.getMapper(CommunityService.class);
	    int result = cs.check_like(user_id,post_id);
	    if (result == 0) cs.insert_like(user_id, post_id,user_login_id);
	    
		return "redirect:/PostDetail?pnum=" + post_id;
	}
}
