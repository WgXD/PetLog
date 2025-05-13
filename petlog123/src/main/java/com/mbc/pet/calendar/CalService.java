package com.mbc.pet.calendar;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface CalService {

	// 로그인한 유저의 특정 년도와 월에 있는 일정 데이터 불러오기용
	ArrayList<CalDTO> by_months(@Param("user_id") Integer user_id,
								@Param("current_year") int current_year,
								@Param("current_month") int current_month,
								@Param("pet_id") int pet_id);

	// 달력에 직접 추가한 일정 저장용
	void cal_save(CalDTO cdto);

	// 메인 페이지에서 오늘 일정 미리보기
	ArrayList<CalDTO> today_sche(@Param("user_id") int user_id,
								 @Param("today") String today);

	// 기존 달력 그리기용 (요일 정렬 포함된 달력용)
	ArrayList<ArrayList<CalendarDayDTO>> getMonthCalendar(@Param("user_id") Integer user_id,
															 @Param("year") int year,
															 @Param("month") int month);

	// 월간 일정 날짜만 반환 (dot 표시용)
	ArrayList<CalendarDayDTO> getMonthScheduleDates(@Param("user_id") int user_id,
													 @Param("startDate") String startDate,
													 @Param("endDate") String endDate);

	// 특정 날짜 일정 목록 가져오기 (AJAX용)
	List<CalDTO> getScheduleByDate(@Param("user_id") Integer user_id,
								   @Param("date") String date);
	//일주일 달력만 가져오기
	List<CalendarDayDTO> getWeekSchedule(@Param("user_id") int user_id,
								         @Param("startDate") String startDate,
								         @Param("endDate") String endDate);

	List<CalDTO> getUpcomingSchedules(@Param("user_id") Integer user_id, 
							          @Param("startDate") String startDate, 
							          @Param("endDate") String endDate);

	CalDTO calendar_detail(int cal_id);

	void cal_delete(int delete);

	void update_save(int cal_id, String cal_title, String cal_date, String cal_content, Integer user_id, int pet_id);

	void insertSchedule(String cal_title, String cal_content, String cal_date, int pet_id, Integer user_id); //modal
}
