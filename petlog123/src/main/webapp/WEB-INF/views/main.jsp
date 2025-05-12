<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
  <title>PetLog 메인</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css?v=2">
</head>
<body>

<!-- ===== 메인 대시보드 ===== -->
<div class="main-dashboard">
  <!-- 좌측: 회원 정보 메뉴 -->
  <aside class="left-sidebar">
    <div class="sidebar-box" onclick="location.href='${pageContext.request.contextPath}/mypage'">
      <div class="sidebar-icon">👤</div>
      <div class="sidebar-label">회원 정보</div>
    </div>
    <div class="sidebar-box" onclick="location.href='${pageContext.request.contextPath}/pet_out'">
      <div class="sidebar-icon">🐾</div>
      <div class="sidebar-label">펫 관리</div>
    </div>
    <div class="sidebar-box" onclick="location.href='${pageContext.request.contextPath}/stamp_grapes'">
      <div class="sidebar-icon">🍇</div>
      <div class="sidebar-label">포도알 ${sessionScope.loginUser.grape_count}개</div>
    </div>
    <div class="sidebar-box" onclick="location.href='${pageContext.request.contextPath}/diary_out'">
      <div class="sidebar-icon">✏️</div>
      <div class="sidebar-label">다이어리</div>
    </div>
    <div class="sidebar-box" onclick="location.href='${pageContext.request.contextPath}/calendar_view'">
      <div class="sidebar-icon">📆</div>
      <div class="sidebar-label">캘린더</div>
    </div>
    <div class="sidebar-box" onclick="location.href='${pageContext.request.contextPath}/items/buy_items'">
      <div class="sidebar-icon">🛍️</div>
      <div class="sidebar-label">내 아이템</div>
    </div>
    <div class="sidebar-box" onclick="location.href='${pageContext.request.contextPath}/qnalist'">
      <div class="sidebar-icon">❓</div>
      <div class="sidebar-label">Q&A</div>
    </div>
  </aside>

  <!-- 중앙: 펫 프로필 -->
  <section class="main-content">
    <c:if test="${not empty sessionScope.user_id}">
      <div class="content-box large">
        <h2>🐻 펫 프로필</h2>
        <div class="profile-cards">
          <c:forEach items="${petdto}" var="dto">
            <div class="card">
              <a href="pet_detail?update1=${dto.pet_id}">
                <img src="${pageContext.request.contextPath}/image/${dto.pet_img}" width="100px"
                     style="border-radius: 50%; margin-bottom: 10px;">
                <div style="font-size: px; font-weight: bold; text-align: center;">${dto.pet_name}</div>
                <div style="font-size: 15px; color: #777;">🐻 성별: ${dto.pet_bog}</div>
                <div style="font-size: 15px; color: #777;">✨ 중성화: ${dto.pet_neuter}</div>
                <div style="font-size: 15px; color: #777;">🎂 생일: ${dto.pet_hbd}</div>
              </a>
            </div>
          </c:forEach>
        </div>
      </div>
    </c:if>

    <c:if test="${empty sessionScope.user_id}">
      <div class="content-box large">
        <h2>🐾 펫 프로필</h2>
        <p>로그인 후 펫 프로필을 확인하고 관리할 수 있습니다</p>
      </div>
    </c:if>


