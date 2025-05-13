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
            margin: 0;
            padding: 0;
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
		  display: inline-block;
		  background-color: #fff3c4;  /* 연노랑 */
		  border: 1px solid #ffcc80;
		  border-radius: 8px;
		  padding: 2px 6px;
		  font-weight: bold;
		  color: #444;
		}
		
		.today-label {
		  font-size: 12px;
		  color: #f6b9b9;
		  font-weight: bold;
		  margin-left: 6px;
		  vertical-align: middle;
		}
		
		th.sun {
		  color: #f48b94; /* 연한 빨강 */
		}
		
		th.sat {
		  color: #8bb3f4; /* 연한 파랑 */
		}
		
.modal {
  position: fixed;
  top: 0; left: 0;
  width: 100vw; height: 100vh;
  background: rgba(0, 0, 0, 0.3);
  display: none;
  justify-content: center;
  align-items: center;
  z-index: 9999;
}

.modal-box-summary {
  background-color: #e6fbf6; /*민트*/
  padding: 36px 28px; /*간격*/
  border-radius: 20px; 
  width: 420px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
  position: relative;
  animation: fadeIn 0.3s ease;
}

.modal-box-summary h3 {
  font-size: 22px;
  color: #6ac9bb; /* 민트 계열 제목 */
  margin-bottom: 18px; /*간격*/
  text-align: center;
}

.modal-box-summary label {
  display: block;
  font-weight: bold;
  margin-top: 4px;
  margin-bottom: 1px;
  color: #444;
  font-size: 14px;
}

.modal-box-summary input[type="text"],
.modal-box-summary input[type="date"],
.modal-box-summary select,
.modal-box-summary textarea {
  width: 100%;
  margin-top: 6px;
  padding: 8px 12px;
  margin-bottom: 4px;
  font-size: 15px;
  border: 1px solid #ddd;
  border-radius: 10px;
  background: #fffefe;
  font-family: 'Pretendard', sans-serif;
  box-sizing: border-box;
}

.modal-box-summary textarea {
  resize: vertical;
  height: 70px;
}

.modal-box-summary .submit-btn {
  background-color: #88ddd0; /*mint button*/
  color: white;
  border: none;
  padding: 12px 24px;
  border-radius: 10px;
  font-size: 15px;
  font-weight: bold;
  margin-top: 6px;
  margin-bottom: 2px;
  cursor: pointer;
  width: 100%;
  transition: background-color 0.3s ease;
}

.modal-box-summary .submit-btn:hover {
  background-color: #5ec2b1;
}

.close-btn {
  position: absolute;
  top: 14px;
  right: 18px;
  font-size: 20px;
  background: none;
  border: none;
  cursor: pointer;
  color: #aaa;
  transition: 0.2s;
}

.close-btn:hover {
  color: #6ac9bb;
}

@keyframes fadeIn {
  from {
    opacity: 0;
    transform: scale(0.95);
  }
  to {
    opacity: 1;
    transform: scale(1);
  }
}
		
  to {
    transform: scale(1);
    opacity: 1;
  }
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
    <button type="button" class="schedule-add-btn" onclick="openAddScheduleModal()">➕ 일정 추가</button>
  </div>
</div>
<br>

<div style="display: flex; justify-content: space-between; align-items: center; margin-top: 10px;">
  <a href="calendar_view?year=<%=prevYear%>&month=<%=prevMonth%>&pet_id=${param.pet_id}">◀ 이전 달</a>
  <a href="calendar_view?year=<%=nextYear%>&month=<%=nextMonth%>&pet_id=${param.pet_id}">다음 달 ▶</a>
</div>

<table>
    <tr><th class="sun">일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th class="sat">토</th></tr>
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

            out.print("<td class='calendar-cell'><div class='cell-content'>"
            		+ "<span class='date-number " + dayClass + todayClass + "'>" + count + (isToday ? "<span class='today-label'> today</span>" : "") + "</span>"
            	);

            // ✅ 일정 출력
            if (calList != null) {
                for (com.mbc.pet.calendar.CalDTO e : calList) {
                    if (e.getCal_date().substring(8, 10).equals(dayStr)) {
                    	out.print("<div class='schedule-item'>📌 <a href='calendar_detail?cal_id=" + e.getCal_id() + "'>" + e.getCal_title() + "</a></div>");
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

<!-- 일정 추가 모달 -->
<div id="addScheduleModal" class="modal" style="display:none;">
  <div class="modal-box-summary">
    <button class="close-btn" onclick="closeAddScheduleModal()">×</button>
    <h3>일정 추가</h3>
    <form action="calendar_input" method="post">
       <label>반려동물
        <select name="pet_id" required>
          <option value="">선택하세요</option>
          <c:forEach var="pet" items="${petlist}">
            <option value="${pet.pet_id}">${pet.pet_name}</option>
          </c:forEach>
        </select>
      </label><br>
      
      <label>제목 
        <input type="text" name="cal_title" placeholder="제목 입력" required />
      </label><br>
      
      <label>내용 
        <textarea name="cal_content" rows="3" placeholder="내용 입력" required></textarea>
      </label><br>
      
      <label>날짜 
        <input type="date" name="cal_date" required />
      </label><br>
      
      <button type="submit" class="submit-btn">저장</button>
    </form>
  </div>
</div>

<script>
  function openAddScheduleModal() {
    document.getElementById("addScheduleModal").style.display = "flex";
  }

  function closeAddScheduleModal() {
    document.getElementById("addScheduleModal").style.display = "none";
  }

  window.onclick = function(event) {
    const modal = document.getElementById("addScheduleModal");
    if (event.target === modal) {
      modal.style.display = "none";
    }
  }
</script>

</body>
</html>