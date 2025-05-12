<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>자유게시판</title>
<style>
 body {
  background-color: #fefefe;
  margin: 0;
  padding: 0;
  color: #333;
}

table {
  width: 90%;
  max-width: 1000px;
  margin: 20px auto;
  border-collapse: collapse;
  background-color: #fff;
  box-shadow: 0 4px 8px rgba(0,0,0,0.05);
  border-radius: 8px;
  overflow: hidden;
}

caption {
  caption-side: top;
  font-size: 2em;
  font-weight: bold;
  padding: 20px;
  color: #db7093;
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
  font-weight: 600;
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

tr:hover {
  background-color: #fff9f9;
}

.btn-wrap {
  width: 90%;
  max-width: 1000px;
  margin: 0 auto 20px;
  text-align: right;
}

.btn-wrap input[type="button"] {
  background-color: #ffe1e1;
  color: #444;
  border: none;
  border-radius: 6px;
  padding: 10px 18px;
  font-size: 1em;
  cursor: pointer;
  transition: background-color 0.3s;
}

.btn-wrap input[type="button"]:hover {
  background-color: #ffcccc;
}

form {
  width: 90%;
  max-width: 1000px;
  margin: 40px auto 0;
  text-align: center;
}

select, input[type="text"], input[type="submit"] {
  padding: 10px 14px;
  margin: 8px;
  border: 1px solid #ddd;
  border-radius: 5px;
  font-size: 1em;
}

input[type="submit"] {
  background-color: #ffe1b8;
  color: #555;
  font-weight: 500;
  transition: background-color 0.3s;
}

input[type="submit"]:hover {
  background-color: #ffd8a6;
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
  max-width: 5000px;
  margin: 20px auto;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.08);
  padding: 30px;
}
</style>
</head>
<body>
<!-- 삭제 후 성공 메시지 처리 -->
<c:if test="${not empty msg}">
    <script>
        alert('${msg}');
    </script>
</c:if>

<div class="table-wrapper">
<!-- 게시글 작성 버튼 -->

<div class="btn-wrap">
  <input type="button" value="게시글 작성" onclick="location.href='CommunityIn'">
</div>

<table>
<caption>자유게시판</caption>
<thead>
<tr>
	<th style="width:5%;">No.</th>
	<th style="width:45%;">제목 </th>
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
		<a href="PostDetail?pnum=${cc.post_id}">
			${cc.post_title} 
			<span style="margin-left:10px;">🗨️ ${cc.comment_count}</span>
			<span style="margin-left:6px;">❤️ ${cc.like_count}</span>
		</a>
	</td>
	<td>${cc.user_login_id}</td>
	<td>${cc.post_date}</td>
	<td>${cc.post_readcnt}</td>
</tr>
</c:forEach>
</tbody>
</table>
	<!-- 검색 기능 -->
	<form action="searchview" method="post">
	<select name="skey" id="skey">
		<option value="user_login_id">작성자</option>
		<option value="post_title">제목</option>
		<option value="post_content">내용</option>
	</select>
	<label><input type="text" name="keyword" placeholder="검색어를 입력하세요."></label>
	<input type="submit" value="검색">
</form>
<!-- 페이징 숫자 출력 1 2 3... -->
<div class="pagination">
  <c:forEach var="i" begin="1" end="${page_count}">
    <a href="CommunityView?page=${i}" 
       class="${i == page ? 'current' : ''}">
       ${i}
    </a>
  </c:forEach>
</div>
</div>
</body>
</html>