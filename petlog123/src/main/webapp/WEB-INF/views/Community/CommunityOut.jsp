<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    font-family: 'Pretendard', sans-serif;
    color: #333;
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

  h2, caption {
    text-align: center;
    color: #f48aa5;
    font-weight: normal;
    font-size: 1.8em;
    margin-bottom: 30px;
  }

  table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 10px;
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

  td a {
    color: #333;
    text-decoration: none;
    font-weight: 500;
  }

  td a:hover {
    color: #d65b7b;
    text-decoration: underline;
  }

  .btn-wrap {
    text-align: right;
    margin-bottom: 20px;
  }

  .btn-wrap input[type="button"] {
    background-color: #ffe1e1;
    color: #444;
    border: none;
    border-radius: 10px;
    padding: 8px 20px;
    font-size: 1em;
    cursor: pointer;
    transition: background-color 0.3s;
  }

  .btn-wrap input[type="button"]:hover {
    background-color: #ffd2d2;
  }

  form {
    width: 100%;
    max-width: 1000px;
    margin: 30px auto 0;
    text-align: center;
  }

  select, input[type="text"], input[type="submit"] {
    padding: 10px 14px;
    margin: 8px;
    border: 1px solid #ddd;
    border-radius: 8px;
    font-size: 1em;
    font-family: 'Pretendard', sans-serif;
  }

  input[type="submit"] {
    background-color: #e5f7f3;
    color: #555;
    font-weight: 500;
    transition: background-color 0.3s;
  }

  input[type="submit"]:hover {
    background-color: #c9ebe2;
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
  
	  .btn-write {
	  float: right;
	  margin-bottom: 10px;
	  background-color: #ffe1e1;
	  color: #333;
	  border: none;
	  padding: 8px 20px;
	  border-radius: 10px;
	  font-weight: normal;
	  cursor: pointer;
	  text-decoration: none;
	}

	.btn-write:hover {
	  background-color: #ffd2d2;
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
  <h2 style="text-align:center; color:#f48aa5; font-weight:normal;">📝 자유게시판</h2>

  <!-- 레시피 스타일처럼 오른쪽 상단 버튼 -->
  <a href="CommunityIn" class="btn-write">게시글 작성</a>

  <table>
    <thead>
      <tr>
        <th style="width:5%;">No.</th>
        <th style="width:45%; text-align: center;">제목</th>
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

  <form action="searchview" method="post">
    <select name="skey" id="skey">
      <option value="user_login_id">작성자</option>
      <option value="post_title">제목</option>
      <option value="post_content">내용</option>
    </select>
    <label><input type="text" name="keyword" placeholder="검색어를 입력하세요."></label>
    <input type="submit" value="검색"">
  </form>

  <div class="pagination">
    <c:forEach var="i" begin="1" end="${page_count}">
      <a href="CommunityView?page=${i}" class="${i == page ? 'current' : ''}">${i}</a>
    </c:forEach>
  </div>
</div>
</body>
</html>