<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">

<%
    com.mbc.pet.user.UserDTO loginUser = (com.mbc.pet.user.UserDTO) session.getAttribute("loginUser");
    if (loginUser == null) {
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

  .btn {
    background-color: #ffe1e1;
    color: #333;
    border: none;
    padding: 8px 20px;
    border-radius: 10px;
    font-weight: normal;
    cursor: pointer;
    text-decoration: none;
    display: inline-block;
  }

  .btn:hover {
    background-color: #ffd2d2;
  }

  .table-wrapper {
    background-color: white;
    width: 100%;
    max-width: 1200px;
    margin: 40px auto 80px auto;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    padding: 30px;
    align-items: center; 
  }

  table {
    width: 100%;
    max-width: 1200px;
    border-collapse: collapse;
    margin-top: 10px;
    background-color: #fff;
    box-shadow: 0 4px 8px rgba(0,0,0,0.05);
    border-radius: 8px;
    overflow: hidden;
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

  td img {
    max-width: 70px;
    height: auto;
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

  .no-diary {
    text-align: center;
    color: #c0392b;
    font-weight: bold;
    padding: 40px 0;
  }

  .button-wrap {
    text-align: right;
    margin-bottom: 30px;
  }
</style>
</head>
<body>
  <div class="table-wrapper">
    <h2 style="color: #f48aa5">📔 일기 보기</h2>

    <!-- 버튼: 항상 보여주되, float + margin으로 간격 확보 -->
    <div style="overflow: hidden; margin-bottom: 10px;">
      <a href="diary_input" class="btn" style="float: right;">일기 쓰러 가기</a>
    </div>

    <!-- 일기 목록이 있을 때만 테이블 출력 -->
    <c:if test="${not empty list}">
      <table>

      <colgroup>
    <col style="width: 10%;">  <!-- 이름 -->
    <col style="width: 20%;">  <!-- 일기 제목 -->
    <col style="width: 10%;">  <!-- 날짜 -->
    <col style="width: 15%;">  <!-- 이미지 -->
    <col style="width: 45%;">  <!-- 일기 내용 -->
  </colgroup>
  <thead>
    <tr>
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
              <td>${di.pet_name}</td>
              <td><a href="diary_detail?diary_id=${di.diary_id}">${di.diary_title}</a></td>
              <td>${di.diary_date}</td>
              <td><img src="./image/${di.diary_image}" alt="일기 이미지"></td>
	          <td>
	          <div style="white-space: pre-line; text-align: center; width: 100%; min-height: 100px; padding: 10px;">
		      ${di.diary_content}
	          </div>
	          </td>
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