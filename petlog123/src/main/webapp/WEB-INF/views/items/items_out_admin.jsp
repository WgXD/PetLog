<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Item Shop</title>

<style>
  body {
    font-family: "Apple SD Gothic Neo", "Malgun Gothic", sans-serif;
    background-color: #fefefe;
    margin: 0;
    padding: 0;
    color: #333;
    text-align: center;
  }

  .table-wrapper {
    width: 90%;
    max-width: 1000px;
    margin: 40px auto 80px auto;
    background-color: #fff;
    border-radius: 16px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    padding: 30px;
  }

  caption {
    font-size: 2em;
    font-weight: bold;
    color: #db7093;
    margin-bottom: 20px;
  }

  table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 10px;
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

  td img {
    max-width: 100px;
    height: auto;
    border-radius: 12px;
  }

  .btn {
    background-color: #ffe1e1;
    color: #444;
    border: none;
    padding: 8px 18px;
    border-radius: 24px;
    font-weight: bold;
    font-size: 14px;
    cursor: pointer;
    text-decoration: none;
    display: inline-block;
    transition: background-color 0.3s ease;
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

  .pagination {
    margin-top: 30px;
    text-align: center;
  }

  .pagination a {
    display: inline-block;
    margin: 0 5px;
    padding: 8px 14px;
    background-color: #f2e9ff;
    color: #5e478e;
    border-radius: 10px;
    text-decoration: none;
    font-weight: bold;
    transition: background-color 0.2s;
  }

  .pagination a:hover {
    background-color: #e0d2f7;
  }

  .pagination a.current {
    background-color: #d7c9f3;
    color: white;
  }

  h1 {
    color: #db7093;
    font-size: 2em;
    margin-bottom: 20px;
  }

  .text-right {
    text-align: right;
    margin-top: 20px;
  }

</style>
</head>
<body>

<div class="table-wrapper">
  <caption>🎁 Item SHOP 🎁</caption>

  <table>
    <thead>
      <tr>
        <th>No.</th>
        <th>아이템명</th>
        <th>포도알</th>
        <th>카테고리</th>
        <th>아이템</th>
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
      <a href="items_out?page=${i}" class="${i == page ? 'current' : ''}">${i}</a>
    </c:forEach>
  </div>
</div>

</body>
</html>