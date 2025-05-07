<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quiz Result</title>
<style>
  body {
    font-family: 'Arial', sans-serif;
    text-align: center;
    padding: 60px 20px;
    background-color: #fff;
    color: #222;
  }

  h1 {
    font-size: 3rem;
    margin-bottom: 40px;
    font-weight: 700;
  }

  .result-text {
    font-size: 2.4rem;
    font-weight: bold;
    margin-bottom: 25px;
    color: #d32f2f;
  }

  .result-text.correct {
    color: #388e3c;
  }

  .info {
    font-size: 1.8rem;
    margin-bottom: 12px;
  }

  h3 {
    font-size: 2rem;
    margin-top: 60px;
    color: #6d4c41;
  }

  table {
    margin: 40px auto 30px;
    width: 90%;
    max-width: 650px;
    border-collapse: collapse;
    font-size: 1.5rem;
    box-shadow: 0 2px 6px rgba(0,0,0,0.05);
  }

  th, td {
    padding: 18px 20px;
    border-bottom: 1px solid #eee;
  }

  th {
    background-color: #f9f9f9;
    font-weight: bold;
    color: #444;
  }

  tr:nth-child(even) {
    background-color: #fafafa;
  }

  .btn-next {
    display: inline-block;
    margin-top: 50px;
    padding: 16px 40px;
    font-size: 1.6rem;
    background-color: #ffcc80;
    color: #4e342e;
    border-radius: 12px;
    text-decoration: none;
    font-weight: bold;
    transition: background-color 0.3s ease;
  }

  .btn-next:hover {
    background-color: #ffb74d;
  }
</style>
</head>
<body>

<h1>퀴즈 결과</h1>

<c:choose>
  <c:when test="${isCorrect}">
    <p class="result-text correct">🎉 정답입니다! 포도알 10개 획득 🎉</p>
    <p class="info">풀이 시간: <strong>${redto.result_time}초</strong></p>
    <p class="info">현재 순위: <strong>${redto.result_rank}위</strong></p>
  </c:when>
  <c:otherwise>
    <p class="result-text">😮 오답입니다. 다음에 다시 도전!</p>
  </c:otherwise>
</c:choose>

<h3>🏆 TOP 10</h3>

<table>
  <tr>
    <th>순위</th>
    <th>유저</th>
    <th>풀이시간</th>
  </tr>
  <c:forEach items="${top10}" var="row">
    <tr>
      <td>${row.result_rank}위</td>
      <td>${row.user_login_id}</td>
      <td>${row.result_time}초</td>
    </tr>
  </c:forEach>
</table>

<a href="./QuizInput" class="btn-next">다음 문제 풀기 ➡</a>

</body>
</html>
