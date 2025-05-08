<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>

  <meta charset="UTF-8">
  <title>My 아이템</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
  <style>
    .item-table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
    }

    .item-table th, .item-table td {
      padding: 12px;
      border-bottom: 1px solid #eee;
      text-align: center;
    }

    .item-table th {
      background-color: #f8f8f8;
      color: #555;
    }

    .item-table td img {
      max-width: 80px;
      height: auto;
    }

    .back-btn {
      background-color: #ffc9de;
      color: #8a3a59;
      border: none;
      padding: 8px 18px;
      border-radius: 18px;
      font-size: 14px;
      font-weight: bold;
      cursor: pointer;
      margin-bottom: 20px;
    }

    .back-btn:hover {
      background-color: #ffe1eb;
    }

    .use-btn {
      background-color: #b8e7dc;
      color: #234;
      border: none;
      padding: 8px 14px;
      border-radius: 12px;
      font-weight: bold;
      cursor: pointer;
    }

    .use-btn:hover {
      background-color: #a0d8cb;
    }

    .center-text {
      text-align: center;
      margin-top: 20px;
      font-size: 16px;
    }
  </style>
</head>
<body>

<div class="main-wrapper">
  <div class="box">
    <h2>💝 My 아이템 💝</h2>

    <button class="back-btn" onclick="history.back()">⬅ 뒤로가기</button>

    <c:if test="${empty list}">
      <p class="center-text">아직 구매한 아이템이 없습니다.</p>
    </c:if>

    <c:if test="${not empty list}">
      <table class="item-table">
        <thead>
          <tr>
            <th>아이템 이미지</th>
            <th>아이템 이름</th>
            <th>카테고리</th>
            <th>착용 여부</th>
            <th>아이템 사용</th>
            <th>아이템 삭제</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="item" items="${list}">
            <tr>
              <td>
                <img src="${pageContext.request.contextPath}/image/${item.item_image}" alt="아이템 이미지">
              </td>
              <td><strong>${item.item_name}</strong></td>
              <td>${item.item_category}</td>
              <td>
                <c:choose>
                  <c:when test="${item.usertem_equip == 'Y'}">✅ 착용 중</c:when>
                  <c:otherwise>❌ 미착용</c:otherwise>
                </c:choose>
              </td>
              <td>
                <form action="${pageContext.request.contextPath}/put_on_frame" method="post" style="display:inline;">
                  <input type="hidden" name="item_id" value="${item.item_id}" />
                  <input type="submit" value="사용하기 🎀" class="use-btn" />
                </form>
              </td>
              
			<td>
				<form action="${pageContext.request.contextPath}/items/items_delete" method="post" style="display:inline;">
				  <input type="hidden" name="delete" value="${item.item_id}">
				  <input type="hidden" name="dfimage" value="${item.item_image}">
				  <button type="submit" style="background:none;border:none;cursor:pointer;">🗑️</button>
				</form>
			</td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </c:if>
  </div>
</div>

</body>
</html>