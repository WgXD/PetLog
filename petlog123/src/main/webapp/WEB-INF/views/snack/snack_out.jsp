<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 보기</title>
<%
    com.mbc.pet.user.UserDTO loginUser = (com.mbc.pet.user.UserDTO) session.getAttribute("loginUser");
    if (loginUser == null) {
        response.sendRedirect(request.getContextPath() + "/login?error=login_required");
        return;
    }
%>
<style>
  .dotted-rounded-table {
    border-collapse: separate;
    border: 2px dotted #aaa;
    border-radius: 16px;
    overflow: hidden;
    background-color: #fff;
    margin: 0 auto;
    box-shadow: 2px 2px 10px rgba(0,0,0,0.1);
  }

  .dotted-rounded-table td,
  .dotted-rounded-table th {
    border: 1px dotted #ccc;
    padding: 12px 16px;
    font-size: 14px;
  }

  .pagination {
    margin-top: 20px;
    text-align: center;
  }

  .pagination a {
    display: inline-block;
    margin: 0 5px;
    padding: 8px 12px;
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

  .btn {
    margin-top: 20px;
    background-color: #d7c9f3;
    color: #5e478e;
    border: none;
    padding: 10px 20px;
    border-radius: 24px;
    font-weight: bold;
    cursor: pointer;
    text-decoration: none;
    display: inline-block;
  }

  .btn:hover {
    background-color: #e8defc;
  }
</style>
</head>
<body>

<header><h2>레시피 보기🍬</h2></header>

<c:if test="${empty list}">
  <p style="margin-top: 20px; font-weight: bold; color: #c0392b;">작성된 레시피가 없습니다. 🍪</p>
  <a href="snack_input" class="btn">레시피 작성하러 가기 ✍️</a>
</c:if>

<c:if test="${not empty list}">
  <table class="dotted-rounded-table">
    <tr>
      <th>No.</th> <th>레시피명</th> <th>레시피</th> <th>이미지</th> <th>게시일</th>
    </tr>
    <c:forEach items="${list}" var="rec">
      <tr>
        <td>${rec.snack_id}</td>
        <td><a href="snack_detail?dnum=${rec.snack_id}">${rec.snack_title}</a></td>
        <td>${rec.snack_recipe}</td>
        <td><img src="./image/${rec.snack_image}" width="120px"></td>
        <td>${rec.snack_date}</td>
      </tr>
    </c:forEach>
  </table>
  
<a href="snack_input" class="btn">레시피 작성하러 가기 ✍️</a>
<br><br>

  <div class="pagination">
    <c:forEach var="i" begin="1" end="${page_count}">
      <a href="snack_out?page=${i}" class="${i == page ? 'current' : ''}">${i}</a>
    </c:forEach>
  </div>

</c:if>

</body>
</html>