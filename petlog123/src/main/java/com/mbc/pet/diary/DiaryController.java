package com.mbc.pet.diary;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.mbc.pet.pet.PetDTO;
import com.mbc.pet.pet.PetService;
import com.mbc.pet.point.PointDTO;
import com.mbc.pet.point.PointService;

@Controller
public class DiaryController {
	
	@Autowired
	SqlSession sqlSession;
	//String path = "C:\\1MBC\\spring\\PetLog\\src\\main\\webapp\\image";
	Principal principa;
	
	
	@RequestMapping(value = "/diary_input") // top에서 다이어리 작성 버튼 눌렀을 때
	public String diary(HttpSession session, Model mo) {
	    
	    // 로그인한 회원 정보 확인
	    Integer user_id = (Integer) session.getAttribute("user_id");

	    if (user_id == null) {
	        return "redirect:/login?error=login_required"; // 로그인 안 된 경우 로그인 페이지로 리다이렉트 + alert 처리
	    }
	    
	    // �ݷ����� ��� �ҷ����� (���� ���� ���� ���� �����ϱ�)
	    PetService petService = sqlSession.getMapper(PetService.class);
	    ArrayList<PetDTO> list = petService.petsbyuser(user_id);

	    // JSP�� �ѱ��
	    mo.addAttribute("list", list);

        return "diary_input"; //jsp file name
	}

	
	@RequestMapping(value = "/diary_save") //from pet_input
	public String diary1(MultipartHttpServletRequest request) throws IllegalStateException, IOException {
		
		String path = request.getSession().getServletContext().getRealPath("/image");
		
	    // �α��ε� ����� user_id ����
	    Integer user_id = (Integer) request.getSession().getAttribute("user_id");
	    
	    // null üũ (��: �α��� Ǯ�Ȱų� ������ ���� ����)
	    if (user_id == null) {
	        return "redirect:/login"; // �Ǵ� ���� ��������
	    }
	    
	    int pet_id = Integer.parseInt(request.getParameter("pet_id"));
	      
		//int diary_id = Integer.parseInt(request.getParameter("diary_id"));
		String diary_title = request.getParameter("diary_title");
		String diary_date = request.getParameter("diary_date");
		MultipartFile image = request.getFile("diary_image");
		String filename = image.getOriginalFilename();
		String diary_content = request.getParameter("diary_content");
		
		UUID ud = UUID.randomUUID();
		filename = ud.toString()+"_"+filename;
		
		//Service�� ȣ��κ�
		DiaryService ds = sqlSession.getMapper(DiaryService.class);
		PointService ps = sqlSession.getMapper(PointService.class);
		
		//Oracle ���������� ���� diary_id �̸� �̴� ��
		int next_diaryid = ds.get_id();
		//
		
		//������� ����Ʈ ���� ���� �߰� ����
		DiaryDTO dd = new DiaryDTO();
		dd.setDiary_id(next_diaryid);
		dd.setDiary_title(diary_title);
		dd.setDiary_date(diary_date);
		dd.setDiary_image(filename);
		dd.setDiary_content(diary_content);
		dd.setGet_grape(0); //�� �ƹ��͵� �ۼ����ϸ� ������ 0���� -> 0		
		dd.setPet_id(pet_id);
		dd.setUser_id(user_id);
		//�������
		
		ds.diary_save(dd);
		
		image.transferTo(new File(path+"\\"+filename));
		
		
		//������� ������ ���� -> �ۼ��� �Խù��� �������� �����Ǿ����� check
		if(dd.getGet_grape()==0) {
			
			PointDTO point = new PointDTO();
			point.setUser_id(user_id);
			point.setPoint_action("diary");
			point.setPoint_action_id(dd.getDiary_id());
			point.setPoint_earned_grapes(1);
			ps.insert_point(point);
			
			ds.grape_check(dd.getDiary_id()); //boolean 0=false , 1=true
			
		}

		return "diary_input"; //jsp file name
	}

	
	@RequestMapping(value = "/diary_out") //top���� ������ ������ �� //@RequestParam(defaultValue = "1") ����Ʈ�� 1������ ������
	public String diary2(Model mo, HttpServletRequest request, @RequestParam(value = "page", defaultValue = "1") int page) {
		
		//��ȸ�� ����
	    HttpSession hs = request.getSession();
	    Integer user_id = (Integer) hs.getAttribute("user_id");
	    if (user_id == null) {
	        return "redirect:/login?error=login_required";
	    }
	
	    
		//����¡ ó�� 1
		int page_size = 5; //�� �������� �ϱ� 5���� ���̱�!!
		int start = (page-1) * page_size; //���� ���������� �����ϴ� �������� ��ġ�� ����ϴ� ����
		int end = start + page_size;
		//����¡ 1 end
		
		DiaryService ds = sqlSession.getMapper(DiaryService.class);
		
		//����¡ ó�� 2
		int total_count = ds.total_diary(); //��ü �ϱ� ���� //ceil ���� �ø�
		
		int page_count = (int) Math.ceil((double)total_count / page_size);
		//����¡ 2 end
		
		//����¡ ó�� 3
		
		System.out.println("start: " + start);
		System.out.println("end: " + end);
		
		 ArrayList<DiaryDTO> list = ds.diary_out(start, end);
		 
		 //System.out.println("list size: " + list.size()); // ��� ����� ũ�� ��� for test
		 
		mo.addAttribute("list", list);
		mo.addAttribute("page", page);
		mo.addAttribute("page_count", page_count);
		mo.addAttribute("page_size", page_size);
		//����¡3 end
		
		return "diary_out"; //jsp file name
	}
	
