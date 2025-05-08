<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Item Shop</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
<style>
  h1 {
    color: #4a6fa5;
    margin-bottom: 30px;
  }

  .shop-table {
    width: 90%;
    margin: auto;
    border-collapse: collapse;
    background-color: #fff;
    border-radius: 20px;
    overflow: hidden;
    box-shadow: 0 2px 8px rgba(0,0,0,0.05);
  }

  .shop-table th, .shop-table td {
    padding: 14px;
    border-bottom: 1px solid #eee;
    text-align: center;
    font-size: 15px;
  }

  .shop-table th {
    background-color: #f2f9ff;
    color: #333;
  }

  .shop-table img {
    width: 100px;
    border-radius: 10px;
  }

  .shop-table a {
    font-size: 22px;
    text-decoration: none;
  }

  .pagination {
    text-align: center;
    margin: 30px 0;
  }

  .pagination a {
    display: inline-block;
    margin: 0 6px;
    text-decoration: none;
    color: #4a6fa5;
    font-weight: bold;
    font-size: 16px;
    padding: 6px 10px;
    border-radius: 6px;
    transition: background-color 0.2s ease;
  }

  .pagination a.current {
    background-color: #d3ebff;
    text-decoration: underline;
  }

  .pagination a:hover {
    background-color: #eaf5ff;
  }
</style>
</head>
<body>

<h1>🎁 Item SHOP 🎁</h1>

<table class="shop-table">
  <tr>
    <th>No.</th>
    <th>아이템명</th>
    <th>포도알</th>
    <th>카테고리</th>
    <th>아이템</th>
    <th>아이템 구매</th>
  </tr>
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
</table>

<div class="pagination">
  <c:forEach var="i" begin="1" end="${page_count}">
    <a href="items_out?page=${i}" class="${i == page ? 'current' : ''}">${i}</a>
  </c:forEach>
</div>

</body>
</html>