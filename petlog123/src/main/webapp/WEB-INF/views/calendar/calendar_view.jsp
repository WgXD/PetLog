<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    <title><%= year %>년 <%= month %>월</title>
    <style>

        body {
            background: linear-gradient(to bottom right, #e0f7f6, #ffe9ec);
            margin: 0;
            padding: 20px;
        }

		table {
		  width: 100%;
		  border-collapse: collapse;
		  table-layout: fixed; /* 칸 너비 균등 분배 */
		  border: 1px solid #d0d0d0; 
		}

        th {
            background-color: #fff8cc;
            color: #444;
            font-weight: bold;
            padding: 10px 0;
            text-align: center;
            border: 1px solid #d0d0d0;
             /* 둥근 모서리 */
			border: 1px solid #d0d0d0;
			border-radius: 12px;
        }

		td {
		  padding: 0;
		  height: 120px;  /* 셀 높이 고정 */
		  border: 1px solid #d0d0d0;
		}

		.calendar-cell {
		  background-color: white;
		  border-radius: 16px;
		  padding: 0;                   /* 패딩 제거 (내부에 줄 예정) */
		  margin: 4px;
		  height: 120px;
		  position: relative;
		  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
		  border: 1px solid #d0d0d0;
		  vertical-align: top;
		  overflow: hidden;            /* 셀 자체에서 넘치지 않게 */
		}
		
		.cell-content {
		  height: 100%;
		  overflow-y: auto;
		  padding: 6px;
		  box-sizing: border-box;
		  text-align: left;
		}
		
		/* 스크롤바 예쁘게 (크롬 기준) */
		.cell-content::-webkit-scrollbar {
		  width: 6px;
		}
		.cell-content::-webkit-scrollbar-thumb {
		  background-color: #ccc;
		  border-radius: 4px;
		}

        /* 날짜 숫자 */
        .date-number {
            font-weight: bold;
            color: #ff8a80;
            font-size: 1.2rem;
            margin-bottom: 6px;
            display: block;
        }

        /* 일정 항목 말풍선 */
        .schedule-item {
            background-color: #ffe0ec;
            color: #333;
            font-size: 0.9rem;
            border-radius: 12px;
            padding: 4px 8px;
            margin-top: 6px;
            display: block;
            max-width: 100%;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }

        .schedule-add-btn {
            font-size: 1rem;
            font-weight: bold;
            padding: 6px 12px;
            background-color: #ffd1dc;
            color: #333;
            border: none;
            border-radius: 16px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            cursor: pointer;
            transition: 0.2s ease;
        }

        .schedule-add-btn:hover {
            background-color: #ffc1d4;
            transform: scale(1.05);
        }
        
        .sun { color: #f48b94; }   /* 연한 빨강 */
		.sat { color: #8bb3f4; }   /* 연한 파랑 */
		.weekday { color: #555; }  /* 일반 평일 - 검정 */
		
		.today {
		  background-color: #fff3c4;
		  border: 1px solid #ffcc80;
		  border-radius: 8px;
		  padding: 2px 6px;
		  display: inline-block;
		  font-weight: bold;
		}
    </style>
</head>
<body>

<div style="text-align: center; margin-bottom: 20px;">
  <h2><%= year %>년 <%= month %>월</h2>

  <form method="get" action="calendar_view" style="display: inline-block;">
      <label for="petSelect">🐶 반려동물 선택: </label>
      <select name="pet_id" id="petSelect" onchange="this.form.submit()">
          <c:forEach var="pet" items="${petlist}">
              <option value="${pet.pet_id}" <c:if test="${param.pet_id == pet.pet_id}">selected</c:if>>
                  ${pet.pet_name}
              </option>
          </c:forEach>
      </select>
      <input type="hidden" name="year" value="<%= year %>"/>
      <input type="hidden" name="month" value="<%= month %>"/>
  </form>

  <div style="margin-top: 16px;">
    <a href="calendar_input" class="schedule-add-btn">➕ 일정 추가</a>
  </div>
</div>
<br>

<div style="display: flex; justify-content: space-between; align-items: center; margin-top: 10px;">
  <a href="calendar_view?year=<%=prevYear%>&month=<%=prevMonth%>&pet_id=${param.pet_id}">◀ 이전 달</a>
  <a href="calendar_view?year=<%=nextYear%>&month=<%=nextMonth%>&pet_id=${param.pet_id}">다음 달 ▶</a>
</div>

<table>
    <tr><th>일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th></tr>
    <tr>
<%
    int count = 1;
    java.util.List<com.mbc.pet.calendar.CalDTO> calList =
        (java.util.List<com.mbc.pet.calendar.CalDTO>) request.getAttribute("list");

    java.util.List<com.mbc.pet.diary.DiaryDTO> diaryList =
        (java.util.List<com.mbc.pet.diary.DiaryDTO>) request.getAttribute("dto");

    for (int i = 1; i <= 35; i++) {
        if (i < startDay || count > lastDay) {
        	out.print("<td class='calendar-cell'><div class='cell-content'></div></td>");
        } else {
            String dayStr = (count < 10) ? "0" + count : String.valueOf(count);

            // ✅ 날짜 셀 스타일 클래스 결정 (요일별 색상 + 오늘 강조)
            java.util.Calendar today = java.util.Calendar.getInstance();
            boolean isToday = (year == today.get(java.util.Calendar.YEAR)
                            && month == (today.get(java.util.Calendar.MONTH) + 1)
                            && count == today.get(java.util.Calendar.DAY_OF_MONTH));

            String dayClass = (i % 7 == 1) ? "sun" : (i % 7 == 0) ? "sat" : "weekday";
            String todayClass = isToday ? " today" : "";

            out.print("<td class='calendar-cell'><div class='cell-content'><span class='date-number " + dayClass + todayClass + "'>" + count + "</span>");

            // ✅ 일정 출력
            if (calList != null) {
                for (com.mbc.pet.calendar.CalDTO e : calList) {
                    if (e.getCal_date().substring(8, 10).equals(dayStr)) {
                        out.print("<div class='schedule-item'>📌 " + e.getCal_title() + "</div>");
                    }
                }
            }

            // ✅ 다이어리 출력
            if (diaryList != null) {
                for (com.mbc.pet.diary.DiaryDTO d : diaryList) {
                    if (d.getDiary_date().substring(8, 10).equals(dayStr)) {
                        out.print("<div class='schedule-item' style='background-color:#e0f7fa;'>📓 <a href='diary_detail?diary_id=" + d.getDiary_id() + "'>" + d.getDiary_title() + "</a></div>");
                    }
                }
            }

            out.print("</div></td>");
            count++;
        }

        if (i % 7 == 0) out.print("</tr><tr>");
    }
%>
    </tr>
</table>

</body>
</html>