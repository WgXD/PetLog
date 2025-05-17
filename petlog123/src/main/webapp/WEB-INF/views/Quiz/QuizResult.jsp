<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">

  <style>
    body {
      background-color: #fff6f6;
      margin: 0;
      padding: 0;
      text-align: center;
      color: #333;
    }

    h3 {
      font-size: 22px;
      color: #f48aa5;
      margin-top: 40px;
      margin-bottom: 20px;
      font-weight: normal;
    }

    .info {
      font-size: 17px;
      color: #555;
      margin: 12px 0;
    }

    .info strong {
      font-size: 19px;
      color: #d65b7b;
    }

    table {
      width: 90%;
      max-width: 600px;
      margin: 20px auto 50px auto;
      background-color: #fff;
      border-radius: 16px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.08);
      border-collapse: collapse;
      overflow: hidden;
    }

    th, td {
      padding: 14px;
      font-size: 15px;
      border-bottom: 1px solid #eee;
    }

    th {
      background-color: #fff0f4;
      color: #555;
      font-weight: bold;
      text-align: center;
    }

    tr:last-child td {
      border-bottom: none;
    }

    .rank-gold td {
      background-color: #fff9db;
      font-weight: bold;
      color: #caa700;
    }

    .rank-silver td {
      background-color: #f1f1f1;
      font-weight: bold;
      color: #888;
    }

    .rank-bronze td {
      background-color: #fce8dd;
      font-weight: bold;
      color: #b56f44;
    }

    .btn-next {
      background-color: #ffe1e1;
      color: #333;
      font-size: 16px;
      font-weight: 500;
      padding: 12px 28px;
      border: none;
      border-radius: 12px;
      cursor: pointer;
      text-decoration: none;
      box-shadow: 0 4px 8px rgba(0,0,0,0.05);
      transition: background-color 0.3s ease, transform 0.2s ease;
      display: inline-block;
      margin-bottom: 60px;
    }

    .btn-next:hover {
      background-color: #ffd2d2;
      transform: scale(1.05);
    }
    
    .result-box {
  background-color: white;
  width: 100%;
  max-width: 600px;
  margin: 40px auto 20px auto;
  border-radius: 16px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.08);
  padding: 30px;
}

.result-wrapper {
  background-color: white;
  width: 95%;
  max-width: 700px;
  margin: 40px auto 60px auto;
  border-radius: 20px;
  box-shadow: 0 4px 16px rgba(0,0,0,0.06);
  padding: 40px 30px;
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

<div class="result-wrapper">
  <div class="result-box">
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
        </strong> 입니다.
      </p>
    </c:otherwise>
  </c:choose>
</div>

<!-- ✅ 정답/오답 상관없이 항상 출력되는 TOP10 -->
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
</div>


</body>
</html>