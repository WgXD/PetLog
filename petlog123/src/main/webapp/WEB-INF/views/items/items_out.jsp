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
    padding: 50px 0;
    color: #333;
    text-align: center;
  }

  .table-wrapper {
    width: 90%;
    max-width: 1000px;
    margin: 0 auto;
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

  td a {
    font-size: 20px;
    text-decoration: none;
    color: #5e478e;
  }

  td a:hover {
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
    margin-bottom: 30px;
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
        <th>아이템 구매</th>
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
          <td><a href="items_detail?num=${it.item_id}">🛒</a></td>
        </tr>
      </c:forEach>
    </tbody>
  </table>

  <div class="pagination">
    <c:forEach var="i" begin="1" end="${page_count}">
      <a href="items_out?page=${i}" class="${i == page ? 'current' : ''}">${i}</a>
    </c:forEach>
  </div>

</div>

</body>
</html>