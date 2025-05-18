<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    font-family: 'Pretendard', sans-serif;
    color: #333;
  }
  .table-wrapper {
    background-color: white;
    width: 100%;
    max-width: 1000px;
    margin: 40px auto 80px auto;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    padding: 30px;
  }
  table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 10px;
    background-color: #fff;
    box-shadow: 0 4px 8px rgba(0,0,0,0.05);
    border-radius: 8px;
    overflow: hidden;
  }
  caption {
    font-size: 1.8em;
    font-weight: normal;
    color: #f48aa5;
    margin-bottom: 20px;
    text-align: center;
  }
  th, td {
    padding: 14px 12px;
    font-size: 1em;
    border-bottom: 1px solid #eee;
    text-align: center;
  }
  th {
    background-color: #fff0f4;
    color: #555;
    font-weight: bold;
  }
  td a {
    color: #333;
    text-decoration: none;
    font-weight: 500;
  }
  td a:hover {
    color: #d65b7b;
    text-decoration: underline;
  }
  .btn-wrap {
    width: 90%;
    max-width: 1000px;
    margin: 0 auto 20px;
    text-align: right;
  }
  .btn-wrap button {
    background-color: #ffe1e1;
    color: #444;
    border: none;
    border-radius: 6px;
    padding: 10px 18px;
    font-size: 1em;
    cursor: pointer;
    transition: background-color 0.3s;
  }
  .btn-wrap button:hover {
    background-color: #ffd2d2;
  }
  .pagination {
    width: 100%;
    text-align: center;
    margin: 40px 0;
  }
  .pagination a {
    margin: 0 6px;
    padding: 6px 12px;
    color: #888;
    text-decoration: none;
    border-radius: 4px;
    font-weight: bold;
    transition: background-color 0.2s;
    background-color: #f2e9ff;
  }
  .pagination a.current {
    background-color: #db7093;
    color: #fff;
  }
  .pagination a:hover {
    background-color: #ffe1e1;
  }
</style>
</head>
<body>

<c:if test="${not empty msg}">
  <script>alert('${msg}');</script>
</c:if>

<div class="table-wrapper">
  <table>
    <caption>🎈멍냥 리스트</caption>
    
<div class="btn-wrap">
  <c:if test="${sessionScope.user_role eq 'admin'}">
    <button type="button" onclick="location.href='QuizInsertPage'">➕퀴즈 등록</button>
  </c:if>
</div>

    <thead>
      <tr>
        <th style="width:5%;">No.</th>
        <th style="width:45%;">문제</th>
        <th style="width:30%;">보기</th>
        <th style="width:5%;">정답</th>
        <th style="width:20%;">관리</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="dto" items="${list}">
      <tr>
        <td>${dto.quiz_id}</td>
        <td>${dto.quiz_question}</td>
        <td>
          <c:forEach var="opt" items="${optionFields}" varStatus="i">
            <c:set var="value" value="${dto[opt]}" />
            <c:choose>
              <c:when test="${value eq dto.quiz_answer}">
                <b>${i.index + 1}. ${value}</b><br/>
              </c:when>
              <c:otherwise>
                ${i.index + 1}. ${value}<br/>
              </c:otherwise>
            </c:choose>
          </c:forEach>
        </td>
        <td>${dto.quiz_answer}</td>
        <td>
          <a href="quiz_admin/edit/${dto.quiz_id}">수정</a> |
          <a href="quiz_admin/delete/${dto.quiz_id}" onclick="return confirm('삭제할까요?')">삭제</a>
        </td>
      </tr>
      </c:forEach>
    </tbody>
  </table>

  <div class="pagination">
    <c:forEach var="i" begin="1" end="${page_count}">
      <a href="Quiz_admin?page=${i}" class="${i == page ? 'current' : ''}">${i}</a>
    </c:forEach>
  </div>
</div>
</body>
</html>
