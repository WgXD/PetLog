<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>

<h2>🛑 판매 종료된 아이템 목록</h2>
<c:if test="${empty list}">
    <p>판매 종료된 아이템이 없습니다.</p>
</c:if>

<c:if test="${not empty list}">
    <table border="1">
        <tr>
            <th>아이템명</th>
            <th>카테고리</th>
            <th>이미지</th>
            <th>상태 변경</th>
        </tr>
        <c:forEach var="item" items="${list}">
            <tr>
                <td>${item.item_name}</td>
                <td>${item.item_category}</td>
                <td><img src="${pageContext.request.contextPath}/image/${item.item_image}" width="80"></td>
				<td>
				  <form action="${pageContext.request.contextPath}/items_restore" method="post" style="display:inline;">
				    <input type="hidden" name="item_id" value="${item.item_id}">
				    <button type="submit" style="background:none;border:none;cursor:pointer;">판매 시작⭕</button>
				  </form>
				</td>
            </tr>
        </c:forEach>
    </table>
</c:if>

</body>
</html>