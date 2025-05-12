<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>펫 정보 수정하기 🐾</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      color: #333;
    }

    .container {
      max-width: 900px;
      margin: 100px auto 80px auto;
      background: #fff;
      padding: 50px 60px;
      border-radius: 14px;
      box-shadow: 0 4px 18px rgba(0, 0, 0, 0.06);
      border: 1px solid #e2d6ee;
    }

    h2 {
      text-align: center;
      font-size: 28px;
      color: #5e478e;
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
      border-color: #b3a1dc;
      outline: none;
    }

	.radio-group {
	  display: flex;
	  align-items: center;
	  gap: 30px;
	  width: 100%;
	  
	}

    .radio-group label {
      display: flex;
	  align-items: center;
	  gap: 6px;
    }

    .form-actions {
      text-align: center;
      margin-top: 40px;
    }

    input[type="submit"],
    input[type="reset"] {
      background-color: #d7c9f3;
      color: #5e478e;
      border: none;
      padding: 12px 30px;
      border-radius: 24px;
      font-size: 15px;
      font-weight: bold;
      margin: 0 12px;
      cursor: pointer;
      transition: background-color 0.3s ease, transform 0.2s ease;
      box-shadow: 2px 2px 5px rgba(100, 80, 160, 0.2);
    }

    input[type="submit"]:hover,
    input[type="reset"]:hover {
      background-color: #e8defc;
      transform: scale(1.05);
    }

    input[type="submit"]:active,
    input[type="reset"]:active {
      transform: scale(0.95);
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

  <script type="text/javascript">
    function confirm_update() {
      return confirm("정말 수정하시겠습니까? 😊");
    }
  </script>
</head>
<body>

  <div class="container">
    <h2>펫 정보 수정하기 🐾</h2>

    <form action="pet_update_save" method="post" enctype="multipart/form-data" onsubmit="return confirm_update()">

      <input type="hidden" name="himage" value="${dto.pet_img}">
      <input type="hidden" name="pet_id" value="${dto.pet_id}">

      <div class="form-group">
        <label for="pet_name">이름</label>
        <input type="text" id="pet_name" name="pet_name" value="${dto.pet_name}">
      </div>

      <div class="form-group">
        <label>성별</label>
        <div class="radio-group">
          <label><input type="radio" name="pet_bog" value="수컷💙"> 수컷💙</label>
          <label><input type="radio" name="pet_bog" value="암컷💛"> 암컷💛</label>
        </div>
      </div>

      <div class="form-group">
        <label>중성화</label>
        <div class="radio-group">
          <label><input type="radio" name="pet_neuter" value="⭕"> ⭕</label>
          <label><input type="radio" name="pet_neuter" value="❌"> ❌</label>
        </div>
      </div>

      <div class="form-group">
        <label for="pet_hbd">생일</label>
        <input type="date" id="pet_hbd" name="pet_hbd" value="${dto.pet_hbd}">
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
