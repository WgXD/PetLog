<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

  <style>
    .logo-img {
      height: 70px;
      vertical-align: middle;
      margin-right: 8px;
    }
  </style>
</head>

<body>

  <div class="top-wrapper">
  <div class="logo-title">
      <img src="${pageContext.request.contextPath}/image/logo11.png" class="logo-img">
  </div>

  <nav class="navbar">
    <div class="container-fluid">

      <div class="navbar-header">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/main"></a>
      </div>

      <ul class="nav navbar-nav">
        <li class="active"><a href="${pageContext.request.contextPath}/main">🏠 Home</a></li>

        <li class="dropdown">
          <a class="dropdown-toggle" data-toggle="dropdown" href="#">📖 오늘의 일기<span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="${pageContext.request.contextPath}/diary_input">✏️ 일기 쓰기</a></li>
            <li><a href="${pageContext.request.contextPath}/diary_out">📖 일기 보기</a></li>
          </ul>
        </li>

        <li class="dropdown">
          <a class="dropdown-toggle" data-toggle="dropdown" href="#">🗨️ 커뮤니티<span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="${pageContext.request.contextPath}/NoticeBoard">📢 PetLog 공지사항</a></li>
            <li><a href="${pageContext.request.contextPath}/CommunityView">📝 게시판</a></li>
            <li><a href="${pageContext.request.contextPath}/snack_input">🦴 레시피 공유</a></li>
            <li><a href="${pageContext.request.contextPath}/snack_out">🦴 레시피 보기</a></li>
          </ul>
        </li>

        <li class="dropdown">
          <a class="dropdown-toggle" data-toggle="dropdown" href="#">🧠 멍냥 퀴즈방<span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="${pageContext.request.contextPath}/QuizInput">🐾 오늘의 멍냥 퀴즈</a></li>
          </ul>
        </li>
            

        <li><a href="${pageContext.request.contextPath}/qnalist">❓ Q&A</a></li>

        <c:if test="${sessionScope.user_role eq 'admin'}">
          <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#">👑 관리자<span class="caret"></span></a>
            <ul class="dropdown-menu">
              <li><a href="${pageContext.request.contextPath}/BoardInput">📢 공지사항 작성하기</a></li>
              <li><a href="${pageContext.request.contextPath}/items_input">🎁 아이템 등록</a></li>
              <li><a href="${pageContext.request.contextPath}/items_out_admin">🎁 아이템 목록</a></li>
              <li><a href="${pageContext.request.contextPath}/Quiz_admin">📄 퀴즈 관리</a></li>
              <li><a href="${pageContext.request.contextPath}/point/grapes_admin_form">🍇 포도알 관리</a></li>
            </ul>
          </li>
        </c:if>
      </ul>

<ul class="nav navbar-nav navbar-right">
  <c:choose>
    
    <c:when test="${loginstate}">
         
      <c:if test="${sessionScope.user_role eq 'admin'}">
        <li><a href="${pageContext.request.contextPath}/mypage">관리자 정보변경</a></li>
        <li><a href="${pageContext.request.contextPath}/logout">로그아웃</a></li>
      </c:if>

      <c:if test="${sessionScope.user_role ne 'admin'}">
        <li><a href="${pageContext.request.contextPath}/mypage">${name}님의 마이페이지</a></li>
        <li style="padding-top:15px; color:#9B59B6;">🍇 ${sessionScope.loginUser.grape_count}개</li>
        <li><a href="${pageContext.request.contextPath}/pet_input">펫 등록</a></li>
        <li><a href="${pageContext.request.contextPath}/items/buy_items">내 아이템</a></li>
        <li><a href="${pageContext.request.contextPath}/logout">로그아웃</a></li>
      </c:if>
    </c:when>
    
    <c:otherwise>
      <li><a href="${pageContext.request.contextPath}/userlogin">회원가입</a></li>
      <li><a href="${pageContext.request.contextPath}/login">로그인</a></li>
    </c:otherwise>

  </c:choose>
</ul>
    </div>
  </nav>
</div>

</body>
</html>