<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="utf-8">
<head>
<meta charset="UTF-8">

<style>
  body {
    background-color: #fefefe;
    margin: 0;
    padding: 0;
    color: #333;
    text-align: center;
  }

  .table-wrapper {
    width: 90%;
    max-width: 600px;
    margin: 0 auto;
    background-color: #fff;
    border-radius: 16px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
    padding: 40px;
  }

  h2 {
    font-size: 24px;
    color: #db7093;
    margin-bottom: 30px;
  }

  label {
    display: block;
    text-align: left;
    font-weight: bold;
    margin: 16px 0 6px 0;
    font-size: 15px;
  }

  select, input[type="number"] {
    width: 100%;
    padding: 10px 12px;
    font-size: 15px;
    border: 1px solid #ccc;
    border-radius: 8px;
    box-sizing: border-box;
  }

  .message {
    color: green;
    font-weight: bold;
    margin-bottom: 20px;
  }

  .form-actions {
    margin-top: 30px;
  }

  input[type="submit"] {
    background-color: #ffe1e1;
    color: #444;
    border: none;
    padding: 10px 24px;
    border-radius: 24px;
    font-weight: bold;
    font-size: 15px;
    cursor: pointer;
    margin: 0 10px;
    transition: background-color 0.3s;
  }

  input[type="submit"]:hover {
    background-color: #ffd2d2;
  }
</style>
</head>
<body>

<div class="table-wrapper">

  <h2>🍇 포도알 관리</h2>

  <c:if test="${not empty message}">
    <p class="message">${message}</p>
  </c:if>

  <form action="${pageContext.request.contextPath}/point/grapes_admin" method="post">
    <label for="user_id1">회원 선택</label>
    <select name="user_id1" id="user_id1" required>
      <option value="">-- 선택하세요 --</option>
      <c:forEach var="user" items="${list}">
        <option value="${user.user_id}">
          ${user.user_login_id} (ID: ${user.user_id}, 🍇: ${user.grape_count}개)
        </option>
      </c:forEach>
    </select>

    <label for="grape_amount">포도알 수 (EX. 1 = 지급, -1 = 차감)</label>
    <input type="number" id="grape_amount" name="grape_amount" required>

    <div class="form-actions">
      <input type="submit" value="적용">
    </div>
  </form>
	
	<form action="${pageContext.request.contextPath}/point/grapes_rank" method="get" style="margin-top: 20px; text-align: right;">
	  <input type="submit" value="회원별 포도알 보기 🍇" class="grape-rank-btn">
	</form>

</div>

</body>
</html>