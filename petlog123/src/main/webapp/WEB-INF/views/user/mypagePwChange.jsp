<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
<style>
  body {
    font-family: "Malgun Gothic", sans-serif;
    margin: 0;
    padding: 0;
  }

  .container {
    max-width: 600px;
    margin: 100px auto;
    padding: 40px;
    background-color: white;
    border-radius: 20px;
    box-shadow: 0 0 20px rgba(0,0,0,0.05);
    text-align: center;
  }

  h2 {
    margin-bottom: 30px;
    color: #333;
    font-size: 24px;
  }

  .input-group {
    text-align: left;
    width: 100%;
    margin-bottom: 20px;
    padding: 0 5%;
  }

  .input-group label {
    font-weight: bold;
    margin-bottom: 8px;
    display: block;
    font-size: 15px;
    color: #333;
  }

  .input-group input {
    width: 90%;
    padding: 12px;
    border: 1px solid #ccc;
    border-radius: 8px;
    font-size: 14px;
    box-sizing: border-box;
  }

  .btn-group {
    display: flex;
    justify-content: center;
    gap: 15px;
    margin-top: 25px;
  }

  .btn {
    flex: 1;
    max-width: 200px;
    padding: 12px;
    background-color: #f9dada;
    border: none;
    border-radius: 10px;
    font-size: 15px;
    font-weight: bold;
    color: #333;
    cursor: pointer;
  }

  #pwChangeResult {
    margin-top: 15px;
    font-weight: bold;
    font-size: 14px;
  }
</style>
</head>
<body>
  <div class="container">
    <h2>👩 비밀번호 변경하기</h2>
    <form id="pwChangeForm">
      <div class="input-group">
        <label for="newPw">새 비밀번호</label>
        <input type="password" id="newPw" name="newPw" required>
      </div>

      <div class="input-group">
        <label for="newPwCheck">새 비밀번호 확인</label>
        <input type="password" id="newPwCheck" name="newPwCheck" required>
      </div>

      <div id="pwChangeResult"></div>

      <div class="btn-group">
        <button type="button" class="btn" onclick="changePassword()">비밀번호 변경</button>
        <button type="button" class="btn"  onclick="location.href='./mypage'">취소</button>
      </div>
    </form>
  </div>

  <script type="text/javascript">
    function changePassword() {
      const newPw = $("#newPw").val();
      const newPwCheck = $("#newPwCheck").val();
      const resultBox = $("#pwChangeResult");

      resultBox.text("");

      if (!newPw || !newPwCheck) {
        resultBox.text("비밀번호를 모두 입력해주세요.").css("color", "red");
        return;
      }

      if (newPw !== newPwCheck) {
        resultBox.text("❌ 새 비밀번호가 일치하지 않습니다.").css("color", "red");
        return;
      }

      if (!confirm("정말 비밀번호를 변경하시겠습니까?")) {
        return;
      }

      $.ajax({
        type: "post",
        url: "pwupdate",
        data: { newPw: newPw },
        success: function(data) {
          if (data === "ok") {
            resultBox.text("✅ 비밀번호가 성공적으로 변경되었습니다.").css("color", "green");
            setTimeout(() => location.href = "mypage", 1500);
          } else {
            resultBox.text(data).css("color", "red");
          }
        },
        error: function() {
          resultBox.text("❌ 오류가 발생했습니다.").css("color", "red");
        }
      });
    }
  </script>

<!-- 비밀번호 숫자, 문자 조합 8자 이상 -->
<script>
  function validateForm() {
    const pw = document.getElementById("password").value;
    const cpw = document.getElementById("confirm_password").value;

    const pattern = /^(?=.*[a-zA-Z])(?=.*\d).{8,}$/;
    if (!pattern.test(pw)) {
      alert("비밀번호는 영문 + 숫자 조합으로 8자 이상이어야 합니다.");
      return false;
    }

    if (pw !== cpw) {
      alert("비밀번호가 일치하지 않습니다.");
      return false;
    }

    return true;
  }
</script>
  
</body>
</html>
