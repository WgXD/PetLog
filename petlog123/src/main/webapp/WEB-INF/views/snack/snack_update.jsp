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
    }

    .container {
      max-width: 1000px;
      margin: 60px auto 100px auto;
      background: #fff;
      padding: 60px 80px;
      border-radius: 16px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
    }

    h2 {
      text-align: center;
      font-size: 26px;
      color: #f48aa5;
      font-weight: normal;
      margin-top: 0;
      margin-bottom: 30px;
    }

    .form-group {
      display: flex;
      align-items: center;
      margin-bottom: 20px;
    }

    .form-group label {
      flex: 0 0 120px;
      font-weight: bold;
      font-size: 15px;
      color: #555;
    }

    .form-group input[type="text"],
    .form-group input[type="date"],
    .form-group input[type="file"],
    .form-group textarea {
      flex: 1;
      padding: 12px 16px;
      font-size: 15px;
      border: 1px solid #ddd;
      border-radius: 8px;
      background-color: #fffdfd;
      transition: all 0.2s ease-in-out;
      box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.05);
    }

    .form-group textarea {
      resize: vertical;
      height: 150px;
    }

    .form-group input:focus,
    .form-group textarea:focus {
      border-color: #f48aa5;
      box-shadow: 0 0 0 3px rgba(244, 138, 165, 0.2);
      outline: none;
    }

    .form-group img {
      margin-bottom: 10px;
      margin-right: 20px;
      max-width: 120px;
      display: block;
    }

    .form-actions {
      text-align: center;
      margin-top: 40px;
    }

    input[type="submit"],
    input[type="reset"] {
      background-color: #f48aa5;
      color: white;
      border: none;
      padding: 12px 30px;
      border-radius: 10px;
      font-size: 15px;
      font-weight: normal;
      margin: 0 10px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    input[type="submit"]:hover,
    input[type="reset"]:hover {
      background-color: #db7093;
    }

    @media screen and (max-width: 768px) {
      .form-group {
        flex-direction: column;
        align-items: flex-start;
      }

      .form-group label {
        margin-bottom: 8px;
      }

      .container {
        padding: 40px 24px;
      }
    }
  </style>
  <script>
    function confirm_update() {
      return confirm("정말 수정하시겠습니까? 😊");
    }
  </script>
</head>
<body>
  <div class="container">
    <h2 style="color: #f48aa5">🦴 레시피 수정하기</h2>

    <form action="snackupdate_save" method="post" enctype="multipart/form-data" onsubmit="return confirm_update()">
      <input type="hidden" name="himage" value="${dto.snack_image}">

      <div class="form-group">
        <label for="snack_id">No.</label>
        <input type="text" id="snack_id" name="snack_id" value="${dto.snack_id}" readonly>
        <input type="hidden" name="snack_id" value="${dto.snack_id}">
      </div>

      <div class="form-group">
        <label for="snack_title">레시피명</label>
        <input type="text" id="snack_title" name="snack_title" value="${dto.snack_title}">
      </div>

      <div class="form-group">
        <label for="snack_recipe">레시피</label>
        <textarea id="snack_recipe" name="snack_recipe">${dto.snack_recipe}</textarea>
      </div>

      <div class="form-group">
        <label for="snack_image">이미지</label>
        <img src="./image/${dto.snack_image}" alt="레시피 이미지">
        <input type="file" id="snack_image" name="snack_image">
      </div>

      <div class="form-group">
        <label for="snack_date">날짜</label>
        <input type="date" id="snack_date" name="snack_date" value="${dto.snack_date}">
      </div>

      <div class="form-actions">
        <input type="submit" value="💾 수정하기">
        <input type="reset" value="❌ 취소하기" onclick="history.back()">
      </div>
    </form>
  </div>
</body>
</html>