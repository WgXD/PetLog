<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style>
/* 기존 스타일 유지 */
.login-wrapper {
  max-width: 360px;
  width: 90%;
  margin: 50px auto;
  background-color: #ffffff;
  padding: 30px 24px;
  border-radius: 16px;
  box-shadow: 0 6px 18px rgba(0, 0, 0, 0.05);
}
.login-wrapper h2 {
  text-align: center;
  margin-bottom: 30px;
  font-size: 22px;
  color: #3e312b;
}
.form-group {
  margin-bottom: 20px;
}
label {
  display: block;
  margin-bottom: 6px;
  font-size: 14px;
  color: #5c5147;
  font-weight: 500;
}
input[type="text"],
input[type="password"] {
  width: 100%;
  padding: 10px;
  font-size: 13px;
  border: 1px solid #d8d2cc;
  border-radius: 8px;
  box-sizing: border-box;
}
input[type="text"]:focus,
input[type="password"]:focus {
  outline: none;
  border-color: #b89b86;
}
.button-group {
  display: flex;
  justify-content: space-between;
  margin-top: 25px;
}
.button-group input {
  width: 48%;
  padding: 10px 0;
  font-size: 14px;
  border: none;
  border-radius: 8px;
  background-color: #f7cac9;
  color: #5c5147;
  cursor: pointer;
  transition: background-color 0.3s;
}
.button-group input:hover {
  background-color: #f3b3b2;
}

/* 아이디/비밀번호 찾기 링크 스타일 */
.login-footer {
  text-align: center;
  margin-top: 20px;
}
.login-footer a {
  font-size: 13px;
  color: #5c5147;
  text-decoration: none;
  margin: 0 10px;
}
.login-footer a:hover {
  text-decoration: underline;
}
</style>
</head>
<body>

<!-- 비회원 : 로그인 하세요! 알람 추가! dasom -->
<c:if test="${param.error == 'login_required'}">
  <script>
    alert("로그인 하세요!");
  </script>
</c:if>

<div class="login-wrapper">
  <h2>로그인</h2>
  <form action="LoginSave" method="post">
    <div class="form-group">
      <label for="user_login_id">아이디</label>
      <input type="text" id="user_login_id" name="user_login_id" placeholder="아이디를 입력하세요." required>
    </div>
    <div class="form-group">
      <label for="password">비밀번호</label>
      <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요." required>
    </div>
    <div class="button-group">
      <input type="submit" value="로그인">
      <input type="reset" value="취소">
    </div>
  </form>

  <!-- 아이디/비번 찾기 버튼 -->
  <div class="login-footer">
    <a href="findIdPage">아이디 찾기</a> |
    <a href="findPwPage">비밀번호 찾기</a>
  </div>
</div>
</body>
</html>