<div class="bottom-section">
  <!-- 왼쪽: 공지사항 / 커뮤니티 -->
  <div class="tab-box">
    <div class="tab-header">
      <div class="tabs">
        <span id="notice-tab" class="tab active" onclick="switchTab('notice')">공지사항</span>
        <span id="community-tab" class="tab" onclick="switchTab('community')">커뮤니티</span>
        <span id="snack-tab" class="tab" onclick="switchTab('snack')">간식레시피</span>
      </div>
      <a id="more-link" class="more-link" href="/notice/list">더보기 &gt;</a>
    </div>

    <div class="tab-content">
      <!-- 공지사항 콘텐츠 -->
      <div id="notice-content" class="tab-pane active">
        <ul class="post-list">
          <c:forEach items="${bodto}" var="notice">
            <li class="post-item">
              <a href="PostDetail?pnum=${notice.post_id}" class="post-title">${notice.post_title}</a>
              <div class="post-meta-right">${notice.post_date}</div>
            </li>
          </c:forEach>
        </ul>
      </div>

      <!-- 커뮤니티 콘텐츠 -->
      <div id="community-content" class="tab-pane">
        <ul class="post-list">
          <c:forEach items="${csdto}" var="post">
            <li class="post-item">
              <a href="PostDetail?pnum=${post.post_id}" class="post-title">
                ${post.post_title} <span class="comment-count">(${post.comment_count})</span></a>
              <div class="post-meta-right">작성자[${post.user_login_id}] | 조회수[${post.post_readcnt}]</div>
            </li>
          </c:forEach>
        </ul>
      </div>

      <!-- 간식 레시피 콘텐츠 -->
      <div id="snack-content" class="snack-pane">
        <ul class="post-list">
          <c:forEach items="${snackList}" var="snack">
            <li class="snack-item">
              <a href="snack_detail?dnum=${snack.snack_id}">${snack.snack_title}</a>
              <div class="snack-meta-right">작성자[ ${snack.user_login_id} ]</div>
            </li>
          </c:forEach>
        </ul>
      </div>
    </div>
  </div>
 
 
 <!-- 오른쪽: 인기 간식 레시피 박스 -->
<div class="half-box snack-preview-box">
  <h3>🍪 인기 간식 레시피</h3>
  <c:forEach items="${popularSnacks}" var="snack" begin="0" end="0"> <!-- 하나만 출력 -->
    <div class="snack-card">
      <img class="snack-image" src="${pageContext.request.contextPath}/image/${snack.snack_image}" alt="snack" />
      <div class="snack-info">
        <div class="snack-meta">
          <span class="snack-title">${snack.snack_title}</span>
          <span>&nbsp;</span>
          <span class="snack-writer">by ${snack.user_login_id}</span>
        </div>
        <p class="snack-content">${fn:substring(snack.snack_recipe, 0, 30)}...</p>
      </div>
    </div><br><br>
  </c:forEach>
  <div class="snack-more"><a href="snack_detail?dnum=${rec.snack_id}">전체 보기 →</a></div>
</div>
</div>
</section>

  <!-- 우측: 통합 캘린더 + 일정 -->
  <!-- 캘린더 박스 (로그인 상태) -->
 <aside class="right-info">
<c:if test="${not empty sessionScope.user_id}">
  <div class="calendar-wrapper-box">
    <div class="calendar-box" onclick="location.href='${pageContext.request.contextPath}/calendar_view'">
      <h2 class="calendar-title">📅 ${year}년 ${month}월</h2>
      <table class="calendar">
        <thead>
          <tr>
            <th>S</th><th>M</th><th>T</th><th>W</th><th>T</th><th>F</th><th>S</th>
          </tr>
        </thead>
       <c:set var="todayStr" value="<%= java.time.LocalDate.now().toString() %>" />
	
	<tbody>
	  <c:forEach var="week" items="${calendar}">
	    <tr>
	      <c:forEach var="day" items="${week}">
	        <c:set var="className" value="day-cell" />
	
	        <!-- 오늘 날짜일 때 클래스 추가 -->
	        <c:set var="className" value="day-cell" />
			<c:if test="${day.date == todayStr}">
			  <c:set var="className" value="${className} today" />
			</c:if>
	
	        <!--  일정 있을 때 클래스 추가 -->
			<c:if test="${day.hasSchedule}">
			  <c:set var="className" value="${className} event" />
			</c:if>
	        <td class="${className}" onclick="showSchedule('${day.date}')">
	          <span>${day.day}</span>
	        </td>
	      </c:forEach>
	    </tr>
	  </c:forEach>
	</tbody>
	      </table>

      <h3>다가올 일정</h3>
      <c:choose>
        <c:when test="${not empty upcomingSchedules}">
          <c:forEach var="schedule" items="${upcomingSchedules}">
            <div class="schedule-item">
              <div class="schedule-header" style="display: flex; align-items: center; gap: 15px;">
                <span class="schedule-date">${schedule.cal_date}</span>
                <c:forEach var="pet" items="${petdto}">
                  <c:if test="${pet.pet_id == schedule.pet_id}">
                    <span class="schedule-pet-name">${pet.pet_name}</span>
                  </c:if>
                </c:forEach>
                <strong>${schedule.cal_title}</strong>
              </div>
            </div>
          </c:forEach>
        </c:when>
        <c:otherwise>
          <p>다음 일정이 없습니다.</p>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
  </
