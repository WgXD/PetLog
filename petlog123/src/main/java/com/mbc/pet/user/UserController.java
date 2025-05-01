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

//회원가입-------------------------------------------------------------	
	//아이디 중복 검사
	@ResponseBody
	@RequestMapping(value = "/idcheck")
	public String signup2(String user_login_id) {
		System.out.println("넘겨받은 아이디: "+user_login_id);
		//넘겨받은 아이디로 디비에서 동일한 아이디가 존재하는지 체크
		UserService us=sqlSession.getMapper(UserService.class);
		int count = us.idcheck(user_login_id);  // 1이면 존재, 0이면 사용 가능
	      return count == 0 ? "ok" : "no";	
	}
	
	@RequestMapping("/SignupSave")
	public String signup3(UserDTO dto) {
		// null 체크 및 기본값 설정
	    if (dto.getProfileimg() == null || dto.getProfileimg().trim().isEmpty()) {
	        dto.setProfileimg("default.png");
	    }
	    if (dto.getRank() == null || dto.getRank().trim().isEmpty()) {
	        dto.setRank("브론즈");
	    }
		String user_login_id=dto.getUser_login_id();
		String password=dto.getPassword();
		String name=dto.getName();
		String phone=dto.getPhone();
		String address=dto.getAddress();
		//String user_role = "user";  //회원가입 -> '일반유저' 자동 등록
		String profilimg = dto.getProfileimg();
		String rank = dto.getRank();
		int grape_count = dto.getGrape_count();
		
		//패스워드 암호화 설정
		PasswordEncoder pe=new BCryptPasswordEncoder();
		password=pe.encode(password);
		dto.setPassword(password); //insert를 dto로 넘기기 때문에 암호화 된 비밀번호를 dto로 넣어줌
		
		//저장
		UserService us=sqlSession.getMapper(UserService.class);
		us.insertsignup(dto);
		return "redirect:/main";
	}
	
// 로그인-------------------------------------------------------------
	@RequestMapping(value = "/LoginSave", method = RequestMethod.POST)
	public String login(HttpServletRequest request, HttpServletResponse response) throws IOException {
	    String user_login_id = request.getParameter("user_login_id").trim();
	    String pw = request.getParameter("password").trim();
	    
	    // DB에서 암호화된 비밀번호 가져오기
	    UserService us = sqlSession.getMapper(UserService.class);
	    String cpw = us.pwsave(user_login_id);

	    System.out.println("폼에서 넘어온 id값: [" + user_login_id + "], 길이: " + user_login_id.length());
	    System.out.println("폼에서 넘어온 id값: " + user_login_id);
	    System.out.println("DB에서 가져온 암호화된 비밀번호: " + cpw);
	    System.out.println("입력한 비밀번호: " + pw);

	    // 암호화된 비밀번호 비교
	    PasswordEncoder pe = new BCryptPasswordEncoder();
	    boolean flag = pe.matches(pw, cpw);

	    if (flag) {
	        // 로그인 성공
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
	        // 로그인 실패
	        response.setContentType("text/html;charset=utf-8");
	        PrintWriter pww = response.getWriter();
	        pww.print("<script>alert('로그인 정보가 맞지 않습니다.')</script>");
	        pww.print("<script>location.href='login'</script>");
	        pww.close();
	        return null;
	    }
	}
	//로그아웃
		@RequestMapping(value = "/logout")
		public String logout(HttpServletRequest request)
		{
			HttpSession hs=request.getSession();
			hs.removeAttribute("loginstate");
			hs.removeAttribute("user_login_id"); //로그아웃 시 세션에 저장된 유저 정보 제거
			return "redirect:/";
		}
	
//마이페이지-------------------------------------------------------------
	@RequestMapping("/mypage")
	public String mypage(HttpServletRequest request, Model mo) {
		 // 로그인 된 사용자 아이디 가져오기
		 String user_login_id = (String) request.getSession().getAttribute("user_login_id");

		 if (user_login_id == null) { 
		 return "redirect:/login";
		 }

		 // Mapper에서 로그인 정보 호출
		 UserService us = sqlSession.getMapper(UserService.class);
		 UserDTO dto = us.editid(user_login_id);

		 // 모델에 정보 전달
		 mo.addAttribute("dto", dto);
		 return "UserMypage";
		}
	//수정 폼
	@RequestMapping("/UserEditProfile")
	public String showEditProfileForm(HttpServletRequest request, Model mo) {
	    String user_login_id = (String) request.getSession().getAttribute("user_login_id");
	    if (user_login_id == null) {
	        return "redirect:/login";
	    }

	    UserService us = sqlSession.getMapper(UserService.class);
	    UserDTO dto = us.editid(user_login_id);
	    mo.addAttribute("dto", dto);

	    return "UserEditProfile"; // 수정 폼 jsp로 보내기
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

	    // 파일 저장할 경로 설정
	    String uploadPath = request.getSession().getServletContext().getRealPath("/image/");

	    if (profileimgfile != null && !profileimgfile.isEmpty()) {
	        String fileName = profileimgfile.getOriginalFilename();
	        dto.setProfileimg(fileName); // DTO에 파일 이름 저장

	        // 서버에 실제로 파일 저장
	        File saveFile = new File(uploadPath, fileName);
	        profileimgfile.transferTo(saveFile);
	    } else {
	        dto.setProfileimg(originalUser.getProfileimg()); // 파일 없으면 기존거 유지
	    }

	    us.updateProfile(dto);

	    return "redirect:/mypage";
	}
}