<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">

<style>
  body {
    font-family: "Apple SD Gothic Neo", "Malgun Gothic", sans-serif;
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

  caption {
    font-size: 1.8em;
    font-weight: bold;
    color: #db7093;
    margin-bottom: 20px;
  }

  table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 10px;
  }

  th, td {
    padding: 12px;
    font-size: 1em;
    border-bottom: 1px solid #eee;
    text-align: center;
  }

  th {
    background-color: #fff0f4;
    color: #555;
    font-weight: 600;
  }

  .rank-number {
    font-weight: bold;
    color: #5e478e;
  }

  .grape-count {
    color: #8e44ad;
    font-weight: bold;
  }
</style>
</head>
<body>

<div class="table-wrapper">

  <caption>🍇 전체 회원 포도알 랭킹 (내림차순)</caption>

  <table>
    <thead>
      <tr>
        <th>순위</th>
        <th>회원 ID</th>
        <th>회원번호</th>
        <th>포도알 수</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="user" items="${list}" varStatus="status">
        <tr>
          <td class="rank-number">${status.index + 1}</td>
          <td>${user.user_login_id}</td>
          <td>${user.user_id}</td>
          <td class="grape-count">${user.grape_count}개</td>
        </tr>
      </c:forEach>
    </tbody>
  </table>

</div>

</body>
</html>