<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>펫 정보 삭제하기 🐾</title>
<style>
  body {
    font-family: 'Arial', sans-serif;
    background-color: #fff8f0;
    text-align: center;
    padding: 60px 20px;
  }

  h2 {
    color: #d03c3c; /* ❗ 붉은 강조 */
    font-size: 26px;
    margin-bottom: 30px;
  }

  .profile-container {
    max-width: 360px;
    margin: 0 auto;
    background-color: #fff0f0; /* 연한 붉은 배경 */
    padding: 30px;
    border-radius: 16px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    border: 1px solid #f3bcbc;
  }

  .profile-container img {
    width: 180px;
    height: 180px;
    object-fit: cover;
    border-radius: 50%;
    margin-bottom: 20px;
  }

  .pet-name {
    font-size: 22px;
    font-weight: bold;
    margin-bottom: 20px;
    color: #c0392b;
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

  .pet-info span {
    display: block;
    margin-bottom: 6px;
  }

  .pet-actions {
    text-align: center;
  }

  .pet-actions input[type="submit"] {
    background-color: #f47b7b; /* 삭제 버튼 붉은색 강조 */
    color: white;
    border: none;
    padding: 10px 22px;
    margin: 6px;
    border-radius: 24px;
    font-size: 15px;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.15s ease;
    box-shadow: 2px 2px 5px rgba(200, 80, 80, 0.2);
  }

  .pet-actions input[type="submit"]:hover {
    background-color: #e55757;
    transform: scale(1.05);
  }

  .pet-actions input[type="submit"]:active {
    transform: scale(0.95);
  }

  .pet-actions input[type="reset"] {
    background-color: #d7c9f3;
    color: #5e478e;
    border: none;
    padding: 10px 22px;
    margin: 6px;
    border-radius: 24px;
    font-size: 15px;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.15s ease;
    box-shadow: 2px 2px 5px rgba(100, 80, 160, 0.2);
  }

  .pet-actions input[type="reset"]:hover {
    background-color: #e8defc;
    transform: scale(1.05);
  }

  .pet-actions input[type="reset"]:active {
    transform: scale(0.95);
  }
</style>

<script>
  function confirm_delete() {
    return confirm("정말 삭제하시겠습니까? 😥");
  }
</script>
</head>
<body>

<h2>⚠️ 정말 삭제하시겠습니까?</h2>

<form action="pet_delete_check" method="post" onsubmit="return confirm_delete()">
  <input type="hidden" name="himage" value="${dto.pet_img}">
  <input type="hidden" name="pet_id" value="${dto.pet_id}">

  <div class="profile-container">
    <img src="image/${dto.pet_img}" alt="반려동물 사진">
    
    <div class="pet-name">${dto.pet_name}</div>

    <div class="pet-info">
      <span>🧸 성별: ${dto.pet_bog}</span>
      <span>✨ 중성화: ${dto.pet_neuter}</span>
      <span>🎂 생일: ${dto.pet_hbd}</span>
    </div>

    <div class="pet-actions">
      <input type="submit" value="💾 삭제하기">
      <input type="reset" value="❌ 취소하기" onclick="history.back()">
    </div>
  </div>
</form>

</body>
</html>
