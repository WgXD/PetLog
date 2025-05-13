<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <h2 style="color: #f48aa5">⚠️ 정말 삭제하시겠습니까?</h2>
  <style>
    body {
      background-color: #fff6f6;
      margin: 0;
      padding: 0;
      font-family: 'Pretendard', sans-serif;
      color: #333;
    }

    h2 {
      text-align: center;
      font-size: 24px;
      color: #f48aa5;
      margin: 50px 0 30px;
    }

    .container {
      max-width: 500px;
      margin: 0 auto 80px auto;
      background-color: #fff;
      padding: 40px 30px;
      border-radius: 16px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
      text-align: center;
    }

    .container img {
      width: 160px;
      height: 160px;
      object-fit: cover;
      border-radius: 50%;
      margin-bottom: 20px;
      border: 4px solid #ffe1e1;
    }

    .pet-name {
      font-size: 22px;
      font-weight: bold;
      margin-bottom: 20px;
      color: #d65b7b;
    }

    .pet-info {
      text-align: left;
      margin: 0 auto 20px auto;
      font-size: 15px;
      color: #555;
      line-height: 1.6;
    }

    .pet-info span {
      display: block;
      margin-bottom: 8px;
    }

    .form-actions {
      margin-top: 30px;
    }

    input[type="submit"],
    input[type="reset"] {
      background-color: #ffe1e1;
      color: #333;
      border: none;
      padding: 10px 24px;
      border-radius: 10px;
      font-size: 15px;
      cursor: pointer;
      margin: 0 10px;
      transition: background-color 0.3s ease;
    }

    input[type="submit"]:hover,
    input[type="reset"]:hover {
      background-color: #ffd2d2;
    }

    input[type="submit"]:active,
    input[type="reset"]:active {
      transform: scale(0.95);
    }
  </style>

  <script>
    function confirm_delete() {
      return confirm("펫정보를 삭제합니다. 😥");
    }
  </script>
</head>
<body>

  <form action="pet_delete_check" method="post" onsubmit="return confirm_delete()">
    <input type="hidden" name="himage" value="${dto.pet_img}">
    <input type="hidden" name="pet_id" value="${dto.pet_id}">

    <div class="container">
      <img src="image/${dto.pet_img}" alt="반려동물 사진">

      <div class="pet-name">${dto.pet_name}</div>

      <div class="pet-info">
        <span>💙 성별: ${dto.pet_bog}</span>
        <span>✨ 중성화: ${dto.pet_neuter}</span>
        <span>🎂 생일: ${dto.pet_hbd}</span>
      </div>

      <div class="form-actions">
        <input type="submit" value="💾 삭제하기">
        <input type="reset" value="❌ 취소하기" onclick="history.back()">
      </div>
    </div>
  </form>

</body>
</html>