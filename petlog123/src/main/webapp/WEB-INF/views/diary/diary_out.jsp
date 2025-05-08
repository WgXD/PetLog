<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
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
</style>
</head>
<body>

<header><h2>일기 읽기 📔</h2></header>

<c:if test="${empty list}">
  <p style="margin-top: 20px; font-weight: bold; color: #c0392b;">작성한 일기가 없습니다. ✍️</p>
  <form action="diary_input" method="get" style="margin-top: 20px;">
  <input type="submit" value="일기 쓰러 가기"
         style="padding: 10px 20px; border-radius: 12px; background-color: #d7c9f3; 
         color: #5e478e; font-weight: bold; border: none; cursor: pointer;">
  </form>
</c:if>

<c:if test="${not empty list}">
  <table class="dotted-rounded-table">
    <tr>
      <th>글번호</th> <th>일기 제목</th> <th>날짜</th> <th>이미지</th> <th>일기 내용</th>
    </tr>

    <c:forEach items="${list}" var="di">
      <tr>
        <td>${di.diary_id}</td>
        <td><a href="diary_detail?diary_id=${di.diary_id}">${di.diary_title}</a></td>
        <td>${di.diary_date}</td>
        <td><img src="./image/${di.diary_image}" width="70px"></td>
        <td>${di.diary_content}</td>
      </tr>
    </c:forEach>
  </table>

  <br><br>
  <div class="pagination">
    <c:forEach var="i" begin="1" end="${page_count}">
      <a href="diary_out?page=${i}" class="${i == page ? 'current' : ''}">${i}</a>
    </c:forEach>
  </div>
</c:if>

</body>
</html>
