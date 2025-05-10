package com.mbc.pet.calendar;

public class CalendarDayDTO {
	
 String date;       // yyyy-MM-dd 형식
 String day;               // 1~31
 boolean hasSchedule;  // 일정 유무

 public CalendarDayDTO() {}


public String getDay() {
	return day;
}

public void setDay(String day) {
	this.day = day;
}

public String getDate() {
	return date;
}

public void setDate(String date) {
	this.date = date;
}

public boolean isHasSchedule() {
	return hasSchedule;
}

public void setHasSchedule(boolean hasSchedule) {
	this.hasSchedule = hasSchedule;
}
}