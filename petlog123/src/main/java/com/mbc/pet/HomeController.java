package com.mbc.pet;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.apache.tomcat.jdbc.pool.interceptor.SlowQueryReport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.mbc.pet.calendar.CalDTO;
import com.mbc.pet.calendar.CalService;
import com.mbc.pet.calendar.CalendarDayDTO;
import com.mbc.pet.community.CommunityDTO;
import com.mbc.pet.community.CommunityService;
import com.mbc.pet.diary.DiaryDTO;
import com.mbc.pet.diary.DiaryService;
import com.mbc.pet.pet.PetDTO;
import com.mbc.pet.pet.PetService;
import com.mbc.pet.quiz.QuizDTO;
import com.mbc.pet.quiz.QuizService;
import com.mbc.pet.snack.SnackDTO;
import com.mbc.pet.snack.SnackService;

@Controller
public class HomeController {

    @Autowired
    SqlSession sqlSession;

    // 첫 페이지 접근 시 메인으로 리디렉트
    @RequestMapping(value = "/")
    public String home1(HttpServletRequest request) {
        HttpSession hs = request.getSession();
        hs.setAttribute("loginstate", false);
        return "redirect:/main";
    }

    // 메인 페이지 진입 시
    @RequestMapping(value = "/main")
    public String home(HttpSession session, Model model) {
        Integer user_id = (Integer) session.getAttribute("user_id");
        if (user_id != null) {
            CalService cals = sqlSession.getMapper(CalService.class);

            // 오늘 일정 불러오기
            String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
            ArrayList<CalDTO> todaySchedule = cals.today_sche(user_id, today);
            model.addAttribute("todaySchedule", todaySchedule);

            // 월간 캘린더 데이터 준비
            Calendar now = Calendar.getInstance();
            int year = now.get(Calendar.YEAR);
            int month = now.get(Calendar.MONTH) + 1;
            LocalDate start = LocalDate.of(year, month, 1);
            LocalDate end = start.withDayOfMonth(start.lengthOfMonth());
            String startDate = start.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            String endDate = end.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

            ArrayList<CalendarDayDTO> monthData = cals.getMonthScheduleDates(user_id, startDate, endDate);
            model.addAttribute("calendar", groupByWeek(monthData, year, month));
            model.addAttribute("year", year);
            model.addAttribute("month", month);

            // 다가올 일정 (오늘부터 7일 후)
            LocalDate todayDate = LocalDate.now();
            LocalDate nextWeek = todayDate.plusDays(7);
            String nextWeekStart = todayDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            String nextWeekEnd = nextWeek.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            
            //다가올 일정 가져오기
            List<CalDTO> upcomingSchedules = cals.getUpcomingSchedules(user_id, nextWeekStart, nextWeekEnd);
            model.addAttribute("upcomingSchedules", upcomingSchedules);
            
            // 날짜 포맷 처리
            SimpleDateFormat sdf = new SimpleDateFormat("M/d");
            for (CalDTO schedule : upcomingSchedules) {
                try {
                    Date date = new SimpleDateFormat("yyyy-MM-dd").parse(schedule.getCal_date()); // 기존 날짜 포맷을 Date로 변환
                    String formattedDate = sdf.format(date); // 날짜를 원하는 형식으로 변환
                    schedule.setCal_date(formattedDate); // 변환된 날짜를 설정
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
            
            // 펫 프로필 정보
            PetService ps = sqlSession.getMapper(PetService.class);
            ArrayList<PetDTO> petdto = ps.getpetbyuserid(user_id);
            
            // 펫 정보 추가
            for (CalDTO cal : todaySchedule) {
                PetDTO pet = ps.getPetById(cal.getPet_id());  // 펫 정보 가져오기
                cal.setPet_name(pet.getPet_name());  // 펫 이름 추가
            }
            model.addAttribute("petdto", petdto);
            
            CommunityService communityService = sqlSession.getMapper(CommunityService.class);
            // 공지사항 목록 가져오기
            List<CommunityDTO> noticeList = communityService.getRecentNotices(); // 공지사항 목록 가져오기
            model.addAttribute("bodto", noticeList); // 공지사항을 모델에 추가
            
            // 커뮤니티 게시글 목록 가져오기
            List<CommunityDTO> communityList = communityService.getPopularPosts(); // 커뮤니티 게시글 목록 가져오기
            model.addAttribute("csdto", communityList); // 커뮤니티 게시글을 모델에 추가
            
            //퀴즈 불러오기
            QuizService qs = sqlSession.getMapper(QuizService.class);
            QuizDTO quiz = qs.getLatestUnsolvedQuiz(user_id);
            
            if(quiz != null) {
            	model.addAttribute("quiz", quiz);
            } else model.addAttribute("noQuiz",true); //퀴즈 없으면 멘트 출력


            SnackService ss = sqlSession.getMapper(SnackService.class);
            
            List<SnackDTO> snackList = ss.getsnackList();
            model.addAttribute("snackList", snackList);
            
	         // 좋아요 순
	         List<SnackDTO> topLikeSnacks = ss.getTopSnackByLikes();
	         model.addAttribute("topLikeSnacks", topLikeSnacks);
	         // 댓글 순
	         List<SnackDTO> topCommentSnacks = ss.getTopSnackByComments();
	         model.addAttribute("topCommentSnacks", topCommentSnacks);
            
            //최근 일기 보여주기
            DiaryService diaryService = sqlSession.getMapper(DiaryService.class);
            DiaryDTO recentDiary = diaryService.getLatestDiary(user_id);
            model.addAttribute("recentDiary", recentDiary);
        }
        return "main";
    }


    // 특정 날짜 클릭 시 일정 AJAX로 불러오기
    @ResponseBody
    @RequestMapping(value = "/getScheduleForDate", produces = "text/html; charset=UTF-8")
    public String getScheduleForDate(@RequestParam("date") String date, HttpSession session) {
        Integer user_id = (Integer) session.getAttribute("user_id");
        if (user_id == null) return "<p>로그인이 필요합니다.</p>";

        CalService calService = sqlSession.getMapper(CalService.class);
        List<CalDTO> list = calService.getScheduleByDate(user_id, date);

        if (list == null || list.isEmpty()) {
            return "<p>등록 된 일정이 없습니다.</p>";
        }

        StringBuilder html = new StringBuilder();
        html.append("<ul>");
        for (CalDTO dto : list) {
            html.append("<li><strong>").append(dto.getCal_title())
                .append("</strong>: ").append(dto.getCal_content()).append("</li>");
        }
        html.append("</ul>");
        return html.toString();
    }
    

    // 월간 달력 데이터를 주차별로 묶는 메서드
    private List<List<CalendarDayDTO>> groupByWeek(ArrayList<CalendarDayDTO> monthData, int year, int month) {
        List<List<CalendarDayDTO>> calendar = new ArrayList<>();

        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.YEAR, year);
        cal.set(Calendar.MONTH, month - 1);
        cal.set(Calendar.DAY_OF_MONTH, 1);
        int firstDayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
        int lastDate = cal.getActualMaximum(Calendar.DAY_OF_MONTH);

        // 일정 존재 여부 map
        Map<String, Boolean> scheduleMap = new HashMap<>();
        for (CalendarDayDTO day : monthData) {
            if (day != null && day.getDate() != null) {
                scheduleMap.put(day.getDate(), true);
            }
        }

        List<CalendarDayDTO> week = new ArrayList<>();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Calendar dayCal = Calendar.getInstance();
        dayCal.set(Calendar.YEAR, year);
        dayCal.set(Calendar.MONTH, month - 1);

        for (int i = 1; i < firstDayOfWeek; i++) {
            week.add(new CalendarDayDTO()); // 빈 칸
        }

        for (int i = 1; i <= lastDate; i++) {
            dayCal.set(Calendar.DAY_OF_MONTH, i);
            String dateStr = sdf.format(dayCal.getTime());
            CalendarDayDTO day = new CalendarDayDTO();
            day.setDay(String.valueOf(i));
            day.setDate(dateStr);
            day.setHasSchedule(scheduleMap.getOrDefault(dateStr, false));
            week.add(day);
            
            if (week.size() == 7) {
                calendar.add(week);
                week = new ArrayList<>();
            }
        }
        if (!week.isEmpty()) {
            while (week.size() < 7) {
                week.add(new CalendarDayDTO());
            }
            calendar.add(week);
        }
        return calendar;
    }
    
    //인기 레시피 출력.. ajax 요청
    @ResponseBody
    @RequestMapping(value = "/popular" , produces = "text/html; charset=UTF-8")
    public void getPopularSnacks(@RequestParam("sort") String sortType) {
    	SnackService ss = sqlSession.getMapper(SnackService.class);
    	List<SnackDTO> list;
    	
    	if("like".equals(sortType)) {
    		list = ss.getTopSnackByLikes();  //좋아요순
    	} else if("comment".equals(sortType)) {
    		list = ss.getTopSnackByComments(); //댓글순
    	} else {
    		list = ss.getSnackPreview();  //기본값(최신 or 무작위)
    		Collections.shuffle(list);
    	}
    }
}
