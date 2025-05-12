<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>퀴즈 결과</title>
<style>
  body {
    font-family: 'Malgun Gothic', sans-serif;
    margin: 0;
    padding: 0;
    text-align: center;
  }

  h3 {
    font-size: 20px;
    color: #444;
    margin: 40px 0 15px;
  }

  .info {
    font-size: 18px;
    color: #555;
    margin: 10px 0;
  }

  .info strong {
    font-size: 20px;
    color: #222;
  }

  table {
    width: 90%;
    max-width: 600px;
    margin: 0 auto 40px auto;
    background-color: #fff;
    border-radius: 14px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.06);
    border-collapse: collapse;
    overflow: hidden;
  }

  th, td {
    padding: 14px;
    border-bottom: 1px solid #eee;
    font-size: 15px;
  }

  th {
    background-color: #fdf1f6;
    color: #444;
  }

  tr:last-child td {
    border-bottom: none;
  }

  .btn-next {
    background-color: #ffe5ec;
    color: #333;
    font-size: 16px;
    font-weight: bold;
    padding: 12px 30px;
    border: none;
    border-radius: 30px;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 4px 10px rgba(0,0,0,0.05);
  }

  .btn-next:hover {
    background-color: #ffdce6;
    transform: scale(1.05);
  }
</style>
</head>
<body>

<script>
  window.onload = function() {
    const isCorrect = "${isCorrect}";
    if (isCorrect === "true") {
      alert("🎉 정답입니다! 포도알 3개 획득!");
    } else {
      alert("❌ 오답입니다. 다음에 다시 도전해주세요!");
    }
  }
</script>

<c:choose>
  <c:when test="${isCorrect}">
    <p class="info">⌛ <strong>${redto.result_time}초 만에 풀었어요!</strong></p>
    <p class="info">🏅 현재 순위: <strong>${redto.result_rank}위</strong></p>
  </c:when>
  <c:otherwise>
    <p class="info">정답은 
      <strong>
        ${quiz.quiz_answer}번 - 
        <c:choose>
          <c:when test="${quiz.quiz_answer == '1'}">${quiz.quiz_option1}</c:when>
          <c:when test="${quiz.quiz_answer == '2'}">${quiz.quiz_option2}</c:when>
          <c:when test="${quiz.quiz_answer == '3'}">${quiz.quiz_option3}</c:when>
          <c:when test="${quiz.quiz_answer == '4'}">${quiz.quiz_option4}</c:when>
        </c:choose>
      </strong>
      입니다.
    </p>
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
    <c:choose>
      <c:when test="${row.result_rank == 1}">
        <tr class="rank-gold">
          <td>🥇 ${row.result_rank}위</td>
          <td>${row.user_login_id}</td>
          <td>${row.result_time}초</td>
        </tr>
      </c:when>
      <c:when test="${row.result_rank == 2}">
        <tr class="rank-silver">
          <td>🥈 ${row.result_rank}위</td>
          <td>${row.user_login_id}</td>
          <td>${row.result_time}초</td>
        </tr>
      </c:when>
      <c:when test="${row.result_rank == 3}">
        <tr class="rank-bronze">
          <td>🥉 ${row.result_rank}위</td>
          <td>${row.user_login_id}</td>
          <td>${row.result_time}초</td>
        </tr>
      </c:when>
      <c:otherwise>
        <tr>
          <td>${row.result_rank}위</td>
          <td>${row.user_login_id}</td>
          <td>${row.result_time}초</td>
        </tr>
      </c:otherwise>
    </c:choose>
  </c:forEach>
</table>

<a href="./QuizInput" class="btn-next">다음 문제 풀기 ➡</a>

</body>
</html>