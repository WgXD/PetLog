<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>펫 정보 자세히 보기</title>
<style>
body {
    font-family: 'Arial', sans-serif;
    background-color: #f8f8f8;
    text-align: center;
    padding: 40px;
}

h2 {
    color: #5e478e;
    font-size: 28px;
    margin-bottom: 20px;
}

.back-button {
    margin-bottom: 20px;
    background-color: #f8d7da;
    color: #a94442;
    border: 1px solid #f5c6cb;
    padding: 10px 20px;
    font-size: 14px;
    border-radius: 16px;
    font-weight: bold;
    cursor: pointer;
}

.back-button:hover {
    background-color: #e8c7ca;
}

/* 카드 컨테이너 */
.profile-container {
    width: 350px;
    margin: 0 auto;
    background-color: #fff;
    border-radius: 16px;
    padding: 30px;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
}

.profile-container img {
    width: 200px;
    height: 200px;
    margin-bottom: 20px;
    object-fit: contain;
}

.profile-container .pet-name {
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 10px;
}

.profile-container .pet-info {
    text-align: left;
    margin: 0 auto 20px auto;
    display: inline-block;
    font-size: 16px;
    color: #555;
    line-height: 1.6;
}

.profile-container .pet-info span {
    display: block;
    margin-bottom: 5px;
}

.pet-actions {
    text-align: center;
    margin-top: 10px;
}

.pet-button {
    padding: 10px 18px;
    background-color: #5e478e;
    color: white;
    text-decoration: none;
    border-radius: 20px;
    font-weight: bold;
    transition: background-color 0.3s;
    margin: 0 8px;
    display: inline-block;
}

.pet-button:hover {
    background-color: #4b357f;
}
.pet-info {
  text-align: left;
  display: block;
  margin: 0 auto 20px auto;
  width: 80%;
  font-size: 16px;
  color: #555;
  line-height: 1.6;
}
</style>
</head>
<body>

<header><h2>펫 정보 자세히 보기</h2></header>
<div><input type="reset" value="⬅ 뒤로가기" class="back-button" onclick="history.back()"></div>

<div class="profile-container">

    <img src="${pageContext.request.contextPath}/image/${dto.pet_img}" alt="Pet Image">
    <div class="pet-name">${dto.pet_name}</div>

    <div class="pet-info">
        <span>🧸 성별 ${dto.pet_bog}</span>
        <span>✨ 중성화 ${dto.pet_neuter}</span>
        <span>🎂 생일 ${dto.pet_hbd}</span>
    </div>

    <div class="pet-actions">
        <a href="pet_update?update=${dto.pet_id}&dfimage=${dto.pet_img}" class="pet-button">✏️</a>
        <a href="pet_delete?delete=${dto.pet_id}&dfimage=${dto.pet_img}" class="pet-button">🗑️</a>
    </div>
</div>

</body>
</html>
