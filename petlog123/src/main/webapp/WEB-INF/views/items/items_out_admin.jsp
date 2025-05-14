<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

    h2 {
      text-align: center;
      color: #f48aa5;
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

    .text-btn {
      background: none;
      border: none;
      color: #d9534f;
      cursor: pointer;
      font-weight: bold;
      font-size: 14px;
    }

    .text-btn:hover {
      opacity: 0.7;
      text-decoration: underline;
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

    td img {
      max-width: 70px;
      height: auto;
      border-radius: 12px;
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

    .text-right {
      text-align: right;
      margin-top: 20px;
    }
  </style>
</head>
<body>

  <div class="table-wrapper">
    <h2 style="color: #f48aa5">🎁 관리자 아이템 상점</h2>

    <table>
      <thead>
        <tr>
          <th>No.</th>
          <th>아이템명</th>
          <th>포도알</th>
          <th>카테고리</th>
          <th>아이템</th>
          <th>수정</th>
          <th>상태 변경</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach items="${list}" var="it">
          <tr>
            <td>${it.item_id}</td>
            <td>${it.item_name}</td>
            <td>${it.item_cost}</td>
            <td>${it.item_category}</td>
            <td><img src="${pageContext.request.contextPath}/image/${it.item_image}" alt="아이템 이미지"></td>
            <td> <a href="items_modify?modify=${it.item_id}&dfimage=${it.item_image}">✏️</a></td>
            <td>
              <form action="${pageContext.request.contextPath}/items_delete_admin" method="post" style="display:inline;">
                <input type="hidden" name="delete" value="${it.item_id}">
                <input type="hidden" name="dfimage" value="${it.item_image}">
                <button type="submit" class="text-btn">판매 종료❌</button>
              </form>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>

    <div class="text-right">
      <form action="${pageContext.request.contextPath}/items_stopped" method="post" style="display:inline;">
        <button type="submit" class="btn">판매 종료 아이템 보기</button>
      </form>
    </div>

	<div class="pagination">
	  <c:forEach var="i" begin="1" end="${page_count}">
	    <c:choose>
	      <c:when test="${page_type eq 'admin'}">
	        <a href="items_out_admin?page=${i}" class="${i == page ? 'active' : ''}">${i}</a>
	      </c:when>
	      <c:otherwise>
	        <a href="items_out?page=${i}" class="${i == page ? 'active' : ''}">${i}</a>
	      </c:otherwise>
	    </c:choose>
	  </c:forEach>
	</div>

</body>
</html>