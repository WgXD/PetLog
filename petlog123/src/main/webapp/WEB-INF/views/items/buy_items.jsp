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

  .back-btn-wrap {
    text-align: left;
    margin-bottom: 10px;
  }

  .back-btn {
    background-color: #ffe1e1;
    color: #444;
    border: none;
    padding: 10px 20px;
    border-radius: 6px;
    font-size: 1em;
    cursor: pointer;
  }

  .back-btn:hover {
    background-color: #ffd2d2;
  }

  h2 {
    text-align: center;
    color: #f48aa5;
    font-weight: normal;
    font-size: 1.8em;
    margin-bottom: 30px;
    margin-top: 0; /* 위 간격 최소화 */
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
  }

  .use-btn {
    background-color: #b8e7dc;
    color: #234;
    border: none;
    padding: 8px 14px;
    border-radius: 10px;
    font-weight: normal;
    font-family: 'Pretendard', sans-serif;
    cursor: pointer;
  }

  .use-btn:hover {
    background-color: #a0d8cb;
  }

  .delete-btn {
    background: none;
    border: none;
    font-size: 18px;
    cursor: pointer;
  }

  .delete-btn:hover {
    opacity: 0.7;
  }
</style>

</head>
<body>

<div class="table-wrapper">

  <div class="back-btn-wrap">
    <button class="back-btn" onclick="history.back()">⬅ 뒤로가기</button>
  </div>

  <h2>💝 내 아이템</h2>

  <c:if test="${empty list}">
    <p class="center-text">아직 구매한 아이템이 없습니다.</p>
  </c:if>

  <c:if test="${not empty list}">
    <table>
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
                <button type="submit" class="delete-btn">🗑️</button>
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