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
      <div class="sidebar-label">펫 페이지</div>
    </div>
    <div class="sidebar-box" onclick="location.href='${pageContext.request.contextPath}/stamp_grapes'">
      <div class="sidebar-icon">🍇</div>
      <div class="sidebar-label">포도알 ${sessionScope.loginUser.grape_count}개</div>
    </div>
    <div class="sidebar-box" onclick="location.href='${pageContext.request.contextPath}/items/buy_items'">
      <div class="sidebar-icon">🛍️</div>
      <div class="sidebar-label">내 아이템</div>
    </div>
    <div class="sidebar-box" onclick="location.href='${pageContext.request.contextPath}/calendar_view'">
      <div class="sidebar-icon">📆</div>
      <div class="sidebar-label">캘린더</div>
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
                <div style="font-size: 16px; font-weight: bold;">${dto.pet_name}</div>
                <div style="font-size: 13px; color: #777;">🐻 성별: ${dto.pet_bog}</div>
                <div style="font-size: 13px; color: #777;">✨ 중성화: ${dto.pet_neuter}</div>
                <div style="font-size: 13px; color: #777;">🎂 생일: ${dto.pet_hbd}</div>
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

<!-- 중앙: 공지사항, 커뮤니티 출력 -->
<div class="tab-box">
  <div class="tab-header">
    <div class="tabs">
      <span id="notice-tab" class="tab active" onclick="switchTab('notice')">공지사항</span>
      <span id="community-tab" class="tab" onclick="switchTab('community')">커뮤니티</span>
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
            <div class="post-meta-right">
          	 ${notice.post_date} 
          </div>
        </li>
      </c:forEach>
    </ul>
  </div>

  <!-- 커뮤니티 콘텐츠 -->
<div id="community-content" class="tab-pane">
  <ul class="post-list">
    <c:forEach items="${csdto}" var="post">
      <li class="post-item">
        <a href="PostDetail?pnum=${post.post_id}" class="post-title">${post.post_title}</a>
          <span class="comment-count">(${post.comment_count})</span>
        </a>
      </li>
    </c:forEach>
  </ul>
</div>
</section>

  <!-- 우측: 통합 캘린더 + 일정 -->
    <aside class="right-info">
    <c:if test="${not empty sessionScope.user_id}">
      <div class="calendar-wrapper-box">
        <div class="calendar-box" onclick="location.href='${pageContext.request.contextPath}/calendar_view'">
          <h2 class="calendar-title">📅 ${year}년 ${month}월</h2>
          <table class="calendar">
            <thead>
              <tr>
                <th>일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="week" items="${calendar}">
                <tr>
                  <c:forEach var="day" items="${week}">
                    <td class="day-cell" onclick="showSchedule('${day.date}')">
                      <span>${day.day}</span>
                      <c:if test="${day.hasSchedule}">
                        <div class="dot">•</div>
                      </c:if>
                    </td>
                  </c:forEach>
                </tr>
              </c:forEach>
            </tbody>
          </table>
          <h3>다가올 일정</h3>
          <c:if test="${not empty upcomingSchedules}">
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
          </c:if>
          <c:if test="${empty upcomingSchedules}">
            <p>다음 일정이 없습니다.</p>
          </c:if>
        </div>
      </div>
   </c:if>
      
  <!-- 로그아웃 상태일 경우 출력 -->
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
        
	<!-- Q&A 출력 부분 -->
    <div class="qna-box">
      <h3>💬 고객 Q&A</h3>
      <p>2건 있어요!</p>
    </div>
    </aside>
</div>
<!-- 커뮤니티, 공지사항 구분 및 바로가기  -->
<script>
  function switchTab(type) {
    const noticeTab = document.getElementById('notice-tab');
    const communityTab = document.getElementById('community-tab');
    const noticeContent = document.getElementById('notice-content');
    const communityContent = document.getElementById('community-content');
    const moreLink = document.getElementById('more-link');

    if (type === 'notice') {
      noticeTab.classList.add('active');
      communityTab.classList.remove('active');
      noticeContent.classList.add('active');
      communityContent.classList.remove('active');
      moreLink.href = '${pageContext.request.contextPath}/NoticeBoard';
    } else {
      communityTab.classList.add('active');
      noticeTab.classList.remove('active');
      communityContent.classList.add('active');
      noticeContent.classList.remove('active');
      moreLink.href = '${pageContext.request.contextPath}/CommunityView';
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
