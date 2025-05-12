<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>펫 정보 입력하기 🐾</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      color: #333;
    }

    .container {
      max-width: 900px;
      margin: 40px auto 80px auto;
      background: #fff;
      padding: 50px 60px;
      border-radius: 12px;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.06);
      border: 1px solid #e0e0e0;
    }

    h2 {
      text-align: center;
      font-size: 28px;
      color: #d85a8a;
      margin-top: 0;
      margin-bottom: 40px;
    }

    .form-group {
      display: flex;
      align-items: center;
      margin-bottom: 22px;
    }

    .form-group label {
      flex: 0 0 140px;
      font-weight: bold;
      font-size: 15px;
      color: #555;
    }

    .form-group input[type="text"],
    .form-group input[type="date"],
    .form-group input[type="file"] {
      flex: 1;
      padding: 10px 12px;
      font-size: 15px;
      border: 1px solid #ccc;
      border-radius: 6px;
      transition: border-color 0.3s ease;
    }

    .form-group input:focus {
      border-color: #a3d8cd; /* 민트 포인트 */
      outline: none;
    }

    .radio-group {
      display: flex;
      gap: 20px;
    }

    .radio-group label {
      font-weight: normal;
      font-size: 14px;
      white-space: nowrap;
    }

    .form-actions {
      text-align: center;
      margin-top: 40px;
    }

    input[type="submit"],
    input[type="reset"] {
      background-color: #d85a8a;
      color: white;
      border: none;
      padding: 12px 30px;
      border-radius: 6px;
      font-size: 16px;
      font-weight: bold;
      margin: 0 12px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    input[type="submit"]:hover,
    input[type="reset"]:hover {
      background-color: #c14573;
    }

    @media screen and (max-width: 768px) {
      .form-group {
        flex-direction: column;
        align-items: flex-start;
      }

      .form-group label {
        margin-bottom: 8px;
      }
    }
  </style>
</head>
<body>

  <div class="container">
    <h2>펫 정보 입력하기 🐾</h2>

    <form action="pet_save" method="post" enctype="multipart/form-data">

      <div class="form-group">
        <label for="pet_name">이름</label>
        <input type="text" id="pet_name" name="pet_name" required>
      </div>

      <div class="form-group">
        <label>성별</label>
        <div class="radio-group">
          <label><input type="radio" name="pet_bog" value="수컷💙" required> 수컷💙</label>
          <label><input type="radio" name="pet_bog" value="암컷💛" required> 암컷💛</label>
        </div>
      </div>

      <div class="form-group">
        <label>중성화</label>
        <div class="radio-group">
          <label><input type="radio" name="pet_neuter" value="⭕" required> ⭕</label>
          <label><input type="radio" name="pet_neuter" value="❌" required> ❌</label>
        </div>
      </div>

      <div class="form-group">
        <label for="pet_hbd">생일</label>
        <input type="date" id="pet_hbd" name="pet_hbd" required>
      </div>

      <div class="form-group">
        <label for="pet_img">사진</label>
        <input type="file" id="pet_img" name="pet_img" required>
      </div>

      <div class="form-actions">
        <input type="submit" value="💾 저장하기">
        <input type="reset" value="❌ 취소하기" onclick="history.back()">
      </div>

    </form>
  </div>

</body>
</html>
