<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>    
    
<!DOCTYPE html>
<html>
<head>

<style>
  body {
    background-color: #fff8f0;
    text-align: center;
    padding: 30px;
  }

  h2 {
   color: #5e478e;
  }

  form {
    display: inline-block;
    text-align: left;
  }

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

  input[type="text"],
  input[type="date"],
  input[type="file"],
  textarea {
    width: 100%;
    padding: 8px;
    border-radius: 8px;
    border: 1px solid #ddd;
    box-sizing: border-box;
  }

  textarea {
    resize: vertical;
  }
  
	  button,
	input[type="submit"],
	input[type="reset"] {
	  background-color: #d7c9f3; /* 연보라 */
	  border: none;
	  color: #5e478e; /* 진보라 텍스트 */
	  padding: 10px 22px;
	  margin: 12px 6px;
	  border-radius: 24px;
	  font-size: 15px;
	  font-weight: bold;
	  cursor: pointer;
	  transition: background-color 0.3s ease, transform 0.15s ease;
	  box-shadow: 2px 2px 5px rgba(100, 80, 160, 0.2);
	}
	
	button:hover,
	input[type="submit"]:hover,
	input[type="reset"]:hover {
	  background-color: #e8defc; /* 좀 더 크리미한 보라 */
	  transform: scale(1.05);
	}
	
	button:active,
	input[type="submit"]:active,
	input[type="reset"]:active {
	  transform: scale(0.95);
	}

</style>
<meta charset="UTF-8">
<title>레시피 자세히 보기</title>
</head>
<body>
<header><h2>레시피 자세히 보기</h2></header>

<div style="margin-bottom: 20px;">
  <input type="reset" value="⬅ 뒤로가기" onclick="history.back()" 
         style="background-color: #f8d7da; color: #a94442; border: 1px solid #f5c6cb;
                padding: 6px 14px; font-size: 13px; border-radius: 16px;
                font-weight: bold; cursor: pointer;">
</div>

<c:set var="isOwnerOrAdmin"
       value="${sessionScope.user_id == dto.user_id or sessionScope.user_role == 'admin'}" />

<table class="dotted-rounded-table">
<tr>
  <th>No.</th> <th>레시피명</th> <th>레시피</th> <th>이미지</th> <th>게시일</th>
  <c:if test="${isOwnerOrAdmin}">
    <th>수정</th> <th>삭제</th>
  </c:if>
</tr>

<tr>
  <td>${dto.snack_id}</td>
  <td>${dto.snack_title}</td>
  <td>${dto.snack_recipe}</td>
  <td><img src="./image/${dto.snack_image}" width="150px"/></td>
  <td>${dto.snack_date.substring(0, 10)}</td>

  <c:if test="${isOwnerOrAdmin}">
    <td><a href="snack_update?update=${dto.snack_id}&dfimage=${dto.snack_image}">✏️</a></td>
    <td><a href="snack_delete?delete=${dto.snack_id}&dfimage=${dto.snack_image}">🗑️</a></td>
  </c:if>
</tr>

</table>
</body>
</html>
