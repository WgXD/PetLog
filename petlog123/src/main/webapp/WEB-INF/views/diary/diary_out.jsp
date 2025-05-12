<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>일기 보기</title>

<%
    com.mbc.pet.user.UserDTO loginUser = (com.mbc.pet.user.UserDTO) session.getAttribute("loginUser");
    if (loginUser == null) {
        response.sendRedirect(request.getContextPath() + "/login?error=login_required");
        return;
    }
%>

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
    max-width: 1000px;
    margin: 40px auto 80px auto;
    background-color: #fff;
    border-radius: 16px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    padding: 30px;
  }

  table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 10px;
  }

  caption {
    font-size: 1.8em;
    font-weight: bold;
    color: #db7093;
    margin-bottom: 20px;
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
    font-weight: 600;
  }

  td img {
    max-width: 70px;
    height: auto;
  }

  td a {
    color: #333;
    text-decoration: none;
    font-weight: 500;
  }

  td a:hover {
    color: #db7093;
    text-decoration: underline;
  }

  .btn {
    margin-top: 30px;
    background-color: #ffe1e1;
    color: #444;
    border: none;
    padding: 10px 24px;
    border-radius: 24px;
    font-weight: bold;
    cursor: pointer;
    text-decoration: none;
    display: inline-block;
  }

  .btn:hover {
    background-color: #ffd2d2;
  }

  .pagination {
    margin-top: 30px;
    text-align: center;
  }

  .pagination a {
    display: inline-block;
    margin: 0 5px;
    padding: 8px 14px;
    background-color: #f2e9ff;
    color: #5e478e;
    border-radius: 10px;
    text-decoration: none;
    font-weight: bold;
    transition: background-color 0.2s;
  }

  .pagination a:hover {
    background-color: #e0d2f7;
  }

  .pagination a.current {
    background-color: #d7c9f3;
    color: white;
  }

  .no-diary {
    color: #c0392b;
    font-weight: bold;
    padding: 20px 0;
  }

</style>
</head>
<body>

<div class="table-wrapper">

  <caption>📔 나의 일기 보기</caption>
  <c:if test="${empty list}">
    <p class="no-diary">작성한 일기가 없습니다. ✍️</p>
    <a href="diary_input" class="btn">일기 쓰러 가기 ✍️</a>
  </c:if>

  <c:if test="${not empty list}">
  <div style="text-align: right; margin-bottom: 10px;">
  <a href="diary_input" class="btn">일기 쓰러 가기 </a>
  </div>
    <table>
      <thead>
        <tr>
          <th>글번호</th>
          <th>이름</th>
          <th>일기 제목</th>
          <th>날짜</th>
          <th>이미지</th>
          <th>일기 내용</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach items="${list}" var="di">
          <tr>
            <td>${di.diary_id}</td>
            <td>${di.pet_name}</td>
            <td><a href="diary_detail?diary_id=${di.diary_id}">${di.diary_title}</a></td>
            <td>${di.diary_date}</td>
            <td><img src="./image/${di.diary_image}" alt="일기 이미지"></td>
            <td>${di.diary_content}</td>
          </tr>
        </c:forEach>
      </tbody>
    </table>

    <div class="pagination">
      <c:forEach var="i" begin="1" end="${page_count}">
        <a href="diary_out?page=${i}" class="${i == page ? 'current' : ''}">${i}</a>
      </c:forEach>
    </div>
  </c:if>

</div>

</body>
</html>