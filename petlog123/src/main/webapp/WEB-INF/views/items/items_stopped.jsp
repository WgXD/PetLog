<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
      color: #333;
    }

    h2 {
      text-align: center;
      color: #f48aa5;
      font-weight: normal;
      font-size: 1.8em;
      margin-bottom: 30px;
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
      text-align: center;
      color: #c0392b;
      font-weight: bold;
      padding: 40px 0;
      font-size: 1.1em;
    }
  </style>
</head>
<body>

  <div class="table-wrapper">
    <h2 style="color: #f48aa5">🎈 판매 종료 아이템</h2>

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