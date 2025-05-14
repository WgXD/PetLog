<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
  body {
    font-family: "Malgun Gothic", sans-serif;
    margin: 0;
    padding: 0;
  }

  .container {
    max-width: 500px;
    margin: 120px auto;
    padding: 40px;
    background-color: white;
    border-radius: 20px;
    box-shadow: 0 0 20px rgba(0,0,0,0.05);
    text-align: center;
  }

  h2 {
    margin-bottom: 30px;
    color: #333;
    font-size: 22px;
  }

  input[type="password"] {
    width: 90%;
    padding: 12px;
    border: 1px solid #ccc;
    border-radius: 8px;
    font-size: 15px;
    box-sizing: border-box;
  }

  button {
    margin-top: 25px;
    width: 90%;
    padding: 12px;
    background-color: #f9dada;
    border: none;
    border-radius: 10px;
    font-size: 15px;
    font-weight: bold;
    color: #333;
    cursor: pointer;
  }

  .error-msg {
    margin-top: 20px;
    color: red;
    font-weight: bold;
  }
</style>
</head>
<body>
  <div class="container">
    <h2>🔒 비밀번호를 다시 입력하세요</h2>

    <form action="pwcheck" method="post">
      <input type="password" name="currentPw" placeholder="현재 비밀번호 입력" required>
      <button type="submit">확인</button>
    </form>

    <c:if test="${not empty errorMsg}">
      <p class="error-msg">${errorMsg}</p>
    </c:if>
  </div>
  
<!-- 비밀번호 일치 검사 -->
<script>
function checkPasswordMatch() {
  const pw = document.getElementById("password").value;
  const cpw = document.getElementById("confirm_password").value;
  const msg = document.getElementById("pw-message");

  if (pw !== cpw) {
    msg.textContent = "비밀번호가 일치하지 않습니다.";
  } else {
    msg.textContent = "";
  }
}

function validateForm() {
  const pw = document.getElementById("password").value;
  const cpw = document.getElementById("confirm_password").value;

  if (pw !== cpw) {
    alert("비밀번호가 일치하지 않습니다.");
    return false;
  }
  return true;
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
