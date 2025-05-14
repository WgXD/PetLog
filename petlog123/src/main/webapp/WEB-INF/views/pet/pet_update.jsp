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
      font-family: 'Pretendard', sans-serif;
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
    .form-group input[type="file"] {
      flex: 1;
      padding: 12px 16px;
      font-size: 15px;
      border: 1px solid #ddd;
      border-radius: 8px;
      background-color: #fffdfd;
      font-family: 'Pretendard', sans-serif;
      transition: all 0.2s ease-in-out;
      box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.05);
    }

    .form-group input:focus {
      border-color: #f48aa5;
      box-shadow: 0 0 0 3px rgba(244, 138, 165, 0.2);
      outline: none;
    }

    .radio-group {
      display: flex;
      gap: 40px;
    }

    .radio-group label {
      display: flex;
      align-items: center;
      gap: 6px;
      min-width: 80px;
      white-space: nowrap;
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

  <script type="text/javascript">
    function confirm_update() {
      return confirm("정말 수정하시겠습니까? 😊");
    }
  </script>
</head>
<body>

  <div class="container">
    <h2 style="color: #f48aa5">🐾 펫 수정하기</h2>

    <form action="pet_update_save" method="post" enctype="multipart/form-data" onsubmit="return confirm_update()">
      <input type="hidden" name="himage" value="${dto.pet_img}">
      <input type="hidden" name="pet_id" value="${dto.pet_id}">

      <div class="form-group">
        <label for="pet_name">이름</label>
        <input type="text" id="pet_name" name="pet_name" value="${dto.pet_name}" required>
      </div>

<div class="form-group">
  <label>성별</label>
  <div class="radio-group">
    <label>
      <input type="radio" name="pet_bog" value="수컷💙"
        ${dto.pet_bog eq '수컷💙' ? 'checked' : ''}> 수컷💙
    </label>
    <label>
      <input type="radio" name="pet_bog" value="암컷💛"
        ${dto.pet_bog eq '암컷💛' ? 'checked' : ''}> 암컷💛
    </label>
  </div>
</div>

<div class="form-group">
  <label>중성화</label>
  <div class="radio-group">
    <label>
      <input type="radio" name="pet_neuter" value="⭕"
        ${dto.pet_neuter eq '⭕' ? 'checked' : ''}> ⭕
    </label>
    <label>
      <input type="radio" name="pet_neuter" value="❌"
        ${dto.pet_neuter eq '❌' ? 'checked' : ''}> ❌
    </label>
  </div>
</div>

      <div class="form-group">
        <label for="pet_hbd">생일</label>
        <input type="date" id="pet_hbd" name="pet_hbd" value="${dto.pet_hbd}" required>
      </div>

      <div class="form-group">
        <label for="pet_img">사진</label>
        <input type="file" id="pet_img" name="pet_img">
      </div>

      <div class="form-actions">
        <input type="submit" value="💾 수정하기">
        <input type="reset" value="❌ 취소하기" onclick="history.back()">
      </div>
    </form>
  </div>

</body>
</html>