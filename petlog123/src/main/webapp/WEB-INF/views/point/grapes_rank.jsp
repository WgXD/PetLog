<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>포도알 랭킹</title>
<style>
  .grape-list {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 10px;
    margin: 30px auto;
    font-size: 1.2em;
  }

  .grape-item {
    background-color: #f8e8f0;
    border: 1px solid #e0c1d0;
    border-radius: 10px;
    padding: 10px 20px;
    color: #4a235a;
    font-weight: bold;
    width: fit-content;
  }
</style>
</head>
<body>

<h2 style="text-align: center;">전체 회원 포도알 갯수 🍇 (내림차순)</h2>

<div class="grape-list">
  <c:forEach var="user" items="${list}">
    <div class="grape-item">
      ${user.user_login_id} (ID: ${user.user_id}) 🍇 ${user.grape_count}개
    </div>
  </c:forEach>
</div>

</body>
</html>
