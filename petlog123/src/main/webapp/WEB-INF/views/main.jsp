<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>PetLog 메인</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>

<div class="main-wrapper">
  <div class="grid-container">

    <div class="box calendar">📅<br>캘린더</div>
    <div class="box grapes">🍇<br>포도알</div>
    <div class="box mini shop">🛍️<br>아이템샵</div>
    <div class="box mini quiz">❓<br>퀴즈</div>
    <div class="box mini snack">❤️<br>간식레시피</div>

    <div class="box post full">🔥 인기 게시물</div>
    <div class="box notice full">📢 공지사항</div>

  </div>
</div>

</body>
</html>