	@RequestMapping(value = "/diary_detail")
	public String diary3(Model mo, HttpServletRequest request) {

	            int unum = Integer.parseInt(request.getParameter("unum"));
	            DiaryService ds = sqlSession.getMapper(DiaryService.class);
	            DiaryDTO dto = ds.diary_detail(unum);  // �ش� �ϱ� �����͸� ������
	            mo.addAttribute("dto", dto); 

	    return "diary_detail";
	}
	
	@RequestMapping(value = "/diary_update") //detail ������ ������ �� (����)
	public String diary4(Model mo, HttpServletRequest request) {
		
			int update = Integer.parseInt(request.getParameter("update"));
			DiaryService ds = sqlSession.getMapper(DiaryService.class);
			DiaryDTO dto = ds.diary_update(update);
			mo.addAttribute("dto", dto);
		
		return "diary_update"; //jsp file name
	}

	
	@RequestMapping(value = "/update_save") //update���� ������ ������ ��
	public String diary5(MultipartHttpServletRequest mul) throws IllegalStateException, IOException {
		
		String path = mul.getSession().getServletContext().getRealPath("/image");
		
		int pet_id = 0;
		int user_id = 0;

		if (principa != null) {
		    try {
		        int parsedId = Integer.parseInt(principa.getName());
		        pet_id = parsedId;
		        user_id = parsedId; // �� �� ������ ���̵��� ���
		    } catch (NumberFormatException e) {
		        // ���� �߻� �� �⺻�� ����
		        pet_id = 0;
		        user_id = 0;
		    }
		}

		int diary_id = Integer.parseInt(mul.getParameter("diary_id")); 
		String diary_title = mul.getParameter("diary_title");
		String diary_date = mul.getParameter("diary_date");
		String diary_content = mul.getParameter("diary_content");
		MultipartFile mf = mul.getFile("diary_image");
		String dfimage = mul.getParameter("himage");
		String fname = mf.getOriginalFilename();
		
		// >> ������� �߰��� �κ�
		
		if (mf != null && !mf.isEmpty()) {
		    // �� �̹����� ���� ���
		    fname = UUID.randomUUID().toString() + "_" + mf.getOriginalFilename();
		    mf.transferTo(new File(path + "\\" + fname));

		    // ���� �̹��� ����
		    if (dfimage != null && !dfimage.trim().equals("")) {
		        File ff = new File(path + "\\" + dfimage);
		        if (ff.exists()) ff.delete();
		    }
		} else {
		    // �� �̹����� ���� ��� ���� �̹��� �״�� ���
		    fname = dfimage;
		}
		
		// << �������
		
		DiaryService ds = sqlSession.getMapper(DiaryService.class);
		ds.update_save(diary_id, diary_title, diary_date, fname, diary_content,user_id, pet_id);
		

  
		return "redirect:/diary_out"; //jsp file name
	}
	
	
	@RequestMapping(value = "/diary_delete") //diary_detail.jsp ������ ������ �� (������)
	public String diary6(HttpServletRequest request,Model mo) {
		
		int delete = Integer.parseInt(request.getParameter("delete"));
		DiaryService ds = sqlSession.getMapper(DiaryService.class);
		
		DiaryDTO dto = ds.delete_check(delete);
		mo.addAttribute("dto", dto);
				
		return "diary_delete"; //jsp file name
	}
	
	@RequestMapping(value = "/delete_page") //diary_delete.jsp ������ ������ ��
	public String diary7(HttpServletRequest request,Model mo) {
		
		String path = request.getSession().getServletContext().getRealPath("/image");
		
		int delete = Integer.parseInt(request.getParameter("diary_id"));
		String dfname = request.getParameter("himage");
		
		DiaryService ds = sqlSession.getMapper(DiaryService.class);
		ds.delete_page(delete);
				
		File ff = new File(path+"\\"+dfname);
		ff.delete();
		
		return "redirect:/diary_out"; //jsp file name
	}
	
	
	
	
	
}
