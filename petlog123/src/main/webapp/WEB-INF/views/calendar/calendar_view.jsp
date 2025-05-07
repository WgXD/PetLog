<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
    Integer yearAttr = (Integer) request.getAttribute("currentYear");
    Integer monthAttr = (Integer) request.getAttribute("currentMonth");

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
  .event-title { font-size: 12px; color: #007bff; }
</style>
</head>
<body>

<h2><%= year %>년 <%= month %>월 달력</h2>

<a href="calendar?year=<%=prevYear%>&month=<%=prevMonth%>" style="margin-right: 20px;">◀ 이전 달</a>
<a href="calendar?year=<%=nextYear%>&month=<%=nextMonth%>">다음 달 ▶</a>

<table>
  <tr><th>일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th></tr>
  <tr>
<%
    int count = 1;
    for (int i = 1; i <= 42; i++) {
        if (i < startDay || count > lastDay) {
            out.print("<td></td>");
        } else {
            out.print("<td><b>" + count + "</b><br/>");
%>
            <c:if test="${not empty calendarList}">
              <c:forEach var="event" items="${calendarList}">
                <c:if test="${fn:substring(event.cal_date, 8, 10) == (count lt 10 ? '0' + count : count)}">
                    <div class="event-title">${event.cal_title}</div>
                </c:if>
              </c:forEach>
            </c:if>
<%
            out.print("</td>");
            count++;
        }

        if (i % 7 == 0) out.print("</tr><tr>");
    }
%>
  </tr>
</table>
<br> <br> <br> <br> <br>
</body>
</html>
