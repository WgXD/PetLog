<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">

<%
	Integer userId = (Integer) session.getAttribute("user_id");
	if (userId == null) {
	    response.sendRedirect(request.getContextPath() + "/login?error=login_required");
	    return;
	}
%>

<style>

  body {
    background-color: #fff6f6;
    margin: 0;
    padding: 0;
    font-family: 'Pretendard', sans-serif;
    color: #333;
  }

  h2 {
    text-align: center;
    color: #d65b7b;
    font-weight: normal;
    font-size: 1.8em;
    margin-bottom: 30px;
  }

  .btn-write {
    float: right;
    margin-bottom: 10px;
    background-color: #ffe1e1;
    color: #333;
    border: none;
    padding: 8px 20px;
    border-radius: 10px;
    font-weight: 60;
    cursor: pointer;
    text-decoration: none;
  }

  .btn-write:hover {
    background-color: #ffd2d2;
  }

table {
  width: 100%;
  max-width: 1000px;
  margin: 10px auto;
  border-collapse: collapse;
  background-color: #fff;
  box-shadow: 0 4px 8px rgba(0,0,0,0.05);
  border-radius: 8px;
  overflow: hidden;
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

  td.title {
    text-align: left;
  }

  td.title a {
    color: #333;
    text-decoration: none;
    font-weight: 500;
  }

  td.title a:hover {
    color: #d65b7b;
    text-decoration: underline;
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

.no-recipe {
  text-align: center;
  color: #c0392b;
  font-weight: bold;
  padding: 40px 0;
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
  <h2 style="color:	#f48aa5">🦴 레시피 보기</h2>

  <c:if test="${empty list}">
    <p class="no-recipe">작성된 레시피가 없습니다. 🍪</p>
    <a href="snack_input" class="btn-write">레시피 작성하러 가기 ✍️</a>
  </c:if>

  <c:if test="${not empty list}">
    <a href="snack_input" class="btn-write">레시피 작성</a>

    <table>
      <thead>
        <tr>
          <th>No.</th>
          <th>제목</th>
          <th>작성자</th>
          <th>작성일자</th>
          <th>조회수</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach items="${list}" var="rec">
          <tr>
            <td>${rec.snack_id}</td>
            <td class="title">
              <a href="snack_detail?dnum=${rec.snack_id}">
                ${rec.snack_title}
              </a>
              <span style="margin-left: 8px; color: #888;">
                🗨️ ${rec.comment_count} ❤️ ${rec.like_count}
              </span>
            </td>
            <td>${rec.user_login_id}</td>
            <td>${rec.snack_date}</td>
            <td>${rec.snack_readcnt}</td>
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
