<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">

<style>
  body {
    background-color: #fff6f6;
    margin: 0;
    padding: 0;
    color: #333;
  }

  h2 {
    text-align: center;
    color: #f48aa5;
    font-weight: normal;
    font-size: 1.8em;
    margin: 40px 0 20px;
  }

  .table-wrapper {
    background-color: white;
    width: 100%;
    max-width: 1000px;
    margin: 20px auto 40px auto;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    padding: 30px;
  }

  table {
    width: 100%;
    border-collapse: collapse;
    background-color: #fff;
    margin-top: 10px;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 4px 8px rgba(0,0,0,0.05);
  }

  caption {
    caption-side: top;
    font-size: 1.4em;
    font-weight: bold;
    color: #d65b7b;
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

  tr:hover {
    background-color: #fdf0f5;
  }

  .search-form {
    text-align: center;
    margin: 30px auto;
  }

  .search-form select,
  .search-form input[type="text"],
  .search-form input[type="submit"] {
    font-size: 14px;
    padding: 8px 10px;
    border-radius: 8px;
    border: 1px solid #ccc;
    margin: 0 6px;
  }

  .search-form input[type="submit"] {
    background-color: #f48aa5;
    color: white;
    border: none;
    cursor: pointer;
    transition: background-color 0.3s;
  }

  .search-form input[type="submit"]:hover {
    background-color: #db7093;
  }
</style>
</head>
<body>

<c:if test="${not empty msg}">
  <script>alert('${msg}');</script>
</c:if>

<h2>"${keyword}" 에 대한 검색 결과</h2>

<div class="table-wrapper">
  <table>
    <caption>검색된 게시글 목록</caption>
    <thead>
      <tr>
        <th style="width:5%;">No.</th>
        <th style="width:45%;">제목</th>
        <th style="width:15%;">작성자</th>
        <th style="width:20%;">작성일자</th>
        <th style="width:10%;">조회수</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach items="${list}" var="cc">
        <tr>
          <td>${cc.post_id}</td>
          <td style="text-align: left;">
            <a href="PostDetail?pnum=${cc.post_id}">${cc.post_title}</a>
          </td>
          <td>${cc.user_id}</td>
          <td>${cc.post_date}</td>
          <td>${cc.post_readcnt}</td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
</div>

<!-- 검색 폼 -->
<div class="search-form">
  <form action="searchview" method="post">
    <select name="skey" id="skey">
      <option value="post_id">작성자</option>
      <option value="post_title">제목</option>
      <option value="post_content">내용</option>
      <option value="post_date">작성일자</option>
    </select>
    <input type="text" name="keyword" placeholder="검색어를 입력하세요." required>
    <input type="submit" value="검색">
  </form>
</div>

</body>
</html>