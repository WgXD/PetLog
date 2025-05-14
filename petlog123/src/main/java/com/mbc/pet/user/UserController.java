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
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.mbc.pet.items.ItemsDTO;
import com.mbc.pet.usertems.UsertemsService;

@Controller
public class UserController {

    @Autowired
    SqlSession sqlSession;

    // 로그인 페이지 이동
    @RequestMapping("/login")
    public String loginPage() {
        return "UserLogin";
    }

    // 회원가입 페이지 이동
    @RequestMapping("/userlogin")
    public String signupPage() {
        return "UserSignup";
    }

    // 아이디 중복 검사
    @ResponseBody
    @RequestMapping("/idcheck")
    public String idcheck(String user_login_id) {
        UserService us = sqlSession.getMapper(UserService.class);
        int count = us.idcheck(user_login_id);
        return count == 0 ? "ok" : "no";
    }

    // 회원가입 처리
    @RequestMapping("/SignupSave")
    public String signup(UserDTO dto, Model mo) {
        if (!PasswordValidator.isValid(dto.getPassword())) {
            mo.addAttribute("error", "비밀번호는 영문 + 숫자 조합으로 8자 이상이어야 합니다.");
            return "SignupSave";
        }

        if (dto.getProfileimg() == null || dto.getProfileimg().trim().isEmpty()) {
            dto.setProfileimg("default.png");
        }
        if (dto.getEmail() == null || dto.getEmail().trim().isEmpty()) {
            dto.setEmail("noemail@none.com"); // 비정상 접근 대비
        }

        if (dto.getUser_role() == null || dto.getUser_role().trim().isEmpty()) {
            dto.setUser_role("user");
        }
        if (dto.getRank() == null || dto.getRank().trim().isEmpty()) {
            dto.setRank("일반회원");
        }
        PasswordEncoder pe = new BCryptPasswordEncoder();
        dto.setPassword(pe.encode(dto.getPassword()));

        UserService us = sqlSession.getMapper(UserService.class);
        us.insertsignup(dto);

        return "redirect:/main";
    }

    // 로그인 처리
    @RequestMapping(value = "/LoginSave", method = RequestMethod.POST)
    public String login(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String user_login_id = request.getParameter("user_login_id").trim();
        String pw = request.getParameter("password").trim();

        UserService us = sqlSession.getMapper(UserService.class);
        String cpw = us.pwsave(user_login_id);

        PasswordEncoder pe = new BCryptPasswordEncoder();
        boolean flag = pe.matches(pw, cpw);

        if (flag) {
            HttpSession hs = request.getSession();
            UserDTO user = us.selectUserByLoginId(user_login_id);
            hs.setAttribute("loginstate", true);
            hs.setAttribute("name", user.getName());
            hs.setAttribute("user_role", user.getUser_role());
            hs.setAttribute("user_login_id", user_login_id);
            hs.setAttribute("user_id", user.getUser_id());
            hs.setAttribute("loginUser", user);
            return "redirect:/main";
        } else {
            response.setContentType("text/html;charset=utf-8");
            PrintWriter pww = response.getWriter();
            pww.print("<script>alert('로그인 정보가 맞지 않습니다.')</script>");
            pww.print("<script>location.href='login'</script>");
            pww.close();
            return null;
        }
    }

    // 로그아웃
    @RequestMapping("/logout")
    public String logout(HttpServletRequest request) {
        request.getSession().invalidate();
        return "redirect:/";
    }

    // 마이페이지
    @RequestMapping("/mypage")
    public String mypage(HttpServletRequest request, Model mo, HttpSession session) {
        Integer user_id = (Integer) session.getAttribute("user_id");
        String user_login_id = (String) session.getAttribute("user_login_id");
        if (user_login_id == null) return "redirect:/login?error=login_required";

        UserService us = sqlSession.getMapper(UserService.class);
        UserDTO dto = us.editid(user_login_id);
        mo.addAttribute("dto", dto);

        UsertemsService uts = sqlSession.getMapper(UsertemsService.class);
        ItemsDTO equippedFrame = uts.getEquippedFrame(user_id);
        mo.addAttribute("equippedFrame", equippedFrame);

        return "UserMypage";
    }

    // 프로필 수정 폼
    @RequestMapping("/UserEditProfile")
    public String showEditProfileForm(HttpServletRequest request, Model mo) {
        String user_login_id = (String) request.getSession().getAttribute("user_login_id");
        if (user_login_id == null) return "redirect:/login?error=login_required";

        UserService us = sqlSession.getMapper(UserService.class);
        UserDTO dto = us.editid(user_login_id);
        mo.addAttribute("dto", dto);
        return "UserEditProfile";
    }

    // 프로필 수정 처리
    @RequestMapping(value = "/updateProfile", method = RequestMethod.POST)
    public String updateProfile(@RequestParam("name") String name,
                                @RequestParam("phone") String phone,
                                @RequestParam("email") String email,
                                @RequestParam(value = "profileimg", required = false) MultipartFile profileimgfile,
                                HttpSession session, HttpServletRequest request) throws Exception {
        String user_login_id = (String) session.getAttribute("user_login_id");

        UserService us = sqlSession.getMapper(UserService.class);
        UserDTO originalUser = us.editid(user_login_id);

        UserDTO dto = new UserDTO();
        dto.setUser_login_id(user_login_id);
        dto.setName(name);
        dto.setPhone(phone);
        dto.setEmail(email);
        dto.setPassword(originalUser.getPassword());
        dto.setRank(originalUser.getRank());
        dto.setGrape_count(originalUser.getGrape_count());

        String uploadPath = request.getServletContext().getRealPath("/image/");
        if (profileimgfile != null && !profileimgfile.isEmpty()) {
            String originalFileName = profileimgfile.getOriginalFilename();
            String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
            String uuidFileName = java.util.UUID.randomUUID().toString() + extension;
            dto.setProfileimg(uuidFileName);
            File saveFile = new File(uploadPath, uuidFileName);
            profileimgfile.transferTo(saveFile);
        } else {
            dto.setProfileimg(originalUser.getProfileimg());
        }

        us.updateProfile(dto);
        return "redirect:/mypage";
    }

