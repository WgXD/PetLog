<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<%
    com.mbc.pet.user.UserDTO loginUser = (com.mbc.pet.user.UserDTO) session.getAttribute("loginUser");
    if (loginUser == null) {
        response.sendRedirect(request.getContextPath() + "/login?error=login_required");
        return;
    }
%>
<style>
  .dotted-rounded-table {
    border-collapse: separate;
    border: 2px dotted #aaa;
    border-radius: 16px;
    overflow: hidden;
    background-color: #fff;
    margin: 0 auto;
    box-shadow: 2px 2px 10px rgba(0,0,0,0.1);
  }

  .dotted-rounded-table td,
  .dotted-rounded-table th {
    border: 1px dotted #ccc;
    padding: 12px 16px;
    font-size: 14px;
  }
</style>

<meta charset="UTF-8">
<title>My pet</title>
</head>
<body>
<header><h2>My pet</h2></header>

<c:if test="${empty list}">
  <p style="margin-top: 20px; font-weight: bold; color: #c0392b;">등록된 펫이 없습니다. 펫을 등록해주세요 🐾</p>
  <form action="pet_input" method="get" style="margin-top: 20px;">
    <input type="submit" value="펫 등록하러 가기"
           style="padding: 10px 20px; border-radius: 12px; background-color: #d7c9f3; 
                  color: #5e478e; font-weight: bold; border: none; cursor: pointer;">
  </form>
</c:if>

<c:if test="${not empty list}">
<table class="dotted-rounded-table">
<tr>
  <th>No.</th> <th>이름</th> <th>성별</th> <th>중성화 여부</th> <th>생일</th> <th>사진</th>
</tr>

<c:forEach items="${list}" var="pet">
<tr>
  <td>${pet.pet_id}</td>
  <td><a href="pet_detail?update1=${pet.pet_id}">${pet.pet_name}</a></td>
  <td>${pet.pet_bog}</td>
  <td>${pet.pet_neuter}</td>
  <td>${pet.pet_hbd}</td>
  <td><img src="./image/${pet.pet_img}" width="100px"></td>
</tr>
</c:forEach>
</table>
</c:if>

</body>
</html>
