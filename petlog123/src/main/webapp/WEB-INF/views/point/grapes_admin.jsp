<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>포도알 지급</title>
</head>
<body>
<h2>포도알 지급</h2>

<!-- 메시지 출력 -->
<c:if test="${not empty message}">
    <p style="color: green;"><strong>${message}</strong></p>
</c:if>

<form action="${pageContext.request.contextPath}/point/grapes_admin" method="post">
    <label>회원 선택:</label>
    <select name="user_id1" required>
        <option value="">-- 선택하세요 --</option>
        <c:forEach var="user" items="${list}">
            <option value="${user.user_id}">
                ${user.user_login_id} (ID: ${user.user_id}, 🍇: ${user.grape_count}개)
            </option>
        </c:forEach>
    </select>
    <br><br>

    <label>포도알 수:</label>
    <input type="number" name="grape_amount" required><br><br>

    <input type="submit" value="지급">
</form>

<br><br>

<form action="${pageContext.request.contextPath}/point/grapes_rank" method="get">
    <input type="submit" value="회원별 포도알 🍇">
</form>

</body>
</html>