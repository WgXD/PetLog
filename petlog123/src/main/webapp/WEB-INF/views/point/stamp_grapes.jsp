<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    com.mbc.pet.user.UserDTO loginUser = (com.mbc.pet.user.UserDTO) session.getAttribute("loginUser");
    if (loginUser == null) {
        response.sendRedirect(request.getContextPath() + "/login?error=login_required");
        return;
    }

    int grapeCount = loginUser.getGrape_count();
    int maxGrape = 100;
    int percent = grapeCount * 100 / maxGrape;
    request.setAttribute("grapeCount", grapeCount);
    request.setAttribute("maxGrape", maxGrape);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">

    <style>
    .main-box {
        background-color: white;
        border-radius: 20px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
        width: 90%;
        max-width: 800px;
        margin: 40px auto;
        padding: 40px 30px;
    }

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
        height: 32px;
        background: linear-gradient(to right, #fef3ff, #e6d6ff);
        border-radius: 20px;
        overflow: hidden;
        box-shadow: inset 0 1px 3px rgba(0,0,0,0.08);
    }

    .grape-fill {
        height: 100%;
        background: linear-gradient(to right, #d59ff8, #b780e5);
        width: <%= percent %>%;
        transition: width 0.5s ease;
        border-radius: 20px;
        box-shadow: inset 0 0 6px rgba(255,255,255,0.5);
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

    .grape-growth-text {
        font-weight: bold;
        color: #b58ed3;
        animation: textFlash 1.2s ease-in-out infinite;
        text-align: center;
        margin-top: 20px;
    }

    @keyframes textFlash {
        0%, 100% { color: #b58ed3; }
        50% { color: #f3e6ff; }
    }

    .grape-count {
        text-align: center;
        margin-top: 10px;
        color: #7b3fa1;
        font-weight: bold;
        font-size: 16px;
    }

    .btn.btn-purple {
        display: block;
        margin: 20px auto 0;
        background-color: #b799e0;
        color: white;
        border: none;
        padding: 10px 24px;
        border-radius: 24px;
        font-weight: bold;
        font-size: 15px;
        cursor: pointer;
    }

    .btn.btn-purple:hover {
        background-color: #a67de0;
    }

    .btn-outline-purple {
        background-color: transparent;
        color: #9b59b6;
        font-size: 15px;
        font-weight: bold;
        padding: 10px 24px;
        border: 2px solid #d6b3f5;
        border-radius: 30px;
        cursor: pointer;
        transition: all 0.3s ease;
        box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        display: block;
        margin: 15px auto 0;
    }

    .btn-outline-purple:hover {
        background-color: #f8ebff;
        color: #7b3fa1;
        border-color: #caa0f0;
    }

    .modal {
        position: fixed;
        z-index: 1000;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0,0,0,0.4);
        display: none;
        justify-content: center;
        align-items: center;
    }

    .modal-content {
        background: #fff;
        padding: 25px 30px;
        border-radius: 20px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.2);
        width: 80%;
        max-width: 400px;
        text-align: center;
        color: #5b3b89;
    }

    .modal-content h3 {
        margin-top: 0;
        margin-bottom: 15px;
    }

    .modal-content ul {
        list-style-type: none;
        padding-left: 0;
        text-align: center;
    }

    .close {
        position: absolute;
        top: 12%;
        right: 10%;
        font-size: 26px;
        font-weight: bold;
        cursor: pointer;
        color: #555;
    }

.grape-fixed-right {
    position: absolute;
    right: -70px;
    top: -37px;
    display: flex;
    flex-direction: column;
    align-items: center;
}
.grape-fixed-right img {
    width: 60px;
}

.grape-fixed-right .speech-bubble {
    background: #fff;
    border: 2px solid #bfa3e0;
    border-radius: 12px;
    padding: 6px 12px;
    color: #7b3fa1;
    font-size: 14px;
    font-weight: bold;
    white-space: nowrap;
    box-shadow: 2px 2px 6px rgba(0,0,0,0.6);
    margin-bottom: 6px;
    position: relative;
    z-index: 2;
}

.grape-fixed-right .speech-bubble::after {
    content: "";
    position: absolute;
    bottom: -8px;
    left: 50%;
    transform: translateX(-50%);
    border-width: 8px 8px 0 8px;
    border-style: solid;
    border-color: #fff transparent transparent transparent;
}
    </style>
</head>

<body>

<div class="main-box">
    <div class="grape-label-flex">
        <span class="grape-label-text">🍇 내 포도</span>
    </div><br><br><br>

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
            </div><br>

            <div class="grape-bar">
                <div class="grape-fill"></div>
            </div>

            <!-- ✅ 오른쪽 끝 캐릭터 + 말풍선 -->
            <div class="grape-fixed-right">
                <div class="speech-bubble">화이팅!</div>
                <img src="${pageContext.request.contextPath}/image/sample.png">
            </div>

        </div>
    </div>

    <div class="grape-growth-text">
        <c:choose>
            <c:when test="${grapeCount le 10}">씨앗을 심었어요! 🌱</c:when>
            <c:when test="${grapeCount le 40}">새싹이 나왔어요! 🌿</c:when>
            <c:when test="${grapeCount le 60}">포도가 익어가고 있어요! 🎉</c:when>
            <c:otherwise>포도가 다 익었어요! 🍇</c:otherwise>
        </c:choose>
    </div>

    <div class="grape-count">${grapeCount} / ${maxGrape}알</div><br>

    <form action="${pageContext.request.contextPath}/items_out" method="get">
        <input type="submit" value="포도 쓰러가기 🍇" class="btn btn-purple">
    </form>
</div>

<!-- 성장과정 모달 버튼 -->
<button onclick="openModal()" class="btn-outline-purple">포도 성장과정 보기 🍇</button>

<!-- 모달 구조 -->
<div id="grapeModal" class="modal">
  <div class="modal-content">
    <span class="close" onclick="closeModal()">&times;</span>
    <h3>🍇 포도는 이렇게 자라요!</h3>
    <ul>
      <li><strong>0 ~ 10알</strong> : 씨앗을 심어요 🌱</li>
      <li><strong>11 ~ 40알</strong> : 새싹이 나와요 🌿</li>
      <li><strong>41 ~ 60알</strong> : 포도가 익어가요 🎉</li>   
      <li><strong>61 ~ 100알</strong> : 포도 재배 성공 🍇</li>
    </ul>
  </div>
</div>

<script>
  function openModal() {
    document.getElementById("grapeModal").style.display = "flex";
  }
  function closeModal() {
    document.getElementById("grapeModal").style.display = "none";
  }
</script>

</body>
</html>