    // 아이디 찾기 페이지
    @RequestMapping("/findIdPage")
    public String showFindIdPage() {
        return "FindID";
    }

    // 아이디 찾기 처리
    @ResponseBody
    @RequestMapping(value = "findId", method = RequestMethod.POST, produces = "text/plain; charset=UTF-8")
    public String findId(HttpServletRequest request) {
        String email = request.getParameter("email");
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");

        UserService us = sqlSession.getMapper(UserService.class);
        String user_login_id = us.findIdByEmailName(email, name, phone);
        return user_login_id != null ? "회원님의 아이디는 [ " + user_login_id + " ] 입니다." : "일치하는 정보가 없습니다.";
    }

    // 비밀번호 찾기 페이지
    @RequestMapping("/findPwPage")
    public String showFindPwPage() {
        return "FindPW";
    }

    // 비밀번호 찾기 처리
    @ResponseBody
    @RequestMapping(value = "findPw", produces = "text/plain; charset=UTF-8")
    public String findPw(HttpServletRequest request) {
        String user_login_id = request.getParameter("user_login_id");
        String email = request.getParameter("email");

        UserService us = sqlSession.getMapper(UserService.class);
        UserDTO user = us.UserByLoginIdAndEmail(user_login_id, email);

        if (user != null && user.getEmail().equals(email)) {
            String tempPw = "petlog" + ((int)(Math.random() * 10000));
            PasswordEncoder pe = new BCryptPasswordEncoder();
            us.updatePassword(user_login_id, pe.encode(tempPw));
            return "임시 비밀번호는 [ " + tempPw + " ] 입니다. 로그인 후 반드시 변경해주세요.";
        } else {
            return "일치하는 정보가 없습니다.";
        }
    }

    // 현재 비밀번호 확인 페이지
    @RequestMapping("/pwcheckPage")
    public String pwcheckPage() {
        return "pwcheckPage";
    }

    // 새 비밀번호 입력 페이지
    @RequestMapping("/mypagePwChange")
    public String mypagePwChange(UserDTO dto, Model mo) {
        if (!PasswordValidator.isValid(dto.getPassword())) {
            mo.addAttribute("error", "비밀번호는 영문 + 숫자 조합으로 8자 이상이어야 합니다.");
            return "mypagePwChange";
        }
        return "mypagePwChange";
    }

    // 현재 비밀번호 확인 후 이동
    @RequestMapping(value = "/pwcheck")
    public String pwchangepage(HttpServletRequest request, @RequestParam("currentPw") String currentPw, Model mo) {
        String user_login_id = (String) request.getSession().getAttribute("user_login_id");
        UserService us = sqlSession.getMapper(UserService.class);
        UserDTO user = us.userPwChange(user_login_id);

        PasswordEncoder pe = new BCryptPasswordEncoder();
        if (user != null && pe.matches(currentPw, user.getPassword())) {
            return "mypagePwChange";
        } else {
            mo.addAttribute("errorMsg", "비밀번호가 일치하지 않습니다.");
            return "pwcheckPage";
        }
    }

    // 비밀번호 업데이트 처리
    @ResponseBody
    @RequestMapping(value = "/pwupdate", produces = "text/plain; charset=UTF-8")
    public String pwchange(HttpServletRequest request, @RequestParam("newPw") String newPw) {
    	String user_login_id = (String) request.getSession().getAttribute("user_login_id");

        // 비밀번호 유효성 검사
        if (!PasswordValidator.isValid(newPw)) {
            return "비밀번호는 영문 + 숫자 조합으로 8자 이상이어야 합니다.";
        }

        PasswordEncoder pe = new BCryptPasswordEncoder();
        UserService us = sqlSession.getMapper(UserService.class);
        try {
            us.updatePw(user_login_id, pe.encode(newPw));
            return "ok";
        } catch (Exception e) {
            return "비밀번호 변경 중 오류가 발생했습니다.";
        }
    }
    
    //이메일 중보복 체크용
    @ResponseBody
    @RequestMapping("/emailcheck")
    public String emailCheck(@RequestParam("email") String email) {
        UserService us = sqlSession.getMapper(UserService.class);
        int count = us.emailCheck(email); // count가 1이면 이미 존재
        return count == 0 ? "ok" : "no";
    }
    
    //회원정보 수정 시 이메일 중복검사
    @ResponseBody
    @RequestMapping("/emailCheckForUpdate")
    public String emailCheckForUpdate(@RequestParam String email,
                                       @RequestParam String user_login_id) {
        UserService us = sqlSession.getMapper(UserService.class);
        int count = us.emailCheckForUpdate(email, user_login_id);
        return count == 0 ? "ok" : "no";
    }
}
