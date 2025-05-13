<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<style>
body {

    font-family: 'Arial', sans-serif;
    background-color: #f8f8f8;
    text-align: center;
    padding: 0;
}
.profile-container {
    display: grid; /* 그리드 레이아웃 활성화 */
    grid-template-columns: repeat(3, 1fr); /* 한 줄에 3개의 카드 */
    gap: 5px; /* 카드 간 간격 */
    justify-items: center; /* 각 카드가 중앙에 정렬 */
    margin-left: 20%; /* 왼쪽 여백 추가 */
    margin-right: 20%; /* 오른쪽 여백 추가 */
    margin-bottom: 20px;
}
.pet-profile {
    width: 240px;
    background-color: #fdf6f9; /* 부드러운 핑크-크림 톤 */
    border: 1px solid #e6d5e5;
    border-radius: 12px;
    padding: 15px;
    box-shadow: 2px 4px 10px rgba(0, 0, 0, 0.05);
    position: relative;
    text-align: center;
}
.pet-profile img {
    width: 200px;
    height: 200px;
    border-radius: 50%;
    margin-bottom: 10px;
    display: block;        /* 이미지 블록화 */
    margin-left: auto;     /* 가운데 정렬 */
    margin-right: auto;
    object-fit: cover;
}
.pet-profile .pet-name {
    font-size: 22px;
    font-weight: bold;
    margin-bottom: 10px;
}
.pet-profile .pet-info {
    font-size: 16px;
    color: #555;
    margin-bottom: 20px;
}
.pet-profile .pet-info span {
    display: block;
    margin-bottom: 5px;
}
.pet-button {
    display: block;
    width: 100%;
    text-align: center;
    background-color: #6d5da7;
    transition: background-color 0.3s ease;
    color: #90cfc3;
    padding: 8px 0;
    border-radius: 20px;
    text-decoration: none;
    font-size: 14px;
    font-weight: bold;
    margin-top: 10px;
}
.pet-button:hover {
	background-color: #7fbfb3;
    text-decoration: none;
}
.pet-info {
    text-align: left;
    display: block;
    margin: 0 auto 20px auto;
    width: 90%;  /* 너무 양끝 붙지 않게 */
    font-size: 16px;
    color: #555;
    line-height: 1.6;
}
  </style>

<meta charset="UTF-8">
<title>My pet</title>
</head>
<body>
<header><h2>My pet</h2></header><br>

<c:if test="${empty list}">
  <p style="margin-top: 20px; font-weight: bold; color: #c0392b;">등록된 펫이 없습니다. 펫을 등록해주세요 🐾</p>
  <form action="pet_input" method="get" style="margin-top: 20px;">
    <input type="submit" value="펫 등록하러 가기"
           style="padding: 10px 20px; border-radius: 12px; background-color: #d7c9f3; 
                  color: #5e478e; font-weight: bold; border: none; cursor: pointer;">
  </form>
</c:if>

<c:if test="${not empty list}">

<div class="profile-container">
        <c:forEach items="${list}" var="pet">
            <div class="pet-profile">
                <!-- 펫 프로필 이미지 출력 -->
                <img src="${pageContext.request.contextPath}/image/${pet.pet_img}" alt="Pet Image">

                <!-- 펫 이름 출력 -->
                <div class="pet-name">${pet.pet_name}</div>

                <!-- 펫 성별, 중성화 여부, 생일 정보 출력 -->
                <div class="pet-info">
                <span>🧸 성별 ${pet.pet_bog}</span>
                <span>✨ 중성화 ${pet.pet_neuter}</span>
                <span>🎂 생일 ${pet.pet_hbd}</span>
            </div>

                <!-- 펫 프로필 보기 버튼 -->
                <a href="pet_detail?update1=${pet.pet_id}" class="pet-button" style="background-color:  #e5f7f3;">펫 프로필 보기</a>
            </div>
        </c:forEach>
    </div>


</c:if>

</body>
</html>
