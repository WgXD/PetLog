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
       value="${sessionScope.user_role == 'admin' or sessionScope.user_id == dto.user_id}" />

<table class="dotted-rounded-table">
<tr>
  <th>No.</th> <th>레시피명</th> <th>레시피</th> <th>이미지</th> <th>작성자</th> <th>게시일</th>
  <th>조회수</th> <th>댓글</th> <th>좋아요</th>
  <c:if test="${isOwnerOrAdmin}">
    <th>수정</th> <th>삭제</th>
  </c:if>
</tr>

<tr>
  <td>${dto.snack_id}</td>
  <td>${dto.snack_title}</td>
  <td>${dto.snack_recipe}</td>
  <td><img src="./image/${dto.snack_image}" width="150px"/></td>
  <td>${dto.user_login_id}</td>
  <td>${dto.snack_date.substring(0, 10)}</td>
  <td>${dto.snack_readcnt}</td>
  <td>${dto.comment_count}</td>
  <td>${dto.like_count}</td> 
  
  <c:if test="${isOwnerOrAdmin}">
    <td><a href="snack_update?update=${dto.snack_id}&dfimage=${dto.snack_image}">✏️</a></td>
    <td><a href="snack_delete?delete=${dto.snack_id}&dfimage=${dto.snack_image}">🗑️</a></td>
  </c:if>
</tr>
</table>

<!--   좋아요 기능 -->
<div style="text-align: center; margin-top: 20px;">
  <form action="like_s" method="post" style="display: inline;">
    <input type="hidden" name="snack_id" value="${dto.snack_id}">
     <c:choose>
      <c:when test="${userLiked}">
        <button type="submit" style="color:red; font-size: 20px; border: none; background: none;">❤️ (${LikeCount})</button>
      </c:when>
      <c:otherwise>
        <button type="submit" style="font-size: 20px; border: none; background: none;">🤍 (${LikeCount})</button>
      </c:otherwise>
    </c:choose>
  </form>
</div>

<!-- 댓글 색션 시작 -->
<div style="width: 60%; margin: 40px auto 20px auto; padding: 15px 0; text-align: left; border-bottom: 1px solid #ddd;">
    <h3 style="margin-bottom: 20px;">댓글</h3>
    
<!-- 댓글 작성 폼 -->
<form action="comment_insert" method="post">
<input type="hidden" name="snack_id" value="${dto.snack_id}">

<textarea name="com_com" rows="3"
	style="width: 100%; padding: 10px; font-size: 15px; resize: none;
	border: none; border-bottom: 1px solid #ccc;
	background: transparent; outline: none;"
	placeholder="댓글을 입력하세요" required></textarea>
<button type="submit"
	style="margin-top: 8px; padding: 6px 12px;
	background-color: #FFE4E1; color: #8B7D7B;
	border: none; border-radius: 4px;
	font-size: 14px; cursor: pointer;">
댓글 작성
</button></form></div>

<!-- 댓글 출력 -->
<c:forEach items="${comments}" var="com">
<c:set var="margin" value="${com.depth * 20}" />

<div style="width: 60%; margin: 0 auto; margin-left: calc(20% + ${margin}px); border-bottom: 1px solid #ddd; padding: 15px 10px; text-align: left; position: relative;">
<div style="font-weight: bold; margin-bottom: 5px;">
	<img src="${pageContext.request.contextPath}/image/${profileimg}" class="profile-img" />
	${com.user_login_id}</div>
<div style="margin-bottom: 10px;">💬 ${com.com_com}</div>

<!-- 대댓글 버튼 -->
<button type="button" onclick="toggleReplyForm(${com.com_id})"
	style="position: absolute; top: 15px; right: 10px; font-size: 12px;
    padding: 4px 8px; background-color: #eee;
    border: 1px solid #aaa; border-radius: 4px; cursor: pointer;">
    답글
</button>

<!-- 대댓글 입력창 -->
<div id="replyForm${com.com_id}" style="display: none; margin-top: 10px;">
	<form action="comment_insert" method="post">
    <input type="hidden" name="snack_id" value="${dto.snack_id}">
    <input type="hidden" name="parent_id" value="${com.com_id}">
    <input type="hidden" name="depth" value="${com.depth + 1}">
    <textarea name="com_com" rows="2"
		style="width: 95%; padding: 8px; border: none;
        border-bottom: 1px solid #ccc;
        background: transparent; resize: none; outline: none;"
        placeholder="답글을 입력하세요" required></textarea>
<button type="submit"
        style="margin-top: 5px; padding: 6px 12px;
        background-color: #FFE4E1; color: #8B7D7B;
        background-color: #e0e0e0; border: 1px solid #bbb;
        border-radius: 4px; font-size: 13px;">
		작성
</button></form></div></div>
</c:forEach>
<!-- 대댓글 폼 토글 -->
<script>
   function toggleReplyForm(id) {
      const form = document.getElementById('replyForm' + id);
      form.style.display = (form.style.display === 'none') ? 'block' : 'none';
   }
</script>

</body>
</html>
