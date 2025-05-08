<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>PetLog 메인</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>

<div class="main-wrapper">
  <div class="grid-container">

		<div class="box calendar">
		  📅<br>캘린더
		  <div style="margin-top: 10px; font-size: 14px;">
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
		
			
		  </div>
		</div>
	
    <div class="box grapes">🍇<br>포도알</div>
    
    <a href="${pageContext.request.contextPath}/items_out" class="box mini shop">
  		🛍️<br>아이템샵
	</a>
	
    <a href="${pageContext.request.contextPath}/QuizInput" class="box mini quiz">
    	❓<br>퀴즈
    </a>
    
	<a href="${pageContext.request.contextPath}/snack_out" class="box mini snack">
	  🍖<br>간식레시피
	</a>

    <div class="box post full">🔥 인기 게시물</div>
    <div class="box notice full">📢 공지사항</div>

  </div>
</div>

</body>
</html>
