package com.mbc.pet.calendar;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

public interface CalService {

	ArrayList<CalDTO> by_months(@Param("user_id") Integer user_id, @Param("current_year") int current_year, @Param("current_month") int current_month);
	 //로그인한 유저의 특정 년도와 월에 있는 일정 데이터 불러오기용
	
	

}
