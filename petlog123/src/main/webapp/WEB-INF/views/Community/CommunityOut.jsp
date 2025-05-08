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
    font-family: "Apple SD Gothic Neo", "Malgun Gothic", sans-serif;
    background-color: #ffffff; /* 흰색 배경 유지 */
    margin: 0;
    padding: 30px 0;
  }
  table {
    width: 80%;
    margin: 0 auto;
    border-collapse: collapse;
    background-color: #fff;
  }
  caption {
    caption-side: top;
    font-size: 1.8em;
    font-weight: bold;
    margin-bottom: 20px;
    color: #333;
  }
  th, td {
    padding: 14px 12px;
    border-bottom: 1px solid #eee;
    font-size: 1em;
    text-align: center;
  }
  th {
    background-color: #f7f7f7;
    color: #555;
  }
  td a {
    color: #555;
    text-decoration: none;
  }
  td a:hover {
    text-decoration: underline;
    color: #db7093; /* 부드러운 분홍 계열로 hover */
  }
  tr:hover {
    background-color: #fafafa;
  }
  .btn-wrap {
    text-align: right;
    width: 80%;
    margin: 0 auto 20px;
  }
  .btn-wrap button {
    padding: 10px 20px;
    font-weight: normal;
    font-size: 1em;
    border: none;
    background-color: #f5d7d7; /* 부드러운 연핑크 */
    color: #555;
    border-radius: 6px;
    cursor: pointer;
    transition: background-color 0.3s;
  }
  .btn-wrap button:hover {
    background-color: #f0caca; /* hover 시 부드러운 핑크 */
  }
  form {
    width: 80%;
    margin: 30px auto 0;
    text-align: center;
  }
  select, input[type="text"], input[type="submit"] {
    padding: 8px 12px;
    margin: 5px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 0.95em;
  }
  input[type="submit"] {
    background-color: #f0e5d8; /* 연한 베이지색 */
    color: #555;
    cursor: pointer;
    transition: background-color 0.3s;
  }
  input[type="submit"]:hover {
    background-color: #e9dbcd;
  }
  .pagination {
    text-align: center;
    margin-top: 30px;
  }
  .pagination a {
    margin: 0 4px;
    text-decoration: none;
    color: #666;
    font-size: 1em;
  }
  .pagination a.current {
    font-weight: bold;
    color: #db7093; /* 현재 페이지 색: 부드러운 핑크 */
    text-decoration: underline;
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
</body>
</html>