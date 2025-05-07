<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    Integer yearAttr = (Integer) request.getAttribute("current_year");
    Integer monthAttr = (Integer) request.getAttribute("current_month");

    int year = (yearAttr != null) ? yearAttr : java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
    int month = (monthAttr != null) ? monthAttr : java.util.Calendar.getInstance().get(java.util.Calendar.MONTH) + 1;

    java.util.Calendar cal = java.util.Calendar.getInstance();
    cal.set(java.util.Calendar.YEAR, year);
    cal.set(java.util.Calendar.MONTH, month - 1);
    cal.set(java.util.Calendar.DAY_OF_MONTH, 1);

    int startDay = cal.get(java.util.Calendar.DAY_OF_WEEK);
    int lastDay = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);

    int prevYear = (month == 1) ? year - 1 : year;
    int prevMonth = (month == 1) ? 12 : month - 1;
    int nextYear = (month == 12) ? year + 1 : year;
    int nextMonth = (month == 12) ? 1 : month + 1;
%>
<html>
<head>
    <title><%= year %>년 <%= month %>월 달력</title>
    <style>
        table { width: 100%; border-collapse: collapse; }
        td, th { border: 1px solid #ccc; height: 100px; vertical-align: top; padding: 5px; }
        .event-title { font-size: 12px; }
    </style>
</head>
<body>

<h2><%= year %>년 <%= month %>월 달력</h2>
<a href="calendar_view?year=<%=prevYear%>&month=<%=prevMonth%>" style="margin-right: 20px;">◀ 이전 달</a>
<a href="calendar_view?year=<%=nextYear%>&month=<%=nextMonth%>">다음 달 ▶</a>

<table>
    <tr><th>일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th></tr>
    <tr>
<%
    int count = 1;
    java.util.List<com.mbc.pet.calendar.CalDTO> calList =
        (java.util.List<com.mbc.pet.calendar.CalDTO>) request.getAttribute("calendarList");

    java.util.List<com.mbc.pet.diary.DiaryDTO> diaryList =
        (java.util.List<com.mbc.pet.diary.DiaryDTO>) request.getAttribute("dto");

    for (int i = 1; i <= 42; i++) {
        if (i < startDay || count > lastDay) {
            out.print("<td></td>");
        } else {
            String dayStr = (count < 10) ? "0" + count : String.valueOf(count);
            out.print("<td><b>" + count + "</b><br/>");

            // 일정 출력
            if (calList != null) {
                for (com.mbc.pet.calendar.CalDTO e : calList) {
                    if (e.getCal_date().substring(8, 10).equals(dayStr)) {
                        out.print("<div class='event-title' style='color:#007bff;'>📌 " + e.getCal_title() + "</div>");
                    }
                }
            }

            // 다이어리 출력
            if (diaryList != null) {
                for (com.mbc.pet.diary.DiaryDTO d : diaryList) {
                    if (d.getDiary_date().substring(8, 10).equals(dayStr)) {
                    	out.print("<div class='event-title' style='color:green;'>📓 <a href='diary_detail?diary_id=" + d.getDiary_id() + "'>" + d.getDiary_title() + "</a></div>");
                    }
                }
            }

            out.print("</td>");
            count++;
        }

        if (i % 7 == 0) out.print("</tr><tr>");
    }
%>
    </tr>
</table>

</body>
</html>
