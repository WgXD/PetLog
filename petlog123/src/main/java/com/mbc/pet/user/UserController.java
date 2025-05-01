package com.mbc.pet.user;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class UserController {

	@Autowired
	SqlSession sqlSession;
	
	@RequestMapping("/login")
	public String signup() {
		return "UserLogin";
	}
	
	@RequestMapping("/userlogin")
	public String signup1() {
		return "UserSignup";
	}

//ȸ������-------------------------------------------------------------	
	//���̵� �ߺ� �˻�
	@ResponseBody
	@RequestMapping(value = "/idcheck")
	public String signup2(String user_login_id) {
		System.out.println("�Ѱܹ��� ���̵�: "+user_login_id);
		//�Ѱܹ��� ���̵�� ��񿡼� ������ ���̵� �����ϴ��� üũ
		UserService us=sqlSession.getMapper(UserService.class);
		int count = us.idcheck(user_login_id);  // 1�̸� ����, 0�̸� ��� ����
	      return count == 0 ? "ok" : "no";	
	}
	
	@RequestMapping("/SignupSave")
	public String signup3(UserDTO dto) {
		// null üũ �� �⺻�� ����
	    if (dto.getProfileimg() == null || dto.getProfileimg().trim().isEmpty()) {
	        dto.setProfileimg("default.png");
	    }
	    if (dto.getRank() == null || dto.getRank().trim().isEmpty()) {
	        dto.setRank("�����");
	    }
		String user_login_id=dto.getUser_login_id();
		String password=dto.getPassword();
		String name=dto.getName();
		String phone=dto.getPhone();
		String address=dto.getAddress();
		//String user_role = "user";  //ȸ������ -> '�Ϲ�����' �ڵ� ���
		String profilimg = dto.getProfileimg();
		String rank = dto.getRank();
		int grape_count = dto.getGrape_count();
		
		//�н����� ��ȣȭ ����
		PasswordEncoder pe=new BCryptPasswordEncoder();
		password=pe.encode(password);
		dto.setPassword(password); //insert�� dto�� �ѱ�� ������ ��ȣȭ �� ��й�ȣ�� dto�� �־���
		
		//����
		UserService us=sqlSession.getMapper(UserService.class);
		us.insertsignup(dto);
		return "redirect:/main";
	}
	
// �α���-------------------------------------------------------------
	@RequestMapping(value = "/LoginSave", method = RequestMethod.POST)
	public String login(HttpServletRequest request, HttpServletResponse response) throws IOException {
	    String user_login_id = request.getParameter("user_login_id").trim();
	    String pw = request.getParameter("password").trim();
	    
	    // DB���� ��ȣȭ�� ��й�ȣ ��������
	    UserService us = sqlSession.getMapper(UserService.class);
	    String cpw = us.pwsave(user_login_id);

	    System.out.println("������ �Ѿ�� id��: [" + user_login_id + "], ����: " + user_login_id.length());
	    System.out.println("������ �Ѿ�� id��: " + user_login_id);
	    System.out.println("DB���� ������ ��ȣȭ�� ��й�ȣ: " + cpw);
	    System.out.println("�Է��� ��й�ȣ: " + pw);

	    // ��ȣȭ�� ��й�ȣ ��
	    PasswordEncoder pe = new BCryptPasswordEncoder();
	    boolean flag = pe.matches(pw, cpw);

	    if (flag) {
	        // �α��� ����
	        HttpSession hs = request.getSession();
	        UserDTO user = us.selectUserByLoginId(user_login_id);

	        hs.setAttribute("loginstate", true);
	        
	        //
	        String name = user.getName();
	        hs.setAttribute("name", name);
	        //
	        
	        hs.setAttribute("user_login_id", user_login_id);
	        hs.setAttribute("user_id", user.getUser_id());

	        return "redirect:/main";
	    } else {
	        // �α��� ����
	        response.setContentType("text/html;charset=utf-8");
	        PrintWriter pww = response.getWriter();
	        pww.print("<script>alert('�α��� ������ ���� �ʽ��ϴ�.')</script>");
	        pww.print("<script>location.href='login'</script>");
	        pww.close();
	        return null;
	    }
	}
	//�α׾ƿ�
		@RequestMapping(value = "/logout")
		public String logout(HttpServletRequest request)
		{
			HttpSession hs=request.getSession();
			hs.removeAttribute("loginstate");
			hs.removeAttribute("user_login_id"); //�α׾ƿ� �� ���ǿ� ����� ���� ���� ����
			return "redirect:/";
		}
	
//����������-------------------------------------------------------------
	@RequestMapping("/mypage")
	public String mypage(HttpServletRequest request, Model mo) {
		 // �α��� �� ����� ���̵� ��������
		 String user_login_id = (String) request.getSession().getAttribute("user_login_id");

		 if (user_login_id == null) { 
		 return "redirect:/login";
		 }

		 // Mapper���� �α��� ���� ȣ��
		 UserService us = sqlSession.getMapper(UserService.class);
		 UserDTO dto = us.editid(user_login_id);

		 // �𵨿� ���� ����
		 mo.addAttribute("dto", dto);
		 return "UserMypage";
		}
	//���� ��
	@RequestMapping("/UserEditProfile")
	public String showEditProfileForm(HttpServletRequest request, Model mo) {
	    String user_login_id = (String) request.getSession().getAttribute("user_login_id");
	    if (user_login_id == null) {
	        return "redirect:/login";
	    }

	    UserService us = sqlSession.getMapper(UserService.class);
	    UserDTO dto = us.editid(user_login_id);
	    mo.addAttribute("dto", dto);

	    return "UserEditProfile"; // ���� �� jsp�� ������
	}

	@RequestMapping(value = "/updateProfile", method = RequestMethod.POST)
	public String updateProfile(
	    @RequestParam("name") String name,
	    @RequestParam("phone") String phone,
	    @RequestParam("address") String address,
	    @RequestParam(value = "profileimg", required = false) MultipartFile profileimgfile,
	    HttpSession session,
	    HttpServletRequest request
	) throws Exception {
	    String user_login_id = (String) session.getAttribute("user_login_id");

	    UserService us = sqlSession.getMapper(UserService.class);
	    UserDTO originalUser = us.editid(user_login_id);

	    UserDTO dto = new UserDTO();
	    dto.setUser_login_id(user_login_id);
	    dto.setName(name);
	    dto.setPhone(phone);
	    dto.setAddress(address);
	    dto.setPassword(originalUser.getPassword());
	    dto.setRank(originalUser.getRank());
	    dto.setGrape_count(originalUser.getGrape_count());

	    // ���� ������ ��� ����
	    String uploadPath = request.getSession().getServletContext().getRealPath("/image/");

	    if (profileimgfile != null && !profileimgfile.isEmpty()) {
	        String fileName = profileimgfile.getOriginalFilename();
	        dto.setProfileimg(fileName); // DTO�� ���� �̸� ����

	        // ������ ������ ���� ����
	        File saveFile = new File(uploadPath, fileName);
	        profileimgfile.transferTo(saveFile);
	    } else {
	        dto.setProfileimg(originalUser.getProfileimg()); // ���� ������ ������ ����
	    }

	    us.updateProfile(dto);

	    return "redirect:/mypage";
	}
}