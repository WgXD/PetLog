<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>간식 레시피 상세보기</title>
<style>
  body {
    background-color: #f9f9f9;
    margin: 0;
    padding: 0;
  }
  table {
    width: 80%;
    margin: 50px auto;
    border-collapse: collapse;
    background-color: transparent;
    border: none;
    box-shadow: none;
  }
  caption {
    caption-side: top;
    text-align: center;
    font-size: 1.4em;
    font-weight: bold;
    padding: 20px 10px;
    background-color: transparent;
    color: #222;
    text-align: left;
  }
  th, td {
    padding: 16px 10px;
    border-bottom: 1px solid #ddd;
    text-align: left;
    background-color: transparent;
    color: #333;
  }
  th {
    width: 20%;
    font-weight: 600;
    color: #444;
    background-color: transparent;
  }
  td img {
    margin-top: 10px;
    border-radius: 4px;
    max-width: 100%;
  }
  .btn-group {
    width: 60%;
    margin: 20px auto;
    display: flex;
    justify-content: flex-end;
    gap: 8px;
  }
  .btn-group input[type="button"] {
    padding: 4px 10px;
    font-size: 13px;
    background-color: #666;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.2s;
  }
  .btn-group input[type="button"]:hover {
    background-color: #444;
  }
  .btn-group input[value="수정"] {
    background-color: #f8c8dc;  
    color: #fff;
  }
  .btn-group input[value="수정"]:hover {
    background-color: #f4aac9; 
  }
  .btn-group input[value="삭제"] {
    background-color: #f8c8dc;
  }
  .btn-group input[value="삭제"]:hover {
    background-color: #f6a5b4;
  }
  .btn-group input[value="목록"] {
    background-color: #dcdcdc;
  }
  .btn-group input[value="목록"]:hover {
    background-color: #aaa;
  }
  .table-wrapper {
    background-color: white;
    width: 100%;
    max-width: 1000px;
    margin: 20px auto;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    padding: 30px;
  }
  .profile-img {
    width: 36px;
    height: 36px;
    border-radius: 50%;
    object-fit: cover;
    vertical-align: middle;
    margin-right: 6px;
  }
 .reply-btn {
    font-size: 14px;
    padding: 2px 10px;
    background-color: #f8c8dc;
    color: #fff;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.2s;
    position: absolute;
    top: 15px;
    right: 10px;
  }

  .reply-btn:hover {
    background-color: #f4aac9;
  }
</style>
</head>
<body>
<input type="hidden" name="nack_id" value="${dto.snack_id}">
<div class="table-wrapper">
<table>
<caption>
<img src="${pageContext.request.contextPath}/image/${profileimg}" class="profile-img" />
 ${dto.user_login_id}님의 간식 레시피 </caption>
<tr>
  <td colspan="2" style="text-align: right; padding: 5px 10px;">
    <span style="font-size: 15px; color: #8B8386;">👁 ${dto.snack_readcnt}</span>
    <span style="font-size: 15px; color: #e74c3c;">❤️ ${likeCount}</span>
    &nbsp;&nbsp;
    <span style="font-size: 15px; color: #8B8386;">💬 ${fn:length(comments)}</span>
  </td>     
</tr>
<tr>
  <th>레시피명</th>
  <td>${dto.snack_title}</td>
</tr>
<tr>
  <th>레시피 내용</th>
  <td>${dto.snack_recipe}</td>
</tr>
<tr>
  <th>이미지</th>
  <td><img src="./image/${dto.snack_image}" width="200px"/></td>
</tr>
<tr>
  <th>작성자</th>
  <td>${dto.user_login_id}</td>
</tr>
<tr>
  <th>게시일</th>
  <td>${dto.snack_date.substring(0, 10)}</td>
</tr>
<tr>
  <td colspan="2" class="btn-group">
    <input type="button" value="목록" onclick="location.href='snack_out'">
    <c:if test="${sessionScope.user_id == dto.user_id or sessionScope.user_role == 'admin'}">
      <input type="button" value="수정" onclick="location.href='snack_update?update=${dto.snack_id}&dfimage=${dto.snack_image}'">
      <input type="button" value="삭제" onclick="confirmDelete('${dto.snack_id}')">
    </c:if>
  </td>
</tr>
</table>


<!-- 좋아요 버튼 -->
<div style="text-align: center; margin-top: 20px;">
  <form action="like_s" method="post">
    <input type="hidden" name="snack_id" value="${dto.snack_id}">
    <c:choose>
      <c:when test="${userLiked}">
        <button type="submit" style="color:red; font-size: 20px; border: none; background: none;">❤️ (${likeCount})</button>
      </c:when>
      <c:otherwise>
        <button type="submit" style="font-size: 20px; border: none; background: none;">🤍 (${LikeCount})</button>
      </c:otherwise>
    </c:choose>
  </form>
</div>

<script>
  function confirmDelete(snackId) {
    if (confirm("정말 삭제하시겠습니까?")) {
      window.location.href = 'snack_delete?delete=' + snackId + '&dfimage=${dto.snack_image}';
    }
  }
</script>
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
<button type="button" class="reply-btn" onclick="toggleReplyForm(${com.com_id})">
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
</div>
<!-- 대댓글 폼 토글 -->
<script>
   function toggleReplyForm(id) {
      const form = document.getElementById('replyForm' + id);
      form.style.display = (form.style.display === 'none') ? 'block' : 'none';
   }
</script>
</body>
</html>