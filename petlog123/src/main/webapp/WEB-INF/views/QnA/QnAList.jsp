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
    padding: 0;
    text-align: center;
  }
  h2 {
    margin-bottom: 30px;
    color: #444;
  }
  table {
    width: 100%;
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
    background-color: #ffe1e1;
    color: #333;
    border: none;
    border-radius: 10px;
    cursor: pointer;
    font-size: 14px;
    margin-bottom: 25px;
    transition: background-color 0.3s;
    text-align: right;
  }
  .btn-write:hover {
    background-color: #a6d1f5;
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
  transition: all 0.2s;
}

.pagination a.current {
  background-color: #db7093;
  color: #fff;
  font-weight: bold;
}

.pagination a:hover {
  background-color: #ffe1e1;
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
</style>
</head>
<body>
<div class="table-wrapper">

<h2>QnA 목록</h2>

<div style="text-align: right; margin-bottom: 15px;">
  <button class="btn-write" onclick="location.href='QnAinput'">새 문의글 작성</button>
</div>

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
</div>
</body>
</html>