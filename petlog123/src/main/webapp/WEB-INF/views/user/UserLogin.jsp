<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style>
/* 전체 로그인 박스 스타일 */
.login-wrapper {
  max-width: 360px;
  width: 90%;
  margin: 50px auto;
  background-color: #ffffff;
  padding: 30px 24px;
  border-radius: 16px;
  box-shadow: 0 6px 18px rgba(0, 0, 0, 0.05);
}
/* 제목 스타일 */
.login-wrapper h2 {
  text-align: center;
  margin-bottom: 30px;
  font-size: 22px;
  color: #3e312b;
}
/* 입력 그룹 */
.form-group {
  margin-bottom: 20px;
}
/* 라벨 */
label {
  display: block;
  margin-bottom: 6px;
  font-size: 14px;
  color: #5c5147;
  font-weight: 500;
}
/* input */
input[type="text"],
input[type="password"] {
  width: 100%;
  padding: 10px;
  font-size: 13px;
  border: 1px solid #d8d2cc;
  border-radius: 8px;
  box-sizing: border-box;
}
/* 입력창 포커스 효과 */
input[type="text"]:focus,
input[type="password"]:focus {
  outline: none;
  border-color: #b89b86;
}

/* 버튼 그룹 */
.button-group {
  display: flex;
  justify-content: space-between;
  margin-top: 25px;
}
/* 로그인/취소 버튼 */
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
/* 버튼 hover 효과 */
.button-group input:hover {
  background-color: #f3b3b2;
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
<!--  -->


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
</div>
</body>
</html>
