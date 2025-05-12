<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PetLog 공지사항</title>
<style>
  body {
    font-family: "Apple SD Gothic Neo", "Malgun Gothic", sans-serif;
    background-color: #ffffff; /* 흰색 배경 유지 */
    margin: 0;
    padding: 0;
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

<!-- 게시글 작성 버튼 -->
<div class="btn-wrap">
  <c:if test="${sessionScope.user_role eq 'admin'}">
      <button type="button" onclick="location.href='BoardInput'">📢 공지사항 작성</button>
  </c:if>
</div>

<!-- 공지사항 테이블 -->
<div class="table-wrapper">
<table>
<caption>PetLog 공지사항</caption>
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
		<a href="BoardDetail?pnum=${cc.post_id}">
			${cc.post_title} 
		</a>
	</td>
	<td>${cc.user_login_id}</td>
	<td>${cc.post_date}</td>
	<td>${cc.post_readcnt}</td>
</tr>
</c:forEach>
</tbody>
</table>
</div>

<!-- 페이징 -->
<div class="pagination">
  <c:forEach var="i" begin="1" end="${page_count}">
    <a href="CommunityView?page=${i}" class="${i == page ? 'current' : ''}">
      ${i}
    </a>
  </c:forEach>
</div>

</body>
</html>
