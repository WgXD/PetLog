<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">

<style>
body {
    background-color: #fff6f6;
    margin: 0;
    padding: 0;
    color: #333;
    text-align: center;
}

h2 {
    text-align: center;
    color: #f48aa5;
    font-weight: normal;
    font-size: 1.8em;
    margin-bottom: 30px;
}

.btn {
    background-color: #ffe1e1;
    color: #333;
    border: none;
    padding: 8px 20px;
    border-radius: 10px;
    font-weight: normal;
    cursor: pointer;
    text-decoration: none;
    display: inline-block;
    font-size: 14px;
}

.btn:hover {
    background-color: #ffd2d2;
}

.table-wrapper {
    background-color: white;
    width: 100%;
    max-width: 600px;
    margin: 40px auto 80px auto;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    padding: 30px;
}

.pet-name {
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 20px;
    color: black;
    }

.profile-container img {
    width: 200px;
    height: 200px;
    margin-bottom: 20px;
    object-fit: cover;
    border-radius: 50%;
    display: block;
    margin-left: auto;
    margin-right: auto;
}

/* ✅ 귀엽게 꾸민 펫 정보 말풍선 박스 */
.pet-info {
    background-color: #fff0f5;
    border-radius: 16px;
    padding: 20px 40px;
    width: max-content;
    min-width: 280px;
    margin: 0 auto 30px auto;
    box-shadow: 0 2px 6px rgba(0,0,0,0.05);
    font-size: 16px;
    color: #555;
    line-height: 1.8;
}

.info-row {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-bottom: 10px;
    font-weight: 500;
    font-size: 16px;
}

.info-row b {
    font-weight: bold;
    color: #444;
}

.pet-actions {
    text-align: center;
    margin-top: 10px;
}

.pet-button {
    padding: 10px 18px;
    background-color: #f48aa5;
    color: white;
    text-decoration: none;
    border-radius: 20px;
    font-weight: bold;
    transition: background-color 0.3s;
    margin: 0 8px;
    display: inline-block;
    font-size: 14px;
}

.pet-button:hover {
    background-color: #d65b7b;
}
</style>
</head>
<body>

<div class="table-wrapper">

  <!-- 1줄: 뒤로가기 버튼만 왼쪽 -->
  <div style="text-align: left; margin-bottom: 0;">
    <a href="javascript:history.back()" class="btn">⬅ 뒤로가기</a>
  </div>

  <!-- 2줄: 가운데 제목 -->
  <div style="text-align: center; margin: 10px 0 30px 0;">
    <h2>🐾 펫 정보 자세히 보기</h2>
  </div>

  <!-- 펫 상세정보 -->
  <div class="profile-container">
    <img src="${pageContext.request.contextPath}/image/${dto.pet_img}" alt="Pet Image">
    <div class="pet-name">🤍 ${dto.pet_name} 🤍</div>

<div class="pet-info">
  <div class="info-row">🧸 <span>성별 <b>${dto.pet_bog}</b></span></div>
  <div class="info-row">✨ <span>중성화 <b>${dto.pet_neuter}</b></span></div>
  <div class="info-row">🎂 <span>생일 <b>${dto.pet_hbd}</b></span></div>
</div>

    <div class="pet-actions">
      <a href="pet_update?update=${dto.pet_id}&dfimage=${dto.pet_img}" class="pet-button">✏️</a>
      <a href="pet_delete?delete=${dto.pet_id}&dfimage=${dto.pet_img}" class="pet-button">🗑️</a>
    </div>
  </div>
</div>
</body>
</html>