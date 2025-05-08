<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>

<style type="text/css">
.dotted-rounded-table {
  border: 2px dotted #8ab6d6;
  border-radius: 16px;
  background: #ffffff;
  margin: auto;
  box-shadow: 2px 2px 10px rgba(0,0,0,0.05);
  border-collapse: separate;
  overflow: hidden;
}

.dotted-rounded-table th,
.dotted-rounded-table td {
  border: 1px dotted #bcdff1;
  padding: 12px 16px;
  font-size: 14px;
}
</style>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<header>✨ 아이템 목록 ✨</header>
<br>

<%
    String role = (String) session.getAttribute("user_role");
    if (role == null || !role.equals("admin")) {
%>
    <script>
        alert("관리자만 접근 가능합니다.");

    </script>
<%
	return;
    }
%>

<!-- 관리자일 때만 페이지 내용 보여줌 -->
<c:if test="${sessionScope.user_role eq 'admin'}">

<form action="items_save" method="post" enctype="multipart/form-data">
<table class="dotted-rounded-table">

      <tr>
        <th><label for="item_name">아이템명 : </label></th>
        <td><input type="text" id="item_name" name="item_name"></td>
      </tr>

      <tr>
        <th><label for="item_cost">포도알 : </label></th>
        <td><input type="number" id="item_cost" name="item_cost"></td>
      </tr>

      <tr>
        <th><label for="item_category">카테고리 : </label></th>
        <td><input type="radio" id="item_category_frame" name="item_category" value="프레임">
        <label for="item_category_frame">프레임</label>
        
      	<input type="radio" id="item_category_sticker" name="item_category" value="스티커">
      	<label for="item_category_sticker">스티커</label></td>
      </tr>

      <tr>
        <th><label for="item_image">아이템 : </label></th>
        <td><input type="file" id="item_image" name="item_image"></td>
      </tr>

      <tr>
      <td colspan="2" style="text-align: center">
      <input type="submit" value="💾 저장하기">
      <input type="reset" value="❌ 취소하기">
      </td>
      </tr>
</table>
</form>
</c:if>
</body>
</html>