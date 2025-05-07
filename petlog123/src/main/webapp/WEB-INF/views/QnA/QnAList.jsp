<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 목록</title>
<style>
  body {
    font-family: "Apple SD Gothic Neo", "Malgun Gothic", sans-serif;
    background-color: #ffffff;
    margin: 0;
    padding: 30px 0;
    text-align: center;
  }
  h2 {
    margin-bottom: 30px;
    color: #444;
  }
  table {
    width: 80%;
    margin: 0 auto;
    border-collapse: collapse;
    background-color: #fff;
    box-shadow: 0 0 10px rgba(0,0,0,0.05);
  }
  th, td {
    padding: 14px 12px;
    border-bottom: 1px solid #eee;
    font-size: 15px;
    text-align: center;
  }
  th {
    background-color: #f9f9f9;
    color: #444;
  }
  td a {
    color: #555;
    text-decoration: none;
  }
  td a:hover {
    text-decoration: underline;
    color: #4a90e2;
  }
  tr:hover {
    background-color: #fafafa;
  }
  .btn-write {
    padding: 10px 20px;
    background-color: #d0e8ff;
    color: #333;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    margin-bottom: 25px;
    transition: background-color 0.3s;
  }
  .btn-write:hover {
    background-color: #a6d1f5;
  }
</style>
</head>
<body>

<h2>QnA 목록</h2>

<button class="btn-write" onclick="location.href='QnAinput'">새 문의글 작성</button>

<table>
  <tr>
    <th>번호</th>
    <th>작성자</th>
    <th>제목</th>
    <th>작성일</th>
    <th>상태</th>
  </tr>

  <c:forEach items="${list}" var="dto">
    <tr>
      <td>${dto.qna_id}</td>
      <td>${dto.user_login_id}</td>
      <td><a href="qnadetail?qnum=${dto.qna_id}">${dto.qna_title}</a></td>
      <td>${dto.qna_date}</td>
      <td>${dto.qna_status}</td>
    </tr>
  </c:forEach>
</table>
<c:if test="${not empty requestScope.alertMsg}">
  <script>
    alert("${requestScope.alertMsg}");
  </script>
</c:if>


<!-- 페이징 -->
<div class="pagination">
  <c:forEach var="i" begin="1" end="${page_count}">
    <a href="QnAList?page=${i}" class="${i == page ? 'current' : ''}">${i}</a>
  </c:forEach>
</div>
</body>
</html>