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

<!-- ===== 상단 탑바 ===== 
<div class="topbar">
  <div class="logo">🐶 PetLog <span class="slogan">함께하는 반려생활</span></div>
  <ul class="top-menu">
    <li><a href="#">오늘의 일기</a></li>
    <li><a href="#">내 포도</a></li>
    <li><a href="#">수제 간식</a></li>
    <li><a href="#">펫 관리</a></li>
    <li><a href="#">커뮤니티</a></li>
    <li><a href="#">멍냥 퀴즈방</a></li>
    <li><a href="#">Q&A</a></li>
  </ul>
  <div class="top-user">회원가입 | 로그인</div>
</div>-->

<!-- ===== 메인 대시보드 ===== -->
<div class="main-dashboard">
  <!-- 좌측: 회원 정보 메뉴 -->
  <aside class="left-sidebar">
   <div class="sidebar-box"  onclick="location.href='${pageContext.request.contextPath}/mypage'">
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
  <!-- 펫 프로필 전체 박스 -->
  <div class="content-box large">
    <h2>🐻 펫 프로필</h2>
    <div class="profile-cards">
      <c:forEach items="${petdto}" var="dto">
        <div class="card">
          <img src="${pageContext.request.contextPath}/image/${dto.pet_img}" width="100px"
               style="border-radius: 50%; margin-bottom: 10px;">
          <div style="font-size: 16px; font-weight: bold;">${dto.pet_name}</div>
          <div style="font-size: 13px; color: #777;">🐻 성별: ${dto.pet_bog}</div>
          <div style="font-size: 13px; color: #777;">✨ 중성화: ${dto.pet_neuter}</div>
          <div style="font-size: 13px; color: #777;">🎂 생일: ${dto.pet_hbd}</div>
        </div>
      </c:forEach>
    </div>
  </div>

 <!-- 중앙: 공지사항, 커뮤니티 출력 -->
<div class="tab-box">
  <div class="tab-header">
  
    <div class="tabs">
      <span id="notice-tab" class="tab active" onclick="switchTab('notice')">공지사항</span>
      <span id="community-tab" class="tab" onclick="switchTab('community')">커뮤니티</span>
    </div>
    <!-- 더보기 버튼 -->
    <a id="more-link" href="/notice/list" class="more-link">더보기 &gt;</a>
  </div>

  <div class="tab-content">
    공지사항, 커뮤니티 내용 출력
  </div>
</div>

  </section>

  <!-- 우측: 통합 캘린더 + 일정 + Q&A -->
  <aside class="right-info">
    <div class="content-box full-height" style="margin-top: 10px; font-size: 14px;">
      <h2>📅 오늘, 수요일</h2>
      📅<br>캘린더
		  <c:choose>
			<c:when test="${not empty sessionScope.user_id}">
			    <c:choose>
			      <c:when test="${not empty todaySchedule}">
			        <c:forEach items="${todaySchedule}" var="sch">
			          <div>📌 ${sch.cal_title}</div>
			        </c:forEach>
			      </c:when>
			      <c:otherwise>
			        <div>오늘은 일정이 없어요! ✨</div>
			      </c:otherwise>
			    </c:choose>
			</c:when>
			
			<%-- 로그인 안했을 때 --%>
			<c:otherwise>
			    <div>로그인 후 오늘 일정을 확인해보세요! 🐾</div>
			  </c:otherwise>
			</c:choose>
      <h3>🗓 일정</h3>
      <ul>
        <li>18:00 내펭글님과 화상 상담</li>
        <li>19:00 박펭글 고객 상담</li>
      </ul>
    </div>
    
    <div class="qna-box">
	  <h3>💬 고객 Q&A</h3>
	  <p>2건 있어요!</p>
	</div>
  </aside>

</div>

</body>
<script>
  function switchTab(type) {
    const noticeTab = document.getElementById('notice-tab');
    const communityTab = document.getElementById('community-tab');
    const moreLink = document.getElementById('more-link');

    if (type === 'notice') {
      noticeTab.classList.add('active');
      communityTab.classList.remove('active');
      moreLink.href='${pageContext.request.contextPath}/NoticeBoard';
    } else {
      noticeTab.classList.remove('active');
      communityTab.classList.add('active');
      moreLink.href='${pageContext.request.contextPath}/CommunityView';
    }
  }
</script>
</html>