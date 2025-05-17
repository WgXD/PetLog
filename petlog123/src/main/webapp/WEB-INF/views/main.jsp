<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
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
      <div class="sidebar-label">내 포도알</div>
    </div>
    <div class="sidebar-box" onclick="location.href='${pageContext.request.contextPath}/diary_out'">
      <div class="sidebar-icon">✏️</div>
      <div class="sidebar-label">다이어리</div>
    </div>
    <div class="sidebar-box" onclick="location.href='${pageContext.request.contextPath}/calendar_input'">
      <div class="sidebar-icon">📆</div>
      <div class="sidebar-label">일정</div>
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
        <c:choose>
        <c:when test="${empty petdto}">
          <p class="no-data-message">📭 등록된 펫 정보가 없습니다.</p>
        </c:when>
        <c:otherwise>
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
          </c:otherwise>
          </c:choose>
        </div>
      </div>
    </c:if>

    <c:if test="${empty sessionScope.user_id}">
      <div class="content-box large">
        <h2>🐾 펫 프로필</h2>
        <p class="no-data-message">🔒 로그인 후 펫 프로필을 확인하고 관리할 수 있습니다.</p>
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
        <c:choose>
		  <c:when test="${empty sessionScope.user_id}">
		    <p class="no-data-message">🔒 로그인 후 공지사항을 확인할 수 있습니다.</p>
		  </c:when>
		  <c:when test="${empty bodto}">
		    <p class="no-data-message">📭 등록된 공지사항이 없습니다.</p>
		  </c:when>
		</c:choose>
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
        <c:choose>
		  <c:when test="${empty sessionScope.user_id}">
		    <p class="no-data-message">🔒 로그인 후 인기 게시물을 확인할 수 있습니다.</p>
		  </c:when>
		  <c:when test="${empty csdto}">
		    <p class="no-data-message">📭 인기 게시물이 없습니다.</p>
		  </c:when>
		</c:choose>
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
        <c:choose>
		  <c:when test="${empty sessionScope.user_id}">
		    <p class="no-data-message">🔒 로그인 후 간식레시피를 확인할 수 있습니다.</p>
		  </c:when>
		  <c:when test="${empty snackList}">
		    <p class="no-data-message">📭 등록 된 게시물이 없습니다.</p>
		  </c:when>
		</c:choose>
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
      <div class="snack-preview-box">
        <h2> 🦴 인기 레시피</h2>
        <div class="snack-slider-wrapper">
    
       <c:forEach items="${topCommentSnacks}" var="snack" varStatus="status">
  <div class="snack-card ${status.index == 0 ? 'active' : ''}" id="comment-snack-${status.index}">		
		    <img class="snack-image" src="${pageContext.request.contextPath}/image/${snack.snack_image}" />
		    <div class="snack-info">
		      <div class="snack-title">${snack.snack_title}</div>
		      <div class="snack-writer">by ${snack.user_login_id}</div>
		      <p class="snack-content">${fn:substring(snack.snack_recipe, 0, 30)}...</p>
		      <br>
		      <a class="snack-more" href="snack_detail?dnum=${snack.snack_id}">전체 보기 →</a>
		    </div>
		  </div>
		</c:forEach>
		<c:choose>
		  <c:when test="${empty sessionScope.user_id}">
		    <p class="no-data-message">🔒 로그인 후 간식 레시피를 확인할 수 있습니다.</p>
		  </c:when>
		  <c:when test="${empty snackList}">
		    <p class="no-data-message">📭 등록 된 간식 레시피가 없습니다.</p>
		  </c:when>
		</c:choose>
		</div>
 		
 		<div class="snack-button-box">
		  <button class="slide-button" onclick="changeCommentSnack(-1)">←</button>
		  <button class="slide-button" onclick="changeCommentSnack(1)">→</button>
		</div>

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
            <th>Sun</th><th>Mon</th><th>Tue</th><th>Wed</th><th>Thu</th><th>Fri</th><th>Sat</th>
          </tr>
        </thead>
       <c:set var="todayStr" value="<%= java.time.LocalDate.now().toString() %>" />
	
	<tbody style="margin-bottom: 0 !important;">
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
  <h2>📓 오늘의 일기</h2>
    <c:choose>
    <c:when test="${empty sessionScope.user_id}">
      <p class="no-data-message">🔒 로그인 후 오늘의 일기를 확인할 수 있습니다.</p>
    </c:when>

    <c:when test="${empty recentDiary}">
      <p class="no-data-message">📭 작성한 일기가 없습니다. 오늘 일기를 써보세요!</p>
    </c:when>
    
    <c:otherwise>
    <p class="diary-title">${recentDiary.diary_title}</p>
    <p class="diary-date">${fn:substringBefore(recentDiary.diary_date, ' ')}</p>
    <p class="diary-pet">${recentDiary.pet_name}의 일기</p>
    <p class="diary-preview">${fn:substring(recentDiary.diary_content, 0, 30)}...</p>
    <a href="diary_detail?diary_id=${recentDiary.diary_id}" class="diary-link">전체 보기 →</a>
  </c:otherwise>
 </c:choose>
</div>
        
	<!-- 퀴즈 출력 부분 -->
    <div class="quiz-preview-box">
	  <h2>🧠 오늘의 멍냥 퀴즈 </h2>
	   <c:choose>
	    <c:when test="${empty sessionScope.user_id}">
	      <p class="no-data-message">🔒 로그인 후 오늘의 퀴즈를 확인할 수 있습니다.</p>
	    </c:when>
	
	    <c:when test="${empty quiz}">
	      <p class="no-data-message">📭 오늘의 퀴즈가 아직 등록되지 않았습니다.</p>
	    </c:when>
	  
	  <c:otherwise>
	  <p class="quiz-question">${quiz.quiz_question}</p>
	  <p class="quiz-note" style="margin-bottom: 10px;">※ 전체 보기는 퀴즈에서 확인하세요!</p>
	  <a href="${pageContext.request.contextPath}/QuizInput" class="quiz-start-button">도전하러 가기 →</a>
	  </c:otherwise>
	 </c:choose>
	</div>
    </aside>

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

<!-- 인기 간식 레시피 슬라이드용 스크립트 -->
<script>
let currentIndex = 0;
let snackCards;

function showSnack(index) {
  snackCards.forEach((card, i) => {
    if (i === index) {
      card.style.display = 'block';
      card.style.opacity = 1;
    } else {
      card.style.display = 'none';
      card.style.opacity = 0;
    }
  });
}

function changeCommentSnack(step = 1) {
  currentIndex = (currentIndex + step + snackCards.length) % snackCards.length;
  showSnack(currentIndex);
}

window.onload = function () {
  snackCards = document.querySelectorAll('.snack-card');
  if (snackCards.length > 0) {
    showSnack(currentIndex);
    setInterval(() => changeCommentSnack(1), 5000);
  }
};
</script>
</body>
</html>