</c:if>

<!-- 비로그인 상태 -->
<c:if test="${empty sessionScope.user_id}">
  <aside class="right-info">
    <div class="calendar-wrapper-box">
      <div class="calendar-box">
        <h2>📆 로그인 후 캘린더를 확인하세요!</h2>
        <p>로그인 후 달력과 일정 기능을 사용할 수 있습니다.</p>
      </div>
    </div>
 </aside>
</c:if>

<!-- 오늘의 다이어리 -->
<div class="diary-wrapper-box">
  <h3>📓 오늘의 다이어리</h3>
  <c:if test="${not empty recentDiary}">
    <p class="diary-title">${recentDiary.diary_title}</p>
    <p class="diary-date">${fn:substringBefore(recentDiary.diary_date, ' ')}</p>
    <p class="diary-pet">${recentDiary.pet_name}의 일기</p>
    <p class="diary-preview">${fn:substring(recentDiary.diary_content, 0, 30)}...</p>
    <a href="diary_detail?diary_id=${recentDiary.diary_id}" class="diary-link">전체 보기 →</a>
  </c:if>
  <c:if test="${empty recentDiary}">
    <p>작성한 다이어리가 없습니다. 오늘 일기를 써보세요!</p>
  </c:if>
</div>
        
	<!-- 퀴즈 출력 부분 -->
    <div class="quiz-preview-box">
	  <h3>🧠 오늘의 퀴즈</h3>
	  <p class="quiz-question">${quiz.quiz_question}</p>
	  <p class="quiz-note">※ 전체 보기는 퀴즈에서 확인하세요!</p>
	  <a href="${pageContext.request.contextPath}/quiz" class="quiz-start-button">도전하러 가기 →</a>
	</div>
    </aside>
</div>


<!-- 커뮤니티, 공지사항 구분 및 바로가기  -->
<script>
  function switchTab(type) {
    const noticeTab = document.getElementById('notice-tab');
    const communityTab = document.getElementById('community-tab');
    const snackTab = document.getElementById('snack-tab');

    const noticeContent = document.getElementById('notice-content');
    const communityContent = document.getElementById('community-content');
    const snackContent = document.getElementById('snack-content');

    const moreLink = document.getElementById('more-link');

    // 모든 탭/내용 초기화
    noticeTab.classList.remove('active');
    communityTab.classList.remove('active');
    snackTab?.classList.remove('active'); // ?는 snackTab이 없을 경우 대비

    noticeContent.classList.remove('active');
    communityContent.classList.remove('active');
    snackContent.classList.remove('active');

    // 선택된 탭만 활성화
    if (type === 'notice') {
      noticeTab.classList.add('active');
      noticeContent.classList.add('active');
      moreLink.href = '${pageContext.request.contextPath}/NoticeBoard';
    } else if (type === 'community') {
      communityTab.classList.add('active');
      communityContent.classList.add('active');
      moreLink.href = '${pageContext.request.contextPath}/CommunityView';
    } else if (type === 'snack') {
      snackTab.classList.add('active');
      snackContent.classList.add('active');
      moreLink.href = '${pageContext.request.contextPath}/SnackList';
    }
  }
</script>
<!-- 캘린더 날짜 클릭 시 일정 표시 -->
<script>
function showSchedule(date) {
  fetch("getScheduleForDate?date=" + date)
    .then(res => res.text())
    .then(data => {
      document.getElementById("scheduleContent").innerHTML = data;
    });
}
</script>
</body>
</html>
