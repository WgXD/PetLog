<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    com.mbc.pet.user.UserDTO loginUser = (com.mbc.pet.user.UserDTO) session.getAttribute("loginUser");
    if (loginUser == null) {
        response.sendRedirect(request.getContextPath() + "/login?error=login_required");
        return;
    }

    int grapeCount = loginUser.getGrape_count();
    int maxGrape = 100;
    int percent = grapeCount * 100 / maxGrape; // 계산된 퍼센트
    request.setAttribute("grapeCount", grapeCount);
    request.setAttribute("maxGrape", maxGrape);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>포도송이 성장 게이지</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    
<style>
.grape-label-flex {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
    margin-bottom: 15px;
}

.grape-label-text {
    font-size: 28px;
    font-weight: bold;
    color: #7b3fa1;
    font-family: 'Segoe UI', '맑은 고딕', sans-serif;
}

.grape-bar-wrapper {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 15px;
    margin-bottom: 10px;
}

.grape-bar-position {
    position: relative;
    width: 100%;
    max-width: 600px;
}

.grape-bar {
    width: 100%;
    height: 30px;
    background: linear-gradient(to right, #f8ebff, #ecdfff); /* 연보라톤 그라데이션 */
    border-radius: 20px;
    overflow: hidden;
    box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.08);
}

.grape-fill {
    height: 100%;
    background: linear-gradient(to right, #c27ef0, #9b59b6); /* 포도 보라톤 */
    width: <%= percent %>%;
    transition: width 0.5s ease;
    border-radius: 20px;
}

.grape-indicator {
    position: absolute;
    top: -38px;
    font-size: 24px;
    left: <%= percent %>%;
    transform: translateX(-50%);
    transition: left 0.5s ease;
    animation: bounce 1.0s infinite ease-in-out;
}

@keyframes bounce {
    0%, 100% { transform: translateX(-50%) translateY(0); }
    50% { transform: translateX(-50%) translateY(-6px); }
}

.grape-img {
    height: 75px;
    width: auto;
}

.grape-count {
    margin-top: 15px;
    color: #7b3fa1;
    font-weight: bold;
    font-size: 16px;
}

.grape-growth-text {
  font-weight: bold;
  color: #b58ed3;
  animation: textFlash 1.2s ease-in-out infinite;
}

/* 글자색 밝기 자체가 변화하는 반짝임 */
@keyframes textFlash {
  0%, 100% {
    color: #b58ed3;
  }
  50% {
    color: #f3e6ff; /* 거의 흰색에 가까운 연한 연보라 */
  }
}

</style>

</head>
<body>

<div class="main-wrapper">
    <div class="box">
        <div class="grape-label-flex">
            <span class="grape-label-text">내 포도</span>
        </div>

        <div class="grape-bar-wrapper">
            <div class="grape-bar-position">
            
            
		<div class="grape-indicator">
		    <c:choose>
		        <c:when test="${grapeCount le 10}">
		            <img src="${pageContext.request.contextPath}/image/seed.png" alt="씨앗" style="height: 40px;">
		        </c:when>
		        <c:when test="${grapeCount le 40}">
		            <img src="${pageContext.request.contextPath}/image/leaf.png" alt="새싹" style="height: 40px;">
		        </c:when>
		        <c:when test="${grapeCount le 60}">
		            <img src="${pageContext.request.contextPath}/image/green_grapes.png" alt="초록포도" style="height: 40px;">
		        </c:when>
		        <c:otherwise>
		            <img src="${pageContext.request.contextPath}/image/purple_grapes.png" alt="보라포도" style="height: 40px;">
		        </c:otherwise>
		    </c:choose>
		</div>

                <div class="grape-bar">
                    <div class="grape-fill"></div>
                </div>
            </div>
            <img src="${pageContext.request.contextPath}/image/bar.png" class="grape-img"/>
        </div>

<div class="grape-growth-text">
    <c:choose>
        <c:when test="${grapeCount le 10}">
            씨앗이 심어졌어요! 🌱
        </c:when>
        <c:when test="${grapeCount le 40}">
            새싹이 나왔어요! 🌱
        </c:when>
        <c:when test="${grapeCount le 60}">
            포도가 익어가고 있어요! 🎉
        </c:when>
        <c:otherwise>
            포도가 익었어요! 🍇
        </c:otherwise>
    </c:choose>
</div>
        <div class="grape-count">${grapeCount} / ${maxGrape}개</div>     
           
        <form action="${pageContext.request.contextPath}/items_out" method="get">
            <input type="submit" value="포도 쓰러가기 🍇" class="btn btn-pink" style="margin-top: 30px;">
        </form>
    </div>
</div>

</body>
</html>