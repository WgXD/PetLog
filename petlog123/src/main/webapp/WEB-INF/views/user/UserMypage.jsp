<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">

<style>

body {
    background-color: #ffffff;
    margin: 0;
    padding: 0;
}

.container {
    max-width: 700px;
    margin: 50px auto;
    background-color: #ffffff;
    padding: 40px;
    border-radius: 20px;
    text-align: center;
}

h1 {
    font-size: 30px;
    margin-bottom: 25px;
    color: #333;
}

h3 {
    font-size: 22px;
    color: #555;
    margin-top: 30px;
}

.nickname {
    font-size: 24px;
    font-weight: bold;
    color: #f49fb6;
    background: #fff4f6;
    padding: 6px 14px;
    border-radius: 20px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}

/* 카드형 회원정보 박스 */
.info-card {
    background: #fff6f8;
    border: 2px solid #ffc1cc;
    border-radius: 20px;
    padding: 25px;
    margin: 25px auto;
    max-width: 400px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.05);
    font-size: 16px;
    color: #444;
}
.info-card p {
    margin: 12px 0;
    line-height: 1.6;
}

.btn-group {
    margin-top: 30px;
}
.btn-group a {
    display: inline-block;
    background: linear-gradient(135deg, #ffc1cc, #fbe5c8);
    color: #5a5a5a;
    text-decoration: none;
    padding: 12px 24px;
    border-radius: 30px;
    font-size: 15px;
    cursor: pointer;
    font-weight: bold;
    margin: 0 10px;
    transition: all 0.3s;
}
.btn-group a:hover {
    background: linear-gradient(135deg, #fba0b2, #f8d7af);
    color: #333;
}

/* 프로필 이미지 프레임 */
.profile-frame-container {
    position: relative;
    width: 220px;
    height: 220px;
    margin: 0 auto 25px auto;
}

.profile-img {
    position: absolute;
    top: 35px;
    left: 35px;
    width: 150px;
    height: 150px;
    border-radius: 50%;
    object-fit: cover;
    z-index: 1;
}

.frame-img {
    position: absolute;
    top: 0;
    left: 0;
    width: 220px;
    height: 220px;
    z-index: 2;
    pointer-events: none;
    border-radius: 50%;
}

.with-border {
    border: 5px solid #ffc1cc;
    border-radius: 50%;
    box-sizing: border-box;
}
</style>

</head>
<body>
<div class="container">
    <h1>🐾 마이페이지</h1>
    <div class="profile-frame-container">
        <c:choose>
            <c:when test="${empty equippedFrame}">
                <img src="${pageContext.request.contextPath}/image/${dto.profileimg != null ? dto.profileimg : 'default.png'}"
                     class="profile-img with-border" alt="프로필">
            </c:when>
            <c:otherwise>
                <img src="${pageContext.request.contextPath}/image/${dto.profileimg != null ? dto.profileimg : 'default.png'}"
                     class="profile-img" alt="프로필">
            </c:otherwise>
        </c:choose>

        <c:if test="${not empty equippedFrame}">
            <img src="${pageContext.request.contextPath}/image/${equippedFrame.item_image}"
                 class="frame-img" alt="프레임">
        </c:if>
    </div>
 
    <h3><span class="nickname">${dto.name}</span>님의 회원정보</h3>

    <!-- 회원 정보 -->
    <div class="info-card">
        <p><strong>아이디:</strong> ${dto.user_login_id}</p>
        <p><strong>이름:</strong> ${dto.name}</p>
        <p><strong>전화번호:</strong> ${dto.phone}</p>
        <p><strong>포도알:</strong> 🍇 ${dto.grape_count}개</p>
        <p><strong>퀴즈 등급:</strong> ${dto.rank}</p>
    </div>

    <!-- 버튼 그룹 -->
    <div class="btn-group">
        <a href="pwcheckPage">비밀번호 변경</a>
        <a href="UserEditProfile">회원정보 수정</a>
        <a href="pet_out">펫 정보</a>
    </div>
</div>
</body>
</html>