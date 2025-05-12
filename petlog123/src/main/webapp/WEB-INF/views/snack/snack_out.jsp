<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>레시피 보기</title>

<%
	Integer userId = (Integer) session.getAttribute("user_id");
	if (userId == null) {
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
    margin: 0 auto;
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
    max-width: 120px;
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

  .no-recipe {
    color: #c0392b;
    font-weight: bold;
    padding: 20px 0;
  }

</style>
</head>
<body>

<div class="table-wrapper">

  <caption>🍩 수제 간식 레시피 보기</caption>

  <c:if test="${empty list}">
    <p class="no-recipe">작성된 레시피가 없습니다. 🍪</p>
    <a href="snack_input" class="btn">레시피 작성하러 가기 ✍️</a>
  </c:if>

  <c:if test="${not empty list}">  <br>  
  <div style="text-align: right; margin-bottom: 10px;">
  <a href="snack_input" class="btn">레시피 작성하러 가기 ✍️</a>
  </div>
    <table>
      <thead>
        <tr>
          <th>No.</th>
          <th>레시피명</th>
          <th>레시피</th>
          <th>이미지</th>
          <th>작성자</th>
          <th>게시일</th>
          <th>조회수</th>
          <th>댓글</th>
          <th>좋아요</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach items="${list}" var="rec">
          <tr>
            <td>${rec.snack_id}</td>
            <td><a href="snack_detail?dnum=${rec.snack_id}">${rec.snack_title}</a></td>
            <td>${rec.snack_recipe}</td>
            <td><img src="./image/${rec.snack_image}" alt="레시피 이미지"></td>
            <td>${rec.user_login_id}</td>
            <td>${rec.snack_date}</td>
            <td>${rec.snack_readcnt}</td>
            <td>${rec.comment_count}</td>
      		<td>${rec.like_count}</td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
    <div class="pagination">
      <c:forEach var="i" begin="1" end="${page_count}">
        <a href="snack_out?page=${i}" class="${i == page ? 'current' : ''}">${i}</a>
      </c:forEach>
    </div>
  </c:if>

</div>

</body>
</html>