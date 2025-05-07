<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>  <!-- 펫 무조건 등록해야 일정 저장 가능! -->

<c:if test="${empty petlist}">
    <script>
        alert("🐶 먼저 반려동물을 등록해주세요!");
        history.back(); // 이전 페이지로 되돌아가기
    </script>
</c:if>

<form action="cal_save" method="post">

    <label>반려동물 선택:</label>
    <select name="pet_id">
        <c:forEach var="pet" items="${petlist}">
            <option value="${pet.pet_id}">${pet.pet_name}</option>
        </c:forEach>
    </select><br>
    
<table>

<tr>
<th><label for="cal_title">제목 : </label></th>
<td><input type="text" id="cal_title" name="cal_title"></td>
<tr>

<tr>
<th><label for="cal_date">날짜 : </label></th>
<td><input type="date" id="cal_date" name="cal_date"></td>
<tr>

<tr>
<th><label for="cal_content">내용 : </label></th>
<td><textarea rows="10" cols="20" id="cal_content" name="cal_content"></textarea></td>
<tr>

<tr>
<td colspan="2" style="text-align: center">
<input type="submit" value="💾 저장하기">
<input type="reset" value="❌ 취소하기" onclick="history.back()">
</td>
</tr>
</table>
</form>
</body>
</html>