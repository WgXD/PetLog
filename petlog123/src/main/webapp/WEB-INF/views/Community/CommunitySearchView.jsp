<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<style>
<style>
  body {
    font-family: "Apple SD Gothic Neo", "Malgun Gothic", sans-serif;
    background-color: #f8f9fa;
    margin: 0;
    padding: 0;
  }

  table {
    width: 80%;
    margin: 0 auto;
    border-collapse: collapse;
    background-color: #fff;
    box-shadow: 0 4px 12px rgba(0,0,0,0.05);
    border-radius: 10px;
    overflow: hidden;
  }

  caption {
    caption-side: top;
    font-size: 1.6em;
    font-weight: bold;
    padding: 20px;
    background-color: #f1f1f1;
    color: #333;
  }

  th, td {
    padding: 14px 12px;
    border-bottom: 1px solid #ddd;
    text-align: center;
    font-size: 0.95em;
  }

  th {
    background-color: #f5f5f5;
    color: #555;
  }

  td a {
    color: #007bff;
    text-decoration: none;
  }

  td a:hover {
    text-decoration: underline;
  }

  tr:hover {
    background-color: #f9f9f9;
  }

  .btn-wrap {
    text-align: right;
    width: 80%;
    margin: 10px auto 20px;
  }

  .btn-wrap input[type="button"] {
    padding: 10px 20px;
    font-weight: bold;
    border: none;
    background-color: #FFE4E1;
    color: #DB7093;
    border-radius: 6px;
    cursor: pointer;
    transition: background-color 0.3s;
  }

  .btn-wrap input[type="button"]:hover {
    background-color: #45a049;
  }
  .table-wrapper {
  background-color: white;
  width: 100%;
  max-width: 5000px;
  margin: 40px auto 80px auto;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.08);
  padding: 30px;
}
</style>
<meta charset="UTF-8">
</head>
<body>
<!-- 메시지 처리 -->
<c:if test="${not empty msg}">
    <script>
        alert('${msg}');
    </script>
</c:if>
<div class="table-wrapper">
<table>
<caption>"${keyword}" 에 대한 검색 결과</caption>
<tr>
	<th style="width:5%;">No.</th>
	<th style="width:45%;">제목</th>
	<th style="width:15%;">작성자</th>
	<th style="width:20%;">작성일자</th>
	<th style="width:10%;">조회수</th>
</tr>
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
</table>
</div>
	<form action="searchview" method="post">
	<select name="skey" id="skey">
		<option value="post_id">작성자</option>
		<option value="post_title">제목</option>
		<option value="post_content">내용</option>
		<option value="post_date">작성일자</option>
	</select>
	<label><input type="text" name="keyword" placeholder="검색어를 입력하세요."> </label>
	<input type="submit" value="검색">
	<p>${msg}</p>
</form>
</body>
</html>