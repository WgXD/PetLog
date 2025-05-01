<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<style type="text/css">
body {
  font-family: Arial, sans-serif;
  background: #f0f8ff;
  text-align: center;
  padding: 30px;
}
h2 { color: #4a6fa5; }
form { display: inline-block; text-align: left; }
.dotted-rounded-table {
  border: 2px dotted #8ab6d6;
  border-radius: 16px;
  background: #ffffff;
  margin: auto;
  box-shadow: 2px 2px 10px rgba(0,0,0,0.05);
  border-collapse: separate;
  overflow: hidden;
}
.dotted-rounded-table th, .dotted-rounded-table td {
  border: 1px dotted #bcdff1;
  padding: 12px 16px;
  font-size: 14px;
}
input[type="text"], input[type="number"], input[type="file"], textarea {
  width: 100%;
  padding: 5px;
  border: 1px solid #cce6f7;
  border-radius: 6px;
  box-sizing: border-box;
  background-color: #f6fbff;
  margin-bottom: 12px;
}
textarea { resize: vertical; }
button, input[type="submit"], input[type="reset"] {
  background: #a8d0f0;
  color: #2e5c8a;
  border: none;
  border-radius: 24px;
  padding: 10px 22px;
  margin: 12px 6px;
  font-size: 15px;
  font-weight: bold;
  cursor: pointer;
  transition: 0.3s ease;
  box-shadow: 2px 2px 5px rgba(50, 100, 160, 0.2);
}
button:hover, input[type="submit"]:hover, input[type="reset"]:hover {
  background: #d3ebff;
  transform: scale(1.05);
}
button:active, input[type="submit"]:active, input[type="reset"]:active {
  transform: scale(0.95);
}


.table-container {
    width: 100%; /* 원하는 너비로 설정 */
    text-align: center; /* 내용 중앙 정렬 */
}
</style>

<header><h2>💝 My 아이템 💝</h2></header>


<div style="margin-bottom: 20px;">
  <input type="reset" value="⬅ 뒤로가기" onclick="history.back()" 
         style="background-color: #f8d7da; color: #a94442; border: 1px solid #f5c6cb;
                padding: 6px 14px; font-size: 13px; border-radius: 16px;
                font-weight: bold; cursor: pointer;">
</div>


<c:if test="${empty list}">
    <p>아직 구매한 아이템이 없습니다.</p>
</c:if>

<c:if test="${not empty list}">
<div class="table-container">
<table class="item-table" border="1" >
    <thead>
        <tr>
            <th>아이템 이미지</th>
            <th>아이템 이름</th>
            <th>카테고리</th>
            <th>착용 여부</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="item" items="${list}">
            <tr>
                <td>
                    <img src="${pageContext.request.contextPath}/image/${item.item_image}" alt="아이템 이미지" width="100">
                </td>
                <td><strong>${item.item_name}</strong></td>
                <td>${item.item_category}</td>
                <td>
                    <c:choose>
                        <c:when test="${item.usertem_equip == 'Y'}">✅ 착용 중</c:when>
                        <c:otherwise>❌ 미착용</c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
</div>
</c:if>