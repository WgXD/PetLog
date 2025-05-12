<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>판매 종료 아이템</title>

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
    margin: 0 auto;
    background-color: #fff;
    border-radius: 16px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    padding: 30px;
  }

  caption {
    font-size: 1.8em;
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
    max-width: 80px;
    height: auto;
    border-radius: 10px;
  }

  .text-btn {
    background: none;
    border: none;
    color: #3e8e41;
    cursor: pointer;
    font-weight: bold;
    font-size: 14px;
  }

  .text-btn:hover {
    opacity: 0.7;
    text-decoration: underline;
  }

  .no-data {
    color: #c0392b;
    font-weight: bold;
    padding: 20px 0;
  }
</style>
</head>
<body>

<div class="table-wrapper">

  <caption>🛑 판매 종료된 아이템 목록</caption>

  <c:if test="${empty list}">
    <p class="no-data">판매 종료된 아이템이 없습니다.</p>
  </c:if>

  <c:if test="${not empty list}">
    <table>
      <thead>
        <tr>
          <th>아이템명</th>
          <th>카테고리</th>
          <th>이미지</th>
          <th>상태 변경</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="item" items="${list}">
          <tr>
            <td>${item.item_name}</td>
            <td>${item.item_category}</td>
            <td><img src="${pageContext.request.contextPath}/image/${item.item_image}" alt="아이템 이미지"></td>
            <td>
              <form action="${pageContext.request.contextPath}/items_restore" method="post" style="display:inline;">
                <input type="hidden" name="item_id" value="${item.item_id}">
                <button type="submit" class="text-btn">판매 시작 ⭕</button>
              </form>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </c:if>

</div>

</body>
</html>