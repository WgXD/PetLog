package com.mbc.pet.pet;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
public class PetController {
	
	@Autowired
	SqlSession sqlSession;
	//String path = "C:\\1MBC\\spring\\PetLog\\src\\main\\webapp\\image"; //절대 경로 사용 XXXXX

	
	@RequestMapping(value = "/pet_input") //top에서 누르고 들어오는 곳
	public String pet(HttpSession session) {
		
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
		
		return "pet_input"; //jsp file name
	}
	
	@RequestMapping(value = "/pet_save")
	public String pet1(MultipartHttpServletRequest request, HttpSession session) throws IllegalStateException, IOException {
		
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
		
		String path = request.getSession().getServletContext().getRealPath("/image");
		
		//int user_id = 0; ///???
		//Integer user_id = (Integer) request.getSession().getAttribute("user_id");
		
		String pet_name = request.getParameter("pet_name");
		String pet_bog = request.getParameter("pet_bog");
		String pet_hbd = request.getParameter("pet_hbd");
		MultipartFile img = request.getFile("pet_img");
		String filename = img.getOriginalFilename();
		String pet_neuter = request.getParameter("pet_neuter");
		
		UUID ud = UUID.randomUUID();
		filename = ud.toString()+"_"+filename;
		
		PetDTO dto = new PetDTO();
		dto.setPet_name(pet_name);
		dto.setPet_bog(pet_bog);
		dto.setPet_hbd(pet_hbd);
		dto.setPet_img(filename);
		dto.setPet_neuter(pet_neuter);
		dto.setUser_id(user_id); ///???
		
		PetService ps = sqlSession.getMapper(PetService.class);
		ps.pet_save(dto);
		
		img.transferTo(new File(path+"\\"+filename));
		
		return "redirect:/pet_out";
	}
	
	@RequestMapping(value = "/pet_out") 
	public String pet2(Model mo, HttpServletRequest req, HttpSession session) {
		
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
		
		PetService ps = sqlSession.getMapper(PetService.class);
		
		ArrayList<PetDTO> list = ps.petsbyuser(user_id); //회원별 반려동물 출력!!!
		
		mo.addAttribute("list", list);
		
		return "pet_out"; //jsp file name
	}
	
	
	@RequestMapping(value = "/pet_detail") 
	public String pet3(Model mo, HttpServletRequest req, HttpSession session) {
		
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
        
		int update1 = Integer.parseInt(req.getParameter("update1"));
		
		PetService ps = sqlSession.getMapper(PetService.class);
		PetDTO dto = ps.pet_detail(update1);
		mo.addAttribute("dto", dto);
		
		return "pet_detail"; //jsp file name
	}
	
	
	@RequestMapping(value = "/pet_update")
	public String pet4(Model mo, HttpServletRequest req, HttpSession session) {
		
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
		
		int update = Integer.parseInt(req.getParameter("update"));
		
		PetService ps = sqlSession.getMapper(PetService.class);
		PetDTO dto = ps.pet_update(update);
		
		mo.addAttribute("dto", dto);
		
		return "pet_update"; //jsp file name
	}
	
	
	@RequestMapping(value = "/pet_update_save") // from pet_detail .. 수정 후 저장하고 다시 출력
	public String pet4_1(HttpSession session, MultipartHttpServletRequest mul, HttpServletRequest req) throws IllegalStateException, IOException {
	    
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
	    
	    String path = mul.getSession().getServletContext().getRealPath("/image");
	    
	    int pet_id = Integer.parseInt(mul.getParameter("pet_id"));
	    String pet_name = mul.getParameter("pet_name");
	    String pet_bog = mul.getParameter("pet_bog");
	    String pet_neuter = mul.getParameter("pet_neuter");
	    String pet_hbd = mul.getParameter("pet_hbd");
	    MultipartFile mf = mul.getFile("pet_img"); // 업로드된 이미지
	    String dfimage = mul.getParameter("himage"); // 기존 이미지명
	    String fname = null; // [안전] 초기화
	    
	    // [이미지 처리 시작]
	    if (mf != null && !mf.isEmpty()) {
	        // 새 이미지가 있는 경우: UUID를 이용한 고유 파일명 생성
	        fname = UUID.randomUUID().toString() + "_" + mf.getOriginalFilename();
	        mf.transferTo(new File(path + "\\" + fname)); // 파일 저장

	        // 기존 이미지 삭제
	        if (dfimage != null && !dfimage.trim().equals("")) {
	            File ff = new File(path + "\\" + dfimage);
	            if (ff.exists()) ff.delete();
	        }
	    } else {
	        // 새 이미지가 없는 경우 기존 이미지 유지
	        fname = dfimage;
	    }
	    // [이미지 처리 끝]

	    PetService ps = sqlSession.getMapper(PetService.class);
	    ps.pet_update_save(pet_id, pet_name, pet_bog, pet_hbd, user_id, fname, pet_neuter);
	    
	    return "redirect:/pet_out";
	}
	
	
	@RequestMapping(value = "/pet_delete") //삭제 전 확인 페이지
	public String pet5(Model mo, HttpServletRequest req, HttpSession session) {
		
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
		
		int delete = Integer.parseInt(req.getParameter("delete"));
		
		PetService ps = sqlSession.getMapper(PetService.class);
		PetDTO dto = ps.delete1(delete);
		
		mo.addAttribute("dto", dto);
		
		return "pet_delete"; //jsp file name
	}
	
	@RequestMapping(value = "/pet_delete_check") //삭제 전 확인 페이지
	public String pet5_1(Model mo, HttpServletRequest req, HttpSession session) {
		
    	// 로그인 체크
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");

        if (user_id == null || user_login_id == null) {
            return "redirect:/login?error=login_required";
        }
		
		String path = req.getSession().getServletContext().getRealPath("/image");
		
		int delete = Integer.parseInt(req.getParameter("pet_id"));
		
		String dfname = req.getParameter("himage");
		
		PetService ps = sqlSession.getMapper(PetService.class);
		ps.delete_check(delete);
		
		File ff = new File(path + "\\" + dfname);
		ff.delete();
		
		return "redirect:/pet_out"; //jsp file name
	}
}
